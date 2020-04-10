--AddCSLuaFiles
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("net/sv_net.lua")


--Actions to do after player spawns.
function GM:PlayerInitialSpawn(ply)

	print("Player "..ply:Name().." has spawned.")
	PlayerSetDefModel( ply )
	GiveDefWeapons( ply )

end

function GM:PlayerConnect(name, ip)

	print("Player "..name.." connected with IP ("..ip..")")
	for k,v in pairs(player.GetAll) do
		v:ChatPrint("Player "..name.." joined.")
	end

end

--Default model & color
function PlayerSetDefModel( ply )

	ply:SetModel( "models/player/kleiner.mdl" )
	ply:SetColor( Color( 255, 0, 0, 255) )

end

--Give all default weapons
function GiveDefWeapons( ply )

	ply:Give( "weapon_357", false)
	ply:Give( "weapon_crossbow", false )
	ply:Give( "weapon_smg1", false )

end

--Give ammo as a reward for killing
function GiveAmmoReward( ply )

	ply:GiveAmmo( 200, "357", true )
	ply:GiveAmmo( 200, "XBowBolt", true )
	ply:GiveAmmo( 200, "SMG1", true )

end

--What to do when a player gets a kill?
function GetAKill( ply )

	ply:SetHealth( 100 )
	GiveAmmoReward( ply )

end

function GM:PlayerSpawn( ply ) 
	GiveDefWeapons(ply)
	GiveAmmoReward(ply)
end


--What to do when a player dies?
function GM:PlayerDeath( victim, inflictor, attacker )
	if ( victim == attacker ) then -- If the person suicided
		PrintMessage( HUD_PRINTTALK, victim:Name() .. " committed suicide." ) -- print in chat that the person committed suicide.
	else -- If the person didn't suicide
		local points = 0
		if (inflictor:GetClass() == "weapon_crossbow") then --If the weapon that killed the player is crossbow, give specific amount of points to the attacker.
			points = 3
		elseif (inflictor:GetClass() == "weapon_357") then --If the weapon that killed the player is .357, give specific amount of points to the attacker.
			points = 4
		elseif (inflictor:GetClass() == "weapon_smg1") then
			points = 1
		end
		PrintMessage( HUD_PRINTTALK, victim:Name() .. "(-1) was killed by " .. attacker:Name() .."(+"..points..")." ) --Print chat
		GetAKill( attacker ) -- run GetAKill function on the attacker
		GivePoint( points, attacker, victim ) -- give points to the attacker, depending on the weapon
		TakePoint( 1, victim, attacker )
	end
end
