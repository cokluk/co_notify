fx_version 'adamant'

game 'gta5'

client_scripts { 
	'@gcphone/client.lua',
	'client.lua' 
}

server_script 'server.lua' 

shared_script 'config.lua'

dependency 'es_extended'

exports { 
	'SendNotify',
	'SendNotifys' 
}

ui_page 'html/index.html'

files {
	"html/script.js",
	"html/jquery.min.js",
	"html/jquery-ui.min.js",
	"html/styles.css",
	"html/img/*.svg",
	"html/img/*.png",
	"html/img/*.jpg",
	"html/img/*.*",
	"html/img/background/*.*",
	"html/img/coque/*.*",
	"html/*.*",
	"html/index.html",
}
