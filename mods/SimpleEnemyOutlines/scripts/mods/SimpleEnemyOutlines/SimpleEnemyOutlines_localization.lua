return {
    mod_name = {
        en = "Simple Enemy Outlines",
    },
    mod_description = {
        en = "Renders outlines on nearby enemies to improve situational awareness. Highly configurable.",
    },

    -- Group headers
    group_general_settings = {
        en = "General Settings",
    },
    group_elite_settings = {
        en = "Elite & Special Highlighting",
    },
    group_highlight_filters = {
        en = "Highlight Filters",
    },
    group_performance = {
        en = "Performance",
    },
    group_per_enemy_colors = {
        en = "Per-Enemy Overrides",
    },

    -- General Settings
    enable_outlines = {
        en = "Enable Enemy Outlines",
    },
    enable_outlines_description = {
        en = "Master toggle for the mod. When off, no outlines will be rendered.",
    },
    outline_radius = {
        en = "Outline Radius (meters)",
    },
    outline_radius_description = {
        en = "Enemies within this distance from you will be outlined.",
    },
    default_outline_color = {
        en = "Default Outline Color",
    },
    default_outline_color_description = {
        en = "The color used for regular enemies.",
    },

    -- Elite Settings
    enable_elite_highlight = {
        en = "Use Different Color for Elites/Specials",
    },
    enable_elite_highlight_description = {
        en = "If enabled, Elites, Specials, and Monsters will use the color specified below.",
    },
    elite_color = {
        en = "Elite/Special Outline Color",
    },
    elite_color_description = {
        en = "The color to use for highlighting Elites, Specials, and Monsters.",
    },

    -- Filter Settings
    highlight_filter_mode = {
        en = "Highlight Filter",
    },
    highlight_filter_mode_description = {
        en = "Choose which broad categories of enemies to outline.",
    },
    highlight_filter_all = {
        en = "All Enemies",
    },
    highlight_filter_elites_only = {
        en = "Elites Only",
    },
    highlight_filter_specials_only = {
        en = "Specials Only",
    },
    highlight_filter_elites_or_specials = {
        en = "Elites or Specials",
    },
    highlight_filter_elites_specials_monsters = {
        en = "Elites, Specials, & Monsters",
    },

    -- Performance Settings
    max_outlines = {
        en = "Max Outlined Enemies",
    },
    max_outlines_description = {
        en = "The maximum number of enemies that can be outlined at once. Lowering this can improve performance in dense hordes. Set to 0 for no limit.",
    },
    
    -- Per-Enemy Description
    enable_per_enemy_colors_description = {
        en = "Here you can set a specific color for each enemy type, disable their outline entirely, or leave them at default.",
    },

    -- Color options
    outline_color_red = { en = "Red" },
    outline_color_green = { en = "Green" },
    outline_color_blue = { en = "Blue" },
    outline_color_yellow = { en = "Yellow" },
    outline_color_cyan = { en = "Cyan" },
    outline_color_magenta = { en = "Magenta" },
    outline_color_white = { en = "White" },
    outline_color_orange = { en = "Orange" },
    outline_color_purple = { en = "Purple" },
    outline_color_teal = { en = "Teal" },
    outline_color_lime = { en = "Lime" },
    outline_color_pink = { en = "Pink" },
    outline_color_brown = { en = "Brown" },
    outline_color_black = { en = "Black" },
    outline_color_gray = { en = "Gray" },
    outline_color_silver = { en = "Silver" },
    outline_color_disabled = { en = "Disabled (Never Outline)" },
    color_none = { en = "None (Use Default)" },

    -- Per-Enemy Names (copied from original)
    enemy_color_renegade_executor = { en = "Crusher" },
    enemy_color_chaos_ogryn_executor = { en = "Crusher (Chaos Ogryn)" },
    enemy_color_cultist_mutant = { en = "Mutant" },
    enemy_color_renegade_berzerker = { en = "Mauler" },
    enemy_color_cultist_berzerker = { en = "Mauler (Dreg)" },
    enemy_color_chaos_ogryn_bulwark = { en = "Bulwark" },
    enemy_color_renegade_gunner = { en = "Gunner (Scab)" },
    enemy_color_renegade_rifleman = { en = "Shooter (Scab)" },
    enemy_color_cultist_gunner = { en = "Gunner (Dreg)" },
    enemy_color_chaos_ogryn_gunner = { en = "Reaper" },
    enemy_color_cultist_flamer = { en = "Tox Flamer" },
    enemy_color_renegade_flamer = { en = "Flamer (Scab)" },
    enemy_color_cultist_grenadier = { en = "Bomber (Dreg)" },
    enemy_color_renegade_grenadier = { en = "Bomber (Scab)" },
    enemy_color_renegade_sniper = { en = "Sniper" },
    enemy_color_renegade_netgunner = { en = "Trapper" },
    enemy_color_cultist_shocktrooper = { en = "Rager (Dreg)" },
    enemy_color_renegade_shocktrooper = { en = "Rager (Scab)" },
    enemy_color_cultist_assault = { en = "Stalker (Dreg)" },
    enemy_color_renegade_assault = { en = "Stalker (Scab)" },
    enemy_color_chaos_hound = { en = "Pox Hound" },
    enemy_color_chaos_poxwalker_bomber = { en = "Poxburster" },
    enemy_color_cultist_holy_stubber_gunner = { en = "Heavy Gunner (Dreg)" },
    enemy_color_renegade_plasma_gunner = { en = "Gunner (Plasma)" },
    enemy_color_renegade_twin_captain = { en = "Captain (Twin)" },
    enemy_color_renegade_twin_captain_two = { en = "Captain" },
    enemy_color_cultist_ritualist = { en = "Scab Corruptor" },
    enemy_color_chaos_plague_ogryn = { en = "Plague Ogryn" },
    enemy_color_chaos_plague_ogryn_sprayer = { en = "Plague Ogryn (Sprayer)" },
    enemy_color_chaos_spawn = { en = "Chaos Spawn" },
    enemy_color_chaos_beast_of_nurgle = { en = "Beast of Nurgle" },
    enemy_color_chaos_daemonhost = { en = "Daemonhost" },
}
