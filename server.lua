ESX = nil

QBTOESX = false --- QB TO ESX PAKETLER İÇİN TRUE YAPIN
 
TriggerEvent("esx:getSharedObject", function(obj)  ESX = obj end)
 
ESX.RegisterServerCallback('co:notify:check_phone', function(source, cb)
    local phone = nil
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer  then return end
    for i, telefon in ipairs(Config.phones) do
	  if EnvanterTest(xPlayer, telefon) >= 1 then 
	    phone = telefon break;
	  end
	end
	cb(phone)
end)

 
EnvanterTest = function(xPlayer, val)
  if QBTOESX then 
	return xPlayer.getQuantity(val)
  else 
    return xPlayer.getInventoryItem(val).count
  end
end
