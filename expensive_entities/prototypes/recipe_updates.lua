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