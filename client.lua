telefon = nil
FirstRun = false
arama = false
Aramainfo = nil


Citizen.CreateThread(function()
	while true do
            Citizen.Wait(0)
            if IsControlJustReleased(0, 186) then 
                    SendNUIMessage({ action = "ytkapat"  }) 
            end

            if Aramainfo ~= nil then
                -- SAG
                if arama ~= true then
                   if IsControlJustReleased(0, 175) then 
                      TriggerEvent("gcPhone:acceptCall", Aramainfo);
                      SendNUIMessage({ action = "arama_kabul"  }) 
                   end
                end
                -- SOL
                if IsControlJustReleased(0, 174) then 
                    TriggerEvent("gcPhone:rejectCall", Aramainfo);
                    SendNUIMessage({ action = "arama_red"  }) 
                    Aramainfo = nil
                end
            end


     end
end)

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
    if app == "arama" then 
        Aramainfo = content
        SendNUIMessage({action = "arama", numara = title, baslik = title })
        return
    end;
    if app == "aramabitir" then 
        SendNUIMessage({ action = "arama_red"  }) 
        Aramainfo = nil
        arama = false
        return
    end;
    if app == "aramakabul" then 
        arama = true
        Aramainfo = content
        SendNUIMessage({ action = "arama_kabul"  }) 
        return
    end;
    if app == "youtube" then 
        SendNUIMessage({ action = "youtube", uygulama = app, baslik = title, icerik = content})
        return
    end;
    if telefon ~= nil  then SendNUIMessage({ action = "bildirim", uygulama = app, baslik = title, icerik = content}) end
end