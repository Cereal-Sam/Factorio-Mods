--Omnidensator  tech here atm, needs to be moved to technology.lua

BuildGen:create("OmniSea","omnidensator-1"):
	setStacksize(10):
	setFluidBox("XXXXX.XXXXX.XXXXX.XXXXX.XXKXX"):
	setIngredients({"iron-plate",10},{"iron-stick",5},{"copper-pipe",5},{"stone-brick",5},{"basic-circuit-board",5}):
	setSpeed(1.0):
	setUsage(200):
	setCrafting("omnidensating"):
	setSubgroup("omnisea-omnidensating"):
	setModSlots(1):
	addIconLevel(1):
	setAnimation({
        filename = "__OmniSea__/graphics/entity/omnidensator.png",
        width = 160,
        height = 192,
        frame_count = 25,
	    line_length = 5,
        shift = {0, 0},
		scale = 1.35,
        animation_speed = 0.5
    }):
	setEnabled(true):
	extend()
	
BuildGen:create("OmniSea","omnidensator-2"):
	setStacksize(10):
	setFluidBox("XXXXX.XXXXX.XXXXX.XXXXX.XXKXX"):
	setIngredients({"omnidensator-1",1},{"omnicium-steel-gear-box",10},{"omnicium-plate",10}):
	setSpeed(1.5):
	setUsage(250):
	setCrafting("omnidensating"):
	setSubgroup("omnisea-omnidensating"):
	setModSlots(1):
	addIconLevel(2):
	setAnimation({
        filename = "__OmniSea__/graphics/entity/omnidensator.png",
        width = 160,
        height = 192,
        frame_count = 25,
	    line_length = 5,
        shift = {0, 0},
		scale = 1.35,
        animation_speed = 0.5
    }):
	setTechName("omnidensator-2"):
	setTechIcon("OmniSea","omnidensator-2-tech"):
	setTechPacks(2):
	setTechCost(150):
	setTechTime(15):
	setTechPrereq("omnitractor-electric-1"):
	setEnabled(false):
	extend()
	

--Omnidrill	
	
BuildGen:create("OmniSea","omnidrill-1"):
	setStacksize(10):
	setFluidBox("XXWXX.XXXXX.XXXXX.XXXXX.XXKXX"):
	setIngredients({"omnicium-steel-alloy",20},{"omnicium-brass-gear-box",10},{"steel-bearing",10},{"brass-pipe",25},{"electronic-circuit",10}):
	setSpeed(1.0):
	setUsage(150):
	setCrafting("omnidrilling"):
	setSubgroup("omnisea-omnidrilling"):
	addIconLevel(1):
	setAnimation({
        filename = "__OmniSea__/graphics/entity/omnidrill.png",
        width = 160,
        height = 160,
        frame_count = 25,
	    line_length = 5,
        shift = {0, 0},
		scale = 1.67,
        animation_speed = 0.5
    }):
	setTechName("omnidrill-1"):
	setTechIcon("OmniSea","omnidrill-1-tech"):
	setTechPacks(3):
	setTechCost(200):
	setTechTime(15):
	setTechPrereq({"omnidensator-2","omnitractor-electric-3"}):
	setEnabled(false):
	extend()
	
BuildGen:create("OmniSea","omnidrill-2"):
	setStacksize(10):
	setFluidBox("XXWXX.XXXXX.XXXXX.XXXXX.XXKXX"):
	setIngredients({"omnidrill-1",1},{"omnicium-aluminium-alloy",15},{"omnicium-titanium-gear-box",10},{"titanium-pipe",25},{"advanced-circuit",10},{"basic-crystallonic",5}):
	setSpeed(1.5):
	setUsage(200):
	setCrafting("omnidrilling"):
	setSubgroup("omnisea-omnidrilling"):
	addIconLevel(2):
	setAnimation({
        filename = "__OmniSea__/graphics/entity/omnidrill.png",
        width = 160,
        height = 160,
        frame_count = 25,
	    line_length = 5,
        shift = {0, 0},
		scale = 1.67,
        animation_speed = 0.5
    }):
	setTechName("omnidrill-2"):
	setTechIcon("OmniSea","omnidrill-2-tech"):
	setTechPacks(4):
	setTechCost(400):
	setTechTime(15):
	setTechPrereq({"omnidrill-1","omnitractor-electric-4"}):
	setEnabled(false):
	extend()
	
BuildGen:create("OmniSea","omnidrill-3"):
	setStacksize(10):
	setFluidBox("XXWXX.XXXXX.XXXXX.XXXXX.XXKXX"):
	setIngredients({"omnidrill-2",1},{"omnicium-tungsten-alloy",15},{"omnicium-tungsten-gear-box",10},{"basic-oscillo-crystallonic",25},{"tungsten-pipe",25},{"processing-unit",10}):
	setSpeed(2.0):
	setUsage(250):
	setCrafting("omnidrilling"):
	setSubgroup("omnisea-omnidrilling"):
	addIconLevel(3):
	setAnimation({
        filename = "__OmniSea__/graphics/entity/omnidrill.png",
        width = 160,
        height = 160,
        frame_count = 25,
	    line_length = 5,
        shift = {0, 0},
		scale = 1.67,
        animation_speed = 0.5
    }):
	setTechName("omnidrill-3"):
	setTechIcon("OmniSea","omnidrill-3-tech"):
	setTechPacks(5):
	setTechCost(300):
	setTechTime(15):
	setTechPrereq({"omnidrill-2","omnitractor-electric-5"}):
	setEnabled(false):
	extend()
	
	
--Omnicompressor

data:extend(
{
	{
	type = "item",
	name = "omnicompressor",
	icon = "__OmniSea__/graphics/icons/omnicompressor.png",
	icon_size = 32,
	flags = {},
	subgroup = "omnisea-omnicompressing",
	order = "a",
	place_result = "omnicompressor",
	stack_size = 10,
    },
	
    {
	type = "furnace",
	name = "omnicompressor",
	icon = "__OmniSea__/graphics/icons/omnicompressor.png",
	icon_size = 32,
	flags = {"placeable-neutral", "placeable-player", "player-creation"},
	minable = {mining_time = 1, result = "omnicompressor"},
    max_health = 300,
	corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    collision_box = {{-2.4, -2.4}, {2.4, 2.4}},
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
	crafting_categories = {"omnisea-chemical-void"},
	module_specification =
	{
		module_slots = 3
	},
    allowed_effects = {"consumption", "speed", "productivity", "pollution"},
	result_inventory_size = 0,
	source_inventory_size = 0,
	crafting_speed = 2,
	resistances =
	{
		{
		type = "fire",
		percent = 80
		},
		{
		type = "explosion",
		percent = 30
		}
	},
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions = 0.03
    },
    energy_usage = "100kW",
	animation =
    {
		filename = "__OmniSea__/graphics/entity/omnicompressor.png",
		priority = "extra-high",
		width = 224,
		height = 224,
		frame_count = 25,
		line_length = 5,
		shift = {0.0, 0.0},
		animation_speed = 0.5
    },
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    working_sound =
    {
      sound = { filename = "__angelsrefining__/sound/ore-leaching-plant.ogg" },
	  idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 },
      apparent_volume = 2.5,
    },
	fluid_boxes =
    {
      {
        production_type = "input",
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type="input", position = {0, -3} }}
      },
	  {
        production_type = "output",
        pipe_covers = pipecoverspictures(),
		base_area = 10,
        base_level = 1,
        pipe_connections = {{ type="output", position = {-0, 3} }}
      },
    },
	pipe_covers = pipecoverspictures(),
	},
	
  	{
	type = "recipe",
	name = "omnicompressor",
	enabled = false,
	energy_required = 20,
	ingredients =
	{
		{"steel-plate", 20},
		{"pump", 2},
		{"iron-gear-wheel", 12},
		{"electronic-circuit", 10},
		{"pipe", 20},
	},
	result = "omnicompressor"
	},
}
)
table.insert( data.raw["technology"]["omnidrill-1"].effects, { type = "unlock-recipe", recipe = "omnicompressor"	} )


