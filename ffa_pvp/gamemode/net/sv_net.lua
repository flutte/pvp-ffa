util.AddNetworkString("GivePoint")
util.AddNetworkString("TakePoint")
util.AddNetworkString("PointsGet")
util.AddNetworkString("ReturnLevel")

--Give player points
function GivePoint(points, ply, victim)
	net.Start( "PointsGive" )
		net.WriteInt( points,16 )
	net.Send(ply)
end

--Takes points away from the player
function TakePoint(points, ply, attacker)
	net.Start( "PointsTake" )
		net.WriteInt( points,16 )
	net.Send( ply )
end

--Get number of points
function PointsGet(ply)
	net.Start("PointsGet")
	net.Send(ply)
end
net.Receive("ReturnLevel",function()
	getpoints = net.ReadInt(16)
end)
