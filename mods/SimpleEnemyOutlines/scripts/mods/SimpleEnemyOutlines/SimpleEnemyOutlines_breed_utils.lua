-- This is a utility script for working with enemy "breed" data in Darktide.
-- It helps to get a clean, sorted list of all supported enemy types.

local Breeds = require("scripts/settings/breed/breeds")

local BreedUtils = {}

-- Some breeds are just variations of others. We map them here to avoid duplicates.
local BREED_ALIAS_MAP = {
    chaos_hound_mutator = "chaos_hound",
    cultist_mutant_mutator = "cultist_mutant",
}

-- We can blacklist certain breeds if we don't want them to appear in our settings.
local BREED_BLACKLIST = {}


-- This function checks if an enemy is a valid "minion" that we should care about.
-- It filters out things like scenery objects or player characters.
function BreedUtils.is_supported_minion(breed_name, breed)
    if BREED_BLACKLIST[breed_name] then
        return false
    end

    if BREED_ALIAS_MAP[breed_name] then
        return false -- We only want the base version, not the alias.
    end

    local tags = breed.tags
    return tags and tags.minion or false
end

-- This function assigns a category number based on tags for sorting purposes.
-- Monsters > Specials > Elites > Others
local function category_from_tags(tags)
    if tags.monster or tags.captain then return 1 end
    if tags.special then return 2 end
    if tags.elite then return 3 end
    if tags.horde or tags.roamer then return 4 end
    return 5
end

-- The main function that builds the sorted list of enemies.
function BreedUtils.get_supported_breeds()
    local entries = {}

    -- Go through every breed defined in the game.
    for breed_name, breed in pairs(Breeds) do
        if BreedUtils.is_supported_minion(breed_name, breed) then
            local tags = breed.tags or {}
            table.insert(entries, {
                name = breed_name,
                category = category_from_tags(tags),
                sort_name = string.lower(breed.display_name or breed_name),
                breed = breed,
            })
        end
    end

    -- Sort the list first by category, then alphabetically by name.
    table.sort(entries, function(a, b)
        if a.category == b.category then
            return a.sort_name < b.sort_name
        end
        return a.category < b.category
    end)

    return entries
end

return BreedUtils
