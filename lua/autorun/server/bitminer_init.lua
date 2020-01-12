
include("bitminer_config.lua")

local meta = FindMetaTable("Player")

util.AddNetworkString("AddBitNote")

function meta:CollectBitCoins(ent)

	local coins = ent:GetMinedCoins(0)

	ent:SetMinedCoins(0)

	if(coins > 0) then
		
		self:addMoney(bitconfig.bitvalue * coins)

		self:ChatPrint("You have collected "..coins.." Bit Coins ( $"..(bitconfig.bitvalue * coins).." )")

	end



end
 
hook.Add("playerBoughtCustomEntity" , "setMinerOnwer" , function(ply , entTab , ent , price)
 
	if ent:GetClass() == "bit_miner_light" or ent:GetClass() == "bit_miner_medium" or ent:GetClass() == "bit_miner_heavy" then
		 
		ent:SetOwnerName(ply:Nick())

	end

end)

hook.Add("EntityRemoved" , "RemoveSound" , function (ent)

	ent:StopSound( "bitminer_sound_heavy" )
	ent:StopSound( "bitminer_sound_medium" )
	ent:StopSound( "bitminer_sound_light" )


end)


--To add files for the client to download from you fastDL server :)

resource.AddFile( "materials/BITMINER/BitMinerHeavy_Mat.vmt" )
resource.AddFile( "materials/BITMINER/BitMinerHeavy_Mat.vtf" )
resource.AddFile( "materials/BITMINER/BitMinerMedium.vmt" )
resource.AddFile( "materials/BITMINER/BitMinerMedium.vtf" )
resource.AddFile( "materials/BITMINER/BitMiner_1_Mat.vmt" )
resource.AddFile( "materials/BITMINER/BitMiner_1_Mat.vtf" )
resource.AddFile( "models/BITMINER/BitMinerHeavy.mdl" )
resource.AddFile( "models/BITMINER/BitMinerLight.mdl" )
resource.AddFile( "models/BITMINER/BitMinerMedium.mdl" )
