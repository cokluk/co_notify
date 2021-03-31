ESX = nil

TriggerEvent("esx:getSharedObject", function(obj)  ESX = obj end)

RegisterNetEvent("co_notify:check_phone")
AddEventHandler('co_notify:check_phone', function()
   local phone = "yok"
   local _source = source
   local xPlayer = ESX.GetPlayerFromId(_source)
   if not xPlayer  then return end
   for i, telefon in ipairs(Config.phones) do
    if xPlayer.getInventoryItem(telefon) then
     if xPlayer.getInventoryItem(telefon).count ~= 0 then  phone = telefon break; else phone = "yok" end 
    end
   end
   TriggerClientEvent('co_notify:phone', source, { phone = phone })
end)
