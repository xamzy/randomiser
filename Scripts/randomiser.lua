--ImportScript("\\Library\\custom.lua")
--LaunchScript("custom.lua")
function WaitWithText(ms) 
    local timer = GetTimer()
    local remain = ms
    while remain > 0 do
        TextPrintString(math.floor(remain/1000).." / "..math.floor(ms/1000),0,1)
        Wait(0)
        local change = GetTimer()
        if IsButtonPressed(3,0) then
            remain = remain - (change - timer)*10
        else
            remain = remain - (change - timer)
        end
        timer = change
    end
end


--[[gRandom = {p=0}
export.StartRandom = function() -- random value based on points system
	gRandom = {p=0}
end
export.AddRandom = function(points,value)
	if points >= 1 then
		gRandom.p = gRandom.p + math.floor(points)
		gRandom[gRandom.p] = value
	end
end
export.GetRandom = function()
	if gRandom.p ~= 0 then
		local index = gRandom.p
		local point = math.random(1,index)
		local value = gRandom[index]
		while index > point do
			index = index - 1
			if gRandom[index] ~= nil then
				value = gRandom[index]
			end
		end
		if value == nil then
			error("GetRandom failed",2) -- just a failsafe, should never actually happen.
		end
		return value
    end
	-- returns nothing if no random values were added.
end

StartRandom()
AddRandom(25,"sheldonatorspawner")
AddRandom(100,"arcadecam")
AddRandom(5,"justdie")
AddRandom(50,"lockup")
AddRandom(30,"teleportation")
AddRandom(25,"money")
AddRandom(45,"gokart")
AddRandom(55,"onehitko")
AddRandom(65,"mayhem")
AddRandom(75,"snow")
AddRandom(75,"wanted")
AddRandom(50,"takedamage")
AddRandom(85,"halfspeed")
AddRandom(85,"doublespeed")
--770 POINTS
--AddRandom("pedspawner")
--AddRandom("qte")
TextPrintString(GetRandom(),1,1)
]]

function T_RandomFuncs()
    local funcs = {invulnerable,bulltime,nohud,fov}--pedspawner,lockup,arcadecam,sheldonatorspawner,teleportation,halfspeed,doublespeed,takedamage,wanted,snow,money,onehitko,gokart,justdie,negmoney,haveacar,mayhem,qte,weather,weapons
    local count = table.getn(funcs)
    while true do
        WaitWithText(30000)
        funcs[math.random(1,count)]()
    end
end

function main() 
    CreateThread("T_RandomFuncs")
end

function pedspawner() --80% Complete - need to make them aggressive for x time
    TextPrintString("Debug Peds",3,2)
    Wait(3000)
    TextPrintString("Spawn Random Peds",29,2)
    local x,y,z = PlayerGetPosXYZ()
    for i=1,7 do
     PedCreateXYZ(math.random(2,258),x+i,y,z)
    end
    PedSetPedToTypeAttitude(i,13,0)
    if x ~=9999 and y ~=9999 and z ~=9999 then
		return x,y,z
    end
    Wait(1500)
end

function justdie() --i wonder if i could make this a qte so you don't die..
    TextPrintString("Time to Die.",29,2)
    PlayerSetHealth(0)
    PlayerGetHealth(0)
    PedApplyDamage(gPlayer,1000)
    Wait(2800)
end

--[[function qte() --attempted qte?
    TextPrintString("Debug qte",3,2)
     Wait(2500)
    TextPrintString("Quick Time Event!",29,2)
    local a = 7
    local b = 8
    local x = 6
    local y = 9
    local rb = 13
    local lb = 11
    local lt = 10
    local rt = 12
    local dleft = 0
    local dright = 1
    local dup = 2
    local ddown = 3
    local crouch = 15
    local backwards = 14

    local controlTable = {0,1,2,3,6,7,8,9,10,11,12,13,14,15}
    local count = table.getn(controlTable)
     while true do
        random = controlTable[math.random(1,count)]()
        wrong = not random
        TextPrintString(random,3,2)
        if IsButtonBeingPressed(random,0) then
         repeat
            random
         until PedIsDead(gPlayer)
            Wait(1500)
        elseif IsButtonBeingPressed(wrong,0) then --will just kill you to get out of it during development
            PlayerSetHealth(0)
            PlayerGetHealth(0)
            PedApplyDamage(gPlayer,3000)
        end
        ClockGet() = originalTime
            Wait(3000)
        if ClockGet() >= originalTime and IsButtonBeingReleased(random,0) then
         PlayerSetHealth(0)
         PlayerGetHealth(0)
         PedApplyDamage(gPlayer,3000)
        end
        end
    end
end]]


--[[declare locals
    random=math.random(1,count)
]]

--[[function haveacar() --doesn't crash but also does nothing at the moment.
    TextPrintString("Spawn a Car",29,2)
     local x,y,z = PlayerGetPosXYZ()
     local bikeTable = {272,273,274,276,277,278,279,280,281,282,283,284,286,288,289}
     local count = table.getn(bikeTable)
    while true do
        VehicleCreateXYZ(bikeTable[math.random(1,count)](),x+2,y,z)
    end
end]]

function lockup() 
    TextPrintString("Locked Controls",7,2)
     PlayerSetControl(0)
    Wait(math.random(1660,9000))
    PlayerSetControl(1)
end

function PedCreateSheldonator(x,y,z,ambient) 
    -- Create thread and table:
    if not gSheldonators then
        gSheldonators = {}
        gSheldonatorThread = function()
            local px,py,pz,near,nearBefore,notWanted
            local processSheldonator = function(v)
                local x,y,z = PedGetPosXYZ(v[1])
                local dist = math.sqrt((px-x)*(px-x) + (py-y)*(py-y) + (pz-z)*(pz-z))
                if v[3] then
                    if GetTimer() >= v[3] + 1100/(v[2]/100) then
                        if PedGetGrappleTargetPed(v[1]) == gPlayer then
                            PlayerSetControl(0)
                            repeat
                                PedSetActionNode(v[1],"/Global/Actions/Grapples/GrappleReversals/MountReversals/MountReversalPunches","Act/Globals.act")
                                for hit = 1,2 do
                                    Wait(325/(v[2]/100))
                                    if not PedIsValid(v[1]) then
                                        return false
                                    end
                                    PlayerSetHealth(PlayerGetHealth()-7)
                                end
                                Wait(0)
                                if not PedIsValid(v[1]) then
                                    return false
                                end
                            until PedGetGrappleTargetPed(v[1]) ~= gPlayer or PlayerGetHealth() <= 0
                            while PedIsPlaying(v[1],"/Global/Actions/Grapples/GrappleReversals/MountReversals/MountReversalPunches",true) do
                                Wait(0)
                                if not PedIsValid(v[1]) then
                                    return false
                                end
                            end
                            if PlayerGetHealth() <= 0 then
                                PedSetActionNode(v[1],"/Global/404Conv/Nerds/Dance1","Act/Conv/4_04.act")
                                if v[5] then
                                    PedMakeAmbient(v[1])
                                    v[5] = nil
                                end
                            end
                            PlayerSetControl(1)
                        end
                        v[3] = nil
                    elseif PedGetGrappleTargetPed(v[1]) == gPlayer and IsButtonBeingPressed(9,0) then
                        local original = GameGetPedStat(v[1],39)
                        GameSetPedStat(v[1],39,0)
                        PedSetActionNode(gPlayer,"/Global/Actions/Grapples/Front/Grapples/GrappleMoves/DirectionalPush","Act/Globals.act")
                        PedSetActionNode(v[1],"/Global/Actions/Grapples/Front/Grapples/GrappleMoves/DirectionalPush/RCV","Act/Globals.act")
                        repeat
                            Wait(0)
                            if not PedIsValid(v[1]) then
                                return false
                            end
                        until PedGetGrappleTargetPed(v[1]) ~= gPlayer
                        GameSetPedStat(v[1],39,original)
                        v[3] = nil
                    end
                elseif PedMePlaying(v[1],"Default_KEY") and not PedIsDead(gPlayer) then
                    if GetTimer() >= v[4] then
                        if dist < 2.6 then
                            PedFaceXYZ(v[1],px,py,pz)
                            PedSetActionNode(v[1],"/Global/J_Damon/Offense/Medium/Grapples/GrapplesAttempt","Act/Anim/J_Damon.act")
                            v[3] = GetTimer()
                            v[4] = GetTimer() + math.random(2000,12500)
                        end
                    elseif GetTimer() >= v[6] then
                        if dist < 1.2 then
                            local reversed = false
                            PedFaceXYZ(v[1],px,py,pz)
                            PedSetActionNode(v[1],"/Global/Actions/Grapples/Front/Grapples/GrappleAttempt","Act/Globals.act")
                            while PedIsPlaying(v[1],"/Global/Actions/Grapples/Front/Grapples/GrappleAttempt",true) do
                                Wait(0)
                                if not PedIsValid(v[1]) then
                                    return false
                                elseif PedGetGrappleTargetPed(v[1]) == gPlayer and IsButtonBeingPressed(9,0) then
                                    PedSetActionNode(gPlayer,"/Global/Actions/Grapples/Front/Grapples/GrappleMoves/DirectionalPush","Act/Globals.act")
                                    reversed = true
                                end
                            end
                            if not reversed and PedGetGrappleTargetPed(v[1]) == gPlayer and PedIsPlaying(v[1],"/Global/Actions/Grapples/Front/Grapples/Hold_Idle",true) then
                                local moves = {"GrappleStrikes/HitA/Charge","GrappleStrikes/HitB/Charge","GrappleStrikes/HitC/Charge","DirectionalPush","HeadButt","BodySlam"}
                                local move = "/Global/Actions/Grapples/Front/Grapples/GrappleMoves/"..moves[math.random(1,table.getn(moves))]
                                PedSetActionNode(v[1],move,"Act/Globals.act")
                                while PedIsPlaying(v[1],move,true) do
                                    Wait(0)
                                    if not PedIsValid(v[1]) then
                                        return false
                                    end
                                end
                            end
                            v[6] = GetTimer() + math.random(3000,9500)
                        end
                    elseif GetTimer() >= v[7] then
                        if dist < 1.4 then
                            PedFaceXYZ(v[1],px,py,pz)
                            PedSetActionNode(v[1],"/Global/BOSS_Darby/Offense/Short/Grapples/HeavyAttacks/Catch_Throw","Act/Anim/BOSS_Darby.act")
                        end
                        v[7] = GetTimer() + math.random(6000,14500)
                    end
                end
                if not near then
                    near = (dist < 10 or (dist < 50 and PedIsOnScreen(v[1]))) and not PedIsDead(v[1])
                end
                return true
            end
            while true do
                px,py,pz = PlayerGetPosXYZ()
                near = false
                for i,v in ipairs(gSheldonators) do
                    if not PedIsValid(v[1]) or not processSheldonator(v) then
                        table.remove(gSheldonators,i)
                        i = i - 1
                    end
                end
                if near then
                    if not nearBefore then
                        notWanted = PlayerGetPunishmentPoints() <= 200
                    end
                    if notWanted then
                        if PlayerGetPunishmentPoints() > 200 then
                            PlayerSetPunishmentPoints(200)
                        end
                    elseif nearBefore then
                        notWanted = PlayerGetPunishmentPoints() <= 200
                    end
                end
                nearBefore = near
                Wait(0)
            end
        end
        gSheldonatorThread = CreateThread("gSheldonatorThread")
    end
   
    -- Get spawn position:
    if not x or not y or not z then
        x,y,z = PedFindRandomSpawnPosition()
        if x == 9999 then
            return nil
        end
    end
   
    -- Spawn ped:
    local ped = PedCreateXYZ(66,x,y,z)
    --PED_SetMissionPed(ped,true)
   
    -- Set stats:
    local health = math.random(150,400)
    local speed = gForceSlowSheldonator and 50 or math.random(145,265)
    PedSetHealth(ped,health)
    PedSetMaxHealth(ped,health)
    PedSetInfiniteSprint(ped,true)
    GameSetPedStat(ped,0,math.random(1,100) <= 10 and 363 or 358)
    GameSetPedStat(ped,1,10)
    GameSetPedStat(ped,2,360)
    GameSetPedStat(ped,3,500)
    GameSetPedStat(ped,6,0)
    GameSetPedStat(ped,7,0)
    GameSetPedStat(ped,8,100)
    GameSetPedStat(ped,12,math.random(40,65))
    GameSetPedStat(ped,14,100)
    GameSetPedStat(ped,20,speed)
    GameSetPedStat(ped,39,math.random(20,60))
    GameSetPedStat(ped,61,math.random(50,75))
    GameSetPedStat(ped,62,math.random(0,1))
    GameSetPedStat(ped,63,10)
   
    -- Set style:
    local styles = {
        "Authority",
        "DO_Striker_A",
        "G_Grappler_A",
        "G_Striker_A",
        "J_Striker_A",
        "Nemesis",
        "P_Striker_A",
        "Russell_102",
    }
    local style = styles[math.random(1,table.getn(styles))]
    PedSetActionTree(ped,"/Global/"..style,"Act/Anim/"..style..".act")
   
    -- Clear weapons:
    PedClearAllWeapons(ped)
   
    -- Attack player:
    for f = 0,11 do
        PedSetPedToTypeAttitude(ped,f,2)
    end
    PedSetPedToTypeAttitude(ped,13,0)
    PedAttackPlayer(ped,3)
   
    -- Add to sheldonators:
    table.insert(gSheldonators,{ped,speed,[4] = 0,[5] = ambient,[6] = 4000,[7] = 7000})
   
    -- Return handle:
    return ped
end
function sheldonatorspawner()
    --LaunchScript("gSheldonator.lua")
    LoadAnimationGroup("4_04_FunhouseFun")
    LoadAnimationGroup("Straf_Dout")
    LoadAnimationGroup("Straf_Male")
    LoadAnimationGroup("Straf_Prep")
    LoadAnimationGroup("Straf_Savage")
    LoadAnimationGroup("Straf_Wrest")
    LoadAnimationGroup("F_BULLY")
    LoadAnimationGroup("F_Douts")
    LoadAnimationGroup("F_Greas")
    LoadAnimationGroup("F_Jocks")
    LoadAnimationGroup("F_Pref")
    LoadAnimationGroup("F_Preps")
    LoadAnimationGroup("DO_Striker")
    LoadAnimationGroup("DO_StrikeCombo")
    LoadAnimationGroup("B_Striker")
    LoadAnimationGroup("G_Striker")
    LoadAnimationGroup("G_Grappler")
    LoadAnimationGroup("J_Striker")
    LoadAnimationGroup("P_Striker")
    LoadAnimationGroup("Authority")
    LoadAnimationGroup("Boxing")
    LoadAnimationGroup("Nemesis")
    LoadAnimationGroup("Russell")
TextPrintString("Sheldonator",29,2)
local x,y,z = PlayerGetPosXYZ()
 PedCreateSheldonator(x+3,y,z,true)
 repeat
    Wait(1)
 until PedIsDead(gPlayer)
end

function teleportation() --10% Complete
TextPrintString("Teleportation to Random Location",29,2)
AreaTransitionXYZ(0,265,-110,6) --temp (need coord list)
end

function arcadecam()
 TextPrintString("Arcade Camera",29,2)
  CameraSetActive(14)
  CameraAllowChange(false)
  CameraAllowScriptedChange(false)
Wait(29000)
 CameraAllowChange(true)
 CameraAllowScriptedChange(true)
 CameraReturnToPlayer()
Wait(1000)
end

function halfspeed() 
 TextPrintString("Player Half Speed",29,2)
 GameSetPedStat(gPlayer,20,50)
 Wait(math.random(10000,30000))
 GameSetPedStat(gPlayer,20,100)
end

function doublespeed()
    TextPrintString("Player Double Speed",29,2)
    GameSetPedStat(gPlayer,20,200)
    Wait(math.random(10000,30000))
    GameSetPedStat(gPlayer,20,100)
end

function takedamage()
 local damage = math.random(50,200)
 TextPrintString("Take Some Damage",29,2)
 PedApplyDamage(gPlayer,damage)
end

function wanted()
 TextPrintString("Red Wanted Level",29,2)
 PedSetPunishmentPoints(gPlayer,500)
end

--function weather() - this will be a randomised weather function as well as the snow to fuck you over
--end

function snow()
    local originalChapter = ChapterGet()
    local originalWeather = WeatherGet()
    TextPrintString("Forced Snow",29,2)
     WeatherForceSnow(true)
     WeatherSet(2)
     ChapterSet(2)
    Wait(29000)
     ChapterSet(originalChapter)
     WeatherSet(originalWeather)
     WeatherForceSnow(false)
    Wait(1000)
end


--[[function weapons() --will give basic weapons and ammo 20% complete
    local weaponTable = {
        305,--spuds
        301,--cherry
        325,--rubberband
        309,--stinks
        304,--marbles
        321--spray
    }
    local count = table.getn(weaponTable)
     --GiveWeaponToPlayer(math.random(weaponTable))
     GiveWeaponToPlayer(weaponTable[math.random(1,count)]())
end]]

function gokart()
    TextPrintString("Gokart Spawn",29,2)
     local time = math.random(7500,26000)
     local x,y,z = PlayerGetPosXYZ()
     local kart = VehicleCreateXYZ(289,x+1,y,z)
     Wait(time)
    PedExitVehicle(gPlayer)--untested
    Wait(2000)--try
    VehicleDelete(kart)
end

function money()
    TextPrintString("Added Money",5,2)
    PlayerAddMoney(math.random(900,9000))
    Wait(1500)
end

--[[function negmoney()
    TextPrintString("Lost Money",5,2)
    	PlayerSetMoney(math.random(-500,-7000))
	    PlayerGetMoney()
    Wait(1500)
end]]

function onehitko()
    TextPrintString("One Hit KO",29,2)
    PedSetDamageGivenMultiplier(gPlayer,2,50)
     Wait(29000)
    PedSetDamageGivenMultiplier(gPlayer,2,1) 
end

function mayhem()
local originalAttitudes = {}
local currentIndex = 0;
for i=1,5 do --iterate through Nerds, Jocks, Dropouts, Greasers and Preps.
    for j=1,13 do -- Iterate from Nerds through to the player.
        if (i~=3 and j ~= 3 and (j<6 or j==13) and i~=j) then -- Ignore Dropouts, only allow Nerd/Jock/Greaser/Prep/Player relationships.  
            originalAttitudes[currentIndex] = PedGetTypeToTypeAttitude(i,j) -- store current attitudes.
            currentIndex = currentIndex+1
        end
    end
end
 
Wait(1000) -- Feel Free to change.
 
--Initiate Mayhem
for i=1,5 do -- iterate through Nerds, Jocks, Dropouts, Greasers and Preps.
    for j=1,5 do
        if(i~=3 and j~=3) then -- Ignore Dropout relationships
            PedSetTypeToTypeAttitude(i,j,0) -- set factions i and j to hate each other.
        end
    end
    if(i~=3) then PedSetTypeToTypeAttitude(i,13,1) -- set faction i to dislike the player.
end

 
--I'm not sure what the below functions do, so I've left them in.
DisablePOI(true, true) -- I'd assume this is for making Peds spawn outside of where they usually would.
AreaSetPopulationSexGeneration(false, true) --Prevent girls from spawning?
AreaOverridePopulation(14, 0, 3, 3, 0, 3, 3, 0, 0, 0, 0, 0, 0) -- Remove Townies and Prefects.
AreaClearAllPeds() -- ?
PedSetGlobalAttitude_Rumble(true) -- ?
DisablePunishmentSystem(true)

TextPrintString("Complete Mayhem",29,2)
Wait(29000) -- Feel free to change.
 
--Disable Mayhem
currentIndex=0;
for i=1,5 do --iterate through Nerds, Jocks, Dropouts, Greasers and Preps.
    for j=1,13 do -- Iterate from Nerds through to the player.
        if (i~=3 and j ~= 3 and (j<6 or j==13) and i~=j) then -- Ignore Dropouts, only allow Nerd/Jock/Greaser/Prep/Player relationships.  
            PedSetTypeToTypeAttitude(i,j,originalAttitudes[currentIndex]) -- Restore original relationships.
            currentIndex = currentIndex+1;
        end
    end
end
--The following is not only untested, but pure guesswork. EDITME
DisablePOI(false, false)
AreaSetPopulationSexGeneration(true, true)
AreaOverridePopulation()
--AreaClearAllPeds() -- If this is run, it's like a hard undo. Otherwise, let remaining fights linger on.
PedSetGlobalAttitude_Rumble(false)
end
end

function gravity()
     local time = math.random(6500,29000)
    TextPrintString("Gravity Off",29,2)
    PedSetEffectedByGravity(gPlayer,false)
     Wait(time)
    PedSetEffectedByGravity(gPlayer,true)
end
--PedResetAttitudes

--[[function dog()
    TextPrintString("Debug dog",4,2)
     Wait(4000)
    TextPrintString("Detroit Become Dog",29,2)
      PedRequestModel(gPlayer,141) --??
      PlayerSwapModel(141)
     Wait(29000)
      PlayerSwapModel(0) --1
end]] --fix asap

function crabblesnitch()
TextPrintString("You Missed Detention!",29,2)
    local time = math.random(6500,29000)
    local x,y,z = PlayerGetPosXYZ()
    local ped = PedCreateXYZ(65,x+2,y+2,z)
     PedSetWeapon(ped,357)
     GameSetPedStat(ped,20,101)
     PedSetPedToTypeAttitude(ped,13,0)
    Wait(time)
     PedDelete(ped)
end

function invulnerable()
    TextPrintString("Invincible",29,2)
    PlayerSetInvulnerable(true)
     Wait(29500)
    PlayerSetInvulnerable(false)
end

--[[function lag()
    local finishit = 
    local time = math.random(2,950)
     repeat
        PlayerSetControl(0)
         Wait(time)
        PlayerSetControl(1)
     until 
    end
end]]

function bulltime()
TextPrintString("Debug Bull",4,2)
Wait(4000)
TextPrintString("Bullworth Bulls!",29,2)
    ClothingGetPlayer()
    local originalClothing = ClothingBackup()
     ClothingGivePlayerOutfit("Mascot")
     ClothingSetPlayerOutfit("Mascot")
     ClothingBuildPlayer()
     Wait(29000)
    ClothingRestore(originalClothing)
    ClothingBuildPlayer()
    Wait(1)
end

function nohud()
TextPrintString("Debug HUD",4,2)
 Wait(4000)
TextPrintString("No HUD",29,2)
 HUDSaveVisibility()
 HUDClearAllElements()
 PauseGameClock()
  Wait(29000)
 HUDRestoreVisibility()
 UnpauseGameClock()
end

function fov()
local random = math.random(95,175)
 TextPrintString("Debug FOV",4,2)
  Wait(4000)
 TextPrintString("Crazy FOV")
CameraGetFOV()
 CameraSetFOV(random)
  Wait(29000)
 CameraDefaultFOV()
end

--[[function cower()
TextPrintString("Debug Cower",4,2)
 Wait(4000)
TextPrintString("Cower in Fear!",29,2)
 GetTimer() + 29000
 local time = math.random(200,1650)
repeat
    --not sure if something is needed here.
 PedSetActionNode(gPlayer,"/Global/1_07/Cower","Act/Conv/1_07.act")
 Wait(time)
 Wait(3000)
until GetTimer() = nil
end]]--will just make a randomised animation function.
