local Category = "PR"

local function StandAnimation( vehicle, player )
	return player:SelectWeightedSequence( ACT_HL2MP_IDLE ) 
end

local V = {
	Name = "LAAT Seat",
	Model = "models/nova/airboat_seat.mdl",
	Class = "prop_vehicle_prisoner_pod",
	Category = Category,

	Author = "Evan & Riddick",
	Information = "Stand Bitch",
	Offset = 100,

	KeyValues = {
		vehiclescript = "scripts/vehicles/prisoner_pod.txt",
		limitview = "0"
	},
	Members = {
		HandleAnimation = StandAnimation,
	}
}
list.Set( "Vehicles", "laatpassengerseat", V )
