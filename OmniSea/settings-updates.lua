data:extend({

-- Force vanilla-biter-generation settings for RSO since Seablock is messing with them

   {
      type = "bool-setting",
      name = "rso-vanilla-biter-generation",
      setting_type = "startup",
      default_value = true,
   },
   {
      type = "bool-setting",
      name = "rso-biter-generation",
      setting_type = "runtime-global",
      default_value = false,
      order = "ca",
   },
})