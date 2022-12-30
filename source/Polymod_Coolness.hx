package;

#if polymod
import polymod.format.ParseRules;
import polymod.Polymod;
import polymod.backends.PolymodAssetLibrary;
#end

/**
	Class for loading mods with `Polymod`.
**/
#if (desktop && polymod)
class Polymod_Coolness
{
	public static var mod_dirs:Array<String> = [];

	public static var modMetaShit:Array<String> = [];

	public static function reloadMods()
	{
		polymod.PolymodConfig.modMetadataFile = "mod.json";
		polymod.PolymodConfig.modIconFile = "mod.png";

		mod_dirs = [];

		for (meta in polymod.Polymod.scan("mods"))
		{
			mod_dirs.push(meta.id);
		}

		modMetaShit = [];

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
	}

	inline public static function getMod():Void{
		var assetLibrary:PolymodAssetLibrary = new PolymodAssetLibrary(null);
		if (assetLibrary != null){
			for (j => i in sys.FileSystem.readDirectory('mods/' + @:privateAccess assetLibrary._checkExists(getID()))){
				if (assetLibrary.exists(i)){
					trace("mod " + j + " exists");
				}
				else {
					trace("mod " + j + " not found");
				}
			}
		}
		else return;
	}

	inline public static function getMods():Array<String>{
		var scanner = Polymod.scan('mods');
		trace('found ' + scanner.length + ' mods when scanning');
		return [for (j in scanner) j.id];
	}

	inline public static function removeMod():Void{
		var assetLibrary:PolymodAssetLibrary = new PolymodAssetLibrary(null);
		var scanner = Polymod.scan('mods');
		if (assetLibrary != null) {
			for (mod in @:privateAccess Polymod.prevParams.dirs){
				if (assetLibrary.exists(mod)){
					try {
						Polymod.unloadMod(mod);
					}
					catch (e:haxe.Exception) {
						trace('removal failed for ' + mod + ': ' + e.message);
					}	
				}
				else {
					return;
					trace('mod ' + mod + 'does not exist');
				}
			}
		}
		else return;
	}

	inline public static function loadMod(id:String):Void{
		var assetLibrary:PolymodAssetLibrary = new PolymodAssetLibrary(null); // humor me more
		for (meta in polymod.Polymod.scan("mods")){
			if (assetLibrary.exists(id)){
				Polymod.loadMod(id);
			}
			else {
				Polymod.error(MISSING_MOD, 'mod does not exist', SCAN);
			}
		}
	}

	inline public static function removeAllMods():Void{
		if (@:privateAccess openfl.utils.Assets.exists(Polymod.prevParams.modRoot)){
			Polymod.unloadAllMods();
		}
		else return;
	}

	inline public static function removeMods(id:Array<String>):Void{
		for (meta in polymod.Polymod.scan("mods")){
			if (@:privateAccess openfl.utils.Assets.exists(Polymod.prevParams.modRoot + id)){
				Polymod.unloadMods(id);
			}
			else {
				Polymod.error(MISSING_MOD, 'mod does not exist', SCAN);
			}
		}
	}

	inline public static function listModdedFiles(type:Dynamic):Void{
		for (meta in polymod.Polymod.scan("mods")){
			if (@:privateAccess openfl.utils.Assets.exists(Polymod.prevParams.modRoot) && meta != null){
				Polymod.listModFiles(type);
			}
			else return;
		}
	}

	inline public static function changeMeta(metaData:String, iconFile:String):Void{
		polymod.PolymodConfig.modMetadataFile = metaData + ".json";
		polymod.PolymodConfig.modIconFile = iconFile + ".png";
	}

	public static function getID():Dynamic{
		for (e in polymod.Polymod.scan("mods")){
			if (e != null && e.exists('mods')) {
				modMetaShit.push(e.id);
				return e.id;
			}
		}
		return null;
	}

	public static inline function clearIDs():Void{
		return modMetaShit.resize(0);
	}
}
#end