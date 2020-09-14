--Omnitractor

	--Hypomnic Water + Research

local get_hypomnic_req=function(lvl)
    local req = {}
    req[#req+1]="omnitech-omnic-acid-hydrolyzation-"..lvl
    if (lvl-1)%omni.fluid_levels_per_tier == 0 then
        req[#req+1]="omnitech-omnitractor-electric-"..((lvl-1)/omni.fluid_levels_per_tier+1)
        if lvl > 1 and omni.fluid_dependency < omni.fluid_levels_per_tier then
            req[#req+1]="omnitech-omnisolvent-omnisludge-"..(lvl-1)
        end
    else
        req[#req+1]="omnitech-omnisolvent-omnisludge-"..(lvl-1)
    end
    if lvl > 1 then
        req[#req+1]="omnitech-hypomnic-water-omnitraction-"..(lvl-1)
    end
    return req
end


local cost = OmniGen:create():
    setYield("hypomnic-water"):
    setIngredients({type="fluid",name="omnic-water",amount=360*2}):
    setWaste("water"):
    linearPercentOutput(720,0.75,1)
local omnisludge = RecChain:create("OmniSea","hypomnic-water-omnitraction"):
	setName("hypomnic-water-omnitraction"):
	setIngredients(cost:ingredients()):
	setCategory("omnite-extraction-both"):
	setIcons("hypomnic-water"):
	setMain("hypomnic-water"):
	setResults(cost:results()):
	setSubgroup("omnisea-fluids"):
	setLevel(omni.fluid_levels):
	setEnergy(function(levels,grade) return 4 end):
	setEnabled(function(levels,grade) return grade == 0 end):
	setTechIcon("OmniSea","hypomnic-water-omnitraction-tech"):
	setTechCost(function(levels,grade) return 25+math.floor(grade/0.022) end ):
	setTechPacks(function(levels,grade) return 2+math.floor(grade/2.2) end ):
	setTechPrereq(function(levels,grade) return get_hypomnic_req(grade)  end):
	--setTechPacks(function(levels,grade) return math.floor((grade-2)/3)+1 end):
	--setTechPrereq("omnitractor-electric-2"):
	setTechTime(15):
	setTechName("omnitech-hypomnic-water-omnitraction"):
	extend()
	

--Viscous Mud Water + Research
	
local get_mud_req=function(lvl)
    local req = {}
    req[#req+1]="omnitech-omnic-acid-hydrolyzation-"..lvl
    if (lvl-1)%omni.fluid_levels_per_tier == 0 then
        req[#req+1]="omnitech-omnitractor-electric-"..((lvl-1)/omni.fluid_levels_per_tier+1)
        if lvl > 1 and omni.fluid_dependency < omni.fluid_levels_per_tier then
            req[#req+1]="omnitech-omnisolvent-omnisludge-"..(lvl-1)
        end
    else
        req[#req+1]="omnitech-omnisolvent-omnisludge-"..(lvl-1)
    end
    if lvl > 1 then
        req[#req+1]="omnitech-viscous-mud-water-omnitraction-"..(lvl-1)
    end
    return req
end

local cost = OmniGen:create():
    setYield("water-viscous-mud"):
    setIngredients({type="fluid",name="omnic-water",amount=360*2}):
    setWaste("water"):
    linearPercentOutput(720,0.5,1)
local omnisludge = RecChain:create("OmniSea","viscous-mud-water-omnitraction"):
	setName("viscous-mud-water-omnitraction"):
	setIngredients(cost:ingredients()):
	setCategory("omnite-extraction-both"):
	setIcons("water-viscous-mud","angelsrefining"):
	setMain("water-viscous-mud"):
	setResults(cost:results()):
	setSubgroup("omnisea-fluids"):
	setLevel(omni.fluid_levels):
	setEnergy(function(levels,grade) return 6 end):
	setEnabled(function(levels,grade) return grade == 0 end):
	setTechIcon("OmniSea","water-viscous-mud-tech"):
	setTechCost(function(levels,grade) return 25+math.floor(grade/0.09) end ):
	setTechPacks(function(levels,grade) return 1+math.floor(grade/2.2) end ):
	setTechPrereq(function(levels,grade) return get_mud_req(grade)  end):
	--setTechPacks(function(levels,grade) return math.floor((grade-2)/3)+1 end):
	--setTechPrereq("omnitractor-electric-2"):
	setTechTime(15):
	setTechName("viscous-mud-water-omnitraction"):
	extend()	
	
	-- Petromnic Waste Water
	
RecGen:create("OmniSea","petromnic-waste-water-recycling"):
	setIngredients({type="fluid",name="petromnic-waste-water",amount=200}):
	setIcons("omnic-waste"):
	setResults({type="fluid",name="omnic-waste",amount=20}, {type="fluid",name="water",amount=180}):
	setEnergy(3.0):
	setCategory("omnite-extraction-both"):
	setSubgroup("omnisea-fluids"):
	setTechName("omnitech-hypomnic-water-omnitraction-1"):
	marathon():
	extend()


--Omnidensator

RecGen:create("OmniSea","omnic-water-condensation"):
	setIngredients():
	setIcons("omnic-water"):
	setResults({type="fluid",name="omnic-water",amount=150}):
	setEnergy(4.0):
	setCategory("omnidensating"):
	setSubgroup("omnisea-fluid-generation"):
	setEnabled():
	marathon():
	extend()

	
--Omnidrill	
--[[	
RecGen:create("OmniSea","omnic-water-fracking"):
	setIngredients({type="fluid",name="steam",amount=40}, {type="item",name="stone-pipe",amount=2}):  -- todo
	setIcons("omnic-water"):
	setResults({type="fluid",name="omnic-water",amount=512}):
	setEnergy(2.0):
	setCategory("omnidrilling"):
	setSubgroup("omnisea-fluid-generation"):
	setTechName("omnidrill-1"):
	marathon():
	extend()
--]]
	
--Filtration Unit

RecGen:create("OmniSea","omnic-waste-filtering-1"):
	setIngredients({type="fluid",name="omnic-waste",amount=160}, {type="fluid",name="water-purified",amount=80}, {type="item", name="filter-coal", amount=1}):
	setIcons("slag-filtering-1"):
	setResults({type="fluid", name="maromnic-water", amount=60}, {type="fluid", name="water-yellow-waste", amount=40}, {type="item", name="filter-frame", amount=1}):
	setEnergy(4.0):
	setCategory("filtering"):
	setSubgroup("omnisea-filtration"):
	setTechName("slag-processing-1"):
	setOrder("a-a"):
	marathon():
	extend()
	
RecGen:create("OmniSea","omnic-waste-filtering-2"):
	setIngredients({type="fluid",name="omnic-waste",amount=160}, {type="fluid",name="water-purified",amount=60}, {type="item", name="filter-ceramic", amount=1}):
	setIcons("slag-filtering-2"):
	setResults({type="fluid", name=("maromnic-water"), amount=60}, {type="fluid", name="water-yellow-waste", amount=20}, {type="item", name="filter-ceramic-used", amount=1}):
	setEnergy(2.0):
	setCategory("filtering"):
	setSubgroup("omnisea-filtration"):
	setTechName("slag-processing-2"):
	setOrder("a-b"):
	marathon():
	extend()
	
RecGen:create("OmniSea","lithomnic-water-filtering-1"):
	setIngredients({type="fluid",name="lithomnic-water",amount=48}, {type="fluid",name="water-purified",amount=20}, {type="item", name="filter-coal", amount=1}):
	setIcons("slag-filtering-1"):
	setResults({type="fluid", name=("maromnic-water"), amount=40}, {type="fluid", name="water-yellow-waste", amount=10}, {type="item", name="filter-frame", amount=1}):
	setEnergy(2.0):
	setCategory("filtering"):
	setSubgroup("omnisea-filtration"):
	setTechName("omnitech-hypomnic-water-omnitraction-1"):
	setOrder("a-c"):
	marathon():
	extend()
	
RecGen:create("OmniSea","lithomnic-water-filtering-2"):
	setIngredients({type="fluid",name="lithomnic-water",amount=48}, {type="fluid",name="water-purified",amount=10}, {type="item", name="filter-ceramic", amount=1}):
	setIcons("slag-filtering-2"):
	setResults({type="fluid", name=("maromnic-water"), amount=40}, {type="item", name="filter-ceramic-used", amount=1}):
	setEnergy(1.0):
	setCategory("filtering"):
	setSubgroup("omnisea-filtration"):
	setTechName("omnitech-hypomnic-water-omnitraction-1"):
	setOrder("a-d"):
	marathon():
	extend()
	
	
--Crystallizer

RecGen:create("OmniSea","crystallizing-to-omnite-1"):
	setIngredients({type="fluid",name="omnic-waste",amount=120}):
	setIcons("omnite"):
	setResults({type="item",name="omnite",amount=3}, {type="item",name="stone-crushed",amount=5}):
	setEnergy(2.0):
	setCategory("crystallizing"):
	setSubgroup("omnisea-crystallizing"):
	setEnabled():
	marathon():
	extend()

RecGen:create("OmniSea","crystallizing-to-omnite-2"):
	setIngredients({type="fluid",name="maromnic-water",amount=40}):
	setIcons("omnite"):
	setResults({type="item",name="omnite",amount=4}):
	setEnergy(2.0):
	setCategory("crystallizing"):
	setSubgroup("omnisea-crystallizing"):
	setTechName("slag-processing-1"):
	marathon():
	extend()
	
	
--Omniplant

RecGen:create("OmniSea","lithomnic-water-enrichment"):
	setIngredients({type="fluid",name="hypomnic-water",amount=135}, {type="fluid",name="hydrosalinic-water",amount=50}):
	setIcons("lithomnic-water"):
	setResults({type="fluid",name="lithomnic-water",amount=54},{type="fluid",name="petromnic-waste-water",amount=134}):
	setEnergy(3.0):
	setCategory("omniplant"):
	setSubgroup("omnisea-fluids"):
	setTechName("omnitech-hypomnic-water-omnitraction-1"):
	marathon():
	extend()


RecGen:create("OmniSea","hydrosalinic-water-enrichment"):
	setIngredients({type="fluid",name="hydromnic-acid",amount=125}, {type="fluid",name="water-saline",amount=75}, {type="item",name="stone-crushed",amount=4}):
	setIcons("hydrosalinic-water"):
	setResults({type="fluid",name="hydrosalinic-water",amount=200}):
	setEnergy(3.0):
	setCategory("omniplant"):
	setSubgroup("omnisea-fluids"):
	setTechName("omnitech-hypomnic-water-omnitraction-1"):
	marathon():
	extend()