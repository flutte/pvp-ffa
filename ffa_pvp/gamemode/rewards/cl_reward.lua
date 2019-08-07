local level = 0
local points = 0
net.Receive("PointsGive", function(len, pointAmount, victim)
	local pointsToAdd = net.ReadInt(16)
	points = points+pointsToAdd
	LocalPlayer():ChatPrint("You got "..pointsToAdd.." points!")
end)

net.Receive("PointsTake", function(len, pointAmount)
	local pointseri = net.ReadInt(16)
	points = points-pointseri
end)

function CheckPoints()
	if (points >= 50) then
		net.Start( "reward1" )
		net.SendToServer()
	elseif (points >= 100) then
		net.Start( "reward2" )
		net.SendToServer()
	elseif (points >= 150) then
		net.Start( "reward3" )
		net.SendToServer()
	end
end

net.Receive("LevelUpdate",function()
	local l = net.ReadInt(16)
	level = l
end)
net.Receive("GetLevel",function()
	net.Start("ReturnLevel")
		net.WriteInt(level,16)
	net.SendToServer()
end)

hook.Add("OnPlayerChat","CheckLevelAmount", function( ply, text, teamChat, isDead )
	local plyr = LocalPlayer()
	if (ply == plyr and text == "!lvl") then
		ply:PrintMessage( HUD_PRINTTALK, "Your level is "..level.."." )
		CheckPoints()
	end
end)
hook.Add("OnPlayerChat","CheckPointAmount", function( ply, text, teamChat, isDead )
	local plyr = LocalPlayer()
	if (ply == plyr and text == "!points") then
		ply:PrintMessage( HUD_PRINTTALK, "You have ".. points .." points." )
		CheckPoints()
	end
end)

hook.Add("OnPlayerChat","modelchanging_1", function(ply,text,team,isdead) 
	if (level == 1 and string.sub(text,1,7) == "!model") then
		if (string.sub(text,7) != "alyx" or string.sub(text,7) != "odessa" or string.sub(text,7) != "gman") then
			ply:PrintMessage( HUD_PRINTTALK, "Thats not a correct model! Models available: gman,odessa,alyx")
		else
			if (string.sub(text,7) == "alyx") then
				net.Start( "alyx_model" )
					net.WriteString("models/alyx.mdl")
				net.SendToServer()
			elseif (string.sub(text,7) == "odessa") then
				net.Start( "odessa_model" )
					net.WriteString("models/odessa.mdl")
				net.SendToServer()
			elseif (string.sub(text,7) == "gman") then
				net.Start( "odessa_model" )
					net.WriteString("models/odessa.mdl")
				net.SendToServer()
			end
		end
	elseif (level != 1 and string.sub(text,1,6) == "!model") then
		ply:PrintMessage( HUD_PRINTTALK, "You dont have the required level!")
	end
end)