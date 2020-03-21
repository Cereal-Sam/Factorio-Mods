if data.raw.technology["sct-automation-science-pack"] then
	tech4 = "sct-automation-science-pack"
else
	tech4 = "sb-startup4"
end
	
--Make water green!

data.raw.tile["water"].variants = data.raw.tile["water-green"].variants
data.raw.tile["deepwater"].variants = data.raw.tile["deepwater-green"].variants

data.raw.tile["water"].map_color = data.raw.tile["water-green"].map_color
data.raw.tile["deepwater"].map_color = data.raw.tile["deepwater-green"].map_color

data.raw.tile["water"].effect = data.raw.tile["water-green"].effect
data.raw.tile["deepwater"].effect = data.raw.tile["deepwater-green"].effect

data.raw.tile["water"].effect_color = data.raw.tile["water-green"].effect_color
data.raw.tile["deepwater"].effect_color = data.raw.tile["deepwater-green"].effect_color

data.raw.tile["water"].transitions = data.raw.tile["water-green"].transitions
data.raw.tile["deepwater"].transitions = data.raw.tile["deepwater-green"].transitions

--log(serpent.block(data.raw.tile["water"]))

-- No free Water!

data.raw.recipe["offshore-pump"].enabled = false


--Remove Angels Seafloor pump and add a prereq to washing-1

omni.lib.remove_unlock_recipe("water-washing-1", "seafloor-pump")
omni.lib.add_prerequisite("water-washing-1", "omnitech-viscous-mud-water-omnitraction-1")


--Edit startup tech

-- Startup 1
data.raw.tool["sb-angelsore3-tool"].icon = "__omnimatter__/graphics/icons/omnite.png"
data.raw.tool["sb-angelsore3-tool"].localised_name = {"item-name.omnite"}
data.raw.tool["sb-angelsore3-tool"].localised_description = "Get Omnite to complete this research."

data.raw.technology["sb-startup1"].icon = "__OmniSea__/graphics/technology/omnite-tech.png"
data.raw.technology["sb-startup1"].localised_name = "Getting Omnite"
data.raw.technology["sb-startup1"].localised_description = "You can use a Crystallizer to turn Omnic Waste into Omnite at a low yield."

--Startup 2&4

if mods["omnimatter_energy"] then

	data.raw.tool["sb-basic-circuit-board-tool"].icon = "__omnimatter_energy__/graphics/icons/omnitor.png"
	data.raw.tool["sb-basic-circuit-board-tool"].localised_name = {"item-name.omnitor"}
	data.raw.tool["sb-basic-circuit-board-tool"].localised_description = "Get an Omnitor to complete this research."

	data.raw.technology["sb-startup2"].icon = "__OmniSea__/graphics/technology/omnitor-tech.png"
	data.raw.technology["sb-startup2"].localised_name = "Omnitor"
	data.raw.technology["sb-startup2"].localised_description = "Omnitors are the source for basic automation."
	
	data.raw.tool["sb-lab-tool"].icon = "__omnimatter_energy__/graphics/icons/omnitor-lab.png"
	data.raw.tool["sb-lab-tool"].localised_name = {"entity-name.omnitor-lab"}
	data.raw.tool["sb-lab-tool"].localised_description = "Get an Omnitor Lab to complete this research."
	
	data.raw.technology[tech4].icon = "__OmniSea__/graphics/technology/omnitor-lab-tech.png"
	data.raw.technology[tech4].localised_name = "Laboratory"
	data.raw.technology[tech4].localised_description = "Omnitor Labs are the first step of your evolution."
 end
 
 
-- Remove Coal from the Omnimatter table to disable all Coal extractions 

	for _,tier in pairs(omnisource) do
		if tier["coal"] then tier["coal"]=nil 
		end
	end


--Add Slag Processing 2 as prereq. for Hypomnic Water Omnitraction

omni.lib.add_prerequisite("omnitech-hypomnic-water-omnitraction-1", "slag-processing-2")


--Stop Seablock from adding my omnic-water-condensation recipe to a tech

omni.lib.remove_unlock_recipe(tech4 , "omnic-water-condensation")
data.raw.recipe["omnic-water-condensation"].normal.enabled = true
data.raw.recipe["omnic-water-condensation"].expensive.enabled = true


--Omniwater/Omniwood compat:Avoid Research cycle

if data.raw.technology["omniwaste"] then
    data.raw.technology["omniwaste"].prerequisites = nil 
    data.raw.technology["omniwaste"].prerequisites = {tech4}  
end


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
	
	
	local wood = data.raw.item["wood"]
	wood.fuel_value = "6MJ"
	
	local owood = data.raw.item["omniwood"]
	owood.fuel_value = "1MJ"


	TechGen:importIf("omniwaste"):removeUnlocks("wasteMutation"):extend()

end


--Omnienergy: Add prereq to basic-logistics

if data.raw.technology["basic-logistics"] then
	TechGen:importIf("basic-logistics"):replacePrereq("sb-startup1", tech4):extend()
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
  ['basic-omnitraction'] = true,
  ['basic-automation'] = true,
  ['landfill'] = true
}

for _,tech in pairs(data.raw.technology) do
	if startuptechs[tech.name] and omni.lib.is_in_table("slag-processing-1",tech.prerequisites) then
		TechGen:import(tech.name):replacePrereq("slag-processing-1", tech4):extend()
	end
end


--Omnienergy: Remove the lab from Startup-3 unlocks, fix anbaric lab unlocks until zelos does, add unlock for boiler,

if mods["omnimatter_energy"] then
	TechGen:importIf("bio-wood-processing"):removeUnlocks("sct-lab-t1","sct-lab1-construction","sct-lab1-mechanization"):extend()
	TechGen:importIf("anbaric-lab"):addUnlocksExists("sct-lab1-construction","sct-lab1-mechanization"):extend()
	TechGen:importIf("bio-wood-processing"):removeUnlocks("lab"):extend()
	RecGen:import("burner-generator"):setEnabled(false):extend()
	TechGen:importIf(tech4):addUnlocks("burner-generator"):removeUnlocks("electric-mining-drill","boiler","steam-engine"):extend()	
end


-- Add Omnidrill recipes for all pipes

for _, pipes in pairs(data.raw.item) do

	if pipes.subgroup == "pipe" then
	
		if pipes.name == "stone-pipe" then tier = 1
		elseif pipes.name == "pipe" or pipes.name == "copper-pipe" 
			then tier = 2 techreq =	{"omnidrill-1"}		-- +40%
		elseif pipes.name == "steel-pipe" or pipes.name == "plastic-pipe" or pipes.name == "bronze-pipe" 
			then tier = 3 techreq =	{"omnidrill-2"}		-- +15%
		elseif pipes.name == "brass-pipe" or pipes.name == "ceramic-pipe" 
			then tier = 4 techreq =	{"omnidrill-3"}		-- +15%
		elseif pipes.name == "titanium-pipe" 
			then tier = 5 techreq =	{"drilling-equipment-brass-pipe","drilling-equipment-ceramic-pipe"}		-- +15%
		elseif pipes.name == "tungsten-pipe" or pipes.name == "nitinol-pipe" 
			then tier = 6 techreq =	{"drilling-equipment-titanium-pipe"} -- +15%
		elseif pipes.name == "copper-tungsten-pipe"
			then tier = 7 techreq =	{"drilling-equipment-tungsten-pipe","drilling-equipment-nitinol-pipe"} -- +15%
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
			drillrec:setTechName("omnidrill-1")
		else
			drillrec:setTechName("drilling-equipment-"..pipes.name):
			setTechPacks(2+math.floor(tier/2)):
			setTechCost(25+math.floor((tier/2)*25)):
			setTechTime(15):
			setTechIcon("OmniSea","tech-"..pipes.name)
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
	
	data:extend(
		{
		{
		type = "recipe",
		name = "omnisea-void-"..rec.name,
		category = "omnisea-chemical-void",
		enabled = "false",
		--hidden = void_hidden,
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
		},
		}
		)
		table.insert( data.raw["technology"]["omnidrill-1"].effects, { type = "unlock-recipe", recipe = "omnisea-void-"..rec.name	} )
	end
end
