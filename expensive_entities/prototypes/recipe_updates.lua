--Check if science pack recipes require entities. If yes, create a copy of that item/recipe for crafting the science pack only
for _, recipe in pairs(e_e.check_science_pack) do
    local rec = data.raw.recipe[recipe]
    e_e.standardise(rec)
    local check ={}
    local ents = e_e.get_entity_ingredients(rec)

    if next(ents) then
        ::loop::
        for _,ing in pairs(ents) do
            if not data.raw.item["ee-sp-"..ing] then
                e_e.create_ingredient_copy(ing, recipe)
                check[#check+1] = ing
            end
            --If we are on the sciencepack recipe, we need to replace on the original, else on the copy
            if rec.name == recipe then
                omni.lib.replace_recipe_ingredient(rec.name, ing, "ee-sp-"..ing)
            else
                omni.lib.replace_recipe_ingredient("ee-sp-"..rec.name, ing, "ee-sp-"..ing)
            end
        end
        --Check the found entity ingredient aswell
        --Get the last element of check and go through its ingredients again
        if next(check) then
            rec = data.raw.recipe[check[#check]]
            if rec then
                e_e.standardise(rec)
                ents = e_e.get_entity_ingredients(rec)
                --check[#check] = nil
                table.remove(check,#check)
                goto loop
            else
                --check[#check] = nil
                table.remove(check,#check)
            end
        end
    end
end

--Apply Multiplier
for _, rec in pairs(data.raw.recipe) do
    if e_e.included_recipes[rec.name] then
        --Standardise recipe ingredients, needed for all modes
        --log("BEFORE:")
        --log(serpent.block(rec))
        e_e.standardise(rec)

        --WIP
        -- --Apply Exponential multiplier
        -- if expo_mode then
        --     e_e.apply_exponential(rec, e_e.exp_constant)
        -- end

        --Apply Linear Multiplier
        if e_e.lin_mode == true then
            e_e.apply_linear(rec, e_e.lin_constant)
            --log("Applied linear factor on recipe: "..rec.name)
        end

        --Apply Progression Multiplier
        if e_e.prog_mode == true then
            e_e.apply_progression(rec, e_e.prog_constant)
            --log("Applied linear factor on recipe: "..rec.name)
        end

        --log("After:")
        --log(serpent.block(rec))
    end
end