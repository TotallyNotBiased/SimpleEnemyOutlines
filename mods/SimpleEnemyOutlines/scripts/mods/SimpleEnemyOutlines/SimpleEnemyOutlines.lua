-- SimpleEnemyOutlines - Based on Psykernautics by Grimalykin
local mod = get_mod("SimpleEnemyOutlines")

-- This table will store the units we are currently outlining
local outlined_units = {}

-- Defines the colors available in the mod options.
local OUTLINE_COLOR_TEMPLATES = {
    red = { color = {1, 0, 0}, priority = 4 },
    green = { color = {0, 1, 0}, priority = 4 },
    blue = { color = {0, 0, 1}, priority = 4 },
    yellow = { color = {1, 1, 0}, priority = 4 },
    cyan = { color = {0, 1, 1}, priority = 4 },
    magenta = { color = {1, 0, 1}, priority = 4 },
    white = { color = {1, 1, 1}, priority = 4 },
    orange = { color = {1, 0.5, 0}, priority = 4 },
    purple = { color = {0.5, 0, 1}, priority = 4 },
    teal = { color = {0, 0.75, 0.75}, priority = 4 },
    lime = { color = {0.7, 1, 0}, priority = 4 },
    pink = { color = {1, 0.4, 0.7}, priority = 4 },
    brown = { color = {0.6, 0.3, 0.1}, priority = 4 },
    black = { color = {0, 0, 0}, priority = 4 },
    gray = { color = {0.6, 0.6, 0.6}, priority = 4 },
    silver = { color = {0.82, 0.82, 0.86}, priority = 4 },
}

-- An empty table used for safely accessing breed tags
local EMPTY_TABLE = {}

-- ######################################################################################################################
-- ## Mod Settings Getters
-- ######################################################################################################################

local function is_outlines_enabled()
    return mod:get("enable_outlines")
end

local function get_outline_radius()
    return mod:get("outline_radius")
end

local function get_default_outline_color()
    return mod:get("default_outline_color")
end

local function is_elite_highlight_enabled()
    return mod:get("enable_elite_highlight")
end

local function get_elite_color()
    return mod:get("elite_color")
end

local function is_per_enemy_colors_enabled()
    return mod:get("enable_per_enemy_colors")
end

local function get_max_outlines()
    return mod:get("max_outlines")
end

local function get_highlight_filter_mode()
    return mod:get("highlight_filter_mode") or "all"
end

-- ######################################################################################################################
-- ## Utility Functions
-- ######################################################################################################################

-- Safely gets a valid color name from settings, otherwise returns a fallback.
local function sanitize_color(color_name, fallback)
    if color_name and OUTLINE_COLOR_TEMPLATES[color_name] then
        return color_name
    end
    return fallback
end

-- Checks if a unit is considered an "elite" type (elite, special, or monster).
local function is_elite_type(unit)
    local breed = Unit.get_data(unit, "breed")
    if breed and breed.tags then
        return breed.tags.elite or breed.tags.special or breed.tags.monster or false
    end
    return false
end

-- Gets the outline system from the game's managers.
local function get_outline_system()
    return Managers.state.extension and Managers.state.extension:system("outline_system")
end

-- ######################################################################################################################
-- ## Core Logic
-- ######################################################################################################################

-- Determines if a unit should be included based on the filter settings.
local function should_include_unit(tags)
    tags = tags or EMPTY_TABLE
    local mode = get_highlight_filter_mode()

    if mode == "all" then
        return true
    elseif mode == "elites_only" then
        return tags.elite or false
    elseif mode == "specials_only" then
        return tags.special or false
    elseif mode == "elites_or_specials" then
        return (tags.elite or tags.special) or false
    elseif mode == "elites_specials_monsters" then
        return (tags.elite or tags.special or tags.monster) or false
    end
    return true
end

-- Scans for enemy units within a given radius around a center point.
local function find_enemies_in_radius(center, radius)
    local side_system = Managers.state.extension and Managers.state.extension:system("side_system")
    if not side_system then return {} end

    local player_side = side_system:get_side_from_name("heroes")
    if not player_side then return {} end

    local enemy_units_list = player_side:relation_units("enemy")
    local enemies_in_range = {}

    for i = 1, #enemy_units_list do
        local unit = enemy_units_list[i]
        if ALIVE[unit] then
            local pos = POSITION_LOOKUP[unit]
            if pos then
                local distance = Vector3.distance(center, pos)
                if distance <= radius then
                    enemies_in_range[unit] = {
                        distance = distance,
                        breed = Unit.get_data(unit, "breed")
                    }
                end
            end
        end
    end
    return enemies_in_range
end


-- Safely removes an outline from a unit.
local function remove_outline_safe(outline_system, unit, color_name)
    if not outline_system or not ALIVE[unit] or not color_name then
        return
    end
    outline_system:remove_outline(unit, color_name, false)
end

-- Clears all outlines currently managed by the mod.
local function clear_all_outlines()
    local outline_system = get_outline_system()
    if not outline_system then return end

    for unit, color_name in pairs(outlined_units) do
        remove_outline_safe(outline_system, unit, color_name)
    end
    outlined_units = {}
end

-- Main update function, called every frame during gameplay.
local function update_outlines()
    -- Ensure we are in a mission
    if not Managers.player or not Managers.player:local_player(1) then
        return
    end
    
    local player = Managers.player:local_player(1)
    if not player or not player.player_unit or not ALIVE[player.player_unit] then
        clear_all_outlines()
        return
    end
    
    -- If mod is disabled in settings, clear outlines and stop
    if not is_outlines_enabled() then
        clear_all_outlines()
        return
    end

    local player_unit = player.player_unit
    local player_pos = POSITION_LOOKUP[player_unit]
    if not player_pos then return end

    local outline_system = get_outline_system()
    if not outline_system then return end

    local search_radius = get_outline_radius()
    if search_radius <= 0 then
        clear_all_outlines()
        return
    end

    local enemies_found = find_enemies_in_radius(player_pos, search_radius)
    local desired_outlines = {}
    local potential_outlines = {}

    local use_per_enemy_colors = is_per_enemy_colors_enabled()

    -- Determine which enemies should be outlined and with what color
    for unit, data in pairs(enemies_found) do
        local breed = data.breed
        local tags = breed and breed.tags
        local breed_name = breed and breed.name and string.lower(breed.name)
        
        -- First, check if this enemy is disabled in per-enemy settings
        if use_per_enemy_colors then
            local per_enemy_color_setting = breed_name and mod:get("enemy_color_" .. breed_name)
            if per_enemy_color_setting == "disabled" then
                goto continue -- Skip this enemy entirely
            end
        end

        if should_include_unit(tags) then
            -- ## FIXED COLOR LOGIC ##
            -- Start with the default color as a baseline.
            local final_color = sanitize_color(get_default_outline_color(), "yellow")

            -- Priority 2: Check for elite override.
            if is_elite_highlight_enabled() and is_elite_type(unit) then
                final_color = sanitize_color(get_elite_color(), final_color)
            end

            -- Priority 1 (Highest): Check for per-enemy override.
            if use_per_enemy_colors then
                local per_enemy_color_setting = breed_name and mod:get("enemy_color_" .. breed_name)
                if per_enemy_color_setting and per_enemy_color_setting ~= "none" then
                    final_color = sanitize_color(per_enemy_color_setting, final_color)
                end
            end

            if final_color then
                potential_outlines[#potential_outlines + 1] = {
                    unit = unit,
                    color = final_color,
                    distance = data.distance,
                }
            end
        end
        ::continue::
    end

    -- Apply performance limit by sorting by distance and taking the closest
    local max_outlines = get_max_outlines()
    if max_outlines > 0 and #potential_outlines > max_outlines then
        table.sort(potential_outlines, function(a, b) return a.distance < b.distance end)
        -- Trim the table by creating a new one with just the closest enemies
        local trimmed_outlines = {}
        for i = 1, max_outlines do
            trimmed_outlines[i] = potential_outlines[i]
        end
        potential_outlines = trimmed_outlines
    end

    for _, data in ipairs(potential_outlines) do
        desired_outlines[data.unit] = data.color
    end

    -- Sync the current outlines with the desired ones
    -- Remove outlines that are no longer desired
    for unit, current_color in pairs(outlined_units) do
        local desired_color = desired_outlines[unit]
        if not desired_color or not ALIVE[unit] then
            remove_outline_safe(outline_system, unit, current_color)
            outlined_units[unit] = nil
        end
    end
    
    -- Add or update outlines that are desired
    for unit, desired_color in pairs(desired_outlines) do
        if ALIVE[unit] then
            local current_color = outlined_units[unit]
            if current_color ~= desired_color then
                if current_color then
                    remove_outline_safe(outline_system, unit, current_color)
                end
                outline_system:add_outline(unit, desired_color, false)
                outlined_units[unit] = desired_color
            end
        end
    end
end


-- ######################################################################################################################
-- ## Mod Hooks and Callbacks
-- ######################################################################################################################

-- This function is required to inject our custom color definitions into the game's outline system.
local function apply_outline_templates(settings)
    local extension_settings = settings and settings.MinionOutlineExtension
    if not extension_settings then return end

    for name, template in pairs(OUTLINE_COLOR_TEMPLATES) do
        extension_settings[name] = {
            priority = template.priority,
            color = { template.color[1], template.color[2], template.color[3] },
            material_layers = { "minion_outline", "minion_outline_reversed_depth" }
        }
    end
end

-- Hook into the game's outline settings to add our colors.
mod:hook_require("scripts/settings/outline/outline_settings", function(settings)
    apply_outline_templates(settings)
end)

-- Also apply templates immediately in case the settings are already loaded.
pcall(function()
    apply_outline_templates(require("scripts/settings/outline/outline_settings"))
end)

-- Hook into the game's main update loop.
mod:hook_safe("GameModeManager", "update", update_outlines)

mod.on_enabled = function()
    -- Runs when the mod is enabled.
end

mod.on_disabled = function()
    -- Runs when the mod is disabled.
    clear_all_outlines()
end

mod.on_unload = function()
    -- Runs when the game is shutting down or the mod is unloaded.
    clear_all_outlines()
end

mod.on_setting_changed = function(setting_id)
    -- When a setting changes, we should clear and re-evaluate outlines.
    clear_all_outlines()
end

