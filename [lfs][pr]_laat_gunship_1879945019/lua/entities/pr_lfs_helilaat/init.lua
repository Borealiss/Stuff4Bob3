--DO NOT EDIT OR REUPLOAD THIS FILE



AddCSLuaFile( "shared.lua" )

AddCSLuaFile( "cl_init.lua" )

include("shared.lua")



function ENT:SpawnFunction( ply, tr, ClassName )

	if not tr.Hit then return end



	local ent = ents.Create( ClassName )

	ent:SetPos( tr.HitPos + tr.HitNormal * 10 ) 

	ent:Spawn()

	ent:Activate()
	
	ent.toggledflymode = true

	ent.toggletimer = 0

	return ent

end





function ENT:RunOnSpawn()

	

	self:GetDriverSeat().ExitPos = Vector(270,0,195)

	



	//self:SetNWEntity("gunnerseat",self:AddPassengerSeat(Vector(180,0,165),Angle(0,-90,0)))

	local GunnerSeat = self:AddPassengerSeat(Vector(180,0,165),Angle(0,-90,0))

	GunnerSeat:SetParent(NULL)

	local pos,ang = LocalToWorld(Vector(180,0,165),Angle(0,-90,0),self:GetPos(),self:GetAngles())

	GunnerSeat:SetPos(pos)

	GunnerSeat:SetAngles(ang)

	GunnerSeat:SetParent(self)

	self:SetGunnerSeat(GunnerSeat)

	self:GetGunnerSeat().ExitPos = Vector(220,0,250)

	

	

	local wingturretseat = self:AddPassengerSeat(Vector(220,0,105),Angle(0,0,0))

	self:SetNWEntity("wingturretseat",wingturretseat)

	

	

	local rightballseat = self:AddPassengerSeat( Vector(0,180,0),Angle(0,0,0) )

	self:SetNWEntity("GunnerSeatR",rightballseat)

	

	local rballid = self:LookupAttachment( "muzzle_rightball" )

	local rightball = self:GetAttachment( rballid )

	local pos,ang = LocalToWorld(Vector(0,-65,-21.5),Angle(0,0,-5),rightball.Pos,rightball.Ang)

	rightballseat:SetParent(NULL)

	rightballseat:SetPos(pos)

	//print(pos)

	rightballseat:SetAngles(ang)

	rightballseat:SetParent(self, rballid)

	rightballseat:AddEffects(EF_PARENT_ANIMATES)

	rightballseat:SetVehicleClass("phx_seat3")



	

	

	local leftballseat = self:AddPassengerSeat( Vector(0,0,0),Angle(0,0,0) )

	self:SetNWEntity("GunnerSeatL",leftballseat)

	

	local lballid = self:LookupAttachment( "muzzle_leftball" )

	local leftball = self:GetAttachment( lballid )

	local pos,ang = LocalToWorld(Vector(0,-65,-21.5),Angle(0,0,-5),leftball.Pos,leftball.Ang)

	leftballseat:SetParent(NULL)

	leftballseat:SetPos(pos)

	leftballseat:SetAngles(ang)

	leftballseat:SetParent(self, lballid)

	leftballseat:AddEffects(EF_PARENT_ANIMATES)

	leftballseat:SetVehicleClass("phx_seat3")

	

	local GunPassengerSeats = {

		{

			pos = Vector(165,65,17),

			ang = Angle(0,0,0)

		},

		{

			pos = Vector(165,-65,17),

			ang = Angle(0,180,0)

		},

	

	}

	

	local PassengerSeats = {

		{

			pos = Vector(100,40,9),

			ang = Angle(0,0,0)

		},

		{

			pos = Vector(88,40,9),

			ang = Angle(0,0,0)

		},

		{

			pos = Vector(66,40,9),

			ang = Angle(0,0,0)

		},

		{

			pos = Vector(44,40,9),

			ang = Angle(0,0,0)

		},

		{

			pos = Vector(22,40,9),

			ang = Angle(0,0,0)

		},

		{

			pos = Vector(0,40,9),

			ang = Angle(0,0,0)

		},

		{

			pos = Vector(-22,40,9),

			ang = Angle(0,0,0)

		},

		{

			pos = Vector(-44,40,9),

			ang = Angle(0,0,0)

		},

		{

			pos = Vector(-66,40,9),

			ang = Angle(0,0,0)

		},

		{

			pos = Vector(100,20,9),

			ang = Angle(0,0,0)

		},

		{

			pos = Vector(88,20,9),

			ang = Angle(0,0,0)

		},

		{

			pos = Vector(66,20,9),

			ang = Angle(0,0,0)

		},

		{

			pos = Vector(44,20,9),

			ang = Angle(0,0,0)

		},

		{

			pos = Vector(22,20,9),

			ang = Angle(0,0,0)

		},

		{

			pos = Vector(0,20,9),

			ang = Angle(0,0,0)

		},

		{

			pos = Vector(-22,20,9),

			ang = Angle(0,0,0)

		},

		{

			pos = Vector(-44,20,9),

			ang = Angle(0,0,0)

		},

		{

			pos = Vector(-66,20,9),

			ang = Angle(0,0,0)

		},

		{

			pos = Vector(100,-20,9),

			ang = Angle(0,180,0)

		},

		{

			pos = Vector(88,-20,9),

			ang = Angle(0,180,0)

		},

		{

			pos = Vector(66,-20,9),

			ang = Angle(0,180,0)

		},

		{

			pos = Vector(44,-20,9),

			ang = Angle(0,180,0)

		},

		{

			pos = Vector(22,-20,9),

			ang = Angle(0,180,0)

		},

		{

			pos = Vector(0,-20,9),

			ang = Angle(0,180,0)

		},

		{

			pos = Vector(-22,-20,9),

			ang = Angle(0,180,0)

		},

		{

			pos = Vector(-44,-20,9),

			ang = Angle(0,180,0)

		},

		{

			pos = Vector(-66,-20,9),

			ang = Angle(0,180,0)

		},

		{

			pos = Vector(100,-40,9),

			ang = Angle(0,180,0)

		},

		{

			pos = Vector(88,-40,9),

			ang = Angle(0,180,0)

		},

		{

			pos = Vector(66,-40,9),

			ang = Angle(0,180,0)

		},

		{

			pos = Vector(44,-40,9),

			ang = Angle(0,180,0)

		},

		{

			pos = Vector(22,-40,9),

			ang = Angle(0,180,0)

		},

		{

			pos = Vector(0,-40,9),

			ang = Angle(0,180,0)

		},

		{

			pos = Vector(-22,-40,9),

			ang = Angle(0,180,0)

		},

		{

			pos = Vector(-44,-40,9),

			ang = Angle(0,180,0)

		},

		{

			pos = Vector(-66,-40,9),

			ang = Angle(0,180,0)

		},

	}

	

	for num, v in pairs( GunPassengerSeats ) do

		local Pod = self:AddPassengerSeat( v.pos, v.ang )

	end

	

	for num, v in pairs( PassengerSeats ) do

		local Pod = self:AddPassengerSeat( v.pos, v.ang )

		Pod:SetVehicleClass("laatpassengerseat")

	end

end



function ENT:RightLaserAttack(seat)

	local rballmuzzle = self:LookupAttachment( "muzzle_rightball" )

	local rballpew = self:GetAttachment( rballmuzzle )

	local pos,ang = LocalToWorld(Vector(0,-0,0),Angle(0,0,0),rballpew.Pos,rballpew.Ang)

	local turret = self:GetNWEntity("GunnerSeatR")

	local laser = util.TraceLine( {

		start = pos,

		endpos =  pos + ang:Right() * -1000000,

		filter = {self,turret},

		ignoreworld = false,

	} )

	util.BlastDamage( self, seat:GetDriver() or self, laser.HitPos, 80*1.5, 80*0.15)

end



function ENT:LeftLaserAttack(seat)

	local lballmuzzle = self:LookupAttachment( "muzzle_leftball" )

	local lballpew = self:GetAttachment( lballmuzzle )

	local pos,ang = LocalToWorld(Vector(0,-0,0),Angle(0,0,0),lballpew.Pos,lballpew.Ang)

	local turret = self:GetNWEntity("GunnerSeatL")

	local laser = util.TraceLine( {

		start = pos,

		endpos =  pos + ang:Right() * -1000000,

		filter = {self,turret},

		ignoreworld = false,

	} )

	util.BlastDamage( self, seat:GetDriver() or self, laser.HitPos, 80*1.5, 80*0.15)

end



function ENT:RightBallTurret(seat,gunner)

	local eyeangles  = seat:WorldToLocalAngles( gunner:EyeAngles() )

	

	local g,correctAngle = WorldToLocal( Vector(0,0,0), eyeangles, Vector(0,0,0), self:LocalToWorldAngles(Angle(0,-90,0) ))

	self:SetPoseParameter( "rightpitch", -correctAngle.p )

	self:SetPoseParameter( "rightyaw", -correctAngle.y )

	

	if gunner:KeyDown( IN_ATTACK ) then

	

		self:RightLaserAttack(seat)

		

	end



end



function ENT:LeftBallTurret(seat,gunner)

	local eyeangles  = seat:WorldToLocalAngles( gunner:EyeAngles() )

	

	local g,correctAngle = WorldToLocal( Vector(0,0,0), eyeangles, Vector(0,0,0), self:LocalToWorldAngles(Angle(0,90,0) ))

	self:SetPoseParameter( "leftpitch", -correctAngle.p )

	self:SetPoseParameter( "leftyaw", correctAngle.y )

	

	if gunner:KeyDown( IN_ATTACK ) then

	

		self:LeftLaserAttack(seat)

		

	end



end



function ENT:RightTopLaserAttack(seat)

	if !self:GetRightTopBallFiring() then return end

	local EyeAngles = self:GetNWEntity("wingturretseat"):WorldToLocalAngles( self:GetNWEntity("wingturretseatdriver"):EyeAngles() )

	local rballpew = self:GetAttachment( 5 )

	local pos,ang = LocalToWorld(Vector(0,0,0),Angle(0,0,0),rballpew.Pos + self:GetAngles():Up() * 30,EyeAngles)

	self:SetWingAngle(ang)

	local turret = self:GetNWEntity("wingturretseat")

	local laser = util.TraceLine( {

		start = pos,

		endpos =  pos + ang:Forward() * 1000000,

		ignoreworld = false,

	} )

	if laser.Entity == self then return end

	util.BlastDamage( self, seat:GetDriver() or self, laser.HitPos, 80*1.5, 80*0.15)

end



function ENT:LeftTopLaserAttack(seat)

	if !self:GetLeftTopBallFiring() then return end

	local EyeAngles = self:GetNWEntity("wingturretseat"):WorldToLocalAngles( self:GetNWEntity("wingturretseatdriver"):EyeAngles() )

	local lballpew = self:GetAttachment( 4 )

	local pos,ang = LocalToWorld(Vector(0,0,0),Angle(0,0,0),lballpew.Pos + self:GetAngles():Up() * 30,EyeAngles)

	local turret = self:GetNWEntity("wingturretseat")

	local laser = util.TraceLine( {

		start = pos,

		endpos =  pos + ang:Forward() * 1000000,

		ignoreworld = false,

	} )

	if laser.Entity == self then return end

	util.BlastDamage( self, seat:GetDriver() or self, laser.HitPos, 80*1.5, 80*0.15)

end



function ENT:RightBottomLaserAttack(seat)

	if !self:GetRightBottomBallFiring() then return end

	local EyeAngles = self:GetNWEntity("wingturretseat"):WorldToLocalAngles( self:GetNWEntity("wingturretseatdriver"):EyeAngles() )

	local rballpew = self:GetAttachment( 5 )

	local pos,ang = LocalToWorld(Vector(0,0,0),Angle(0,0,0),rballpew.Pos + self:GetAngles():Up() * -30,EyeAngles)

	self:SetWingAngle(ang)

	local turret = self:GetNWEntity("wingturretseat")

	local laser = util.TraceLine( {

		start = pos,

		endpos =  pos + ang:Forward() * 1000000,

		ignoreworld = false,

	} )

	if laser.Entity == self then return end

	debugoverlay.Line(pos,laser.HitPos)

	util.BlastDamage( self, seat:GetDriver() or self, laser.HitPos, 80*1.5, 80*0.15)

end



function ENT:LeftBottomLaserAttack(seat)

	if !self:GetLeftBottomBallFiring() then return end

	local EyeAngles = self:GetNWEntity("wingturretseat"):WorldToLocalAngles( self:GetNWEntity("wingturretseatdriver"):EyeAngles() )

	local lballpew = self:GetAttachment( 4 )

	local pos,ang = LocalToWorld(Vector(0,0,0),Angle(0,0,0),lballpew.Pos + self:GetAngles():Up() * -30,EyeAngles)

	local turret = self:GetNWEntity("wingturretseat")

	local laser = util.TraceLine( {

		start = pos,

		endpos =  pos + ang:Forward() * 1000000,

		ignoreworld = false,

	} )

	

	if laser.Entity == self then return end

	util.BlastDamage( self, seat:GetDriver() or self, laser.HitPos, 80*1.5, 80*0.15)

end



function ENT:OnTick()
	if IsValid(self:GetNWEntity("GunnerSeatR")) && !IsValid(self:GetNWEntity("GunnerSeatR"):GetDriver()) then self:SetNWEntity("GunnerSeatRDriver",NULL) end

	if IsValid(self:GetNWEntity("GunnerSeatL")) && !IsValid(self:GetNWEntity("GunnerSeatL"):GetDriver()) then self:SetNWEntity("GunnerSeatLDriver",NULL) end

	if IsValid(self:GetNWEntity("wingturretseat")) && !IsValid(self:GetNWEntity("wingturretseat"):GetDriver()) then self:SetNWEntity("wingturretseatdriver",NULL) end

	

	if IsValid(self:GetNWEntity("GunnerSeatR")) && IsValid(self:GetNWEntity("GunnerSeatR"):GetDriver()) then

		

		if !IsValid(self:GetNWEntity("GunnerSeatRDriver")) then self:SetNWEntity("GunnerSeatRDriver",self:GetNWEntity("GunnerSeatR"):GetDriver()) end

		self:RightBallTurret(self:GetNWEntity("GunnerSeatR"),self:GetNWEntity("GunnerSeatR"):GetDriver())

		if self:GetNWEntity("GunnerSeatRDriver"):KeyDown( IN_ATTACK ) then  self:SetRightBallFiring(true) else self:SetRightBallFiring(false) end

	end

	

	if IsValid(self:GetNWEntity("GunnerSeatL")) && IsValid(self:GetNWEntity("GunnerSeatL"):GetDriver()) then

		

		if !IsValid(self:GetNWEntity("GunnerSeatLDriver")) then self:SetNWEntity("GunnerSeatLDriver",self:GetNWEntity("GunnerSeatL"):GetDriver()) end

		self:LeftBallTurret(self:GetNWEntity("GunnerSeatL"),self:GetNWEntity("GunnerSeatL"):GetDriver())

		if self:GetNWEntity("GunnerSeatLDriver"):KeyDown( IN_ATTACK ) then self:SetLeftBallFiring(true) else self:SetLeftBallFiring(false) end

	end

	

	if IsValid(self:GetNWEntity("wingturretseat")) && IsValid(self:GetNWEntity("wingturretseat"):GetDriver()) then

		

		if !IsValid(self:GetNWEntity("wingturretseatdriver")) then self:SetNWEntity("wingturretseatdriver",self:GetNWEntity("wingturretseat"):GetDriver()) end

		

		if self:GetNWEntity("wingturretseatdriver"):KeyDown( IN_ATTACK ) then 

			local EyeAngles = self:GetNWEntity("wingturretseat"):WorldToLocalAngles( self:GetNWEntity("wingturretseatdriver"):EyeAngles() )

			local angDiff = EyeAngles.p - self:GetAngles().p

			if angDiff < 0 then

				self:SetRightTopBallFiring(true) 

				self:SetLeftTopBallFiring(true) 

				self:SetRightBottomBallFiring(false) 

				self:SetLeftBottomBallFiring(false)

				self:RightTopLaserAttack(self:GetNWEntity("wingturretseat"))

				self:LeftTopLaserAttack(self:GetNWEntity("wingturretseat"))

			elseif angDiff > 0 then

				self:SetRightTopBallFiring(false) 

				self:SetLeftTopBallFiring(false) 

				self:SetRightBottomBallFiring(true) 

				self:SetLeftBottomBallFiring(true)

				self:RightBottomLaserAttack(self:GetNWEntity("wingturretseat"))

				self:LeftBottomLaserAttack(self:GetNWEntity("wingturretseat"))

			end

		else

			self:SetRightTopBallFiring(false) 

			self:SetLeftTopBallFiring(false) 

			self:SetRightBottomBallFiring(false) 

			self:SetLeftBottomBallFiring(false)

		end

	end



end



local function CalcFlight( self )

	if self.toggledflymode && !self:IsDestroyed() then

		
		if not self:GetEngineActive() or self:IsStartStopping() then return end

		

		self:InWater()

		

		//if self:IsDestroyed() then
		//
		//	self:StopEngine()
		//
		//	
		//
		//	return
		//
		//end

		

		//self:CheckRotorClearance()

		

		local MaxTurnSpeed = self:GetMaxTurnSpeedHeli()

		local MaxPitch = MaxTurnSpeed.p

		local MaxYaw = MaxTurnSpeed.y

		local MaxRoll = MaxTurnSpeed.r

		

		local PhysObj = self:GetPhysicsObject()

		if not IsValid( PhysObj ) then return end

		

		local Pod = self:GetDriverSeat()

		if not IsValid( Pod ) then return end

		

		local LocalVel = self:WorldToLocal( self:GetVelocity() + self:GetPos() )

		local AngVel = self:GetAngVel()

		

		local Mass = PhysObj:GetMass()

		

		local Driver = Pod:GetDriver()

		

		local EyeAngles = self:GetAngles()

	

		local OnGround = self:HitGround()

		

		local ThrInc = false

		local ThrDec = OnGround

		local PitchUp = false

		local PitchDn = false

		local YawL = false

		local YawR = false

		local RollL = false

		local RollR = false

		

		local HoverMode = false

		local unlockYaw = false

		

		local TargetThrust = 0

		

		local FT = FrameTime()

		

		if IsValid( Driver ) then

			EyeAngles = Pod:WorldToLocalAngles( Driver:EyeAngles() )

			

			if Driver:lfsGetInput( "FREELOOK" ) then

				if isangle( self.StoredEyeAngles ) then

					EyeAngles = self.StoredEyeAngles

				end

				unlockYaw = true

			else

				self.StoredEyeAngles = EyeAngles

				unlockYaw = false

			end

			

			ThrInc = Driver:lfsGetInput( "+THROTTLE_HELI" ) || Driver:KeyDown( IN_JUMP )

			ThrDec = not ThrInc and OnGround or Driver:lfsGetInput( "-THROTTLE_HELI" )

			

			//PitchUp = Driver:lfsGetInput( "HOVERMODE" )

			//PitchDn = Driver:lfsGetInput( "HOVERMODE" )

			

			YawL  = Driver:lfsGetInput( "-YAW_HELI" )

			YawR  = Driver:lfsGetInput( "+YAW_HELI" )

			

			RollL = Driver:lfsGetInput( "-ROLL_HELI" )

			RollR = Driver:lfsGetInput( "+ROLL_HELI" )

			

			//HoverMode = Driver:lfsGetInput( "HOVERMODE" )

			

			TargetThrust = self:GetMaxThrustHeli() * ((ThrInc and 1 or 0)  - (ThrDec and 1 or 0))

		else

			local HasAI = self:GetAI()

			if HasAI then

				local TPos =  self:RunAI()

				local LPos = self:WorldToLocal( TPos )

				

				local Target = self:AIGetTarget()

				

				local P = math.Clamp(LPos.x * 0.02 - LocalVel.x * 0.1,-40,40)

				local Y = ((IsValid( Target ) and Target:GetPos() or TPos) - self:GetPos()):Angle().y

				local R = math.Clamp(-LPos.y * 0.02 + LocalVel.y * 0.1,-40,40)

				

				EyeAngles = Angle(P,Y,R)

				self.Roll = R

				

				TargetThrust = math.Clamp( LPos.z -LocalVel.z,-self:GetMaxThrustHeli(),self:GetMaxThrustHeli())

			else

				TargetThrust = self:GetMaxThrustHeli() * ((ThrInc and 1 or 0)  - (ThrDec and 1 or 0))

			end

		end

		

		local Rate = FrameTime() * 8

		self.Thrust = self.Thrust and ( self.Thrust + math.Clamp( TargetThrust - self.Thrust,-Rate,Rate ) ) or 0

		

		local cForce = self:GetZForce()

		local Force = Vector(0,0,cForce * (1 - self:GetThrustEfficiency())) + self:GetUp() * (cForce * self:GetThrustEfficiency() - LocalVel.z * 0.01 + self.Thrust)

		

		--self.Pitch = (PitchDn or PitchUp) and (self.Pitch and self.Pitch + ((PitchDn and MaxPitch or 0) - (PitchUp and MaxPitch or 0)) * FT or EyeAngles.p) or EyeAngles.p

		--self.Yaw = (YawR or YawL) and (self.Yaw and self.Yaw + ((YawL and MaxYaw or 0) - (YawR and MaxYaw or 0)) * FT or EyeAngles.y) or EyeAngles.y

		

		self.Roll = self.Roll and self.Roll + ((RollR and MaxRoll or 0) - (RollL and MaxRoll or 0)) * FT or 0

	

		--local AngForce = self:WorldToLocalAngles( Angle(self.Pitch,self.Yaw,self.Roll) )

		local AngForce = self:WorldToLocalAngles( Angle(EyeAngles.p,EyeAngles.y,self.Roll) )

		

		if HoverMode then

			local P = math.Clamp(-LocalVel.x * 0.1,-40,40)

			local Y = EyeAngles.y

			local R = math.Clamp(LocalVel.y * 0.1,-40,40)

			

			if PitchUp or PitchDn then

				P = (PitchDn and 40 or 0) - (PitchUp and 40 or 0)

			end

			

			if YawL or YawR then

				Y = Y + (YawL and 45 or 0) - (YawR and 45 or 0)

			end

			

			if RollL or RollR then

				R = (RollR and 60 or 0) - (RollL and 60 or 0)

			end

			

			if unlockYaw then

				self.Yaw = self.Yaw and self.Yaw + ((YawL and MaxYaw or 0) - (YawR and MaxYaw or 0)) * FT or EyeAngles.y

				Y = self.Yaw

			else

				self.Yaw = Y

			end

			

			AngForce = self:WorldToLocalAngles( Angle(P,Y,R) )

			

			self.Roll = 0

		end

	

		self:SetRPM( self:GetLimitRPM() * math.max((self.Thrust + cForce) / (self:GetMaxThrustHeli() + cForce),0.12) )

		

		local P = math.Clamp(AngForce.p,-MaxPitch,MaxPitch)

		local Y = math.Clamp(AngForce.y,-MaxYaw,MaxYaw)

		local R = math.Clamp(AngForce.r + math.cos(CurTime()) * 2,-MaxRoll,MaxRoll)

		

		AngForce.p,AngForce.y,AngForce.r = self:CalcFlightOverride( P, Y, R )

		

		PhysObj:ApplyForceCenter( Force * Mass )

		

		if (OnGround and (ThrInc or RollL or RollR or HoverMode)) or not OnGround then

			self:ApplyAngForce( (AngForce * 2 - AngVel) * FT * Mass * 500 )

		else

			self:ApplyAngForce( -AngVel * Mass * FT * 500 )

		end

		

		self:SetRotPitch( AngForce.p / MaxPitch )

		self:SetRotYaw( AngForce.y / MaxYaw)

		self:SetRotRoll( AngForce.r / MaxRoll )

	else

		if self:IsDestroyed() then return end
	
		local MaxTurnSpeed = self:GetMaxTurnSpeed()
	
	
	
		local MaxPitch = MaxTurnSpeed.p
	
	
	
		local MaxYaw = MaxTurnSpeed.y
	
	
	
		local MaxRoll = MaxTurnSpeed.r
	
	
	
		
	
	
	
		local IsInVtolMode =  self:IsVtolModeActive()
	
	
	
		
	
	
	
		local PhysObj = self:GetPhysicsObject()
	
	
	
		if not IsValid( PhysObj ) then return end
	
	
	
		
	
	
	
		local Pod = self:GetDriverSeat()
	
	
	
		if not IsValid( Pod ) then return end
	
	
	
		
	
	
	
		local Driver = Pod:GetDriver()
	
	
	
		
	
	
	
		local A = false
	
	
	
		local D = false
	
	
	
		
	
	
	
		local LocalAngPitch = 0
	
	
	
		local LocalAngYaw = 0
	
	
	
		local LocalAngRoll = 0
	
	
	
		
	
	
	
		local AngDiff = 0
	
	
	
		
	
	
	
		if IsValid( Driver ) then 
	
	
	
			local EyeAngles = Pod:WorldToLocalAngles( Driver:EyeAngles() )
	
	
	
			
	
	
	
			if Driver:lfsGetInput( "FREELOOK" ) then
	
	
	
				if isangle( self.StoredEyeAngles ) then
	
	
	
					EyeAngles = self.StoredEyeAngles
	
	
	
				end
	
	
	
			else
	
	
	
				self.StoredEyeAngles = EyeAngles
	
	
	
			end
	
	
	
			
	
	
	
			local LocalAngles = self:WorldToLocalAngles( EyeAngles )
	
	
	
			
	
	
	
			local Pitch_Up = Driver:KeyDown( IN_JUMP )
	
	
	
			local Pitch_Dn = Driver:KeyDown( IN_JUMP )
	
			
	
			local Yaw_R = Driver:lfsGetInput( "+YAW" )
	
	
	
			local Yaw_L = Driver:lfsGetInput( "-YAW" )
	
	
	
			local Roll_R = Driver:lfsGetInput( "+ROLL" )
	
	
	
			local Roll_L = Driver:lfsGetInput( "-ROLL" ) 
	
	
	
			
	
	
	
			/*if not IsInVtolMode then
	
	
	
				if Pitch_Up or Pitch_Dn then
	
	
	
					EyeAngles = self:GetAngles()
	
	
	
					
	
	
	
					self.StoredEyeAngles = Angle(EyeAngles.p,EyeAngles.y,0)
	
	
	
					
	
	
	
					local X = (Pitch_Up and -90 or 0) + (Pitch_Dn and 90 or 0)
	
	
	
	
	
	
	
					//LocalAngles = Angle(X,0,0)
	
	
	
				end
	
	
	
			end*/
	
	
	
			
	
	
	
			if Yaw_R or Yaw_L then
	
	
	
				EyeAngles = self:GetAngles()
	
	
	
				
	
	
	
				self.StoredEyeAngles = Angle(EyeAngles.p,EyeAngles.y,0)
	
	
	
				
	
	
	
				LocalAngles.y = (Yaw_R and -90 or 0) + (Yaw_L and 90 or 0)
	
	
	
			end
	
	
	
			if Yaw_R or Yaw_L then
	
	
	
				A = not Roll_R
	
	
	
				D = not Roll_L
	
	
	
			else
	
			
	
				A = Roll_L
	
			
	
				D = Roll_R
	
			
	
			end
	
	
	
			
	
	
	
			LocalAngPitch = LocalAngles.p
	
	
	
			LocalAngYaw = LocalAngles.y
	
	
	
			LocalAngRoll = LocalAngles.r + math.cos(CurTime()) * 2
	
	
	
			
	
	
	
			local EyeAngForward = EyeAngles:Forward()
	
	
	
			local Forward = self:GetForward()
	
	
	
			
	
	
	
			AngDiff = math.deg( math.acos( math.Clamp( Forward:Dot(EyeAngForward) ,-1,1) ) )
	
	
	
		else
	
	
	
			local EyeAngles = self:GetAngles()
	
	
	
			
	
	
	
			if self:GetAI() then
	
	
	
				EyeAngles = self:RunAI()
	
	
	
			else
	
	
	
				if self:IsSpaceShip() and isangle( self.StoredEyeAngles ) then
	
	
	
					EyeAngles = self.StoredEyeAngles
	
	
	
				end
	
	
	
			end
	
	
	
			
	
	
	
			local LocalAngles = self:WorldToLocalAngles( EyeAngles )
	
	
	
			
	
	
	
			LocalAngPitch = LocalAngles.p
	
	
	
			LocalAngYaw = LocalAngles.y
	
	
	
			LocalAngRoll = LocalAngles.r
	
	
	
			
	
	
	
			local EyeAngForward = EyeAngles:Forward()
	
	
	
			local Forward = self:GetForward()
	
	
	
			
	
	
	
			AngDiff = math.deg( math.acos( math.Clamp( Forward:Dot(EyeAngForward) ,-1,1) ) )
	
	
	
		end
	
	
	
		
	
	
	
		local WingFinFadeOut = math.max( (90 - AngDiff ) / 90, 0 )
	
	
	
		local RudderFadeOut = math.max( (60 - AngDiff ) / 60, 0 )
	
	
	
	
	
	
	
		self:SteerWheel( LocalAngYaw )
	
	
	
		
	
	
	
		local Stability = self:GetStability()
	
	
	
	
	
	
	
		local RollRate =  math.min(self:GetVelocity():Length() / math.min(self:GetMaxVelocity() * 0.5,3000),1)
	
	
	
		RudderFadeOut = math.max(RudderFadeOut,1 - RollRate)
	
	
	
		
	
		local ManualRoll = (D and MaxRoll or 0) - (A and MaxRoll or 0)
	
	
	
		
	
	
	
		//if IsInVtolMode then
	
	
	
			ManualRoll = math.Clamp(((D and 25 or 0) - (A and 25 or 0) - self:GetAngles().r) * 20, -MaxRoll, MaxRoll)
	
	
	
		//end
	
	
	
		
	
	
	
		local AutoRoll = (-LocalAngYaw * 22 * RollRate + LocalAngRoll * 3.5 * RudderFadeOut) * WingFinFadeOut
	
	
	
		
	
	
	
		local P = math.Clamp(-LocalAngPitch * 25,-MaxPitch,MaxPitch)
	
	
	
		local Y = math.Clamp(-LocalAngYaw * 160 * RudderFadeOut,-MaxYaw,MaxYaw)
	
	
	
		local R = math.Clamp( (not A and not D) and AutoRoll or ManualRoll,-MaxRoll ,MaxRoll )
	
	
	
		
	
	
	
		local Pitch,Yaw,Roll,StabW,StabE,StabR = self:CalcFlightOverride( P, Y, R, Stability )
	
	
	
		
	
	
	
		local Mass = PhysObj:GetMass()
	
	
	
		
	
	
	
		self:ApplyAngForce( Angle(0,0,-self:GetAngVel().r + Roll * StabW) *  Mass * 500 * StabW )
	
	
	
		
	
	
	
		PhysObj:ApplyForceOffset( -self:GetWingUp() * self:GetWingVelocity() *  Mass * StabW, self:GetWingPos() )
	
	
	
		
	
	
	
		PhysObj:ApplyForceOffset( -self:GetElevatorUp() * (self:GetElevatorVelocity() + Pitch * StabE) * Mass * StabE, self:GetElevatorPos() )
	
	
	
		
	
	
	
		PhysObj:ApplyForceOffset( -self:GetRudderUp() * (math.Clamp(self:GetRudderVelocity(),-MaxYaw,MaxYaw) + Yaw * StabR) *  Mass * StabR, self:GetRudderPos() )
	
	
	
		
	
	
	
		if self:IsSpaceShip() then
	
	
	
			PhysObj:ApplyForceCenter( self:GetRight() * self:WorldToLocal( self:GetPos() + self:GetVelocity() ).y * Mass * 0.01 )
	
	
	
		end
	
	
	
		
	
	
	
		self:SetRotPitch( (Pitch / MaxPitch) * 30 )
	
	
	
		self:SetRotYaw( (Yaw / MaxYaw) * 30 )
	
	
	
		self:SetRotRoll( (Roll / MaxRoll) * 30 )
	
	end
	
end



function ENT:HandleEngine()

	if self:IsDestroyed() then return end

	local IdleRPM = self:GetIdleRPM()



	local MaxRPM = self:GetMaxRPM()



	local LimitRPM = self:GetLimitRPM()



	local MaxVelocity = self:GetMaxVelocity()



	



	local EngActive = self:GetEngineActive()



	



	self.TargetRPM = self.TargetRPM or 0



	

	//print(EngActive)

	if EngActive then



		local Pod = self:GetDriverSeat()



		



		if not IsValid( Pod ) then return end



		



		local Driver = Pod:GetDriver()



		



		local RPMAdd = 0



		local KeyThrottle = false



		local KeyBrake = false



		



		if IsValid( Driver ) then 



			KeyThrottle = Driver:lfsGetInput( "+THROTTLE" )



			KeyBrake = Driver:lfsGetInput( "-THROTTLE" )



			



			RPMAdd = ((KeyThrottle and self:GetThrottleIncrement() or 0) - (KeyBrake and self:GetThrottleIncrement() or 0)) * FrameTime()



		end



		



		if KeyThrottle ~= self.oldKeyThrottle then



			self.oldKeyThrottle = KeyThrottle



			



			self:OnKeyThrottle( KeyThrottle )



		end



		



		self.TargetRPM = math.Clamp( self.TargetRPM + RPMAdd,IdleRPM,(KeyThrottle and self:GetWepEnabled()) and LimitRPM or MaxRPM)



	else



		self.TargetRPM = self.TargetRPM - math.Clamp(self.TargetRPM,-250,250)



	end



	



	self:SetRPM( self:GetRPM() + (self.TargetRPM - self:GetRPM()) * FrameTime() )



	



	local PhysObj = self:GetPhysicsObject()



	



	if not IsValid( PhysObj ) then return end



	



	local fThrust = MaxVelocity * (self:GetRPM() / LimitRPM) - self:GetForwardVelocity()



	



	if not self:IsSpaceShip() and not self:GetAI() then fThrust = math.max( fThrust ,0 ) end



	

	//print(fThrust,MaxVelocity,self:GetMaxThrust(),LimitRPM)

	local Force = fThrust / MaxVelocity * self:GetMaxThrust() * LimitRPM * FrameTime()



	if self:IsDestroyed() or not EngActive then



		//self:StopEngine()



		



		//return



	end



	



	if self.VerticalTakeoff then



		if self:IsSpaceShip() then



			local Driver = self:GetDriver()







			if IsValid( Driver ) then 



				local IsVtolActive = self:IsVtolModeActive()



				



				if self.oldVtolMode ~= IsVtolActive then



					self.oldVtolMode = IsVtolActive



					self:OnVtolMode( IsVtolActive )



					



					self.smfForce = 0



				end



				



				if IsVtolActive then



					if isnumber( self.VtolAllowInputBelowThrottle ) then



						local KeyThrottle = Driver:KeyDown( IN_JUMP )

						local KeyBrake 

						if self.CrashLand then

							KeyBrake = true

						else

							KeyBrake = Driver:lfsGetInput( "-THROTTLE" ) and self:GetThrottlePercent() <= 10

						end

			



						local Up = KeyThrottle and self:GetThrustVtol() or 0



						local Down = KeyBrake and -self:GetThrustVtol() or 0

						

	

						if self.CrashLand && self:GetEngineActive() then

							Up = 0

							Down = (Down - 350) or -1000

							//print("applying down")

						end



						local VtolForce = (Up + Down) * PhysObj:GetMass() * FrameTime() 



						self.smfForce = isnumber( self.smfForce ) and (self.smfForce + (VtolForce - self.smfForce) * FrameTime() * 2) or VtolForce



						self:ApplyThrustVtol( PhysObj, self:GetUp(), self.smfForce )

						



					else



						self.TargetRPM = (self:GetVelocity():Length() / MaxVelocity) * LimitRPM



						



						local Up = Driver:lfsGetInput( "+THROTTLE" ) and self:GetThrustVtol() or 0



						local Down = Driver:lfsGetInput( "-THROTTLE" ) and -self:GetThrustVtol() or 0



						local VtolForce = (Up + Down) * PhysObj:GetMass() * FrameTime() 



						



						self.smfForce = isnumber( self.smfForce ) and (self.smfForce + (VtolForce - self.smfForce) * FrameTime() * 2) or VtolForce



						self:ApplyThrustVtol( PhysObj, self:GetUp(), self.smfForce )



						



						return



					end



				end



			end



		end



	end



	//print(Force)

	self:ApplyThrust( PhysObj, self:GetForward(), Force )



end



function ENT:ToggleEngine()



	if self:GetEngineActive() then



		self:StopEngine()



	else

		//print("start pls")

		self:StartEngine()



	end



end





function ENT:Think()

//if(IsValid(self:GetNWEntity("wingturretseatdriver"))) then

	//print(self:GetNWEntity("wingturretseat"):WorldToLocalAngles( self:GetNWEntity("wingturretseatdriver"):EyeAngles() )) end

	if self.toggledflymode then	

		self:HandleActive()

		self:HandleStart()

		self:HandleLandingGear()

		self:HandleWeapons()

		CalcFlight( self )

		self:PrepExplode()

		self:RechargeShield()

		self:OnTick()

		self:CalcEngineStart()

		self:CalcEngineStop()

	else

		self:HandleActive()



		self:HandleStart()

	

		self:HandleLandingGear()

	

		self:HandleWeapons()

	

		self:HandleEngine()

	

		CalcFlight( self )

	

		self:PrepExplode()

	

		self:RechargeShield()

	

		self:OnTick()



	end

		

		self:NextThink( CurTime() )

	if IsValid(self:GetDriver()) && self:GetDriver():KeyPressed( IN_SPEED ) && !self:IsDestroyed() && self.toggletimer <= CurTime() then

		self.toggledflymode = !self.toggledflymode

		if !self.toggledflymode then

			self:SetEngineState(1)

			self:SetRPM(self:GetRPM()/2)

			self.Inertia = Vector(400000,400000,400000)

		else

			self:SetEngineState(0)

			self:SetRPM(self:GetRPM()/4)

			self.Inertia = Vector(10000,10000,10000)

		end

		

		self.toggledtimer = CurTime() + 1

	end

	

	return true

end





function ENT:OnEngineStartInitialized()

	self:EmitSound( "renegadelaat/enginestart.wav")

end



function ENT:OnRotorDestroyed()

	self:EmitSound( "physics/metal/metal_box_break2.wav" )

	

	//self:SetHP(1)

	

	timer.Simple(2, function()

		if not IsValid( self ) then return end

		//self:Destroy()

	end)

end



function ENT:OnTakeDamage( dmginfo )



	self:TakePhysicsDamage( dmginfo )



	



	local Damage = dmginfo:GetDamage()



	local CurHealth = self:GetHP()



	local NewHealth = math.Clamp( CurHealth - Damage , 0, self:GetMaxHP()  )



	local ShieldCanBlock = dmginfo:IsBulletDamage() or dmginfo:IsDamageType( DMG_AIRBOAT )



	



	if ShieldCanBlock then



		local dmgNormal = -dmginfo:GetDamageForce():GetNormalized() 



		



		self:SetNextShieldRecharge( 3 )



		



		if self:GetMaxShield() > 0 and self:GetShield() > 0 then



			dmginfo:SetDamagePosition( dmginfo:GetDamagePosition() + dmgNormal * 250 ) 



			



			net.Start("lfs_shieldhit")



				net.WriteVector( dmginfo:GetDamagePosition() )



			net.Broadcast()



			



			self:TakeShieldDamage( Damage )



		else



			local effectdata = EffectData()



				effectdata:SetOrigin( dmginfo:GetDamagePosition() )



				effectdata:SetNormal( dmgNormal )



			util.Effect( "MetalSpark", effectdata )



			



			self:SetHP( NewHealth )



		end



	else



		self:SetHP( NewHealth )



	end



	



	if NewHealth == 0 and not (self:GetShield() > Damage and ShieldCanBlock) then

		self:SetEngineState(2)

		if not self:IsDestroyed() then



			self.FinalAttacker = dmginfo:GetAttacker() 



			self.FinalInflictor = dmginfo:GetInflictor()

			self.toggledflymode = false

			if !self.toggledflymode then

				//self:SetEngineActive( false )

				self.Inertia = Vector(400000,400000,400000)

				timer.Simple(.5, function()

					//self:SetEngineActive( true )

				end)

			end



			self:Destroy()



			self:EmitSound("renegadelaat/fataldamage.wav")



			self.MaxPerfVelocity = self.MaxPerfVelocity * 10



			



			self.particleeffect = ents.Create( "info_particle_system" )



			self.particleeffect:SetKeyValue( "effect_name" , "fire_large_01")



			self.particleeffect:SetKeyValue( "start_active" , 1)



			self.particleeffect:SetOwner( self )



			self.particleeffect:SetPos( self:LocalToWorld( self:GetPhysicsObject():GetMassCenter() ) )



			self.particleeffect:SetAngles( self:GetAngles() )



			self.particleeffect:Spawn()



			self.particleeffect:Activate()



			self.particleeffect:SetParent( self )



			self:dOwner( self.particleeffect )



			



			if self:GetAI() then



				timer.Simple( 8, function()



					if not IsValid( self ) then return end



					self:Explode()



				end)



			end



		end



	end



end



function ENT:Destroy()



	//self.Destroyed = true

	self.CrashLand = true

	



	local PObj = self:GetPhysicsObject()



	if IsValid( PObj ) then



		PObj:SetDragCoefficient( -1000 )



	end



end



function ENT:PhysicsCollide( data, physobj )

	if data.HitEntity:GetClass() == "atmospheric_tracer" then return end

	//print("Hit")

	if self.CrashLand then

	//print("disable engine")

		self.Destroyed = true

		self:StopEngine()

		self.MarkForDestruction = true

	end



	



	if IsValid( data.HitEntity ) then



		if data.HitEntity:IsPlayer() or data.HitEntity:IsNPC() then



			return



		end



	end



	



	if data.Speed > 60 and data.DeltaTime > 0.2 then



		if data.Speed > 500 then



			self:EmitSound( "Airboat_impact_hard" )



			



			self:TakeDamage( 400, data.HitEntity, data.HitEntity )



		else



			self:EmitSound( "MetalVehicle.ImpactSoft" )



		end



	end



end



function ENT:PrepExplode()



	if self.MarkForDestruction then

		//print("marked")

		self.MarkForDestruction = false

			if IsValid(self) then

				timer.Simple(10, function()

					if !IsValid(self) then return end

					self:Explode()

				end)

			end

	

	end



	



	if self:IsDestroyed() then



		if self:GetVelocity():Length() < 800 then



			//self:Explode()



		end



	end



end



function ENT:ApplyAngForce( angForce )

	

	if self:IsDestroyed() then 

	

	

		local phys = self:GetPhysicsObject()







	if not IsValid( phys ) then return end



	



	local up = self:GetUp()



	local left = self:GetRight() * -1



	local forward = self:GetForward()







	local pitch = up * (angForce.p * 0.5)



	phys:ApplyForceOffset( forward, pitch )



	phys:ApplyForceOffset( forward * -1, pitch * -1 )







	local yaw = forward * (angForce.y * 0.5)



	phys:ApplyForceOffset( left, yaw )



	phys:ApplyForceOffset( left * -1, yaw * -1 )







	local roll = left * (angForce.r * 0.5)



	phys:ApplyForceOffset( up, roll )



	phys:ApplyForceOffset( up * -1, roll * -1 )

	

	

	

	return end







	local phys = self:GetPhysicsObject()







	if not IsValid( phys ) then return end



	



	local up = self:GetUp()



	local left = self:GetRight() * -1



	local forward = self:GetForward()







	local pitch = up * (angForce.p * 0.5)



	phys:ApplyForceOffset( forward, pitch )



	phys:ApplyForceOffset( forward * -1, pitch * -1 )







	local yaw = forward * (angForce.y * 0.5)



	phys:ApplyForceOffset( left, yaw )



	phys:ApplyForceOffset( left * -1, yaw * -1 )







	local roll = left * (angForce.r * 0.5)



	phys:ApplyForceOffset( up, roll )



	phys:ApplyForceOffset( up * -1, roll * -1 )



end



function ENT:PrimaryAttack()

if not self:CanPrimaryAttack() then return end

	local EyeAngles = self:GetGunner():GetVehicle():WorldToLocalAngles( self:GetGunner():EyeAngles() )

	local angdiff = EyeAngles.y - self:GetAngles().y

	//print(EyeAngles.y)

	print(angdiff)

	if angdiff > -30 &&  angdiff < 25 then

	self:SetNextPrimary( 0.08)

		local laser = util.TraceLine( {

			start = self:GetGunner():EyePos(),

			endpos = self:EyePos() + EyeAngles:Forward() * 1000000,

			filter = {self,self:GetGunner()},

			ignoreworld = false,

		} )

		

		self:EmitSound("renegadelaat/twinfire.wav")

		local startpos =  self:GetRotorPos()

		local fP = { Vector(94.6,-7.12,-73.62), Vector(94.6,7.87,-73.62), Vector(95.27,-7.13,-64.17), Vector(95.27,7.57,-64.17), }

		local bullet = {}

		bullet.Num 	= 1

		bullet.Src 	= self:LocalToWorld( Vector(300,35,33) )

		bullet.Dir 	= (laser.HitPos - bullet.Src):GetNormalized()

		bullet.Spread 	= Vector( 0.001,  0.001, 0 )

		bullet.Tracer	= 1

		bullet.TracerName	= "lfs_twinlaatlaser"

		bullet.Force	= 100

		bullet.HullSize 	= 40

		bullet.Damage	= 20

		bullet.Attacker 	= self:GetDriver()

		bullet.AmmoType = "Pistol"

		bullet.Callback = function(att, tr, dmginfo)

			dmginfo:SetDamageType(DMG_AIRBOAT)

		end

		self:FireBullets( bullet )

	end

	if angdiff > -30 && angdiff < 100 then

self:SetNextPrimary( 0.08)

		local laser = util.TraceLine( {

			start = self:GetGunner():EyePos(),

			endpos = self:EyePos() + EyeAngles:Forward() * 1000000,

			filter = {self,self:GetGunner()},

			ignoreworld = false,

		} )

		self:EmitSound("renegadelaat/twinfire.wav")

		local startpos =  self:GetRotorPos()

		local fP = { Vector(94.6,-7.12,-73.62), Vector(94.6,7.87,-73.62), Vector(95.27,-7.13,-64.17), Vector(95.27,7.57,-64.17), }

		local bullet = {}

		bullet.Num 	= 1

		bullet.Src 	= self:LocalToWorld( Vector(300,35,33) )

		bullet.Dir 	= (laser.HitPos - bullet.Src):GetNormalized()

		bullet.Spread 	= Vector( 0.001,  0.001, 0 )

		bullet.Tracer	= 1

		bullet.TracerName	= "lfs_singlelaatlasera"

		bullet.Force	= 100

		bullet.HullSize 	= 40

		bullet.Damage	= 20

		bullet.Attacker 	= self:GetDriver()

		bullet.AmmoType = "Pistol"

		bullet.Callback = function(att, tr, dmginfo)

			dmginfo:SetDamageType(DMG_AIRBOAT)

		end

		self:FireBullets( bullet )

	end

	

	if  angdiff < 30 && angdiff > -100 then

	self:SetNextPrimary( 0.08)

		local laser = util.TraceLine( {

			start = self:GetGunner():EyePos(),

			endpos = self:EyePos() + EyeAngles:Forward() * 1000000,

			filter = {self,self:GetGunner()},

			ignoreworld = false,

		} )

		self:EmitSound("renegadelaat/twinfire.wav")

		local startpos =  self:GetRotorPos()

		local fP = { Vector(94.6,-7.12,-73.62), Vector(94.6,7.87,-73.62), Vector(95.27,-7.13,-64.17), Vector(95.27,7.57,-64.17), }

		local bullet = {}

		bullet.Num 	= 1

		bullet.Src 	= self:LocalToWorld( Vector(300,35,33) )

		bullet.Dir 	= (laser.HitPos - bullet.Src):GetNormalized()

		bullet.Spread 	= Vector( 0.001,  0.001, 0 )

		bullet.Tracer	= 1

		bullet.TracerName	= "lfs_singlelaatlaserb"

		bullet.Force	= 100

		bullet.HullSize 	= 40

		bullet.Damage	= 20

		bullet.Attacker 	= self:GetDriver()

		bullet.AmmoType = "Pistol"

		bullet.Callback = function(att, tr, dmginfo)

			dmginfo:SetDamageType(DMG_AIRBOAT)

		end

		self:FireBullets( bullet )

	end

	if  angdiff > 140 || angdiff < -140 then

	self:SetNextPrimary( 0.13)

		local laser = util.TraceLine( {

			start = self:GetGunner():EyePos(),

			endpos = self:EyePos() + EyeAngles:Forward() * 1000000,

			filter = {self,self:GetGunner(),self:GetGunner():GetVehicle()},

			ignoreworld = false,

		} )

		self:EmitSound("renegadelaat/tailgun.wav")

		local startpos =  self:GetRotorPos()

		local fP = { Vector(94.6,-7.12,-73.62), Vector(94.6,7.87,-73.62), Vector(95.27,-7.13,-64.17), Vector(95.27,7.57,-64.17), }

		local bullet = {}

		bullet.Num 	= 1

		bullet.Src 	= self:LocalToWorld( Vector(-300,35,33) )

		bullet.Dir 	= (laser.HitPos - bullet.Src):GetNormalized()

		bullet.Spread 	= Vector( 0.001,  0.001, 0 )

		bullet.Tracer	= 1

		bullet.TracerName	= "lfs_singlelaatlaserc"

		bullet.Force	= 100

		bullet.HullSize 	= 40

		bullet.Damage	= 30

		bullet.Attacker 	= self:GetDriver()

		bullet.AmmoType = "Pistol"

		bullet.Callback = function(att, tr, dmginfo)

			dmginfo:SetDamageType(DMG_AIRBOAT)

		end

		self:FireBullets( bullet )

	end

end



function ENT:SecondaryAttack()

	if not self:CanSecondaryAttack() then return end

	if self:GetAI() then return end

	

	self:TakeSecondaryAmmo()



	self:EmitSound( "renegadelaat/firerocket2.wav" )

	

	local startpos =  self:GetRotorPos()

	local tr = util.TraceHull( {

		start = startpos,

		endpos = (startpos + self:GetForward() * 50000),

		mins = Vector( -40, -40, -40 ),

		maxs = Vector( 40, 40, 40 ),

		filter = self

} )

	

	local rocketpos = {

		self:GetPos()+self:GetForward()*65+self:GetUp()*-94+self:GetRight()*-37,

	}	

		

	//local ent = ents.Create( "lunasflightschool_hyena_missile" )

	local mPos

	if (self:GetAmmoSecondary()+1)%5 == 0 then

		mPos = rocketpos[1]

		self:SetNextSecondary( 0.30 )



	elseif (self:GetAmmoSecondary()+1)%5 == 4 then

		mPos = rocketpos[1]

		self:SetNextSecondary( 0.30 )



	elseif (self:GetAmmoSecondary()+1)%5 == 3 then

		mPos = rocketpos[1]

		self:SetNextSecondary( 0.30 )



	elseif (self:GetAmmoSecondary()+1)%5 == 2 then

		mPos = rocketpos[1]

		self:SetNextSecondary( 0.30 )



	else

		mPos = rocketpos[1]

		self:SetNextSecondary( 7 )

	end



	local Ang = self:WorldToLocal( mPos ).y > 0 and -1 or 1

	ent:SetPos( mPos )

	ent:SetAngles( self:LocalToWorldAngles( Angle(0,Ang,0) ) )

	ent:Spawn()

	ent:Activate()

	ent:SetAttacker( self:GetDriver() )

	ent:SetInflictor( self )

	ent:SetStartVelocity( self:GetVelocity():Length() )

	ent:SetDirtyMissile( true )

	

	if self:GetAI() then

		local enemy = self:AIGetTarget()

		if IsValid(enemy) then

			if math.random(1,8) != 1 then

				if string.find(enemy:GetClass(),"lunasflightschool") then

					if enemy:GetClass() == "lunasflightschool_hyena_missile" then return end

					ent:SetLockOn(enemy)

					ent:SetStartVelocity(0)

				end

			end

		end

	else

		if tr.Hit then

			local Target = tr.Entity

			if IsValid(Target) then

				if Target:GetClass():lower() ~= "lunasflightschool_hyena_missile" then

					ent:SetLockOn(Target)

					ent:SetStartVelocity(0)

				end

			end

		end

	end

	constraint.NoCollide(ent,self,0,0) 

end



function ENT:SetNextAltPrimary( delay )

	self.NextAltPrimary = CurTime() + delay

end



function ENT:CanAltPrimaryAttack()

	self.NextAltPrimary = self.NextAltPrimary or 0

	return self.NextAltPrimary < CurTime()

end



ENT.TotalBombsFire = 0

function ENT:AltPrimaryAttack( Driver, Pod )



	if not self:CanAltPrimaryAttack() then return end

	

	if self.TotalBombsFire >= 9 then

		return

	end

	self:SetNextAltPrimary( 0.25 )

	self.TotalBombsFire = self.TotalBombsFire +1

	if self.TotalBombsFire >= 9 then

		timer.Simple(5,function()

			if IsValid(self) then

				self.TotalBombsFire = 0

			end

		end)

	end



	

	self.MirrorPrimary = not self.MirrorPrimary	

	local Mirror = self.MirrorPrimary and -1 or 1

	self:EmitSound( "renegadelaat/firerocket2.wav" )

	local ent = ents.Create("lunasflightschool_prlaat_missile")

	local Pos

	if Mirror == 1 then

		Pos = self:LocalToWorld(Vector( 139.81, 69.2, 272.4 ))

	else

		Pos = self:LocalToWorld(Vector( 139.81, -68.81, 272.53 ))

	end

	ent:SetPos(Pos)

	ent:SetAngles(self:GetAngles())

	ent.SmallExplosion = true

	ent:Spawn()

	ent:Activate()

	ent:SetAttacker(self:GetDriver())

	ent:SetInflictor(self)

	ent:SetStartVelocity(0)

	constraint.NoCollide(ent,self,0,0)

end



function ENT:OnKeyThrottle( bPressed )

	if bPressed then

		if self:CanSound() then

			self:EmitSound( "HYENA_BOOST" )

			self:DelayNextSound( 4 )

		end

	end

end



function ENT:HandleWeapons(Fire1, Fire2)

	local Driver = self:GetDriver()

	local Gunner = self:GetGunner()

	local HasGunner = IsValid(Gunner)

	if IsValid(Driver) then

		if(Driver:KeyDown(IN_ATTACK2)) then

			self:AltPrimaryAttack()

		end

	end

	if IsValid( Gunner ) then

		if self:GetAmmoPrimary() > 0 then

			Fire1 = Gunner:KeyDown( IN_ATTACK )

		end

	

		-- FireTurret = Gunner:KeyDown( IN_WALK )

	

		-- if self:GetAmmoSecondary() > 0 then

		-- 	Fire2 = Gunner:KeyDown( IN_ATTACK2 )

		-- end

	end

	

	if Fire1 then self:PrimaryAttack() end



	-- if Fire1 then

	-- 	if FireTurret and not HasGunner then

	-- 		self:AltPrimaryAttack()

	-- 	else

	-- 		self:PrimaryAttack()

	-- 	end

    -- end



	-- if Fire2 then

	-- 	self:SecondaryAttack()

	-- end

end



function ENT:OnRotorDestroyed()

	self:EmitSound( "physics/metal/metal_box_break2.wav" )

	

	self:SetBodygroup( 1, 2 )

	self:SetBodygroup( 2, 2 ) 

	

	//self:SetHP(1)

	

	timer.Simple(2, function()

		if not IsValid( self ) then return end

		//self:Destroy()

	end)

end

