if not e_e then e_e = {} end

--Global tables
e_e.included_recipes = {}
e_e.tech_tiers = {}
e_e.check_science_pack = {}

--Triggers
e_e.lin_mode = true --settings.startup["e_e_linear"].value
e_e.lin_constant = settings.startup["e_e_linear_constant"].value
e_e.prog_mode = settings.startup["e_e_progression"].value
e_e.prog_constant = settings.startup["e_e_progression_constant"].value
-- e_e.exp_mode = settings.startup["e_e_exponential"].value
-- e_e.exp_constant = settings.startup["e_e_exponential_constant"].value
e_e.affect_science = settings.startup["e_e_affect_science"].value
e_e.exclude_exp_ings = settings.startup["e_e_exclude_expensive_ingredients"].value


require("prototypes/functions")