AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include("shared.lua")
include("bitminer_config.lua")

local explodePos

local interval = 0.25 --Seconds before adding the value

function ENT:Think()

	if self.timer < CurTime() then
		
		self.timer = CurTime() + interval

		self:SetMinedProgress(self:GetMinedProgress(0) +  bitconfig.mediumProccessSpeed)

	end

	if self:GetMinedProgress(0) > 100 then

			self:SetMinedProgress(0)
			self:SetMinedCoins(self:GetMinedCoins(0) + 1)



	end 

	if self:WaterLevel() > 0 then

		self:Remove()

		local explode = ents.Create( "env_explosion" )
		explode:SetPos( self:GetPos())
		explode:Spawn() 
		explode:SetKeyValue( "iMagnitude", tostring(bitconfig.exploisionSize)  )
		explode:Fire( "Explode", 1, 0 )
		explode:EmitSound( "weapon_AWP.Single", 400, 400 ) 



	end

end
 
function ENT:OnTakeDamage(damage )
	
	self.health = self.health - damage:GetDamage()

	if self.health <= 0 then
		
		self:Remove()
		explodePos = self:GetPos()

		timer.Simple(0.1 , function()

			local explode = ents.Create( "env_explosion" )
			explode:SetPos( explodePos)
			explode:Spawn() 
			explode:SetKeyValue( "iMagnitude", tostring(bitconfig.exploisionSize) )
			explode:Fire( "Explode", 1, 0 )
			explode:EmitSound( "weapon_AWP.Single", 400, 400 ) 

			end)

	end

end

function ENT:Use(act , caller)

	caller:CollectBitCoins(self)

end