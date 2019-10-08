--DO NOT EDIT OR REUPLOAD THIS FILE



ENT.Type            = "anim"

DEFINE_BASECLASS( "lunasflightschool_basescript_heli" )



ENT.PrintName = "LAAT Gunship"

ENT.Author = "Riddick & Evan"

ENT.Information = "www.projectrenegade.net"

ENT.Category = "[LFS] Renegade"



ENT.Spawnable			= true

ENT.AdminSpawnable		= false

 

ENT.MDL = "models/renegade/vehicles/laat3test4.mdl"

ENT.GibModels = {

	"models/salza/arc170_gib1.mdl",

	"models/salza/arc170_gib2.mdl",

	"models/salza/arc170_gib3.mdl",

	"models/salza/arc170_gib4.mdl",

	"models/salza/arc170_gib5.mdl",

	"models/salza/arc170_gib6.mdl"

} 



ENT.AITEAM = 2

ENT.Mass = 4000
ENT.Inertia = Vector(10000,10000,10000)
ENT.Drag = 1

ENT.SeatPos = Vector(270,0,135)
ENT.SeatAng = Angle(0,-90,0)

ENT.IdleRPM = 1
ENT.MaxRPM = 2600
ENT.LimitRPM = 3200
ENT.RPMThrottleIncrement = 1300

ENT.RotorPos = Vector(200,0,10)
ENT.WingPos = Vector(-100,0,200)
ENT.ElevatorPos = Vector(-200,0,100)
ENT.RudderPos = Vector(-200,0,10)

ENT.MaxVelocity = 2500

ENT.MaxThrust = 5000

ENT.Stability = .9

ENT.MaxTurnPitch = 300
ENT.MaxTurnYaw = 600
ENT.MaxTurnRoll = 50

ENT.MaxPerfVelocity = 1500

ENT.MaxHealth = 30000
ENT.MaxShield = 600

ENT.VerticalTakeoff = true
ENT.VtolAllowInputBelowThrottle = 10000
ENT.MaxThrustVtol = 10000

ENT.MaxThrustHeli = 2500
ENT.MaxTurnPitchHeli = 130
ENT.MaxTurnYawHeli = 150

ENT.ThrustEfficiencyHeli = 0.7

ENT.MaxPrimaryAmmo = 1000
ENT.MaxSecondaryAmmo = 6



function ENT:SetupDataTables()

    self:NetworkVar( "Entity",0, "Driver" )

    self:NetworkVar( "Entity",1, "DriverSeat" )

    self:NetworkVar( "Entity",2, "Gunner" )

    self:NetworkVar( "Entity",3, "GunnerSeat" )

    

    self:NetworkVar( "Bool",0, "Active" )

    self:NetworkVar( "Bool",1, "EngineActive" )

    self:NetworkVar( "Bool",2, "AI",    { KeyName = "aicontrolled",    Edit = { type = "Boolean",    order = 1,    category = "AI"} } )

    self:NetworkVar( "Bool",3, "IsGroundTouching" )

    self:NetworkVar( "Bool",4, "RotorDestroyed" )

	self:NetworkVar( "Bool", 5, "RightBallFiring")

	self:NetworkVar( "Bool", 6, "LeftBallFiring")

	self:NetworkVar( "Bool", 7, "RightTopBallFiring")

	self:NetworkVar( "Bool", 8, "RightBottomBallFiring")

	self:NetworkVar( "Bool", 9, "LeftTopBallFiring")

	self:NetworkVar( "Bool", 10, "LeftBottomBallFiring")

    

	self:NetworkVar("Angle",1,"WingAngle")

	

    self:NetworkVar( "Int",2, "AITEAM", { KeyName = "aiteam", Edit = { type = "Int", order = 2,min = 0, max = 2, category = "AI"} } )

    

    self:NetworkVar( "Float",0, "LGear" )

    self:NetworkVar( "Float",1, "RGear" )

    self:NetworkVar( "Float",2, "RPM" )

    self:NetworkVar( "Float",3, "RotPitch" )

    self:NetworkVar( "Float",4, "RotYaw" )

    self:NetworkVar( "Float",5, "RotRoll" )

    self:NetworkVar( "Float",6, "HP", { KeyName = "health", Edit = { type = "Float", order = 2,min = 0, max = self.MaxHealth, category = "Misc"} } )

    

    self:NetworkVar( "Float",7, "Shield" )

    

    self:NetworkVar( "Int",0, "AmmoPrimary", { KeyName = "primaryammo", Edit = { type = "Int", order = 3,min = 0, max = self.MaxPrimaryAmmo, category = "Weapons"} } )

    self:NetworkVar( "Int",1, "AmmoSecondary", { KeyName = "secondaryammo", Edit = { type = "Int", order = 4,min = 0, max = self.MaxSecondaryAmmo, category = "Weapons"} } )

	self:NetworkVar("Int",3,"EngineState")

    if SERVER then

        self:NetworkVarNotify( "AI", self.OnToggleAI )

	self:SetWingAngle(Angle(0,0,0))

        self:SetAITEAM( self.AITEAM )

        self:SetHP( self.MaxHealth )

        self:SetShield( self.MaxShield )

		self:SetRightBallFiring(false)

		self:SetLeftBallFiring(false)

		self:SetRightTopBallFiring(false) 

		self:SetLeftTopBallFiring(false) 

		self:SetRightBottomBallFiring(false) 

		self:SetLeftBottomBallFiring(false)

        self:OnReloadWeapon()

		self:SetEngineState(0)

    end

    

    self:AddDataTables()

end



function ENT:GetMaxTurnSpeedHeli()

	return  {p = self.MaxTurnPitchHeli, y = self.MaxTurnYawHeli, r = self.MaxTurnRollHeli }

end



function ENT:GetMaxThrustHeli()

	return self.MaxThrustHeli

end



function ENT:GetThrustEfficiency()

	self.ThrustEfficiencyHeli = self.ThrustEfficiencyHeli or 0.7

	return math.Clamp( self.ThrustEfficiencyHeli ,0.1 ,1 )

end



function ENT:GetRotorAngle()

	return self:LocalToWorldAngles( self.RotorAngle )

end



function ENT:GetRotorRadius()

	return self.RotorRadius

end



function ENT:IsHelicopter()

	return false

end

if CLIENT then



end

sound.Add( {

	name = "PRLAAT_FRONTFIRE",

	channel = CHAN_WEAPON,

	volume = 1.0,

	level = 125,

	pitch = {95, 105},

	sound = "renegadelaat/twinfire.wav"

} )



sound.Add( {

	name = "PRLAAT_BEAMLOOP",

	channel = CHAN_WEAPON,

	volume = 1.0,

	level = 125,

	sound = "renegadelaat/laserloop.wav"

} )



sound.Add( {

	name = "PRLAAT_REARFIRE",

	channel = CHAN_STREAM,

	volume = 1.0,

	level = 125,

	pitch = {95, 105},

	sound = "renegadelaat/tailgun.wav"

} )



sound.Add( {

	name = "PRLAAT_BEAMSTART",

	channel = CHAN_STREAM,

	volume = 1.0,

	level = 125,

	pitch = {95, 105},

	sound = "renegadelaat/laserstart.wav"

} )



sound.Add( {

	name = "PRLAAT_HOVERENGINE",

	channel = CHAN_STATIC,

	volume = 1.0,

	level = 120,

	sound = "renegadelaat/hoverloop.wav"

} )



sound.Add( {

	name = "PRLAAT_FLIGHTENGINE",

	channel = CHAN_STATIC,

	volume = 1.0,

	level = 120,

	sound = "renegadelaat/flightloop.wav"

} )



sound.Add( {

	name = "PRLAAT_PILOTSOUND",

	channel = CHAN_STATIC,

	volume = 1.0,

	level = 120,

	sound = "renegadelaat/ballinteriorloop.wav"

} )



sound.Add( {

	name = "PRLAAT_CRASHING",

	channel = CHAN_STATIC,

	volume = 1.0,

	level = 120,

	sound = "renegadelaat/crashflying.wav"

} )



sound.Add( {

	name = "PRLAAT_BASS",

	channel = CHAN_STATIC,

	volume = 1.0,

	level = 125,

	sound = "renegadelaat/basshum.wav"

} )