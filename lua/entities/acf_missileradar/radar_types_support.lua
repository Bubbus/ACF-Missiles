print("radar type support loaded")


ACFM.RadarBehaviour = ACFM.RadarBehaviour or {}
ACFM.DefaultRadarSound = ACFM.DefaultRadarSound or "buttons/button16.wav"

ACFM.RadarBehaviour["DIR"] = 
{
	GetDetectedEnts = function(self)
		return ACFM_GetMissilesInCone(self:GetPos(), self:GetForward(), self.ConeDegs)
	end
}


ACFM.RadarBehaviour["OMNI"] = 
{
	GetDetectedEnts = function(self)
		return ACFM_GetMissilesInSphere(self:GetPos(), self.Range)
	end
}