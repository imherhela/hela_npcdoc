fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'ImHerHela'
description 'Offline NPC Doctor for RedM'
version '1.0.0'

shared_scripts {
    'config.lua',
    'language.lua'
}

client_script
    'client.lua'

server_script 
    'server.lua'

