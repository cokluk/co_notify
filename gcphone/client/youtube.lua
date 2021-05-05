RegisterNUICallback('youtube_Play', function(data)
    exports['co_notify']:SendNotify('youtube', data, "true")
    exports["xsound"]:Cal(data, false)
end)

RegisterNUICallback('youtube_Pause', function()
    exports["xsound"]:Duraklat()
end)

RegisterNUICallback('youtube_Stop', function() 
    exports["xsound"]:Durdur()
end)

RegisterNUICallback('youtube_Resume', function()
    exports["xsound"]:Devamet()
end)