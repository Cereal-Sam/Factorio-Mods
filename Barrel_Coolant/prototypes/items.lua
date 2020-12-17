data:extend(    
    {
        {
            type = "item",
            name = "fluid-coolant-used-barrel",
            localised_name = "Used Coolant Barrel",
            icons = 
            {
				{icon = "__base__/graphics/icons/fluid/barreling/empty-barrel.png"},
				{icon = "__base__/graphics/icons/fluid/barreling/barrel-side-mask.png", tint = util.table.deepcopy{r = 68/255, g = 85/255, b = 112/255}},
				{icon = "__base__/graphics/icons/fluid/barreling/barrel-hoop-top-mask.png", tint = util.table.deepcopy{r = 68/255, g = 85/255, b = 112/255}},
            },
			icon_size = 64,
            flags = 
			{
			},
            subgroup = "angels-barrels",
            order = "u[fluid-coolant-used-barrel]",
            stack_size = 10,
        },
    }
)