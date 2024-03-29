--Proto type list, can be split for further setting options
local ent_all = {
    "accumulator",
    "arithmetic-combinator",
    "ammo-turret",
    "artillery-turret",
    "artillery-wagon",
    "assembling-machine",
    "beacon",
    "boiler",
    "car",
    "cargo-wagon",
    "combat-robot",
    "constant-combinator",
    "construction-robot",
    "container",
    "curved-rail",
    "decider-combinator",
    "electric-pole",
    "electric-turret",
    "fluid-turret",
    "fluid-wagon",
    "furnace",
    "gate",
    "generator",
    "heat-pipe",
    "inserter",
    "lab",
    "land-mine",
    "lamp",
    "loader",
    "loader-1x1",
    "locomotive",
    "logistic-container",
    "logistic-robot",
    "mining-drill",
    "offshore-pump",
    "pipe",
    "pipe-to-ground",
    "power-switch",
    "programmable-speaker",
    "pump",
    "radar",
    "rail-signal",
    "rail-chain-signal",
    "reactor",
    "roboport",
    "rocket-silo",
    "solar-panel",
    "splitter",
    "storage-tank",
    "straight-rail",
    "train-stop",
    "transport-belt",
    "turret",
    "underground-belt",
    "wall"
}

--Analyse functions
function e_e.find_prototype(name)
    if type(name)=="table" then return name elseif type(name)~="string" then return nil end
    for _, p in pairs(ent_all) do
        if data.raw[p][name] then return data.raw[p][name] end
    end
    return nil
end

function e_e.include_recipe(rec_name)
    if rec_name then
        e_e.included_recipes[rec_name] =
        {
        name = rec_name,
        linear = false,
        exponential = false,
        progression = false,
        progression_tier = 1 --Default to 1, if unlocked by tech this gets overwritten
        }
    end
end

--Misc functions
function e_e.remove_from_table(tab, element)
    if tab and element then
        local found = false
        for i, x in pairs(tab) do
            if x == element then
                found = true
                table.remove(tab,i)
                break
            end
        end
        if not found then log("Could not remove "..element.." from table") end
    end
end

function e_e.is_in_table(tab, element)
    if tab and element then
        local found = false
        for _, x in pairs(tab) do
            if x == element then 
                    found = true
                break
            end
        end
        return found
    end
end

--Tech functions
function e_e.get_all_techs(recipename)
    local technames = {}
    for _,tech in pairs(data.raw.technology) do
        if tech.effects then
            for _,eff in pairs(tech.effects) do
                if eff.type == "unlock-recipe" and eff.recipe ==recipename then
                    technames[#technames+1] = tech.name
                end
            end
        end
    end
    return technames
end

--Recipe functions

--Returns a standardised copy of all ingredients, prefers recipe.expensive
function e_e.get_ings(recipe)
    local ing = {}

    if recipe.ingredients then
        for _, ingredient in pairs(recipe.ingredients) do
            if ingredient.name then
                ing[#ing+1] = {type = ingredient.type or "item", name = ingredient.name, amount = ingredient.amount or 1}
            else
                ing[#ing+1] = {type = "item", name = ingredient[1], amount = ingredient[2] or 1}
            end
        end
    elseif recipe.expensive and recipe.expensive.ingredients then
        for _, ingred in pairs(recipe.expensive.ingredients) do
            if ingred.name and ingred.amount then
                ing[#ing+1] = ingred
            else
                
                ing[#ing+1] = {type = "item", name = ingred[1], amount = ingred[2] or 1}
            end
        end
    elseif recipe.normal and recipe.normal.ingredients then
        for _, ingredient in pairs(recipe.normal.ingredients) do
            if ingredient.name then
                ing[#ing+1] = {type = ingredient.type or "item", name = ingredient.name, amount = ingredient.amount or 1}
            else
                ing[#ing+1] = {type = "item", name = ingredient[1], amount = ingredient[2] or 1}
            end
        end
    end

    return table.deepcopy(ing)
end

--Returns a standardised copy of all results, prefers recipe.expensive
function e_e.get_res(recipe)
    local res = {}
    if recipe.result then
        res[#res+1] = {type = "item", name = recipe.result, amount = recipe.result_count or 1}
    elseif recipe.expensive and recipe.expensive.result then
        res[#res+1] = {type = "item", name = recipe.expensive.result, amount = recipe.expensive.result_count or 1}
    elseif recipe.normal and recipe.normal.result then
        res[#res+1] = {type = "item", name = recipe.normal.result, amount = recipe.normal.result_count or 1}
    elseif recipe.results then
        for _, result in pairs(recipe.results) do
            if result.name then
                res[#res+1] = {type = result.type or "item", name = result.name, amount = result.amount or 1}
            else
                res[#res+1] = {type = "item", name = result[1], amount = result[2] or 1}
            end
        end
    elseif recipe.expensive and recipe.expensive.results then
        for _, result in pairs(recipe.expensive.results) do
            if result.name then
                res[#res+1] = {type = result.type or "item", name = result.name, amount = result.amount or 1}
            else
                res[#res+1] = {type = "item", name = result[1], amount = result[2] or 1}
            end
        end
    elseif recipe.normal and recipe.normal.results then
        for _, result in pairs(recipe.normal.results) do
            if result.name then
                res[#res+1] = {type = result.type or "item", name = result.name, amount = result.amount or 1}
            else
                res[#res+1] = {type = "item", name = result[1], amount = result[2] or 1}
            end
        end
    end

    return table.deepcopy(res)
end

function e_e.standardise(recipe)
    if recipe then
        -- log("Start stand")
        -- log(serpent.block(recipe))
        if not recipe.expensive then recipe.expensive = {} end
        if not recipe.normal then recipe.normal = {} end

        --Ingredients
        local ings = e_e.get_ings(recipe)
        --Always overwrite ingredients to ensure that all have tags
        recipe.normal.ingredients = table.deepcopy(ings)
        recipe.expensive.ingredients = table.deepcopy(ings)
        recipe.ingredients = nil

        --Results (only move into .normal and .expensive to not break icons/main-products)
        if recipe.result then
            recipe.normal.result = recipe.result
            recipe.normal.result_count = recipe.result_count
            recipe.expensive.result = recipe.result
            recipe.expensive.result_count = recipe.result_count
            recipe.result = nil
            recipe.result_count = nil

        elseif recipe.results then
            local res = e_e.get_res(recipe)
            recipe.normal.results = table.deepcopy(res)
            recipe.expensive.results = table.deepcopy(res)
            recipe.results = nil
        end
        --Move recipe.main_product
        recipe.normal.main_product = recipe.main_product
        recipe.expensive.main_product = recipe.main_product
        recipe.main_product = nil

        --copy .enabled into normal/expensive
        if recipe.enabled ~= nil then
            recipe.normal.enabled = recipe.enabled
            recipe.expensive.enabled = recipe.enabled
        end

        --catch recipes that only have .normal filled
        if recipe.expensive.enabled == nil and recipe.normal.enabled ~= nil then
            recipe.expensive.enabled = recipe.normal.enabled
        end
    end
end

--Get all recipe ingredients that can be placed down / are entities
function e_e.get_entity_ingredients(recipe)
    local ings = e_e.get_ings(recipe)
    local ents = {}
    for _, ing in pairs(ings) do
        if ing.name and e_e.find_prototype(ing.name) then
            ents[#ents+1] = ing.name
        end
    end
    return ents
end

--Create a copy of the ingredient item and recipe
function e_e.create_ingredient_copy(ingredient_name, pack)
    local ing = data.raw.item[ingredient_name]
    local recipe = data.raw.recipe[ingredient_name]
    e_e.standardise(recipe)
    if ing then
        local new_ing = table.deepcopy(ing)
        new_ing.name = "ee-sp-"..new_ing.name
        new_ing.localised_name = omni.lib.locale.of(ing).name --new_ing.localised_name or {"item-name."..ing.name}
        new_ing.place_result = nil
        new_ing.subgroup = "science-pack-ingredients"
        new_ing.order = "aa["..pack.."]"

        local ic = omni.lib.icon.of(ing, true)
        local small = omni.lib.icon.of(data.raw.recipe[pack], true)
        local ic_sz = small[1].icon_size
        ic[#ic+1] = {icon = small[1].icon, icon_size = ic_sz, scale = 0.4375*(small[1].scale or (32/ic_sz)), shift = {10, 10}}
        new_ing.icons = ic
        new_ing.icon = nil


        local new_rec = table.deepcopy(recipe)
        new_rec.name = "ee-sp-"..new_rec.name
        new_rec.localised_name = omni.lib.locale.of(recipe).name  --new_ing.localised_name
        new_rec.enabled = recipe.enabled
        new_rec.normal.enabled = recipe.normal.enabled
        new_rec.expensive.enabled = recipe.expensive.enabled
        new_rec.subgroup = "science-pack-ingredients"
        new_rec.order = "aa["..pack.."]"

        ic = omni.lib.icon.of(recipe, true)
        ic_sz = small[1].icon_size
        ic[#ic+1] = {icon = small[1].icon, icon_size = ic_sz, scale = 0.4375*(small[1].scale or (32/ic_sz)), shift = {10, 10}}
        new_rec.icons = ic
        new_rec.icon = nil

        data:extend({new_ing,new_rec})

        omni.lib.replace_recipe_result(new_rec.name, ingredient_name, "ee-sp-"..ingredient_name)
        local tech = omni.lib.get_tech_name(pack)
        if tech then omni.lib.add_unlock_recipe(tech, new_rec.name) end
    end
end

--e_e applying functions
function e_e.apply_linear(recipe, mult)
    if recipe then
        for _, ing in pairs(recipe.expensive.ingredients) do
            if not (e_e.exclude_exp_ings and e_e.included_recipes[ing.name]) then
                ing.amount = ing.amount * mult
                ing.amount = math.floor(math.min(ing.amount, 64444))
            end
        end
        e_e.included_recipes[recipe.name].linear = true
    end
end

function e_e.apply_progression(recipe, constant)
    if recipe then
        local tier = e_e.included_recipes[recipe.name].progression_tier
        local mult = 1 + (tier*constant)
        --log("Applying Progression multiplier of "..mult.." to recipe "..recipe.name)
        for _, ing in pairs(recipe.expensive.ingredients) do
            if not (e_e.exclude_exp_ings and e_e.included_recipes[ing.name]) then
                ing.amount = ing.amount * mult
                ing.amount = math.floor(math.min(ing.amount, 64444))
            end
        end
        e_e.included_recipes[recipe.name].progression = true
    end
end

-- function e_e.apply_exponential(recipe, cnst_string)
--     if recipe then
--         local expo = tonumber(cnst_string)
--         local ingredient = {name = "ingredients", total = 0, count = 0, component={}}
--         local result = {name="results", total = 0, count = 0, component={}}

--         --log(serpent.block(recipe))
--         if expo < 1 then
--             error("Exponential constant can not be < 1")
--         end

--         --Analyse ingredients
--         for j,ing in pairs(recipe.expensive.ingredients) do
--             if not (e_e.exclude_exp_ings and e_e.included_recipes[ing.name]) then
--                 local am=ing.amount
                    
-- 				ingredient.component[ing.name]={amount = am, nr = j}
-- 				ingredient.total = ingredient.total + am
--                 ingredient.count = ingredient.count + 1
--              end
--         end

-- 		--Analyse result
--         for j, res in pairs(recipe.expensive.results) do
--             local am = res.amount 

-- 			result.component[res.name] = {amount = am, nr = j}
-- 			result.total = result.total + am
--             result.count = result.count + 1
--         end

--         --Apply ingredient multiplier
--         for j, ing in pairs(recipe.expensive.ingredients) do
--             if ingredient.component[ing.name] then
--                 --New total ingredients
--                 local totalnew = math.pow(ingredient.total, expo)
--                 --Calculate weight for the current ingredient
--                 local weight = ingredient.component[ing.name].amount / ingredient.total

--                 ing.amount = totalnew * weight
--             end
--         end

--         --Apply result multiplier
--         for j, res in pairs(recipe.expensive.results) do
--             --New total ingredients
--             local totalnew = math.pow(result.total, expo)
--             --Calculate weight for the current ingredient
--             local weight = result.component[res.name].amount / result.total

--             res.amount = totalnew * weight
--         end
        
-- 		-- Check for a gcd and divide if possible
-- 		local gcd = 0
-- 		for _, ingres in pairs({recipe.expensive.ingredients, recipe.expensive.results}) do
-- 			for _,part in pairs(ingres) do
-- 				if part.type == "item" then
-- 					if gcd == 0 then
-- 						gcd = part.amount
-- 					else
-- 						gcd = gcd(gcd,part.amount or math.floor((part.amount_min+part.amount_max)/2))
-- 					end
-- 				else
-- 					if gcd == 0 then
-- 						gcd = part.amount
-- 					else
-- 						gcd = gcd(gcd,math.max(round((part.amount or (part.amount_min+part.amount_max)/2)/60),1))
-- 					end
-- 				end
-- 			end
-- 		end

-- 		if gcd > 1 then
-- 			for _, ingres in pairs({recipe.expensive.ingredients, recipe.expensive.results}) do
-- 				for _,part in pairs(ingres) do
-- 					if part.amount then
-- 						part.amount = part.amount/gcd 
-- 					else
-- 						part.amount_max = part.amount_max/gcd 
-- 						part.amount_min = part.amount_min/gcd 
--                     end
--                     part.amount = math.floor(part.amount+0.5)
-- 				end
-- 			end
--         end
        
--         --Cap the amount to avoid crashes with stuff like rocket silos
--         for _, ingres in pairs({recipe.expensive.ingredients, recipe.expensive.results}) do
--             for _,part in pairs(ingres) do
--                 part.amount = math.min(part.amount, 64444)
--             end
--         end
    
--         --Split up results with amount > stacksize
--         for _,res in pairs(recipe.expensive.results) do
-- 			local size = find_stacksize(res.name)

-- 			if size and size>=1 and res.type == "item" and not res.probability and res.amount and res.amount > size then
-- 				while res.amount > size do
-- 					rec.expensive.results[#rec.expensive.results+1]={name=res.name, amount = size,type=res.type}
-- 					res.amount = res.amount-size
-- 				end
-- 				--standardise to set icons for recipes that had a single result before  (-->prob no icons)
-- 				if not rec.icons then standardise(rec) end
-- 			end
-- 		end
            
--         e_e.included_recipes[recipe.name].exponential = true
--         --log(serpent.block(recipe))
--     end
-- end