include("shared.lua")
include("disable_pvp/cl_do_pvp_pause.lua")

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

net.Receive("PointsGet", function()
	net.Start( "PointsReturn" )
		net.WriteInt(points,16)
	net.SendToServer()
end)
