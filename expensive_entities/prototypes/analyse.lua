--Proto type list, can be split for further setting options
local ent_all = {
	"accumulator",
	"arithmetic-combinator",
	"ammo-turret",
	"artillery-turret",
	"artillery-wagon",
	"assembling-machine",
	"beacon",
	"boiler",
	"car",
	"cargo-wagon",
	"combat-robot",
	"constant-combinator",
	"construction-robot",
	"container",
	"curved-rail",
	"decider-combinator",
	"electric-pole",
	"electric-turret",
	"fluid-turret",
	"fluid-wagon",
	"furnace",
	"gate",
	"generator",
	"heat-pipe",
	"inserter",
	"lab",
	"land-mine",
	"lamp",
	"loader",
	"loader-1x1",
	"locomotive",
	"logistic-container",
	"logistic-robot",
	"mining-drill",
	"offshore-pump",
	"pipe",
	"pipe-to-ground",
	"power-switch",
	"programmable-speaker",
	"pump",
	"radar",
	"rail-signal",
	"rail-chain-signal",
	"reactor",
	"roboport",
	"rocket-silo",
	"solar-panel",
	"splitter",
	"storage-tank",
	"straight-rail",
	"train-stop",
	"transport-belt",
	"turret",
	"underground-belt",
	"wall"
}

--Analyse all recipes and add them to the e_e table
for _, rec in pairs(data.raw.recipe) do

	local ing = e_e.get_ings(rec)
	local res = e_e.get_res(rec)


	--Exclude creative mode recipes or recipes with 0 ingredients
	if string.find(rec.name,"creative") or #ing == 0 then
		log("Recipe "..rec.name.." excluded")
        goto cont
    end

	for _, result in pairs(res) do
		--Add recipes that have a placable entity as result
		if e_e.find_prototype(result.name, ent_all) then
			e_e.include_recipe(rec.name)
			--log("Include recipe: "..rec.name)
			goto cont
		end
	end

	--If the affect_science setting is true, add recipes that are in the science pack subgroup (have a science pack as result)
	if e_e.affect_science and rec.subgroup == "science-pack" then
		e_e.include_recipe(rec.name)
		--log("Include recipe: "..rec.name)
		goto cont
	end

	::cont::
end

--If progression mode is active, get tech progression tiers and add them to recipes
if e_e.prog_mode then
	--Add all techs to a table to work through
	local remaining_techs = {}
	for _,tech in pairs(data.raw.technology) do
		if not tech.hidden then
			remaining_techs[tech.name] = {name = tech.name, remove = false}
		end
	end

	--Repeat looping through remaining_techs until empty and assign tiers
	local index = 1 -- start with 2 since default enabled recipes are tier 1
	while next(remaining_techs) do
		index = index +1
		--log("Looping through the internal tech list for the "..index.." time")

		if index > 100 then
			log("WARNING: Max amount of tech list loops exceeded!")
			break 
		end

		--Mark all techs that have no prereq or only prereqs that are not in the remaining list
		for _,techname in pairs(remaining_techs) do
			local tech = data.raw.technology[techname.name]


			--Check if tech has no prereqs (-->tier 1)
			if not tech.prerequisites or tech.prerequisites == {} then
				techname.remove = true
			--If no prereq is in the remaining tech table, assign tier, else continue
			elseif tech.prerequisites then
				for _,prereq in pairs(tech.prerequisites) do
					if remaining_techs[prereq] then
						--log("Tech "..tech.name.." still has reqs,jumping")
						goto continue
					end
				end
				techname.remove = true
			end
			::continue::
		end

		--Remove marked techs from the list and add the current index as tier for unlocked recipes
		for _,techname in pairs(remaining_techs) do
			local tech = data.raw.technology[techname.name]
			if techname.remove == true and tech.effects then
				for _,effect in pairs(tech.effects) do
					if effect.type == "unlock-recipe" and e_e.included_recipes[effect.recipe] then
						e_e.included_recipes[effect.recipe].progression_tier = index
						e_e.tech_tiers[tech.name] = index
						--log("Adding tech "..tech.name.." with a tier of "..index)
					end
				end
				remaining_techs[tech.name] = nil
			elseif techname.remove == true then
				remaining_techs[tech.name] = nil
			end
		end
	end
end