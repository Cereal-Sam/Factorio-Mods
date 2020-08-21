for _, rec in pairs(data.raw.recipe) do
    if marathon.included_recipes[rec.name] then
        --Standardise recipe ingredients, needed for all modes
        --log("BEFORE:")
        --log(serpent.block(rec))
        marathon.standardise(rec)

        --WIP
        -- --Apply Exponential multiplier
        -- if expo_mode then
        --     marathon.apply_exponential(rec, marathon.exp_constant)
        -- end

        --Apply Linear Multiplier
        if marathon.lin_mode == true then
            marathon.apply_linear(rec, marathon.lin_constant)
            --log("Applied linear factor on recipe: "..rec.name)
        end

        --Apply Progression Multiplier
        if marathon.prog_mode == true then
            marathon.apply_progression(rec, marathon.prog_constant)
            --log("Applied linear factor on recipe: "..rec.name)
        end

        --log("After:")
        --log(serpent.block(rec))
    end
end