if not marathon then marathon = {} end

--Global tables
marathon.included_recipes = {}
marathon.tech_tiers = {}

--Triggers
marathon.lin_mode = true --settings.startup["marathon_linear"].value
marathon.lin_constant = settings.startup["marathon_linear_constant"].value
marathon.prog_mode = settings.startup["marathon_progression"].value
marathon.prog_constant = settings.startup["marathon_progression_constant"].value
-- marathon.exp_mode = settings.startup["marathon_exponential"].value
-- marathon.exp_constant = settings.startup["marathon_exponential_constant"].value
marathon.affect_science = settings.startup["marathon_affect_science"].value
marathon.exclude_marath_ings = settings.startup["marathon_exclude_marathonised_ingredients"].value


require("prototypes/functions")