fx_version 'bodacious'

game 'gta5'

author 'Devory & Newtonzz'
description 'Stats for esx'

version '1.0'

client_script 'client/cl_stats.lua'

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/sv_stats.lua' 
}
