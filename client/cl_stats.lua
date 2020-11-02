--[[       
####	Title:          	Stats for esx
####	Description:     	Save client stats to database
####								
####	Author:		 		Devory & Newtonzz
####	Version:        	v1.0  
]]--

---------------
-- Variables --
---------------
ESX = nil

---------------
-- ESX CORE  --
---------------

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end
end)

---------------
-- Main Loop --
---------------

Citizen.CreateThread(function()
    while true do

        Citizen.Wait(300000)
        Citizen.Wait(math.random(1, 31))
        ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)
            local PlayerData = ESX.GetPlayerData()
            local Citizenid = PlayerData.citizenid
            local Total = (PlayerData.money + PlayerData.accounts[1].money)
            local Name = GetPlayerName(PlayerId())
            local Charinfo = PlayerData.charinfo
            local FirstLast = data.firstname .. " " .. data.lastname
            local JobName = PlayerData.job.name
            local JobLabel = PlayerData.job.grade_name
            local JobOnDuty = PlayerData.job.onduty

            if JobOnDuty == true then
                JobOnDuty = "true"
            else
                JobOnDuty = "false"
            end
            TriggerServerEvent("stats:upload", Name, FirstLast, Citizenid, Total, JobName, JobLabel, JobOnDuty)
        end, GetPlayerServerId(PlayerId()))
        Citizen.Wait(5000)
    end
end)

function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then
                k = '"' .. k .. '"'
            end
            s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end
