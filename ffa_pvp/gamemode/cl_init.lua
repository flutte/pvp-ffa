include("shared.lua")
include("disable_pvp/cl_do_pvp_pause.lua")

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
net.Receive("LevelUpdate",function() end
	local l = net.ReadInt(16)
	level = l
end)
net.Receive("GetLevel",function() end
	net.Start("ReturnLevel")
		net.WriteInt(level,16)
	net.SendToServer()
end)