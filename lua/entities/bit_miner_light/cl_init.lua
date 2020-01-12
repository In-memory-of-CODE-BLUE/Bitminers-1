include("shared.lua")


function ENT:Draw()

	local ply = LocalPlayer()

	self:DrawModel()

	if ply:GetPos():Distance(self:GetPos()) then
		
		self.CanDraw = true

	else

		self.CanDraw = false

	end

end




