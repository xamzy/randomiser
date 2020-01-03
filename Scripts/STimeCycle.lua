LaunchScript("randomiser.lua")
main = function()
	while not SystemIsReady() do
		Wait(0)
	end
	while true do
		Wait(0)
	end
end

F_StartClass = function()
	if not IsMissionCompleated("3_08") or IsMissionCompleated("3_08_PostDummy") then
		F_RingSchoolBell() 
	end
end
F_EndClass = function()
	if not IsMissionCompleated("3_08") or IsMissionCompleated("3_08_PostDummy") then
		F_RingSchoolBell()
	end
end
F_AttendedClass = function()
	if not IsMissionCompleated("3_08") or IsMissionCompleated("3_08_PostDummy") then
		SetSkippedClass(false)
		PlayerSetPunishmentPoints(0)
	end
end
F_MissedClass = function()
	if not IsMissionCompleated("3_08") or IsMissionCompleated("3_08_PostDummy") then
		SetSkippedClass(true)
		StatAddToInt(166)
	end
end
F_UpdateTimeCycle = function()
	if not IsMissionCompleated("1_B") then
		local day = GetCurrentDay(false)
		if day < 0 or day > 2 then
			SetCurrentDay(0)
		end
	end
	F_UpdateCurfew()
end
F_UpdateCurfew = function()
	(shared.gCurfewRules or F_CurfewDefaultRules)()
end
F_CurfewDefaultRules = function()
	local t = ClockGet()
	shared.gCurfew = t >= 23 or t < 7
end
F_Nothing = function()
	
end
F_ClassWarning = F_Nothing
F_StartMorning = F_UpdateTimeCycle
F_EndMorning = F_UpdateTimeCycle
F_StartLunch = F_UpdateTimeCycle
F_EndLunch = F_UpdateTimeCycle
F_StartAfternoon = F_UpdateTimeCycle
F_EndAfternoon = F_UpdateTimeCycle
F_StartEvening = F_UpdateTimeCycle
F_EndEvening = F_UpdateTimeCycle
F_StartCurfew_SlightlyTired = F_UpdateTimeCycle
F_StartCurfew_Tired = F_UpdateTimeCycle
F_StartCurfew_MoreTired = F_UpdateTimeCycle
F_StartCurfew_TooTired = F_UpdateTimeCycle
F_EndCurfew_TooTired = F_UpdateTimeCycle
F_EndTired = F_UpdateTimeCycle
