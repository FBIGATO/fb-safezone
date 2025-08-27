fx_version 'cerulean'
game 'gta5'
version '0.0.2'
description 'Zonas (Segura, Roja, Carga) con HUD y vms_notify'----puedes cambiar el vms-notify por el que uses
author 'fbigato_j'-----Porfavor no remover el author

client_scripts {
    'config.lua',
    'client/*.lua',
}

server_scripts {
    'server/version_check.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js'
}
