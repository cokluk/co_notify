telefon = nil
FirstRun = false
 
TriggerServerEvent("co_notify:check_phone");

RegisterNetEvent('co_notify:first_run')
AddEventHandler('co_notify:first_run', function(data)
    SendNUIMessage({ action = "ilk", zoom = Config.zoom, background = Config.background, time = Config.time  }) 
end)


RegisterNetEvent('co_notify:phone')
AddEventHandler('co_notify:phone', function(data)
    telefon = data.phone
	if telefon == "yok" then
	   telefon = nil
	end
end)
 
RegisterNetEvent('co_notify:client:SendNotifys')
AddEventHandler('co_notify:client:SendNotifys', function(data)
    if FirstRun == false then TriggerEvent('co_notify:first_run'); FirstRun = true  end
    TriggerServerEvent("co_notify:check_phone");
    Wait(100)
    if telefon ~= nil then SendNUIMessage({ action = "bildirim", uygulama = data.app, baslik = data.title, icerik = data.content }) end
end)

function SendNotify(app, title, content)
    if FirstRun == false then TriggerEvent('co_notify:first_run'); FirstRun = true  end
    TriggerServerEvent("co_notify:check_phone");
    Wait(100)
    if telefon ~= nil  then SendNUIMessage({ action = "bildirim", uygulama = app, baslik = title, icerik = content}) end
end