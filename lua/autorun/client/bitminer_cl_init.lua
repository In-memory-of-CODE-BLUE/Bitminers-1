local alpha = 0
local prevValue = 0

surface.CreateFont( "BitMineFont_1", {
	font = "Arial",
	size = 16,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "BitMineFont_2", {
	font = "Arial",
	size = 23,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "BitMineFont_3", {
	font = "Arial",
	size = 23,
	weight = 500,
	blursize = 3,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

local notifications = {}
local coinAmount = 0


net.Receive("AddBitNote" , function()

	notifications[table.Count(notifications) + 1] = 3
	coinAmount = net.ReadInt(16)

end)

hook.Add("HUDPaint" , "PaintBitInfo" , function()

	data = LocalPlayer():GetEyeTrace()

	local pos = 0

	if IsValid(data.Entity) then

		if data.Entity:GetClass() == "bit_miner_light" or data.Entity:GetClass() == "bit_miner_medium" or data.Entity:GetClass() == "bit_miner_heavy" then
			if data.Entity.CanDraw and data.Entity:GetPos():Distance(LocalPlayer():GetPos()) < 255 then

				if alpha < 255 then

					alpha = alpha + 400 * FrameTime()

				else

					alpha = 255

				end
				
				local value = Lerp(4 * FrameTime() , prevValue , (data.Entity:GetMinedProgress(0) / 100) * 190)

				draw.RoundedBox(0,ScrW() /2 - 100, ScrH() /2 - 30,200,60 , Color(30,30,30,alpha))
				draw.RoundedBox(0,ScrW() /2 - 100, ScrH() /2 - 30,200,20, Color(60,60,60,alpha))

				draw.RoundedBox(0,ScrW() /2 - 95 , ScrH() /2   - 5, 190 , 30 , Color(140,140,140 , alpha))
				draw.RoundedBox(0,ScrW() /2 - 95 , ScrH() /2   - 5, value, 30 , Color(255,255,255 , alpha))

				surface.SetFont( "BitMineFont_1" )
				surface.SetTextColor( 255, 255, 255, 255 )
				local x = surface.GetTextSize(data.Entity:GetOwnerName() .. "'s BitMiner")/2
				surface.SetTextPos(ScrW() /2 - x , ScrH() /2 - 27)
				surface.DrawText(data.Entity:GetOwnerName() .."'s BitMiner")


				surface.SetFont( "BitMineFont_3" )
				surface.SetTextColor( 0,0,0, 255 )
				local x = surface.GetTextSize(data.Entity:GetMinedCoins(0).." Coins Mined")/2
				surface.SetTextPos(ScrW() /2 - x , ScrH() /2)
				surface.DrawText(data.Entity:GetMinedCoins(0).." Coins Mined")

				surface.SetFont( "BitMineFont_2" )
				surface.SetTextColor( 0,0,0, 255 )
				local x = surface.GetTextSize(data.Entity:GetMinedCoins(0).." Coins Mined")/2
				surface.SetTextPos(ScrW() /2 - x , ScrH() /2)
				surface.DrawText(data.Entity:GetMinedCoins(0).." Coins Mined")

				prevValue = value


			end

		else

			alpha = 0

		end

	end

end)

hook.Add("EntityRemoved" , "RemoveSound" , function (ent)

	ent:StopSound( "ambient/machines/machine3.wav" )


end)