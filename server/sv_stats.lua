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

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

-------------------
-- Main Script   --
-------------------

RegisterNetEvent("stats:upload")
AddEventHandler("stats:upload", function(Name, FirstLast, Citizenid, MoneyTotal, Job, JobLabel, OnDuty)
    local id = GetPlayerIdentifiers(source)[1]
    MySQL.Async.execute('INSERT INTO stats (`Name`, `SourceID`, `FirstLast`, `Citizenid`, `MoneyTotal`, `Job`, `JobLabel`, `OnDuty`) VALUES (@Name, @SourceID, @FirstLast, @Citizenid, @MoneyTotal, @Job, @JobLabel, @OnDuty)', {
        ['Name'] = Name,
        ['SourceID'] = id,
        ['FirstLast'] = FirstLast,
        ['Citizenid'] = Citizenid,
        ['MoneyTotal'] = MoneyTotal,
        ['Job'] = Job,
        ['JobLabel'] = JobLabel,
        ['OnDuty'] = OnDuty
    }, function(affectedRows)
        print(affectedRows)
    end)
end)
