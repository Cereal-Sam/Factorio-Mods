data:extend(
	{
		{
			type = "recipe",
			name = "mud-water-well-pump",
			enabled = false,
			energy_required = 20,
			ingredients =
			{
				{"steel-plate", 16},
				{"copper-plate", 32},
				{"iron-gear-wheel", 12},
				{"electronic-circuit", 8},
				{"pipe", 12},
			},
			result = "mud-water-well-pump"
		},
		
		{
			type = "recipe-category",
			name = "mud-water-well-production"
		},
		
		{
			type = "recipe",
			name = "mud-water-well-flow",
			enabled = true,
			hidden = true,
			energy_required = 1, 
			category = "mud-water-well-production",
			ingredients =
			{
			},
			results=
			{
				{type="fluid", name="water-viscous-mud", amount=2000},
			},
		},
	}
)

table.insert( data.raw["technology"]["steel-processing"].effects, { type = "unlock-recipe", recipe = "mud-water-well-pump"	} )