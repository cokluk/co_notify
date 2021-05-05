function YellowPagesGetPosts(a, b)
    MySQL.Async.fetchAll([===[SELECT yellowpages_posts.*, twitter_accounts.username as author, twitter_accounts.avatar_url as authorIcon, users.firstname as firstname, users.lastname as lastname FROM yellowpages_posts LEFT JOIN twitter_accounts ON yellowpages_posts.authorId = twitter_accounts.id LEFT JOIN users ON yellowpages_posts.realUser = users.identifier ORDER BY time DESC LIMIT 30]===], {}, b)
end
function YellowPagesPostIlan(a, b, c, d, e)
    getUserYellow(d, function(f)
        MySQL.Async.fetchAll("SELECT phone_number FROM users WHERE users.identifier = @realUser", {["@realUser"] = d}, function(g)MySQL.Async.insert("INSERT INTO yellowpages_posts (`authorId`, `message`, `image`, `realUser`, `phone`) VALUES(@authorId, @message, @image, @realUser, @phone);", {["@authorId"] = f.id, ["@message"] = a, ["@image"] = b, ["@realUser"] = d, ["@phone"] = g[1].phone_number}, function(h)
            post = {}
            post["authorId"] = f.id;
            post["message"] = a;
            post["image"] = b;
            post["realUser"] = d;
            post["time"] = os.date()
            post["author"] = f.author;
            post["authorIcon"] = f.authorIcon;
            
            TriggerClientEvent("gcPhone:yellow_newPost", -1, post)sendDiscordYellow(post)
        end)
        end)
    end)
end

function YellowGetMyPosts(accountId, cb)
    MySQL.Async.fetchAll([===[
      SELECT yellowpages_posts.*,
        twitter_accounts.username as author,
        twitter_accounts.avatar_url as authorIcon
      FROM yellowpages_posts
        LEFT JOIN twitter_accounts
          ON twitter_accounts.identifier = @accountId
      WHERE realUser = @accountId ORDER BY TIME DESC LIMIT 30
    ]===]
        
        
        
        
        
        
        
        , {['@accountId'] = accountId}, cb)
end

function getUserYellow(identifier, cb)
    MySQL.Async.fetchAll("SELECT id, username as author, avatar_url as authorIcon FROM twitter_accounts WHERE twitter_accounts.identifier = @identifier", {
        ['@identifier'] = identifier
    }, function(data)
        cb(data[1])
    end)
end

function YellowToogleDelete(identifier, id, sourcePlayer)
    MySQL.Async.execute('DELETE FROM yellowpages_posts WHERE id = @id', {
        ['@id'] = id,
    }, function()
        YellowGetMyPosts(identifier, function(posts)
            TriggerClientEvent('gcPhone:yellow_getMyPosts', sourcePlayer, posts)
        end)
    end)
end

function TwitterShowError(sourcePlayer, title, message)
    TriggerClientEvent('gcPhone:twitter_showError', sourcePlayer, message)
end

RegisterServerEvent('gcPhone:yellow_getPosts')
AddEventHandler('gcPhone:yellow_getPosts', function()
    local sourcePlayer = tonumber(source)
    YellowPagesGetPosts(nil, function(posts)
        TriggerClientEvent('gcPhone:yellow_getPosts', sourcePlayer, posts)
    end)
end)

RegisterServerEvent('gcPhone:yellow_getMyPosts')
AddEventHandler('gcPhone:yellow_getMyPosts', function()
    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)
    YellowGetMyPosts(srcIdentifier, function(posts)
        TriggerClientEvent('gcPhone:yellow_getMyPosts', sourcePlayer, posts)
    end)
end)

RegisterServerEvent('gcPhone:yellow_toggleDeletePost')
AddEventHandler('gcPhone:yellow_toggleDeletePost', function(id)
    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)
    YellowToogleDelete(srcIdentifier, id, sourcePlayer)
end)

RegisterServerEvent('gcPhone:yellow_postIlan')
AddEventHandler('gcPhone:yellow_postIlan', function(message, image)
    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)
	local xPlayer = ESX.GetPlayerFromId(source)
    local maven_datastore = MySQL.Sync.fetchAll("SELECT username FROM twitter_accounts WHERE identifier = @identifier", { ['@identifier'] = xPlayer.identifier })
    for _, i in ipairs(GetPlayers()) do
	 TriggerClientEvent('co_notify:client:SendNotifys', source, { app = "yellow" , title = "@"..maven_datastore[1].username, content = message })
	end
    YellowPagesPostIlan(message, image, sourcePlayer, srcIdentifier)
end)

function sendDiscordYellow(post)
    local discord_webhook = GetConvar('yellow_discord_webhook', '')
    if discord_webhook == 'https://discord.com/api/webhooks/799263038871961621/TxIAqFlXsn8BSQ5O_2DnJkP0lPgxiGFDzfSzPPtaJVSAZ0DNFxYDu0alVLlgECWg0xrO' then
        return
    end
    local headers = {
        ['Content-Type'] = 'application/json'
    }
    local data = {
        ["username"] = post.author,
        ["embeds"] = {{
            ["thumbnail"] = {
                ["url"] = post.authorIcon
            },
            ["color"] = 1942002
        }}
    }
    if post.image ~= "https://discord.com/api/webhooks/783469195252989972/5snYQkUQ1K7znaazThMsH_swnHRuN3k4tpb0eATKbE3RtpP5369WPMIsNQ_rd_X2nb5f" then
        data['embeds'][1]['image'] = {['url'] = post.image}
    end
    post.message = post.message:gsub("{{{", ":")
    post.message = post.message:gsub("}}}", ":")
    data['embeds'][1]['description'] = post.message
    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
end
