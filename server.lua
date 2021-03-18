ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(10)
        TriggerEvent("esx:getSharedObject", function(obj)
            ESX = obj
        end)
    end
end)

RegisterNetEvent("co_notify:check_phone")
AddEventHandler('co_notify:check_phone', function()
   local phone = "yok"
   local _source = source
   local xPlayer = ESX.GetPlayerFromId(_source)
   if not xPlayer  then return end
   if xPlayer.getInventoryItem('phone') then
     if xPlayer.getInventoryItem('phone').count ~= 0 then  phone = "phone" end 
   elseif
     xPlayer.getInventoryItem('blue_phone') then
     if xPlayer.getInventoryItem('blue_phone').count ~= 0 then  phone = "blue_phone" end 
   elseif
     xPlayer.getInventoryItem('green_phone') then
     if xPlayer.getInventoryItem('green_phone').count ~= 0 then  phone = "green_phone" end 
   elseif
     xPlayer.getInventoryItem('white_phone') then
     if xPlayer.getInventoryItem('white_phone').count ~= 0 then  phone = "white_phone" end 
   else phone = "yok" end
   TriggerClientEvent('co_notify:phone', source, { phone = phone })
end)