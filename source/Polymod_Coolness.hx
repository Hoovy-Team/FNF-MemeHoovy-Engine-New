package;

#if polymod
import polymod.format.ParseRules;
#end

/**
	Class for loading mods with `Polymod`.
**/
class Polymod_Coolness
{
	public static var mod_dirs:Array<String> = [];

	public static function reloadMods()
	{
		#if desktop
		polymod.PolymodConfig.modMetadataFile = "mod.json";
		polymod.PolymodConfig.modIconFile = "mod.png";

		mod_dirs = [];

		for (meta in polymod.Polymod.scan("mods"))
		{
			mod_dirs.push(meta.id);
		}

		mod_dirs = [];

		var parse_rules:ParseRules = ParseRules.getDefault();
		parse_rules.addFormat("json", new JsonTools());

		polymod.Polymod.init({
			modRoot: "mods",
			dirs: mod_dirs,
			framework: OPENFL,
			errorCallback: function(error:polymod.Polymod.PolymodError)
			{
				trace(error.message);
			},
			frameworkParams: {
				assetLibraryPaths: [
					"songs" => "songs",
					"shared" => "shared",
					"tutorial" => "tutorial",
					"week1" => "week1",
					"week2" => "week2",
					"week3" => "week3",
					"week4" => "week4",
					"week5" => "week5",
					"week6" => "week6"
				]
			},
			parseRules: parse_rules
		});
		#end
	}
}
