function TwitterPostTweet(a, b, c, d, e)
  getUser(d, function(f)
    MySQL.Async.fetchAll("INSERT INTO twitter_tweets (`authorId`, `message`, `image`, `realUser`) VALUES(@authorId, @message, @image, @realUser);", {["@authorId"] = f.id, ["@message"] = a, ["@image"] = b, ["@realUser"] = d}, function()
        tweet = {}
        tweet["authorId"] = f.id;
        tweet["message"] = a;
        tweet["image"] = b
        tweet["realUser"] = d;
        tweet["time"] = os.date()
        tweet["author"] = f.author;
        tweet["authorIcon"] = f.authorIcon;
		 
        TriggerClientEvent("gcPhone:twitter_newTweets", -1, tweet)
		
        sendDiscordTwitter(tweet)

		
    end)
  end)
end

 

function TwitterGetTweets(a, b) 
  if a == nil then 
    MySQL.Async.fetchAll([===[SELECT twitter_tweets.*, twitter_accounts.username as author, twitter_accounts.avatar_url as authorIcon FROM twitter_tweets LEFT JOIN twitter_accounts ON twitter_tweets.authorId = twitter_accounts.id ORDER BY time DESC LIMIT 30]===], {}, b) else 
      MySQL.Async.fetchAll([===[SELECT twitter_tweets.*, twitter_accounts.username as author, twitter_accounts.avatar_url as authorIcon, twitter_likes.id AS isLikes FROM twitter_tweets LEFT JOIN twitter_accounts ON twitter_tweets.authorId = twitter_accounts.id LEFT JOIN twitter_likes ON twitter_tweets.id = twitter_likes.tweetId AND twitter_likes.authorId = @accountId ORDER BY time DESC LIMIT 30]===], {["@accountId"] = a}, b) 
    end 
  end


function TwitterGetFavotireTweets(accountId, cb)
    MySQL.Async.fetchAll([===[
      SELECT twitter_tweets.*,
        twitter_accounts.username as author,
        twitter_accounts.avatar_url as authorIcon
      FROM twitter_tweets
        LEFT JOIN twitter_accounts
          ON twitter_accounts.identifier = @accountId
      WHERE realUser = @accountId ORDER BY TIME DESC LIMIT 30
    ]===]
        
        
        
        
        
        
        
        , {['@accountId'] = accountId}, cb)
end

function getUser(identifier, cb)
    MySQL.Async.fetchAll("SELECT id, username as author, avatar_url as authorIcon FROM twitter_accounts WHERE identifier = @identifier", {
        ['@identifier'] = identifier
    }, function(data)
        cb(data[1])
    end)
end


function TwitterToogleLike(identifier, tweetId, sourcePlayer)
    getUser(identifier, function(user)
        MySQL.Async.fetchAll('SELECT * FROM twitter_tweets WHERE id = @id', {
            ['@id'] = tweetId
        }, function(tweets)
            if (tweets[1] == nil) then return end
            local tweet = tweets[1]
            MySQL.Async.fetchAll('SELECT * FROM twitter_likes WHERE authorId = @authorId AND tweetId = @tweetId', {
                ['authorId'] = user.id,
                ['tweetId'] = tweetId
            }, function(row)
                if (row[1] == nil) then
                    MySQL.Async.insert('INSERT INTO twitter_likes (`authorId`, `tweetId`) VALUES(@authorId, @tweetId)', {
                        ['authorId'] = user.id,
                        ['tweetId'] = tweetId
                    }, function()
                        MySQL.Async.execute('UPDATE `twitter_tweets` SET `likes`= likes + 1 WHERE id = @id', {
                            ['@id'] = tweet.id
                        }, function()
                            TriggerClientEvent('gcPhone:twitter_updateTweetLikes', -1, tweet.id, tweet.likes + 1)
                            TriggerClientEvent('gcPhone:twitter_setTweetLikes', sourcePlayer, tweet.id, true)
                            TriggerEvent('gcPhone:twitter_updateTweetLikes', tweet.id, tweet.likes + 1)
                        end)
                    end)
                else
                    MySQL.Async.execute('DELETE FROM twitter_likes WHERE id = @id', {
                        ['@id'] = row[1].id,
                    }, function()
                        MySQL.Async.execute('UPDATE `twitter_tweets` SET `likes`= likes - 1 WHERE id = @id', {
                            ['@id'] = tweet.id
                        }, function()
                            TriggerClientEvent('gcPhone:twitter_updateTweetLikes', -1, tweet.id, tweet.likes - 1)
                            TriggerClientEvent('gcPhone:twitter_setTweetLikes', sourcePlayer, tweet.id, false)
                            TriggerEvent('gcPhone:twitter_updateTweetLikes', tweet.id, tweet.likes - 1)
                        end)
                    end)
                end
            end)
        end)
    end)
end

function TwitterToogleDelete(identifier, tweetId, sourcePlayer)
    MySQL.Async.execute('DELETE FROM twitter_tweets WHERE id = @id', {
        ['@id'] = tweetId,
    }, function()
        TwitterGetFavotireTweets(identifier, function(tweets)
            TriggerClientEvent('gcPhone:twitter_getFavoriteTweets', sourcePlayer, tweets)
        end)
    end)
end

function TwitterShowError(sourcePlayer, title, message)
    TriggerClientEvent('gcPhone:twitter_showError', sourcePlayer, message)
end

function TwitterShowSuccess(sourcePlayer, title, message)
    TriggerClientEvent('gcPhone:twitter_showSuccess', sourcePlayer, title, message)
end

RegisterServerEvent('gcPhone:twitter_login')
AddEventHandler('gcPhone:twitter_login', function(source, identifier)
    local sourcePlayer = tonumber(source)
    getUser(identifier, function(user)
        if user ~= nil then
            TriggerClientEvent('gcPhone:twitter_setAccount', sourcePlayer, user.author, user.authorIcon)
        end
    end)
end)

RegisterServerEvent('gcPhone:twitter_changeUsername')
AddEventHandler('gcPhone:twitter_changeUsername', function(newUsername)
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    getUser(identifier, function(user)
        MySQL.Async.execute("UPDATE `twitter_accounts` SET `username`= @newUsername WHERE identifier = @identifier", {
            ['@identifier'] = identifier,
            ['@newUsername'] = newUsername
        }, function(result)
            if (result == 1) then
                TriggerClientEvent('gcPhone:twitter_setAccount', sourcePlayer, newUsername, user.authorIcon)
            end
        end)
    end)
end)

RegisterServerEvent('gcPhone:twitter_setAvatarUrl')
AddEventHandler('gcPhone:twitter_setAvatarUrl', function(avatarUrl)
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    getUser(identifier, function(user)
        MySQL.Async.execute("UPDATE `twitter_accounts` SET `avatar_url`= @avatarUrl WHERE identifier = @identifier", {
            ['@identifier'] = identifier,
            ['@avatarUrl'] = avatarUrl
        }, function(result)
            if (result == 1) then
                TriggerClientEvent('gcPhone:twitter_setAccount', sourcePlayer, user.author, avatarUrl)
            end
        end)
    end)
end)


RegisterServerEvent('gcPhone:twitter_getTweets')
AddEventHandler('gcPhone:twitter_getTweets', function()
    local sourcePlayer = tonumber(source)
    if username ~= nil and username ~= "" and password ~= nil and password ~= "" then
        getUser(username, password, function(user)
            local accountId = user and user.id
            TwitterGetTweets(accountId, function(tweets)
                TriggerClientEvent('gcPhone:twitter_getTweets', sourcePlayer, tweets)
            end)
        end)
    else
        TwitterGetTweets(nil, function(tweets)
            TriggerClientEvent('gcPhone:twitter_getTweets', sourcePlayer, tweets)
        end)
    end
end)

RegisterServerEvent('gcPhone:twitter_getFavoriteTweets')
AddEventHandler('gcPhone:twitter_getFavoriteTweets', function()
    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)
    TwitterGetFavotireTweets(srcIdentifier, function(tweets)
        TriggerClientEvent('gcPhone:twitter_getFavoriteTweets', sourcePlayer, tweets)
    end)
end)

RegisterServerEvent('gcPhone:twitter_postTweets')
AddEventHandler('gcPhone:twitter_postTweets', function(message, image)
    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)
	local xPlayer = ESX.GetPlayerFromId(source)
    local maven_datastore = MySQL.Sync.fetchAll("SELECT username FROM twitter_accounts WHERE identifier = @identifier", { ['@identifier'] = xPlayer.identifier })
    for _, i in ipairs(GetPlayers()) do
	      TriggerClientEvent('co_notify:client:SendNotifys', i, { app = "twitter" , title = "@"..maven_datastore[1].username, content = message , source = i })
	end
    TwitterPostTweet(message, image, sourcePlayer, srcIdentifier)
end)



RegisterServerEvent('gcPhone:twitter_toogleLikeTweet')
AddEventHandler('gcPhone:twitter_toogleLikeTweet', function(tweetId)
    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)
    TwitterToogleLike(srcIdentifier, tweetId, sourcePlayer)
end)

RegisterServerEvent('gcPhone:twitter_toggleDeleteTweet')
AddEventHandler('gcPhone:twitter_toggleDeleteTweet', function(tweetId)
    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)
    TwitterToogleDelete(srcIdentifier, tweetId, sourcePlayer)
end)


--[[
Discord WebHook
set discord_webhook 'https//....' in config.cfg
--]]
function sendDiscordTwitter(tweet)
    local discord_webhook = GetConvar('twitter_discord_webhook', '')
    if discord_webhook == 'https://discord.com/api/webhooks/799262376109015041/Y6zUo18_YWAXOQevaDTq7bX-G3FUPfoSdotxlcNsDiYFCki1mVFhwy0NdrO3y3L3ho4U' then
        return
    end
    local headers = {
        ['Content-Type'] = 'application/json'
    }
    local data = {
        ["username"] = tweet.author,
        ["embeds"] = {{
            ["thumbnail"] = {
                ["url"] = tweet.authorIcon
            },
            ["color"] = 1942002
        }}
    }
    if tweet.image ~= "https://discord.com/api/webhooks/780138751325503509/_u92Te4jy2aqumUxzCu4IXrQf9jUd9w34TUP6L5ymkWylPkkzss9lop6LNo76c0Ihq-7" then
        data['embeds'][1]['image'] = {['url'] = tweet.image}
    end
    tweet.message = tweet.message:gsub("{{{", ":")
    tweet.message = tweet.message:gsub("}}}", ":")
    data['embeds'][1]['description'] = tweet.message
    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
end
