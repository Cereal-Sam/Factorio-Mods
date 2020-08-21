data:extend(
{
  -- {
  --   type = "bool-setting",
  --   name = "marathon_linear",
  --   setting_type = "startup",
  --   default_value = true,
	--   order = "a"
  -- },
  {
    type = "string-setting",
    name = "marathon_linear_constant",
    setting_type = "startup",
    default_value = "2",
	  order = "b"
  },
  {
    type = "bool-setting",
    name = "marathon_progression",
    setting_type = "startup",
    default_value = true,
	  order = "c"
  },
  {
    type = "string-setting",
    name = "marathon_progression_constant",
    setting_type = "startup",
    default_value = "0.5",
	  order = "d"
  },
  -- {
  --   type = "bool-setting",
  --   name = "marathon_exponential",
  --   setting_type = "startup",
  --   default_value = false,
	--   order = "e"
  -- },
  -- {
  --   type = "string-setting",
  --   name = "marathon_exponential_constant",
  --   setting_type = "startup",
  --   default_value = "1.5",
	--   order = "f"
  -- },
  {
    type = "bool-setting",
    name = "marathon_affect_science",
    setting_type = "startup",
    default_value = true,
	  order = "g"
  },
  {
    type = "bool-setting",
    name = "marathon_exclude_marathonised_ingredients",
    setting_type = "startup",
    default_value = true,
	  order = "h"
  },
}
)


