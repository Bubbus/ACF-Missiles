



ACFM_EffectOverrides = 
{
	FLR = function(self, Bullet)
	
		local setPos = Bullet.SimPos
		
		if((math.abs(setPos.x) > 16000) or (math.abs(setPos.y) > 16000) or (setPos.z < -16000)) then
		
			self:Remove()
			return
			
		end
		
		
		if( setPos.z < 16000 ) then
		
			self:SetPos( setPos )--Moving the effect to the calculated position
			self:SetAngles( Bullet.SimFlight:Angle() )
			
		end
		
		
		if Bullet.Tracer then
		
			Bullet.Tracer:Finish()
			Bullet.Tracer = nil
		
		end
		
		
		if not self.FlareEffect then
		
			ParticleEffectAttach( "ACFM_Flare", PATTACH_ABSORIGIN_FOLLOW, self, 0 )
			self.FlareEffect = true
		
		end
	
	end
}




-- For finding bullet effects which have special ammo-types and making them look different.
function ACFM_EffectTryOverride(ent)
	
	if ent:GetClass() == "class CLuaEffect" then
		-- wish there was a better way... could modify the bullet effect to call a hook...
		timer.Simple(0.01, function() ACFM_InspectEffect(ent) end)
	end

end


hook.Add("OnEntityCreated", "ACFM_EffectTryOverride", ACFM_EffectTryOverride)




function ACFM_InspectEffect(ent)
	
	print("ACFM_EffectOverride", ent, ent.Index, ACF.BulletEffect[ent.Index])
	
	local index = ent.Index
	if not index then return end
	
	local bullet = ACF.BulletEffect[index]
	if not (bullet and bullet.AmmoType) then return end
	
	local override = ACFM_EffectOverrides[bullet.AmmoType]
	
	if override then
		ent.ApplyMovement = override	
	end

end



