
--DO NOT EDIT OR REUPLOAD THIS FILE

EFFECT.Mat = Material( "effects/lfs_base/spark" )
EFFECT.Mat2 = Material( "sprites/light_glow02_add" )

local Materials = {
	"particle/smokesprites_0001",
	"particle/smokesprites_0002",
	"particle/smokesprites_0003",
	"particle/smokesprites_0004",
	"particle/smokesprites_0005",
	"particle/smokesprites_0006",
	"particle/smokesprites_0007",
	"particle/smokesprites_0008",
	"particle/smokesprites_0009",
	"particle/smokesprites_0010",
	"particle/smokesprites_0011",
	"particle/smokesprites_0012",
	"particle/smokesprites_0013",
	"particle/smokesprites_0014",
	"particle/smokesprites_0015",
	"particle/smokesprites_0016"
}

function EFFECT:Init( data )

	self.StartPos = data:GetEntity():GetAttachment(6).Pos
	self.StartPos2 = data:GetEntity():GetAttachment(7).Pos
	self.EndPos = data:GetOrigin()
	
	self.Dir = self.EndPos - self.StartPos
	self.Dir2 = self.EndPos - self.StartPos2

	self:SetRenderBoundsWS( self.StartPos, self.EndPos )

	self.TracerTime = math.min( 1, self.StartPos:Distance( self.EndPos ) / 15000 )
	self.Length = math.Rand( 0.1, 0.15 )

	-- Die when it reaches its target
	self.DieTime = CurTime() + self.TracerTime
	
	local Dir = self.Dir:GetNormalized()
	
	local emitter = ParticleEmitter( self.StartPos, false )
	
	for i = 0, 12 do
		local Pos = self.StartPos + Dir * i * 0.7 * math.random(1,2) * 0.5
		local Pos2 = self.StartPos2 + Dir * i * 0.7 * math.random(1,2) * 0.5
		
		local particle = emitter:Add( "effects/muzzleflash2", Pos )
		local particle2 = emitter:Add( "effects/muzzleflash2", Pos2 )
		local Size = 1
		
		if particle then
			particle:SetVelocity( Dir * 800 )
			particle:SetDieTime( 0.05 )
			particle:SetStartAlpha( 255 * Size )
			particle:SetStartSize( math.max( math.random(10,24) - i * 0.5,0.1 ) * Size )
			particle:SetEndSize( 0 )
			particle:SetRoll( math.Rand( -1, 1 ) )
			particle:SetColor( 0,255,50 )
			particle:SetCollide( false )
		end
		if particle2 then
			particle2:SetVelocity( Dir * 800 )
			particle2:SetDieTime( 0.05 )
			particle2:SetStartAlpha( 255 * Size )
			particle2:SetStartSize( math.max( math.random(10,24) - i * 0.5,0.1 ) * Size )
			particle2:SetEndSize( 0 )
			particle2:SetRoll( math.Rand( -1, 1 ) )
			particle2:SetColor( 0,255,50 )
			particle2:SetCollide( false )
		end
		
		
	end
	
	-- for i = 0,20 do
	-- 	local particle = emitter:Add( Materials[math.random(1,table.Count( Materials ))],self.StartPos )
		
	-- 	local rCol = 255
		
	-- 	if particle then
	-- 		particle:SetVelocity( Dir * math.Rand(1000,3000) + VectorRand() * math.Rand(0,10) )
	-- 		particle:SetDieTime( math.Rand(0.05,0.2) )
	-- 		particle:SetAirResistance( math.Rand(50,100) ) 
	-- 		particle:SetStartAlpha( 20 )
	-- 		particle:SetStartSize( 2 )
	-- 		particle:SetEndSize( math.Rand(5,10) )
	-- 		particle:SetRoll( math.Rand(-1,1) )
	-- 		particle:SetColor( rCol,rCol,rCol )
	-- 		particle:SetGravity( VectorRand() * 200 + Vector(0,0,200) )
	-- 		particle:SetCollide( false )
	-- 	end
	-- end
	
	emitter:Finish()
	
end

function EFFECT:Think()

	if CurTime() > self.DieTime then
		return false
	end

	return true

end

function EFFECT:Render()

	local fDelta = ( self.DieTime - CurTime() ) / self.TracerTime
	fDelta = math.Clamp( fDelta, 0, 1 ) ^ 1

	local sinWave = math.sin( fDelta * math.pi )
	
	local Pos1 = self.EndPos - self.Dir * ( fDelta - sinWave * self.Length )
	local Pos2 = self.EndPos - self.Dir2 * ( fDelta - sinWave * self.Length )
	
	render.SetMaterial( self.Mat )
	render.DrawBeam( Pos1,
		self.EndPos - self.Dir * ( fDelta + sinWave * self.Length ),
		15, 1, 0, Color(0,255,50,255) )
	render.DrawBeam( Pos2,
		self.EndPos - self.Dir2 * ( fDelta + sinWave * self.Length ),
		15, 1, 0, Color(0,255,50,255) )
	
		
	render.SetMaterial( self.Mat2 ) 
	render.DrawSprite( Pos1, 30, 30, Color(220,255,220,255) ) 
	render.DrawSprite( Pos2, 30, 30, Color(220,255,220,255) ) 
end