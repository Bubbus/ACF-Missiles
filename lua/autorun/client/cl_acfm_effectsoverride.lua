

ACFM_EffectOverrides = 
{
	FLR = function(self, Bullet)
	
		local setPos = Bullet.SimPos
		if((math.abs(setPos.x) > 16000) or (math.abs(setPos.y) > 16000) or (setPos.z < -16000)) then
			self:Remove()
			return
		end
		if( setPos.z < 16000 ) then
			self:SetPos( Bullet.SimPos )--Moving the effect to the calculated position
			self:SetAngles( Bullet.SimFlight:Angle() )
		end
		
		if Bullet.Tracer then
			local DeltaTime = CurTime() - Bullet.LastThink
			local DeltaPos = Bullet.SimFlight*DeltaTime
			local Length =  math.max(DeltaPos:Length()*2,1)
			local MaxSprites = 2 
				local Light = Bullet.Tracer:Add( "sprites/acf_tracer.vmt", Bullet.SimPos - DeltaPos )
				if (Light) then		
					Light:SetAngles( Bullet.SimFlight:Angle() )
					local vel = VectorRand()
					vel.z = math.abs(vel.z)
					Light:SetVelocity( vel * 200 )
					Light:SetColor( 255, 0, 0 )
					Light:SetDieTime( 0.5 ) -- 0.075, 0.1
					Light:SetStartAlpha( 255 )
					Light:SetEndAlpha( 155 )
					Light:SetStartSize( 128 ) -- 5
					Light:SetEndSize( 1 )
					Light:SetStartLength( Length )
					Light:SetEndLength( 1 )
				end
			for i=1, MaxSprites do
				local Smoke = Bullet.Tracer:Add( "particle/smokesprites_000"..math.random(1,9), Bullet.SimPos - (DeltaPos*i/MaxSprites) )
				if (Smoke) then		
					Smoke:SetAngles( Bullet.SimFlight:Angle() )
					Smoke:SetVelocity( Bullet.SimFlight*0.05 )
					Smoke:SetColor( 200 , 200 , 200 )
					Smoke:SetDieTime( 0.6 ) -- 1.2
					Smoke:SetStartAlpha( 10 )
					Smoke:SetEndAlpha( 0 )
					Smoke:SetStartSize( 128 )
					Smoke:SetEndSize( Length/400*Bullet.Caliber )
					Smoke:SetRollDelta( 0.1 )
					Smoke:SetAirResistance( 150 )
					Smoke:SetGravity( Vector(0,0,20) )
				end
			end
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



