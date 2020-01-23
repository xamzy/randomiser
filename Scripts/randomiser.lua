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
StartRandom = function() -- random value based on points system
	gRandom = {p=0}
end
AddRandom = function(points,value)
	if points >= 1 then
		gRandom.p = gRandom.p + math.floor(points)
		gRandom[gRandom.p] = value
	end
end
GetRandom = function()
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
AddRandom(5,"justdie")
AddRandom(40,"lockup")
AddRandom(85,"arcadecam")
AddRandom(80,"halfspeed")
AddRandom

--AddRandom("pedspawner")
--AddRandom("qte")
TextPrintString(GetRandom(),1,1)]]


function T_RandomFuncs()
    local funcs = {gokart,teleportation}--justdie,lockup,sheldonatorspawner,arcadecam,halfspeed,doublespeed,takedamage,wanted,snow,gokart,money,onehitko,gravity,invulnerable,bulltime,nohud,fov,weather,pedspawner,lockup,arcadecam,sheldonatorspawner,teleportation,halfspeed,doublespeed,takedamage,wanted,snow,money,onehitko,gokart,justdie,negmoney,haveacar,mayhem,qte,weather,weapons
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
    peds = PedCreateXYZ(math.random(2,258),x+i,y,z)
    end
    PedSetPedToTypeAttitude(peds,13,0)
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
 until PedIsDead(gPlayer) or PedIsDead(gSheldonator)
end

--[[function randomteleportation() --40% Complete
 TextPrintString("Debug Teleportation",4,2)
  Wait(4000)
 TextPrintString("Teleported to Random Location",29,2)
local locTable = {
    "0,265, -110, 6", --outside dorm
    "2,-628.28, -312.97, 0.00",--schoolhallways
    "4,-599.08, 325.00, 34.22",--chemlab
    "5,-701.37, 214.76, 31.55",--principals office
    "6,-711.12, 312.25, 33.38",--biology lab
    "8,-730.91, -56.17, 9.89",--janitor room
    "9,-786.53, 202.86, 90.13",--library
    "13,-622.60, -72.63, 59.61",--pool
    "14,-502.28, 310.96, 31.41",--boysdorm
    "15,-560.40, 315.86, -1.95",--classroom
    "16,-655.90, 81.57, 9.99",--trailer
    "17,-537.39, 375.90, 14.03",--artroom
    "18,-427.33, 364.87, 80.84",--autoshop
    "19,-778.50, 294.50, 77.47",--auditorium
    "20,-755.68, 96.27, 30.80",--chemplant
    "23,-654.19, 227.29, -0.39",--staffroom
    "26,-572.13, 387.32, 0.07",--grocery store
    "27,-723.70, 371.16, 294.41",--boxing ring
    "29,-785.62, 379.38, 0.00",--bike shop vale
    "30,-724.71, 14.51, 0.00",--comic shop vale
    "32,-567.37, 133.24, 46.15",--prep house
    "33,-707.84, 259.35, 0.00",--rich clothing
    "34,-647.37, 257.80, 0.93",--poor clothing
    "35,-439.02, 318.77, -7.90",--girls dorm
    "36,-544.59, -49.03, 31.00",--tenements
    "37,-711.86, -537.98, 8.10",--house of mirrors
    "38,-735.31, 422.98, 2.00",--asylum
    "39,-655.66, 124.12, 2.99",--barber
    "40,-694.96, 75.75, 20.25",--observ
    "42,-310.60, 496.36, 1.00",--gokart
    "43,-753.54, -606.70, 6.75",--junkyard
    "45,-793.77, 90.96, 9.96",--midway
    "46,-766.53, 21.18, 2.95",--hair salon
    "50,-792.76, 47.74, 6.69",--souvenir
    "51,-88.38, 68.73, 26.63",--imgraceA
    "52,-36.88, 38.91, 0.45",--imgraceB
    "53,-39.78, 62.38, 62.15",--imgraceC
    "54,-672.29, -169.27, 0.06",--warehouse
    "55,-469.43, -77.54, 9.07",--freakshow
    "56,-664.98, 390.62, 2.43",--poor barbers
    "57,-655.29, 246.27, 15.22",--idropouts
    "59,-748.85, 348.84, 3.51",--ijocks
    "60,-773.40, 351.50, 6.41",--ipreps
    "61,-691.91, 344.91, 3.29",--igreasers
    "62,-775.55, 634.97, 29.11",--bmxtracks
}
local count = table.getn(locTable)
    while true do
     locTable[AreaTransitionXYZ(math.random(1,count))]()
    end
end]]

function telebdorm()
TextPrintString("Debug Bdorm",4,2)
 Wait(4000)
TextPrintString("Teleported to Boys Dorm",5,2)
    AreaTransitionXYZ(14, -502.28, 310.96, 31.41)
    Wait(5000)
end

function teletenements()
TextPrintString("Debug tenements",4,2)
 Wait(4000)
TextPrintString("Teleported to Tenements",5,2)
    AreaTransitionXYZ(36, -544.59, -49.03, 31.00)
    Wait(5000)
end

function telelibrary()
TextPrintString("Debug library",4,2)
 Wait(4000)
TextPrintString("Teleported to Library",5,2)
    AreaTransitionXYZ(9, -786.53, 202.86, 90.13)
    Wait(5000)
end

function telegrocery()
TextPrintString("Debug grocery",4,2)
 Wait(4000)
TextPrintString("Teleported to Grocery Store",5,2)
    AreaTransitionXYZ(26, -572.13, 387.32, 0.07)
    Wait(5000)
end

function telebmx()
TextPrintString("Debug BMX",4,2)
 Wait(4000)
TextPrintString("Teleported to BMX Park",5,2)
    AreaTransitionXYZ(62,-775.55, 634.97, 29.11)
    Wait(5000)
end

function telefinalcut()
TextPrintString("Debug finalcut",4,2)
 Wait(4000)
TextPrintString("Teleported to Final Cut",5,2)
    AreaTransitionXYZ(34,-647.37, 257.80, 0.93)
    Wait(5000)
end

function teleaquaberry()
TextPrintString("Debug aqua",4,2)
 Wait(4000)
TextPrintString("Teleported to Aquaberry Clothing",5,2)
    AreaTransitionXYZ(33, -707.84, 259.35, 0.00)
    Wait(5000)
end

function telefreaks()
TextPrintString("Debug freaks",4,2)
 Wait(4000)
TextPrintString("Teleported to Freakshow",5,2)
    AreaTransitionXYZ(55,-469.43, -77.54, 9.07)
    Wait(5000)
end


--[[MAIN_MAP        0   0.00, 0.00, 0.00
SCHOOLHALLWAYS  2   -628.28, -312.97, 0.00             
CHEM_LAB        4   -599.08, 325.00, 34.22
PRINCIPAL       5   -701.37, 214.76, 31.55
BIO_LAB         6   -711.12, 312.25, 33.38
JANITORSROOM    8   -730.91, -56.17, 9.89
LIBRARY         9   -786.53, 202.86, 90.13
POOL            13  -622.60, -72.63, 59.61
BOYS_DORM       14  -502.28, 310.96, 31.41
CLASSROOM       15  -560.40, 315.86, -1.95
TRAILER         16  -655.90, 81.57, 9.99
ART_ROOM        17  -537.39, 375.90, 14.03
AUTOSHOP        18  -427.33, 364.87, 80.84
AUDITORIUM      19  -778.50, 294.50, 77.47
CHEM_PLANT      20  -755.68, 96.27, 30.80
Staff_Room      23  -654.19, 227.29, -0.39
GroceryStore    26  -572.13, 387.32, 0.07
BoxingRing      27  -723.70, 371.16, 294.41
BIKE_SHOP_RICH  29  -785.62, 379.38, 0.00
COMIC_SHOP_RICH 30  -724.71, 14.51, 0.00
PREP_HOUSE      32  -567.37, 133.24, 46.15
RICH_CLOTH      33  -707.84, 259.35, 0.00
POOR_CLOTH      34  -647.37, 257.80, 0.93
GIRLS_DORM      35  -439.02, 318.77, -7.90
TENEMENT        36  -544.59, -49.03, 31.00
HOUSEOFMIRRORS  37  -711.86, -537.98, 8.10
ASYLUM          38  -735.31, 422.98, 2.00
BARBER          39  -655.66, 124.12, 2.99
OBSERVATORY     40  -694.96, 75.75, 20.25
TGOKART         42  -310.60, 496.36, 1.00
JUNKYARD        43  -753.54, -606.70, 6.75
MIDWAY          45  -793.77, 90.96, 9.96
HAIR_SALON      46  -766.53, 21.18, 2.95
SOUVENIR        50  -792.76, 47.74, 6.69
IMGRACEA        51  -88.38, 68.73, 26.63
IMGRACEB        52  -36.88, 38.91, 0.45
IMGRACEC        53  -39.78, 62.38, 62.15
WAREHOUSE       54  -672.29, -169.27, 0.06
FREAK_SHOW      55  -469.43, -77.54, 9.07
POOR_HAIR       56  -664.98, 390.62, 2.43
IDROPS          57  -655.29, 246.27, 15.22
IJOCKS          59  -748.85, 348.84, 3.51
IPREPS          60  -773.40, 351.50, 6.41
IGRSRS          61  -691.91, 344.91, 3.29
BMXTRACK        62  -775.55, 634.97, 29.11
end
]]

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

function weather() -- this will be a randomised weather function as well as the snow to fuck you over
TextPrintString("Debug Weather",4,2)
 Wait(4000)
TextPrintString("Random Weather",29,2)
    local originalChapter = ChapterGet()
    local originalWeather = WeatherGet()
        for i=1,5 do 
         ChapterSet(i)
         WeatherSet(i)
        end
    Wait(29000)
     ChapterSet(originalChapter)
     WeatherSet(originalWeather)
    Wait(1000)
end


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
    PedExitVehicle(gPlayer,kart)--untested
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

TextPrintString("Debug Mayhem",4,2)
Wait(4000)
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
--PedResetAttitudes

function gravity()
     local time = math.random(6500,29000)
    TextPrintString("Gravity Off",29,2)
    PedSetEffectedByGravity(gPlayer,false)
     Wait(time)
    PedSetEffectedByGravity(gPlayer,true)
end


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
     PedSetEmotionTowardsPed(ped,gPlayer,0)
     PedGetEmotionTowardsPed(ped,gPlayer)
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

function fallover()
TextPrintString("Debug Fallover",4,2)
 Wait(4000)
TextPrintString("No Running Allowed",29,2)
    local a = 7
    if IsButtonBeingPressed(a,0) then 
        PedSetActionNode(gPlayer,"Collapse","Act/Globals.act")
    end
end

function nopower()
TextPrintString("Debug nopower",4,2)
Wait(4000)
TextPrintString("Jimmy is weak",29,2)
    PedSetDamageGivenMultiplier(gPlayer,2,0.01)
     Wait(29000)
    PedSetDamageGivenMultiplier(gPlayer,2,1) 
end

function bodyguard()
TextPrintString("Debug bodyguard",4,2)
Wait(4000)
TextPrintString("Pete's your Bodyguard",29,2)
    local x,y,z = PlayerGetPosXYZ()
    local bunny = PedCreateXYZ(165,x+1,y,z)
    PedRecruitAlly(gPlayer,bunny)
        Wait(29000)
    PedDismissAlly(gPlayer,bunny)
    PedDelete(bunny)
end

function nothing()
 TextPrintString("Absolutely Nothing, You're Safe",5,2)
    Wait(5000)
end
