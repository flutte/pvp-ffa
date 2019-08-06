AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

AddCSLuaFile("disable_pvp/cl_do_pvp_pause.lua")
include("disable_pvp/sv_do_pvp_pause.lua")

function GM:PlayerInitialSpawn(ply)

	print("Player "..ply:Name().." has spawned.")
	PlayerSetDefModel( ply )
	GiveDefWeapons( ply )

end

function GM:PlayerConnect(name, ip)

	print("Player "..name.." connected with IP ("..ip..")")

end


function PlayerSetDefModel( ply )

	ply:SetModel( "models/player/kleiner.mdl" )
	ply:SetColor( Color( 255, 0, 0, 255) )

end

function GiveDefWeapons( ply )

	ply:Give( "weapon_357", false)
	ply:Give( "weapon_crossbow", false )
	ply:Give( "weapon_smg1", false )

end

function GiveAmmo( ply )

	ply:GiveAmmo( 200, "357", true )
	ply:GiveAmmo( 200, "XBowBolt", true )
	ply:GiveAmmo( 200, "SMG1", true )

end

function GetAKill( ply )

	ply:SetHealth( "100" )

end