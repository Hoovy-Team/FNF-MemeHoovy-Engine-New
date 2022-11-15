package ui;

import flixel.FlxG;
import flixel.util.FlxSave;
import flixel.util.FlxColor;

class PreferencesMenu extends Page
{
	public static var preferences:Map<String, Dynamic> = new Map<String, Dynamic>();
	static final defaultPreferences:Array<Array<Dynamic>> = [
		['naughtyness', 'censor-naughty', true],
		['flashing menu', 'flashing-menu', true],
		['note splashes', 'note-splashes', true],
		['camera zooming on beat', 'camera-zoom', true],
		['downscroll', 'downscroll', false],
		['ghost tapping', 'ghost-tapping', true],
		['health bar colors', 'health-bar-colors', true],
		['Global Antialiasing', 'global-antialiasing', true],
		#if (desktop || web)
		['auto pause', 'auto-pause', #if web false #else true #end],
		#end
		['fps counter', 'fps-counter', true],
	];

	static var save:FlxSave;

	// first item: title of the section;
	// other items: options below the section;
	final sections:Array<Array<String>> = [
		[
			'visuals',
			'censor-naughty',
			'flashing-menu',
			'note-splashes',
			'camera-zoom',
			'health-bar-colors',
			'global-antialiasing',
		],
		['gameplay', 'downscroll', 'ghost-tapping'],
		[
			'misc',
			#if (desktop || web)
			'auto-pause',
			#end
			'fps-counter',
		]
	];

	var checkboxes:Array<CheckboxThingie> = [];
	var menuCamera:FNFCamera;
	var items:TextMenuList;

	override public function new()
	{
		super();
		menuCamera = new FNFCamera(0.06);
		FlxG.cameras.add(menuCamera, false);
		menuCamera.bgColor = FlxColor.TRANSPARENT;
		camera = menuCamera;
		add(items = new TextMenuList());
		for (i in 0...sections.length)
		{
			var idx:Int = items.length;
			if (i > 0)
				idx += i;
			var sectionText:AtlasText = new AtlasText(0, 120 * idx + 30, sections[i][0], AtlasFont.Bold);
			sectionText.screenCenter(X);
			add(sectionText);
			for (j in 1...sections[i].length)
			{
				for (pref in defaultPreferences)
				{
					if (pref[1] == sections[i][j])
					{
						createPrefItem(120 * (idx + 1) + 30, pref[0], pref[1], pref[2]);
						idx++;
						break;
					}
				}
			}
		}
		menuCamera.camFollow.x = FlxG.width / 2;
		if (items != null)
			menuCamera.camFollow.y = items.members[items.selectedIndex].y;
		menuCamera.snapToPosition(null, null, true);
		menuCamera.target.setSize(140, 70);
		menuCamera.deadzone.set(0, 160, menuCamera.width, 40);
		menuCamera.minScrollY = 0;
		items.onChange.add(function(item:TextMenuItem)
		{
			menuCamera.camFollow.y = item.y;
		});
	}

	inline public static function getPref(pref:String)
	{
		return preferences.get(pref);
	}

	inline public static function setPref(identifier:String, value:Dynamic)
	{
		preferences.set(identifier, value);
	}

	public static function initPrefs()
	{
		save = new FlxSave();
		save.bind('preferences', 'memehoovy');
		if (save.data.preferences != null)
			preferences = cast save.data.preferences;
		for (pref in defaultPreferences)
		{
			preferenceCheck(pref[1], pref[2]);
			prefUpdate(pref[1]);
		}
		savePrefs();
	}

	public static function savePrefs()
	{
		save.data.preferences = preferences;
		save.flush();
	}

	inline public static function preferenceCheck(identifier:String, defaultValue:Dynamic)
	{
		if (getPref(identifier) == null)
			setPref(identifier, defaultValue);
	}

	public function createPrefItem(y:Float, label:String, identifier:String, value:Dynamic)
	{
		items.createItem(120, y, label, AtlasFont.Bold, function()
		{
			preferenceCheck(identifier, value);
			if (Type.typeof(value) == TBool)
			{
				prefToggle(identifier);
			}
		});
		if (Type.typeof(value) == TBool)
		{
			createCheckbox(identifier, y);
		}
	}

	public function createCheckbox(identifier:String, y:Float)
	{
		var box:CheckboxThingie = new CheckboxThingie(0, y - 30, getPref(identifier));
		checkboxes.push(box);
		add(box);
	}

	public function prefToggle(identifier:String)
	{
		var value:Bool = getPref(identifier);
		value = !value;
		preferences.set(identifier, value);
		savePrefs();
		checkboxes[items.selectedIndex].daValue = value;
		// trace('toggled? ' + Std.string(value));
		prefUpdate(identifier);
	}

	public static function prefUpdate(identifier:String)
	{
		var value:Dynamic = getPref(identifier);
		switch (identifier)
		{
			#if (desktop || web)
			case 'auto-pause':
				FlxG.autoPause = value;
			#end
			case 'fps-counter':
				if (Main.FPSCounter != null)
					Main.FPSCounter.visible = value;
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (items.exists)
			items.forEachAlive(function(item:MenuItem)
			{
				if (item == items.members[items.selectedIndex])
					item.x = 150;
				else
					item.x = 120;
			});
	}

	override public function destroy()
	{
		super.destroy();
		if (FlxG.cameras.list.contains(menuCamera))
			FlxG.cameras.remove(menuCamera);
	}
}
