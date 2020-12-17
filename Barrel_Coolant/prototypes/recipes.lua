data:extend(
{	
		{
              type = "item-subgroup",
              name = "angels-fluid-control-angels-barrels",
              group = "angels-fluid-control",
              order = "z-coolant-usedz"
		},
			  
		{
			type = "recipe",
			name = "fill-fluid-coolant-used-barrel",
			localised_name = "Fill used Coolant Barrel",
			enabled = false,
			subgroup = "angels-fluid-control-angels-barrels",
			category = "barreling-pump",
			energy_required = 0.2,
			icons = 
			{
				{icon = "__base__/graphics/icons/fluid/barreling/barrel-fill.png", icon_size = 64},
				{icon = "__base__/graphics/icons/fluid/barreling/barrel-fill-side-mask.png", icon_size = 64, tint = util.table.deepcopy{r = 68/255, g = 85/255, b = 112/255}},
				{icon = "__base__/graphics/icons/fluid/barreling/barrel-fill-top-mask.png", icon_size = 64, tint = util.table.deepcopy{r = 68/255, g = 85/255, b = 112/255}},
				{icon = "__angelssmelting__/graphics/icons/liquid-coolant-used.png", icon_size = 32, scale = 0.5, shift = {4, -8}},
			},
			icon_size = 32,
			order = "coolant-used-barrel-a",
			ingredients =
			{
				{type = "item", name = "empty-barrel", amount = 1},
				{type = "fluid", name = "liquid-coolant-used", amount = 250, minimum_temperature = 300},
			},
			results = 
			{
				{type = "item", name = "fluid-coolant-used-barrel", amount = 1},
			},
		},
		
		{
			type = "recipe",
			name = "empty-fluid-coolant-used-barrel",
			localised_name = "Empty used Coolant Barrel",
			enabled = false,
			subgroup = "angels-fluid-control-angels-barrels",
			category = "barreling-pump",
			energy_required = 0.2,
			icons = 
			{
				{icon = "__base__/graphics/icons/fluid/barreling/barrel-empty.png", icon_size = 64},
				{icon = "__base__/graphics/icons/fluid/barreling/barrel-empty-side-mask.png", icon_size = 64, tint = util.table.deepcopy{r = 68/255, g = 85/255, b = 112/255}},
				{icon = "__base__/graphics/icons/fluid/barreling/barrel-empty-top-mask.png", icon_size = 64, tint = util.table.deepcopy{r = 68/255, g = 85/255, b = 112/255}},
				{icon = "__angelssmelting__/graphics/icons/liquid-coolant-used.png", icon_size = 32, scale = 0.5, shift = {7, 8}},
			},
			icon_size = 32,
			order = "z-coolant-used-barrel-b",
			ingredients =
			{
				{type = "item", name = "fluid-coolant-used-barrel", amount = 1},
			},
			results = 
			{
				{type= "fluid", name="liquid-coolant-used", amount = 250, temperature = 300},
				{type = "item", name = "empty-barrel", amount = 1},
			},
		},
}
)
		table.insert( data.raw["technology"]["fluid-handling"].effects, { type = "unlock-recipe", recipe = "fill-fluid-coolant-used-barrel"	 } )
		table.insert( data.raw["technology"]["fluid-handling"].effects, { type = "unlock-recipe", recipe = "empty-fluid-coolant-used-barrel" } )