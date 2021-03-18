telefon = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        TriggerServerEvent("co_notify:check_phone");
    end
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
    print(telefon)
    if telefon ~= nil   then
	SendNUIMessage({ action = "bildirim", uygulama = data.app, baslik = data.title, icerik = data.content })
	end
end)



function SendNotify(app, title, content)
    print(telefon)
    if telefon ~= nil  then
	SendNUIMessage({ action = "bildirim", uygulama = app, baslik = title, icerik = content})
	end
end