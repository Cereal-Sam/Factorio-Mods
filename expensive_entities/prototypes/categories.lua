local group = "intermediate-products"

if data.raw.recipe["automation-science-pack"] and data.raw.recipe["automation-science-pack"].subgroup then
    local sub = data.raw.recipe["automation-science-pack"].subgroup
    if data.raw["item-subgroup"][sub] then
        group = data.raw["item-subgroup"][sub].group
    end
end

data:extend(
{
    {
        type = "item-subgroup",
        name = "science-pack-ingredients",
        group = group,
        order = "gzzzz",
    },
})