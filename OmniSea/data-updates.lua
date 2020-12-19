if data.raw.technology["sct-automation-science-pack"] then
	tech4 = "sct-automation-science-pack"
else
	tech4 = "sb-startup4"
end

-- No free Water!
data.raw.recipe["offshore-pump"].enabled = false

--Remove Angels Seafloor pump and add a prereq to washing-1
omni.lib.remove_unlock_recipe("water-washing-1", "seafloor-pump")

--Set initial omnitraction recipes (saph+stir) to be craftable in an electric omnitractor aswell
data.raw.recipe["initial-omnitraction-angels-ore1"].category = "omnite-extraction-both"
data.raw.recipe["initial-omnitraction-angels-ore3"].category = "omnite-extraction-both"

--Edit startup tech
-- Startup 1
data.raw.tool["sb-angelsore3-tool"].icon = "__omnimatter__/graphics/icons/omnite.png"
data.raw.tool["sb-angelsore3-tool"].localised_name = {"item-name.omnite"}
data.raw.tool["sb-angelsore3-tool"].localised_description = "Get Omnite to complete this research."
data.raw.technology["sb-startup1"].icon = "__OmniSea__/graphics/technology/omnite-tech.png"
data.raw.technology["sb-startup1"].localised_name = "Getting Omnite"
data.raw.technology["sb-startup1"].localised_description = "Use an omnidensator to condensate omnic water out of the air. You can condense omnic waste out of omnic water which you you can into omnite at a low yield."

--Startup 2&4
if mods["omnimatter_energy"] then
	data.raw.tool["sb-basic-circuit-board-tool"].icon = nil
	data.raw.tool["sb-basic-circuit-board-tool"].icon_size = nil
	data.raw.tool["sb-basic-circuit-board-tool"].icons = data.raw.item["omnitor"].icons
	data.raw.tool["sb-basic-circuit-board-tool"].localised_name = {"item-name.omnitor"}
	data.raw.tool["sb-basic-circuit-board-tool"].localised_description = "Get an Omnitor to complete this research."

	data.raw.technology["sb-startup2"].icon = nil
	data.raw.technology["sb-startup2"].icon_size = nil
	data.raw.technology["sb-startup2"].icons = data.raw.item["omnitor"].icons
	data.raw.technology["sb-startup2"].localised_name = "Omnitor"
	data.raw.technology["sb-startup2"].localised_description = "Omnitors are the source for basic automation."
	
	data.raw.tool["sb-lab-tool"].icon = "__omnimatter_energy__/graphics/icons/omnitor-lab.png"
	data.raw.tool["sb-lab-tool"].icon_size = 32
	data.raw.tool["sb-lab-tool"].localised_name = {"entity-name.omnitor-lab"}
	data.raw.tool["sb-lab-tool"].localised_description = "Get an Omnitor Lab to complete this research."
	
	data.raw.technology[tech4].icon = "__OmniSea__/graphics/technology/omnitor-lab-tech.png"
	data.raw.technology[tech4].localised_name = "Laboratory"
	data.raw.technology[tech4].localised_description = "Omnitor Labs are the first step of your evolution."
end

--Add Slag Processing 2 as prereq. for Hypomnic Water Omnitraction
omni.lib.add_prerequisite("omnitech-hypomnic-water-omnitraction-1", "slag-processing-2")

--Stop Seablock from adding my omnic-water-condensation recipe to a tech
omni.lib.remove_unlock_recipe(tech4 , "omnic-water-condensation")
omni.lib.remove_unlock_recipe(tech4 , "omnidensator-1")
omni.lib.enable_recipe("omnidensator-1")
omni.lib.enable_recipe("omnic-water-condensation")

-- --Omniwater/Omniwood compat:Avoid Research cycle
-- if data.raw.technology["omniwaste"] then
--     data.raw.technology["omniwaste"].prerequisites = nil 
--     data.raw.technology["omniwaste"].prerequisites = {tech4}  
-- end

--Omniwood compat: Add an early low-yield omnialgae recipe and fix the fuel value of wood
if mods["omnimatter_wood"] then 
	RecGen:create("OmniSea","omnialgae-processing-0"):
	setIngredients({type="fluid",name="water-purified",amount=100}, {type="item",name="omnite",amount=40}):
	setIcons("omnialgae","omnimatter_wood"):
	setResults({type="item",name="omnialgae",amount=40}):
	setEnergy(20.0):
	setCategory("bio-processing"):
	setSubgroup("omnisea-fluids"):
	setEnabled(true):
	extend()
	
	data.raw.item["wood"].fuel_value = "6MJ"
	data.raw.item["omniwood"].fuel_value = "1MJ"

	--TechGen:importIf("omniwaste"):removeUnlocks("wasteMutation"):extend()
end

local startuptechs = {
  ['automation'] = true,
  ['logistics'] = true,
  ['optics'] = true,
  ['turrets'] = true,
  ['stone-walls'] = true,
  ['basic-chemistry'] = true,
  ['ore-crushing'] = true,
  ['steel-processing'] = true,
  ['military'] = true,
  ['angels-sulfur-processing-1'] = true,
  ['water-treatment'] = true,
  ['water-washing-1'] = true,
  ['slag-processing-1'] = true,
  ['angels-fluid-control'] = true,
  ['angels-metallurgy-1'] = true,
  ['angels-iron-smelting-1'] = true,
  ['angels-copper-smelting-1'] = true,
  ['angels-coal-processing'] = true,
  ['bio-wood-processing-2'] = true,
  ['omnitech-basic-omnitraction'] = true,
  ['basic-automation'] = true,
  ['omnitech-simple-automation'] = true,
  ['landfill'] = true
}

for _,tech in pairs(data.raw.technology) do
	if startuptechs[tech.name] and omni.lib.is_in_table("slag-processing-1",tech.prerequisites) then
		omni.lib.replace_prerequisite(tech.name,"slag-processing-1", tech4)
	end
end

--Omnienergy: Remove the lab from Startup-3 unlocks, fix anbaric lab unlocks until zelos does, add unlock for boiler,
if mods["omnimatter_energy"]  and false then
	omni.lib.remove_unlock_recipe("bio-wood-processing", "sct-lab-t1")
	omni.lib.remove_unlock_recipe("bio-wood-processing", "sct-lab1-construction")
	omni.lib.remove_unlock_recipe("bio-wood-processing", "sct-lab1-mechanization")
	omni.lib.remove_unlock_recipe("bio-wood-processing", "lab")

	omni.lib.add_unlock_recipe("anbaric-lab", "sct-lab1-construction")
	omni.lib.add_unlock_recipe("anbaric-lab", "sct-lab1-mechanization")

	omni.lib.disable_recipe("burner-generator")
	omni.lib.remove_unlock_recipe(tech4, "electric-mining-drill")
	omni.lib.remove_unlock_recipe(tech4, "boiler")
	omni.lib.remove_unlock_recipe(tech4, "steam-engine")

	--Omnienergy: Add prereq to basic-logistics
	if data.raw.technology["basic-logistics"] then
		omni.lib.replace_prerequisite("basic-logistics","sb-startup1", tech4)
	end
end

-- Add Omnidrill recipes for all pipes
for _, pipes in pairs(data.raw.item) do
	if pipes.subgroup == "pipe" then
		if pipes.name == "stone-pipe" then tier = 1
		elseif pipes.name == "pipe" or pipes.name == "copper-pipe" 
			then tier = 2 techreq =	{"omnitech-omnidrill-1"}		-- +40%
		elseif pipes.name == "steel-pipe" or pipes.name == "plastic-pipe" or pipes.name == "bronze-pipe" 
			then tier = 3 techreq =	{"omnitech-omnidrill-2"}		-- +15%
		elseif pipes.name == "brass-pipe" or pipes.name == "ceramic-pipe" 
			then tier = 4 techreq =	{"omnitech-omnidrill-3"}		-- +15%
		elseif pipes.name == "titanium-pipe" 
			then tier = 5 techreq =	{"omnitech-drilling-equipment-brass-pipe","omnitech-drilling-equipment-ceramic-pipe"}		-- +15%
		elseif pipes.name == "tungsten-pipe" or pipes.name == "nitinol-pipe" 
			then tier = 6 techreq =	{"omnitech-drilling-equipment-titanium-pipe"} -- +15%
		elseif pipes.name == "copper-tungsten-pipe"
			then tier = 7 techreq =	{"omnitech-drilling-equipment-tungsten-pipe","omnitech-drilling-equipment-nitinol-pipe"} -- +15%
		else tier = 1
		end
		
		baseout = 512		
		if tier == 1 then 
			bonus = 0
		else 
			bonus = math.floor((baseout*0.4) + ((tier-2)*(baseout*0.15)) )
		end
		
	local drillrec = RecGen:create("OmniSea","omnic-water-fracking-".. pipes.name):
		setIngredients({type="fluid",name="coromnic-vapour",amount=100}, {type="item",name= pipes.name,amount=1}):
		setIcons("omnic-water"):
		addSmallIcon(pipes.icon, 3):
		setResults({type="fluid",name="omnic-water",amount=(baseout + bonus)}):
		setEnergy(4.0):
		setCategory("omnidrilling"):
		setSubgroup("omnisea-fluid-generation"):
		setOrder(tier.."-"..pipes.order):
		marathon()
		if tier == 1 then
			drillrec:setTechName("omnitech-omnidrill-1")
		else
			drillrec:setTechName("omnitech-drilling-equipment-"..pipes.name):
			setTechPacks(2+math.floor(tier/2)):
			setTechCost(25+math.floor((tier/2)*25)):
			setTechTime(15):
			setTechIcons("tech-"..pipes.name,"OmniSea")
		end
		drillrec:setTechPrereq(techreq)
		drillrec:extend()
	end
end
--[[
		baseout = 512		
		if tier == 1 then 
			bonus = 0
			techname = "omnidrill-1"
			techpacks = nil
			techcost = nil
			techtime = nil
			techicon = nil
		else 
			bonus = math.floor((baseout*0.4) + ((tier-2)*(baseout*0.15)))
			techname = "drilling-equipment-"..tier
			techpacks = 2+math.floor(tier/2)
			techcost = (25+math.floor((tier/2)*25
			techtime = 15
			techicon = "Omnimatter","omnic-water"
		end
--]]
----log(serpent.block(data.raw.recipe))

-- Add Omnicompressor Recipes
for i, rec in pairs(data.raw.recipe) do		
	if rec.category == "angels-chemical-void" and string.find(rec.name,"gas") then
	data:extend({
	{
		type = "recipe",
		name = "omnisea-void-"..rec.name,
		category = "omnisea-chemical-void",
		enabled = "false",
		energy_required = 1,
		ingredients = rec.ingredients, --100
		results=
		{
			{type="fluid", name= "coromnic-vapour", amount=50},
		},
		subgroup = "omnisea-void",
		icon = rec.icon,
		icon_size = 32,
		order = "omnisea-void-"..rec.name
	}
	})
	omni.lib.add_prerequisite("omnitech-omnidrill-1", "omnisea-void-"..rec.name)
	end
end
