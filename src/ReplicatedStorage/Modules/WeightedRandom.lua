local WeightedRandom = {}

function WeightedRandom.pick(weightTable)
    local totalWeight = 0
    for _, entry in pairs(weightTable) do
        totalWeight += entry.Weight
    end

    local roll = math.random() * totalWeight
    local cursor = 0

    for key, entry in pairs(weightTable) do
        cursor += entry.Weight
        if roll <= cursor then
            return key
        end
    end

    return next(weightTable)
end

return WeightedRandom
