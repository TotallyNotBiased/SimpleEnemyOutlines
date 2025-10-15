local mod = get_mod("SimpleEnemyOutlines")

-- Defines the list of colors available in dropdown menus
local COLOR_KEYS = {
    "red", "green", "blue", "yellow", "cyan", "magenta", "white", "orange",
    "purple", "teal", "lime", "pink", "brown", "black", "gray", "silver",
}

-- Helper function to build a list of options for a dropdown menu
local function build_options(prefix)
    local options = {}
    for i = 1, #COLOR_KEYS do
        local key = COLOR_KEYS[i]
        options[#options + 1] = {
            text = prefix .. key,
            value = key,
        }
    end
    return options
end

-- Helper function to clone options so dropdowns don't share the same table
local function clone_options(source)
    local options = {}
    for i = 1, #source do
        options[i] = { text = source[i].text, value = source[i].value }
    end
    return options
end

-- Helper function to create a settings group
local function group(setting_id, title_key, widgets)
    return {
        setting_id = setting_id,
        type = "group",
        sub_widgets = widgets,
    }
end

local outline_color_options = build_options("outline_color_")

-- Color options with "none" (use default) and "disabled" (never outline)
local color_options_with_none = {
    { text = "outline_color_disabled", value = "disabled" },
    { text = "color_none", value = "none" }
}
for i = 1, #COLOR_KEYS do
    color_options_with_none[#color_options_with_none + 1] = {
        text = "outline_color_" .. COLOR_KEYS[i],
        value = COLOR_KEYS[i],
    }
end

-- ######################################################################################################################
-- ## Settings Groups
-- ######################################################################################################################

local group_general_settings = group("group_general_settings", "group_general_settings", {
    {
        setting_id = "enable_outlines",
        type = "checkbox",
        default_value = true,
    },
    {
        setting_id = "outline_radius",
        type = "numeric",
        default_value = 20,
        range = { 1, 100 },
        decimals_number = 0,
    },
    {
        setting_id = "default_outline_color",
        type = "dropdown",
        default_value = "yellow",
        options = clone_options(outline_color_options),
    },
})

local group_elite_settings = group("group_elite_settings", "group_elite_settings", {
    {
        setting_id = "enable_elite_highlight",
        type = "checkbox",
        default_value = true,
    },
    {
        setting_id = "elite_color",
        type = "dropdown",
        default_value = "orange",
        options = clone_options(outline_color_options),
    },
})

local group_performance = group("group_performance", "group_performance", {
    {
        setting_id = "max_outlines",
        type = "numeric",
        default_value = 40,
        range = { 0, 150 },
        decimals_number = 0,
    },
})

local group_highlight_filters = group("group_highlight_filters", "group_highlight_filters", {
    {
        setting_id = "highlight_filter_mode",
        type = "dropdown",
        default_value = "all",
        options = {
            { text = "highlight_filter_all", value = "all" },
            { text = "highlight_filter_elites_only", value = "elites_only" },
            { text = "highlight_filter_specials_only", value = "specials_only" },
            { text = "highlight_filter_elites_or_specials", value = "elites_or_specials" },
            { text = "highlight_filter_elites_specials_monsters", value = "elites_specials_monsters" },
        },
    },
})

-- Per-Enemy Color Overrides
local group_per_enemy_colors = group("group_per_enemy_colors", "group_per_enemy_colors", {
    {
        setting_id = "enable_per_enemy_colors",
        type = "checkbox",
        default_value = false,
    },
    -- Elites (Melee)
    {
        setting_id = "enemy_color_renegade_executor",
        type = "dropdown",
        default_value = "none",
        options = clone_options(color_options_with_none),
    },
    {
        setting_id = "enemy_color_chaos_ogryn_executor",
        type = "dropdown",
        default_value = "none",
        options = clone_options(color_options_with_none),
    },
    {
        setting_id = "enemy_color_cultist_mutant",
        type = "dropdown",
        default_value = "none",
        options = clone_options(color_options_with_none),
    },
    {
        setting_id = "enemy_color_renegade_berzerker",
        type = "dropdown",
        default_value = "none",
        options = clone_options(color_options_with_none),
    },
    {
        setting_id = "enemy_color_cultist_berzerker",
        type = "dropdown",
        default_value = "none",
        options = clone_options(color_options_with_none),
    },
    {
        setting_id = "enemy_color_chaos_ogryn_bulwark",
        type = "dropdown",
        default_value = "none",
        options = clone_options(color_options_with_none),
    },
    -- Elites (Ranged)
    {
        setting_id = "enemy_color_renegade_gunner",
        type = "dropdown",
        default_value = "none",
        options = clone_options(color_options_with_none),
    },
    {
        setting_id = "enemy_color_renegade_rifleman",
        type = "dropdown",
        default_value = "none",
        options = clone_options(color_options_with_none),
    },
    {
        setting_id = "enemy_color_cultist_gunner",
        type = "dropdown",
        default_value = "none",
        options = clone_options(color_options_with_none),
    },
    {
        setting_id = "enemy_color_chaos_ogryn_gunner",
        type = "dropdown",
        default_value = "none",
        options = clone_options(color_options_with_none),
    },
    -- Specials
    {
        setting_id = "enemy_color_cultist_flamer",
        type = "dropdown",
        default_value = "none",
        options = clone_options(color_options_with_none),
    },
    {
        setting_id = "enemy_color_renegade_flamer",
        type = "dropdown",
        default_value = "none",
        options = clone_options(color_options_with_none),
    },
    {
        setting_id = "enemy_color_cultist_grenadier",
        type = "dropdown",
        default_value = "none",
        options = clone_options(color_options_with_none),
    },
    {
        setting_id = "enemy_color_renegade_grenadier",
        type = "dropdown",
        default_value = "none",
        options = clone_options(color_options_with_none),
    },
    {
        setting_id = "enemy_color_renegade_sniper",
        type = "dropdown",
        default_value = "none",
        options = clone_options(color_options_with_none),
    },
    {
        setting_id = "enemy_color_renegade_netgunner",
        type = "dropdown",
        default_value = "none",
        options = clone_options(color_options_with_none),
    },
    {
        setting_id = "enemy_color_cultist_shocktrooper",
        type = "dropdown",
        default_value = "none",
        options = clone_options(color_options_with_none),
    },
    {
        setting_id = "enemy_color_renegade_shocktrooper",
        type = "dropdown",
        default_value = "none",
        options = clone_options(color_options_with_none),
    },
    {
        setting_id = "enemy_color_cultist_assault",
        type = "dropdown",
        default_value = "none",
        options = clone_options(color_options_with_none),
    },
    {
        setting_id = "enemy_color_renegade_assault",
        type = "dropdown",
        default_value = "none",
        options = clone_options(color_options_with_none),
    },
    {
        setting_id = "enemy_color_chaos_hound",
        type = "dropdown",
        default_value = "none",
        options = clone_options(color_options_with_none),
    },
    {
        setting_id = "enemy_color_chaos_poxwalker_bomber",
        type = "dropdown",
        default_value = "none",
        options = clone_options(color_options_with_none),
    },
    {
        setting_id = "enemy_color_cultist_holy_stubber_gunner",
        type = "dropdown",
        default_value = "none",
        options = clone_options(color_options_with_none),
    },
    {
        setting_id = "enemy_color_renegade_plasma_gunner",
        type = "dropdown",
        default_value = "none",
        options = clone_options(color_options_with_none),
    },
    {
        setting_id = "enemy_color_renegade_twin_captain_two",
        type = "dropdown",
        default_value = "none",
        options = clone_options(color_options_with_none),
    },
    {
        setting_id = "enemy_color_renegade_twin_captain",
        type = "dropdown",
        default_value = "none",
        options = clone_options(color_options_with_none),
    },
    {
        setting_id = "enemy_color_cultist_ritualist",
        type = "dropdown",
        default_value = "none",
        options = clone_options(color_options_with_none),
    },
    -- Monsters
    {
        setting_id = "enemy_color_chaos_plague_ogryn",
        type = "dropdown",
        default_value = "none",
        options = clone_options(color_options_with_none),
    },
    {
        setting_id = "enemy_color_chaos_plague_ogryn_sprayer",
        type = "dropdown",
        default_value = "none",
        options = clone_options(color_options_with_none),
    },
    {
        setting_id = "enemy_color_chaos_spawn",
        type = "dropdown",
        default_value = "none",
        options = clone_options(color_options_with_none),
    },
    {
        setting_id = "enemy_color_chaos_beast_of_nurgle",
        type = "dropdown",
        default_value = "none",
        options = clone_options(color_options_with_none),
    },
    {
        setting_id = "enemy_color_chaos_daemonhost",
        type = "dropdown",
        default_value = "none",
        options = clone_options(color_options_with_none),
    },
})


return {
    name = mod:localize("mod_name"),
    description = mod:localize("mod_description"),
    is_togglable = true,
    options = {
        widgets = {
            group_general_settings,
            group_elite_settings,
            group_highlight_filters,
            group_performance,
            group_per_enemy_colors,
        }
    }
}
