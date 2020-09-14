--Move the Basic Extraction (and water-omnitraction)research behind the tutorial ones
omni.lib.add_prerequisite("base-impure-extraction", tech4)

--Disable Mineralized-Water crystallization
RecGen:import("sb-water-mineralized-crystallization"):setEnabled(false):extend()

--Final energy compat
if mods["omnimatter_energy"] then
	--Energy adds anabracity as prereq for everything without prereqs, remove that rom sb-startup-1 to avoid loops
	omni.lib.remove_prerequisite("sb-startup1", "omnitech-anbaricity")
	omni.lib.remove_prerequisite("sct-lab-t2", "electronics")
	
else
	-- Remove the fuel value of Omnite and crushed Omnite without omni energy
	local remfuel = {
		"omnite",
		"crushed-omnite",
	}

	for _,entity in pairs(remfuel) do
		data.raw.item[entity].fuel_category = nil
		data.raw.item[entity].fuel_value = nil
	end
	
end