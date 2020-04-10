--Receives

net.Receive("PointsGive", function(len, pointAmount, victim)
	local pointsToAdd = net.ReadInt(16)
	points = points+pointsToAdd
	LocalPlayer():ChatPrint("You got "..pointsToAdd.." points!")
end)

net.Receive("PointsTake", function(len, pointAmount)
	local takePoints = net.ReadInt(16)
	points = points-takePoints
end)

net.Receive("LevelUpdate",function()
	local l = net.ReadInt(16)
	level = l
end)
net.Receive("GetLevel",function()
	net.Start("ReturnLevel")
		net.WriteInt(level,16)
	net.SendToServer()
end)