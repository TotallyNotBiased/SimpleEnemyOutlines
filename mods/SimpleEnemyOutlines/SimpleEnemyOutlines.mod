return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`SimpleEnemyOutlines` encountered an error loading the Darktide Mod Framework.")

		new_mod("SimpleEnemyOutlines", {
			mod_script       = "SimpleEnemyOutlines/scripts/mods/SimpleEnemyOutlines/SimpleEnemyOutlines",
			mod_data         = "SimpleEnemyOutlines/scripts/mods/SimpleEnemyOutlines/SimpleEnemyOutlines_data",
			mod_localization = "SimpleEnemyOutlines/scripts/mods/SimpleEnemyOutlines/SimpleEnemyOutlines_localization",
		})
	end,
	packages = {},
}
