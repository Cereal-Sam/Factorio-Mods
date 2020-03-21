--Move the Basic Extraction (and water-omnitraction)research behind the tutorial ones

	omni.lib.add_prerequisite("base-impure-extraction", tech4)
	omni.lib.add_prerequisite("omnitech-water-omnitraction-1", tech4)

  
--Add some prereq´s for Water-Omnitraction to avoid ppl. getting stuck in progression

omni.lib.add_prerequisite("omnitech-water-omnitraction-2", "omnitech-hypomnic-water-omnitraction-1")
omni.lib.add_prerequisite("omnitech-water-omnitraction-3", "omnitech-hypomnic-water-omnitraction-2")
omni.lib.add_prerequisite("omnitech-water-omnitraction-4", "omnitech-hypomnic-water-omnitraction-3")


--Disable Mineralized-Water crystallization

RecGen:import("sb-water-mineralized-crystallization"):setEnabled(false):extend()


-- Remove the fuel value of Omnite and crushed Omnite

local remfuel = {
	"omnite",
	"crushed-omnite",
	}

for _,entity in pairs(remfuel) do
	data.raw.item[entity].fuel_category = nil
	data.raw.item[entity].fuel_value = nil
end


--Reset fuel category  of burner stuff back to normal if omnienergy is present
  
if mods["omnimatter_energy"] then 
	local burnerEntities = {
		"burner-mining-drill",
		"burner-research_facility",
		"burner-omnicosm",
		"burner-omniphlog",
		"burner-omni-furnace",
		"burner-ore-crusher",
		"mixing-steel-furnace",
		"mixing-furnace",
		"chemical-steel-furnace",
		"chemical-boiler",
		"steel-furnace",
		"stone-furnace",
		"burner-assembling-machine",
		"omnitor-assembling-machine",
		"burner-omnitractor",
		"omnitor-lab",
	}

	for _,entity in pairs(burnerEntities) do
		BuildGen:importIf(entity):setFuelCategory("chemical"):extend()
	end
end	
--log(serpent.block(data.raw.technology))