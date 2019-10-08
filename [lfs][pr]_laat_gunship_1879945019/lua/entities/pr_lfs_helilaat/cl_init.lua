--DO NOT EDIT OR REUPLOAD THIS FILE

include("shared.lua")

local function CopyPoseParams( pEntityFrom, pEntityTo )
	for i = 0, pEntityFrom:GetNumPoseParameters() - 1 do
		local flMin, flMax = pEntityFrom:GetPoseParameterRange( i )
		local sPose = pEntityFrom:GetPoseParameterName( i )
		pEntityTo:SetPoseParameter( sPose, math.Remap( pEntityFrom:GetPoseParameter( sPose ), 0, 1, flMin, flMax ) )
	end
end


function ENT:Initialize()
	
	if IsValid(self) then
	self.RBLOOP = CreateSound(self,"PRLAAT_BEAMLOOP")
		self.LBLOOP = CreateSound(self,"PRLAAT_BEAMLOOP")
		self.WLOOP = CreateSound(self,"PRLAAT_BEAMLOOP")
		self.WLOOP1 = CreateSound(self,"PRLAAT_BEAMLOOP")
	self.ClientEngineState = self:GetEngineState()
	self.NextEngineCheck = 0
	self.InFirstPerson = false
	// nothing like putting pretend players in so you can do trailer footage at the dead hours of the morning

		-- self.GhostEntity1 = ClientsideModel( "models/player/renegade/clones/arf/ace.mdl", RENDERGROUP_BOTH ) 
		-- //self.GhostEntity1:SetNoDraw( true )
		
		-- self.GhostEntity2 = ClientsideModel( "models/player/kleiner.mdl", RENDERGROUP_BOTH )
		-- //self.GhostEntity2:SetNoDraw( true )	
		-- local rballid = self:LookupAttachment( "muzzle_rightball" )
		-- local rightball = self:GetAttachment( 2 )
		-- local pos,ang = LocalToWorld(Vector(110,-160,-85),Angle(-5,-90,0),rightball.Pos,rightball.Ang)
		-- //local pos,ang = LocalToWorld(Vector(0,-160,0),Angle(-20,-90,0),rightball.Pos,rightball.Ang)
		-- self.GhostEntity1:SetParent(NULL)
		-- self.GhostEntity1:SetPos(pos)
		-- self.GhostEntity1:SetSequence( self.GhostEntity1:LookupSequence("drive_jeep") )
		-- //print(pos)
		-- self.GhostEntity1:SetAngles(ang)
		-- self.GhostEntity1:SetParent(self, 2)
		-- self.GhostEntity1:AddEffects(EF_PARENT_ANIMATES)
		-- //self.GhostEntity1:FollowBone(self, self:LookupBone("cbt_pitch_r"))
		-- //self.GhostEntity1:SetPos(pos)
		
		
		
		
		
		-- local lballid = self:LookupAttachment( "muzzle_leftball" )
		-- local leftball = self:GetAttachment( lballid )
		-- local pos,ang = LocalToWorld(Vector(0,-370,-20),Angle(0,0,20),leftball.Pos,leftball.Ang)
		-- self.GhostEntity2:SetParent(NULL)
		-- //self.GhostEntity2:SetPos(pos)
		-- self.GhostEntity2:SetAngles(ang)
		-- self.GhostEntity2:SetParent(self, lballid)
		
	end
	

end


function ENT:ExhaustFX()
	if not self:GetEngineActive() then return end
	
	self.nextEFX = self.nextEFX or 0
	
	local THR = (self:GetRPM() - self.IdleRPM) / (self.LimitRPM - self.IdleRPM)
	
	local Driver = self:GetDriver()
	if IsValid( Driver ) then
		local W = Driver:lfsGetInput( "+THROTTLE" )
		if W ~= self.oldW then
			self.oldW = W
			if W then
				self.BoostAdd = 200
			end
		end
	end
	
	self.BoostAdd = self.BoostAdd and (self.BoostAdd - self.BoostAdd * FrameTime()) or 0
	
	if self.nextEFX < CurTime() then
		self.nextEFX = CurTime() + 0.01
		
		local emitter = ParticleEmitter( self:GetPos(), false )

		if emitter then
			local Mirror = false
			for i = 0,1 do
				local Sub = Mirror and 1 or -1
				local vOffset = self:LocalToWorld( Vector(-330,70 * Sub,273) )
				local vNormal = -self:GetForward()

				vOffset = vOffset + vNormal * 5

				local particle = emitter:Add( "effects/muzzleflash2", vOffset )
				if not particle then return end

				particle:SetVelocity( vNormal * math.Rand(500,1000) + self:GetVelocity() )
				particle:SetLifeTime( 0 )
				particle:SetDieTime( 0.1 )
				particle:SetStartAlpha( 255 )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( math.Rand(15,25) )
				particle:SetEndSize( math.Rand(0,10) )
				particle:SetRoll( math.Rand(-1,1) * 100 )
				
				particle:SetColor( 255, 50, 200 )
			
				Mirror = true
			end
			
			emitter:Finish()
		end
	end
end

function ENT:CalcEngineSound( RPM, Pitch, Doppler )
//print(self.ENG)
	if self.ENG then
	if(CurTime()>self.NextEngineCheck ) then
		if(self.ClientEngineState!=self:GetEngineState()) then
			if(self:GetEngineState()==0) then 
				self.ClientEngineState = 0
				self.ENG:Stop()
				self.ENG = CreateSound( self, "PRLAAT_HOVERENGINE" )
				self.ENG:PlayEx(0,0)
			elseif(self:GetEngineState()==1) then
				self.ClientEngineState = 1
				self.ENG:Stop()
				self.ENG = CreateSound( self, "PRLAAT_FLIGHTENGINE" )
				self.ENG:PlayEx(0,0)
			else
				self.ClientEngineState = 2
				self.ENG:Stop()
				self.ENG = CreateSound( self, "PRLAAT_CRASHING" )
				self.ENG:PlayEx(0,0)
			end
		end
		self.NextEngineCheck = CurTime()+2
	end
	//print(self.FirstPersonMode)
	if(self.FirstPersonMode) then
		self.ENG:SetDSP(1)
	else
		self.ENG:SetDSP(1)
	end
	
		self.ENG:ChangePitch(  math.Clamp(math.Clamp(  70 + Pitch * 45, 50,255) + Doppler,0,255) )
		self.ENG:ChangeVolume( math.Clamp( -1 + Pitch * 6, 0.5,1) )
	end
	
	if self.DIST then
		self.DIST:ChangePitch(  math.Clamp(math.Clamp(  Pitch * 150, 50,255) + Doppler,0,255) )
		self.DIST:ChangeVolume( math.Clamp( -1 + Pitch * 6, 0.5,1) )
	end
end

function ENT:EngineActiveChanged( bActive )
	if bActive then
		self.ENG = CreateSound( self, "PRLAAT_HOVERENGINE" )
		self.ENG:PlayEx(0,0)
		
		--self.DIST = CreateSound( self, "LFS_SPITFIRE_DIST" )
		--self.DIST:PlayEx(0,0)
	else
		self:SoundStop()
	end
end

function ENT:OnRemove()
	self:SoundStop()
end

function ENT:SoundStop()
	-- if self.DIST then
	-- 	self.DIST:Stop()
	-- end
	
	if self.ENG then
		self.ENG:Stop()
	end
	if self.INT then
		self.INT:Stop()
	end
	if self.RBLOOP then
		self.RBLOOP:Stop()
	end
	if self.LBLOOP then
		self.LBLOOP:Stop()
	end
	if self.WLOOP then
		self.WLOOP:Stop()
	end
	if self.WLOOP1 then
		self.WLOOP1:Stop()
	end
end

function ENT:AnimFins()
//print(self:GetManipulateBoneAngles(3))
	local Gunner = self:GetGunner()
	
	local HasGunner = IsValid( Gunner )
	
	if not IsValid( Gunner ) and not HasGunner then return end
	
	if HasGunner then Driver = Gunner end
	
	local EyeAngles = self:WorldToLocalAngles( Gunner:EyeAngles() )
	//local EyeAngles = Gunner:EyeAngles() 

	local Yaw = math.Clamp( EyeAngles.y,-30,100)
	local Pitch = math.Clamp( EyeAngles.p,-80,90 )
	
	local Yaw2 = math.Clamp( EyeAngles.y,-100,25)
	local Pitch2 = math.Clamp( EyeAngles.p,-80,90 )
	
	local EyeAngles = self:GetGunner():GetVehicle():WorldToLocalAngles( Gunner:EyeAngles() )
	local Forward = -self:GetForward()
	
	
	
	local angDiffy = EyeAngles.y - self:GetAngles().y
	local angDiffp = EyeAngles.p - self:GetAngles().p
	
	EyeAngles:RotateAroundAxis( self:GetUp(), 180 )
	//local Yaw3 = math.Clamp(  EyeAngles.y,-40,40)
	//local Pitch3 = math.Clamp( EyeAngles.p,-60,60 )
	//(EyeAngles.y)
	self:ManipulateBoneAngles( 3, Angle(0,Yaw,-Pitch) )
	self:ManipulateBoneAngles( 8,Angle(0,Yaw2,-Pitch2)  )
	local AimDirToForwardDir = math.deg( math.acos( math.Clamp( Forward:Dot( EyeAngles:Forward() ) ,-1,1) ) )
	
	if AimDirToForwardDir > 45 then self:ManipulateBoneAngles( 9,Angle(0,0,0)  )return end
	self:ManipulateBoneAngles( 9,Angle(0,EyeAngles.y,-EyeAngles.p)  )
	
end


function ENT:AnimCabin()
end

function ENT:GunCamera( view, ply )
	if IsValid(self:GetNWEntity("GunnerSeatRDriver")) && ply == self:GetNWEntity("GunnerSeatRDriver") then
		local rballmuzzle = self:LookupAttachment( "muzzle_rightball" )
		local rballpew = self:GetAttachment( rballmuzzle )
		local pos,ang = LocalToWorld(Vector(0,-30,20),Angle(0,0,0),rballpew.Pos,rballpew.Ang)
		local Zoom = ply:KeyDown( IN_ATTACK2 )
		
		if Zoom then 
			view.fov = 60
		else
		
		end
		view.origin = pos
		view.angles = ply:EyeAngles()
	end
	
	if IsValid(self:GetNWEntity("GunnerSeatLDriver")) && ply == self:GetNWEntity("GunnerSeatLDriver") then
		local rballmuzzle = self:LookupAttachment( "muzzle_leftball" )
		local rballpew = self:GetAttachment( rballmuzzle )
		local pos,ang = LocalToWorld(Vector(0,-30,20),Angle(0,0,0),rballpew.Pos,rballpew.Ang)
		local Zoom = ply:KeyDown( IN_ATTACK2 )
		
		if Zoom then 
			view.fov = 70
		else
		
		end
		view.origin = pos
		view.angles = ply:EyeAngles()
	end
	return view
end

local HardLaser = Material( "lightsaber/hard_light" )
local HardLaserInner = Material( "lightsaber/hard_light_inner" )

local HardLaserTrail = Material( "lightsaber/hard_light_trail" )
local HardLaserTrailInner = Material( "lightsaber/hard_light_trail_inner" )
local HardLaserTrailInner2 = Material( "sprites/tp_beam001" )
local HardLaserTrailEnd = Material( "lightsaber/hard_light_trail_end" )
local HardLaserTrailEndInner = Material( "lightsaber/hard_light_trail_end_inner" )
local CompositeGlow = Material( "sprites/light_glow02_add" )
function ENT:CreateWingBeam(seat,pos,ang)

		local laser = util.TraceLine( {
			start = pos,
			endpos =  pos + ang:Forward() * 1000000,
			ignoreworld = false,
		} )
		if laser.Entity == self then return end
		local clr = Color(10,255,0)
		local inclr = Color(700,700,700,255)
		
		local compositepoint = pos + ang:Right()*-15

		//Glowies
		render.SetMaterial( CompositeGlow )
		local outerwidth = 90 + math.random(0,20)
		local innerwidth = 50 + math.random(0,20)
		
		render.DrawSprite( compositepoint+ang:Right()*-3, outerwidth, outerwidth, Color(0,255,0,255) )
		render.DrawSprite( compositepoint+ang:Right()*-3, innerwidth, innerwidth, Color(255,255,255,255) )
		render.DrawSprite( laser.HitPos, innerwidth*4, innerwidth*4, Color(255,255,255,255) )
		render.DrawSprite( laser.HitPos, outerwidth*4, outerwidth*4, Color(0,255,0,255) )
		//Beamies
		//render.SetMaterial( HardLaserTrailInner2 )
		////Composite Beams
		//render.DrawBeam( pos+ang:Up()*5+ang:Forward()*3,compositepoint, 3, 1, 0.01, clr )
		//render.DrawBeam( pos+ang:Up()*5+ang:Forward()*-3,compositepoint, 3, 1, 0.01, clr )
		//render.DrawBeam( pos+ang:Forward()*-7,compositepoint, 3, 1, 0.01, clr )
		//render.DrawBeam( pos+ang:Forward()*7,compositepoint, 3, 1, 0.01, clr )
		//render.DrawBeam( pos+ang:Up()*-5+ang:Forward()*-3,compositepoint, 3, 1, 0.01, clr )
		//render.DrawBeam( pos+ang:Up()*-5+ang:Forward()*3,compositepoint, 3, 1, 0.01, clr )
		
		//Main Beams
		render.DrawBeam( compositepoint,laser.HitPos, 25, 1, 0.01, clr )
		render.SetMaterial( HardLaser )
		render.DrawBeam( compositepoint,laser.HitPos, 10, 1, 0.01, clr )

		render.SetMaterial( HardLaserInner )
		render.DrawBeam(   compositepoint,laser.HitPos, 13, 1, 0.01, inclr )
		util.Decal( "Scorch", laser.HitPos + laser.HitNormal, laser.HitPos - laser.HitNormal );
	
		local fx = EffectData()
	
		fx:SetOrigin(laser.HitPos);
	
		fx:SetNormal(laser.HitNormal);
	
		util.Effect( "StunstickImpact", fx, true )
		//util.Effect( "green_impact_03", fx, true )
		//fx:SetFlags( 4 )
		//util.Effect( "Explosion", fx, true )


end

function ENT:CreateBeam(seat,pos,ang)

		local laser = util.TraceLine( {
			start = pos,
			endpos =  pos + ang:Right() * -1000000,
			ignoreworld = false,
		} )
		if laser.Entity == self then return end
		local clr = Color(10,255,0)
		local inclr = Color(700,700,700,255)
		
		local compositepoint = pos + ang:Right()*-15

		//Glowies
		render.SetMaterial( CompositeGlow )
		local outerwidth = 90 + math.random(0,20)
		local innerwidth = 50 + math.random(0,20)
		
		render.DrawSprite( compositepoint+ang:Right()*-3, outerwidth, outerwidth, Color(0,255,0,255) )
		render.DrawSprite( compositepoint+ang:Right()*-3, innerwidth, innerwidth, Color(255,255,255,255) )
		render.DrawSprite( laser.HitPos, innerwidth*4, innerwidth*4, Color(255,255,255,255) )
		render.DrawSprite( laser.HitPos, outerwidth*4, outerwidth*4, Color(0,255,0,255) )
		//Beamies
		render.SetMaterial( HardLaserTrailInner2 )
		//Composite Beams
		render.DrawBeam( pos+ang:Up()*5+ang:Forward()*3,compositepoint, 3, 1, 0.01, clr )
		render.DrawBeam( pos+ang:Up()*5+ang:Forward()*-3,compositepoint, 3, 1, 0.01, clr )
		render.DrawBeam( pos+ang:Forward()*-7,compositepoint, 3, 1, 0.01, clr )
		render.DrawBeam( pos+ang:Forward()*7,compositepoint, 3, 1, 0.01, clr )
		render.DrawBeam( pos+ang:Up()*-5+ang:Forward()*-3,compositepoint, 3, 1, 0.01, clr )
		render.DrawBeam( pos+ang:Up()*-5+ang:Forward()*3,compositepoint, 3, 1, 0.01, clr )
		
		//Main Beams
		render.DrawBeam( compositepoint,laser.HitPos, 25, 1, 0.01, clr )
		render.SetMaterial( HardLaser )
		render.DrawBeam( compositepoint,laser.HitPos, 10, 1, 0.01, clr )

		render.SetMaterial( HardLaserInner )
		render.DrawBeam(   compositepoint,laser.HitPos, 13, 1, 0.01, inclr )
		util.Decal( "Scorch", laser.HitPos + laser.HitNormal, laser.HitPos - laser.HitNormal );
	
		local fx = EffectData()
	
		fx:SetOrigin(laser.HitPos);
	
		fx:SetNormal(laser.HitNormal);
	
		util.Effect( "StunstickImpact", fx, true )
		//util.Effect( "green_impact_03", fx, true )
		//fx:SetFlags( 4 )
		//util.Effect( "Explosion", fx, true )


end

-- function ENT:RightBallTurret(seat,gunner)
-- 	local eyeangles  = seat:WorldToLocalAngles( gunner:EyeAngles() )
	
-- 	local g,correctAngle = WorldToLocal( Vector(0,0,0), eyeangles, Vector(0,0,0), self:LocalToWorldAngles(Angle(0,-90,0) ))
-- 	self:SetPoseParameter( "rightpitch", -correctAngle.p )
-- 	self:SetPoseParameter( "rightyaw", -correctAngle.y )
-- 	self:InvalidateBoneCache()
-- 	if gunner:KeyDown( IN_ATTACK ) then
	
-- 		self:RightLaserAttack(seat)
		
-- 	end

-- end

-- function ENT:LeftBallTurret(seat,gunner)
-- 	local eyeangles  = seat:WorldToLocalAngles( gunner:EyeAngles() )
	
-- 	local g,correctAngle = WorldToLocal( Vector(0,0,0), eyeangles, Vector(0,0,0), self:LocalToWorldAngles(Angle(0,90,0) ))
-- 	self:SetPoseParameter( "leftpitch", -correctAngle.p )
-- 	self:SetPoseParameter( "leftyaw", correctAngle.y )
-- 	self:InvalidateBoneCache()
-- 	if gunner:KeyDown( IN_ATTACK ) then
	
-- 		self:LeftLaserAttack(seat)
		
-- 	end

-- end

function ENT:OnRemove()

if IsValid(self.GhostEntity1) then self.GhostEntity1:Remove() end
if IsValid(self.GhostEntity2) then self.GhostEntity2:Remove() end
self:SoundStop()

end

-- function ENT:Think()
-- 	if IsValid(self:GetNWEntity("GunnerSeatR")) && IsValid(self:GetNWEntity("GunnerSeatRDriver")) then
-- 		print("Cmon")
-- 		self.GhostEntity1:SetNoDraw(false)
-- 		self:GetNWEntity("GunnerSeatRDriver"):SetNoDraw(false)
-- 		-- if self:GetNWEntity("GunnerSeatRDriver"):GetSequence() != self.GhostEntity1:GetSequence() then
-- 		-- 	self.GhostEntity1:ResetSequenceInfo()
-- 		-- 	self.GhostEntity1:SetSequence( self:GetNWEntity("GunnerSeatRDriver"):GetSequence() )
-- 		-- end
-- 		-- CopyPoseParams( self:GetNWEntity("GunnerSeatRDriver"), self.GhostEntity1 )
-- 		self.GhostEntity1:InvalidateBoneCache()
-- 	else
-- 		self.GhostEntity1:SetNoDraw(false)	
-- 	end
	
	
-- 	if IsValid(self:GetNWEntity("GunnerSeatL")) && IsValid(self:GetNWEntity("GunnerSeatLDriver")) then
-- 		self.GhostEntity2:SetNoDraw(false)
-- 		-- if self:GetNWEntity("GunnerSeatLDriver"):GetSequence() != self.GhostEntity2:GetSequence() then
-- 		-- 	self.GhostEntity2:ResetSequenceInfo()
-- 		-- 	self.GhostEntity2:SetSequence( self:GetNWEntity("GunnerSeatLDriver"):GetSequence() )
-- 		-- end
		
-- 		-- CopyPoseParams( self:GetNWEntity("GunnerSeatLDriver"), self.GhostEntity2 )
-- 		self.GhostEntity2:InvalidateBoneCache()
-- 	else
-- 		self.GhostEntity2:SetNoDraw(false)	
-- 	end

-- end

local mat = Material( "sprites/light_glow02_add" )
function ENT:Draw()
//print( self:LocalToWorldAngles(self:GetNWEntity("wingturretseatdriver"):GetAimVector():Angle()))
	self:DrawModel()
	//self.GhostEntity1:SetPredictable(false)
	//debugoverlay.Sphere(self:GetAttachment(self:LookupAttachment("muzzle_rightball")).Pos, 1, .1)
	if IsValid(self:GetNWEntity("GunnerSeatRDriver")) && self:GetRightBallFiring() then
		local seat = self:GetNWEntity("GunnerSeatR")
		local rballmuzzle = self:LookupAttachment( "muzzle_rightball" )
		local rballpew = self:GetAttachment( rballmuzzle )
		local pos,ang = LocalToWorld(Vector(0,-0,0),Angle(0,0,0),rballpew.Pos,rballpew.Ang)
		self:CreateBeam(seat,pos,ang)
		if(!self.RBLOOP:IsPlaying()) then
			self:EmitSound("renegadelaat/laserstart.wav")
		end
		self.RBLOOP:SetDSP(0)
		self.RBLOOP:Play()
	elseif(self.RBLOOP) then
		self.RBLOOP:Stop()
	end
	if IsValid(self:GetNWEntity("GunnerSeatLDriver")) && self:GetLeftBallFiring() then
		local seat = self:GetNWEntity("GunnerSeatL")
		local lballmuzzle = self:LookupAttachment( "muzzle_leftball" )
		local lballpew = self:GetAttachment( lballmuzzle )
		local pos,ang = LocalToWorld(Vector(0,0,0),Angle(0,0,0),lballpew.Pos,lballpew.Ang)
		self:CreateBeam(seat,pos,ang)
		if(!self.LBLOOP:IsPlaying()) then
			self:EmitSound("renegadelaat/laserstart.wav")
		end
		
		self.LBLOOP:Play()
	elseif(self.LBLOOP) then
		self.LBLOOP:Stop()
	end
	
	if IsValid(self:GetNWEntity("wingturretseatdriver")) && self:GetRightTopBallFiring() then
		
		//EyeAngles:RotateAroundAxis( self:GetUp(), 90 )
		local seat = self:GetNWEntity("wingturretseat")
		local lballpew = self:GetAttachment( 5 )
		local pos,ang = LocalToWorld(Vector(0,0,0),Angle(0,0,0),lballpew.Pos + self:GetAngles():Up() * 30,Angle(0,0,0))
		ang = self:GetWingAngle()
		//ang = ang - self:GetAngles()
		//ang:RotateAroundAxis(self:GetUp(),90)
		self:CreateWingBeam(seat,pos,ang)
		if(!self.WLOOP:IsPlaying()) then
			self:EmitSound("renegadelaat/laserstart.wav")
		end
		
		self.WLOOP:Play()
	elseif(self.WLOOP) then
		self.WLOOP:Stop()
	end
	
	if IsValid(self:GetNWEntity("wingturretseatdriver")) && self:GetLeftTopBallFiring() then
		
		//EyeAngles:RotateAroundAxis( self:GetUp(), 90 
		local seat = self:GetNWEntity("wingturretseat")
		local lballpew = self:GetAttachment( 4 )
		local pos,ang = LocalToWorld(Vector(0,0,0),Angle(0,0,0),lballpew.Pos + self:GetAngles():Up() * 30,self:GetNWEntity("wingturretseatdriver"):GetAimVector():Angle())
		ang = self:GetWingAngle()
		//ang:RotateAroundAxis(self:GetUp(),90)
		self:CreateWingBeam(seat,pos,ang)
		
	end
	
	
	if IsValid(self:GetNWEntity("wingturretseatdriver")) && self:GetRightBottomBallFiring() then
		
		//EyeAngles:RotateAroundAxis( self:GetUp(), 90 )
		
		local seat = self:GetNWEntity("wingturretseat")
		local lballpew = self:GetAttachment( 5 )
		local pos,ang = LocalToWorld(Vector(0,0,0),Angle(0,0,0),lballpew.Pos - self:GetAngles():Up() * 30,Angle(0,0,0))
		ang = self:GetWingAngle()
		//ang:RotateAroundAxis(self:GetUp(),90)
		self:CreateWingBeam(seat,pos,ang)
		if(!self.WLOOP1:IsPlaying()) then
			self:EmitSound("renegadelaat/laserstart.wav")
		end
		
		self.WLOOP1:Play()
	elseif(self.WLOOP1) then
		self.WLOOP1:Stop()
	end
	
	if IsValid(self:GetNWEntity("wingturretseatdriver")) && self:GetLeftBottomBallFiring() then
		
		//EyeAngles:RotateAroundAxis( self:GetUp(), 90 )
		local seat = self:GetNWEntity("wingturretseat")
		local lballpew = self:GetAttachment( 4 )
		local pos,ang = LocalToWorld(Vector(0,0,0),Angle(0,0,0),lballpew.Pos - self:GetAngles():Up() * 30,Angle(0,0,0))
		ang = self:GetWingAngle()
		//ang:RotateAroundAxis(self:GetUp(),90)
		
		self:CreateWingBeam(seat,pos,ang)
	end
	
	if not self:GetEngineActive() then return end
	
	local Boost = self.BoostAdd or 0
	
	local Size = 80 + (self:GetRPM() / self:GetLimitRPM()) * 120 + Boost
	local Mirror = false
	for i = 0,1 do
		local Sub = Mirror and 1 or -1
		local pos = self:LocalToWorld( Vector(-330,70 * Sub,273) )
		
		render.SetMaterial( mat )
		render.DrawSprite( pos, Size, Size, Color( 255, 50, 0, 255) )
		Mirror = true
	end
end


function ENT:LFSCalcViewThirdPerson( view, ply ) -- modify third person camera view here
	local ply = LocalPlayer()
	
	local Pod = ply:GetVehicle()
	
	if not IsValid( Pod ) then return view end
	
	if ply == self:GetDriver() then
		local radius = 1000
		radius = radius + radius * Pod:GetCameraDistance()
		
		view.origin = self:LocalToWorld( Vector(0,0,300) )
		view.angles = LocalPlayer():EyeAngles()
		local TargetOrigin = view.origin - view.angles:Forward() * radius  + view.angles:Up() * 950 * 0.1
		local WallOffset = 1

		local tr = util.TraceHull( {
			start = view.origin,
			endpos = TargetOrigin,
			filter = function( e )
				local c = e:GetClass()
				local collide = not c:StartWith( "prop_physics" ) and not c:StartWith( "prop_dynamic" ) and not c:StartWith( "prop_ragdoll" ) and not e:IsVehicle() and not c:StartWith( "gmod_" ) and not c:StartWith( "player" ) and not e.LFS
				
				return collide
			end,
			mins = Vector( -WallOffset, -WallOffset, -WallOffset ),
			maxs = Vector( WallOffset, WallOffset, WallOffset ),
		} )
		
		view.origin = tr.HitPos
		
		if tr.Hit and not tr.StartSolid then
			view.origin = view.origin + tr.HitNormal * WallOffset
		end
		
		return view
	end
	
	if ply == self:GetGunner() then
		local radius = 1000
		local WallOffset = 1
		radius = radius + radius * Pod:GetCameraDistance()
		
		view.origin = self:LocalToWorld( Vector(0,0,200) )
		view.angles = LocalPlayer():EyeAngles()
		local TargetOrigin = view.origin - view.angles:Forward() * radius  + view.angles:Up() * 3500 * 0.1
		
		local tr = util.TraceHull( {
			start = self:GetGunner():GetPos(),
			endpos = TargetOrigin,
			filter = function( e )
				local c = e:GetClass()
				local collide = not c:StartWith( "prop_physics" ) and not c:StartWith( "prop_dynamic" ) and not c:StartWith( "prop_ragdoll" ) and not e:IsVehicle() and not c:StartWith( "gmod_" ) and not c:StartWith( "player" ) and not e.LFS
				return collide
			end,
			mins = Vector( -WallOffset, -WallOffset, -WallOffset ),
			maxs = Vector( WallOffset, WallOffset, WallOffset ),
		} )
		
		view.origin = tr.HitPos
		
		if tr.Hit and not tr.StartSolid then
			view.origin = view.origin + tr.HitNormal * WallOffset
		end
		
		return view
	end
	
	if ply == self:GetNWEntity("wingturretseatdriver") then
		local radius = 1000
		local WallOffset = 1
		radius = radius + radius * Pod:GetCameraDistance()
		//print("Work")
		view.origin = self:LocalToWorld( Vector(500,0,0) )
		view.angles = LocalPlayer():EyeAngles()
		local TargetOrigin = view.origin - view.angles:Forward() * radius  + view.angles:Up() * 3500 * 0.1
		
		local tr = util.TraceHull( {
			start = self:GetNWEntity("wingturretseatdriver"):GetPos(),
			endpos = TargetOrigin,
			filter = function( e )
				local c = e:GetClass()
				local collide = not c:StartWith( "prop_physics" ) and not c:StartWith( "prop_dynamic" ) and not c:StartWith( "prop_ragdoll" ) and not e:IsVehicle() and not c:StartWith( "gmod_" ) and not c:StartWith( "player" ) and not e.LFS
				return collide
			end,
			mins = Vector( -WallOffset, -WallOffset, -WallOffset ),
			maxs = Vector( WallOffset, WallOffset, WallOffset ),
		} )
		
		view.origin = tr.HitPos
		
		if tr.Hit and not tr.StartSolid then
			view.origin = view.origin + tr.HitNormal * WallOffset
		end
		
		return view
	end
	return view
end


function ENT:LFSCalcViewFirstPerson( view, ply )
	if IsValid(self:GetNWEntity("GunnerSeatRDriver")) && ply == self:GetNWEntity("GunnerSeatRDriver") then
	
		return self:GunCamera( view, ply )
	end
	
	if IsValid(self:GetNWEntity("GunnerSeatLDriver")) && ply == self:GetNWEntity("GunnerSeatLDriver") then
	
		return self:GunCamera( view, ply )
	end
	return view
end
