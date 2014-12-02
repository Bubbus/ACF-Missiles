/*
              _____ ______   __  __ _         _ _           
        /\   / ____|  ____| |  \/  (_)       (_) |          
       /  \ | |    | |__    | \  / |_ ___ ___ _| | ___  ___ 
	  / /\ \| |    |  __|   | |\/| | / __/ __| | |/ _ \/ __|
	 / ____ \ |____| |      | |  | | \__ \__ \ | |  __/\__ \
	/_/    \_\_____|_|      |_|  |_|_|___/___/_|_|\___||___/
                                                         
	By Bubbus + Cre8or
	
	A reimplementation of XCF missiles and bombs, with guidance and more.

*/



if not ACF then error("ACF is not installed - ACF Missiles require it!") end


if not ACF_CreateBulletSWEP then

	function ACF_CreateBulletSWEP( BulletData, Swep, LagComp )

		if not IsValid(Swep) then error("Tried to create swep round with no swep or owner!") return end
		
		local owner = Swep:IsPlayer() and Swep or Swep.Owner or BulletData.Owner or Ply or error("Tried to create swep round with unowned swep!")

		BulletData = table.Copy(BulletData)
		
		if LagComp then
			BulletData.LastThink = SysTime()
			
			BulletData.Owner = owner
			BulletData.HandlesOwnIteration = true
			BulletData.OnRemoved = ACF_SWEP_OnRemoved
		end
		
		BulletData.TraceBackComp = 0
		--BulletData.TraceBackComp = owner:GetVelocity():Dot(BulletData.Flight:GetNormalized())
		BulletData.Gun = Swep
		
		BulletData.Filter = BulletData.Filter or {}
		BulletData.Filter[#BulletData.Filter + 1] = Swep
		BulletData.Filter[#BulletData.Filter + 1] = owner
		
		ACF_CustomBulletLaunch(BulletData)
		
		return BulletData
		
	end
	
end




if not ACF_BulletLaunch then

	function ACF_BulletLaunch(BData)

		ACF.CurBulletIndex = ACF.CurBulletIndex + 1		--Increment the index
		if ACF.CurBulletIndex > ACF.BulletIndexLimt then
			ACF.CurBulletIndex = 1
		end

		local cvarGrav = GetConVar("sv_gravity")
		BData.Accel = Vector(0,0,cvarGrav:GetInt()*-1)			--Those are BData settings that are global and shouldn't change round to round
		BData.LastThink = BData.LastThink or SysTime()
		BData["FlightTime"] = 0
		--BData["TraceBackComp"] = 0
		local Owner = BData.Owner
		
		if BData["FuseLength"] then
			BData["InitTime"] = SysTime()
		end
		
		if not BData.TraceBackComp then											--Check the Gun's velocity and add a modifier to the flighttime so the traceback system doesn't hit the originating contraption if it's moving along the shell path
			if IsValid(BData.Gun) then
				BData["TraceBackComp"] = BData.Gun:GetPhysicsObject():GetVelocity():Dot(BData.Flight:GetNormalized())
			else
				BData["TraceBackComp"] = 0
			end
		end
		
		BData.Filter = BData.Filter or { BData["Gun"] }
			
		if XCF and XCF.Ballistics then
			BData = XCF.Ballistics.Launch(BData)
			--XCF.Ballistics.CalcFlight( BulletData.Index, BulletData )
		else
			BData.Index = ACF.CurBulletIndex
			ACF.Bullet[ACF.CurBulletIndex] = BData		--Place the bullet at the current index pos
			ACF_BulletClient( ACF.CurBulletIndex, ACF.Bullet[ACF.CurBulletIndex], "Init" , 0 )
			--ACF_CalcBulletFlight( ACF.CurBulletIndex, ACF.Bullet[ACF.CurBulletIndex] )
		end
		
	end

end



if not ACF_CustomBulletLaunch then

	function ACF_CustomBulletLaunch(BData)

		ACF_BulletLaunch(BData)
		
		if BData.HandlesOwnIteration then
			bullets[BData.Owner] = bullets[BData.Owner] or {}
			local btbl = bullets[BData.Owner]
			local btblIdx = #btbl+1
			BData.OwnerIndex = btblIdx
			btbl[btblIdx] = BData
		end
		
	end

end



if not ACF_ExpandBulletData then

	function ACF_ExpandBulletData(bullet)

		//print("expand bomb")
		//print(debug.traceback())

		/*
		print("\n\nBEFORE EXPAND:\n")
		printByName(bullet)
		//*/

		local toconvert = {}
		toconvert["Id"] = 			bullet["Id"] or "12.7mmMG"
		toconvert["Type"] = 		bullet["Type"] or "AP"
		toconvert["PropLength"] = 	bullet["PropLength"] or 0
		toconvert["ProjLength"] = 	bullet["ProjLength"] or 0
		toconvert["Data5"] = 		bullet["FillerVol"] or bullet["Flechettes"] or bullet["Data5"] or 0
		toconvert["Data6"] = 		bullet["ConeAng"] or bullet["FlechetteSpread"] or bullet["Data6"] or 0
		toconvert["Data7"] = 		bullet["Data7"] or 0
		toconvert["Data8"] = 		bullet["Data8"] or 0
		toconvert["Data9"] = 		bullet["Data9"] or 0
		toconvert["Data10"] = 		bullet["Tracer"] or bullet["Data10"] or 0
		toconvert["Colour"] = 		bullet["Colour"] or Color(255, 255, 255)
			
		/*
		print("\n\nTO EXPAND:\n")
		printByName(toconvert)
		//*/
			
		local rounddef = ACF.RoundTypes[bullet.Type] or error("No definition for the shell-type", bullet.Type)
		local conversion = rounddef.convert
		--print("rdcv", rounddef, conversion)
		
		if not conversion then error("No conversion available for this shell!") end
		local ret = conversion( nil, toconvert )
		
		--ret.ProjClass = this
		
		ret.Pos = bullet.Pos or Vector(0,0,0)
		ret.Flight = bullet.Flight or Vector(0,0,0)
		ret.Type = ret.Type or bullet.Type
		
		local cvarGrav = GetConVar("sv_gravity")
		ret.Accel = Vector(0,0,cvarGrav:GetInt()*-1)
		if ret.Tracer == 0 and bullet["Tracer"] and bullet["Tracer"] > 0 then ret.Tracer = bullet["Tracer"] end
		ret.Colour = toconvert["Colour"]
		/*
		print("\n\nAFTER EXPAND:\n")
		printByName(ret)
		//*/
		
		return ret

	end

end



if not ACF_MakeCrateForBullet then

	function ACF_MakeCrateForBullet(self, bullet)

		if not (type(bullet) == "table") then
			--print("we got swep?")
			if bullet.BulletData then
				self:SetNetworkedString( "Sound", bullet.Primary and bullet.Primary.Sound or nil)
				self.Owner = bullet:GetOwner()
				self:SetOwner(bullet:GetOwner())
				bullet = bullet.BulletData
			end
		end
		
		
		self:SetNetworkedInt( "Caliber", bullet.Caliber or 10)
		self:SetNetworkedInt( "ProjMass", bullet.ProjMass or 10)
		self:SetNetworkedInt( "FillerMass", bullet.FillerMass or 0)
		self:SetNetworkedInt( "DragCoef", bullet.DragCoef or 1)
		self:SetNetworkedString( "AmmoType", bullet.Type or "AP")
		self:SetNetworkedInt( "Tracer" , bullet.Tracer or 0)
		local col = bullet.Colour or self:GetColor()
		self:SetNetworkedVector( "Color" , Vector(col.r, col.g, col.b))
		self:SetNetworkedVector( "TracerColour" , Vector(col.r, col.g, col.b))
		self:SetColor(col)

	end
	
end