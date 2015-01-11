-- shared.lua

DEFINE_BASECLASS("base_wire_entity")
ENT.Type        	= "anim"
ENT.Base        	= "base_wire_entity"
ENT.PrintName 		= "XCF Rack"
ENT.Author 			= "Bubbus"
ENT.Contact 		= "splambob@googlemail.com"
ENT.Purpose		 	= "Because launch tubes aren't cool enough."
ENT.Instructions 	= "Point towards face for removal of face.  Point away from face for instant fake tan (then removal of face)."

ENT.Spawnable 		= false
ENT.AdminOnly		= false
ENT.AdminSpawnable = false


function ENT:GetOverlayText()
	local name = self:GetNetworkedString("WireName")
	local GunType = self:GetNetworkedBeamString("GunType")
	local Ammo = self:GetNetworkedBeamInt("Ammo")
	local FireRate = self:GetNetworkedBeamInt("Interval")
	local txt = GunType.." ("..Ammo.." left) \nFire interval: "..FireRate or ""
	if (not game.SinglePlayer()) then
		local PlayerName = self:GetPlayerName()
		txt = txt .. "\n(" .. PlayerName .. ")"
	end
	if(name and name ~= "") then
	    if (txt == "") then
	        return "- "..name.." -"
	    end
	    return "- "..name.." -\n"..txt
	end
	return txt
end




function ENT:GetMunitionAngPos(rack, attach, attachname)
	local angpos
	--print(rack, attach, attachname)
	
	if attach ~= 0 then
		angpos = self:GetAttachment(attach)
	else
		angpos = {Pos = self:GetPos(), Ang = self:GetAngles()}
	end
	
	local gun = ACF.Weapons.Guns[rack.Id]
	if not gun then return angpos end
	
    --pbn(gun)
	if not gun then return angpos end
	
    local offset = (rack.Caliber or gun.caliber) / 2.54
    
	mountpoint = gun.mountpoints[attachname] or {["offset"] = Vector(0,0,0), ["scaledir"] = Vector(0, 0, -1)}
	angpos.Pos = angpos.Pos + (self:LocalToWorld(mountpoint.offset) - self:GetPos()) + (self:LocalToWorld(mountpoint.scaledir) - self:GetPos()) * offset
	
	return angpos
end
