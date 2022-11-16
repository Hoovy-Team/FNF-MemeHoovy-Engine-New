package ui;

import flixel.FlxG;
import flixel.FlxSprite;

class OptionsState extends MusicBeatState
{
	var pages:Map<String, Class<Page>> = new Map<String, Class<Page>>();
	var currentPage:Page;

	var defaultName:String = 'options';
	var currentName(default, null):String;

	override function create()
	{
		if (FlxG.sound.music == null || !FlxG.sound.music.playing)
			CoolUtil.resetMusic();
		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.color = 0xFFEA71FD;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.scrollFactor.set(0, 0);
		add(bg);
		pages.set(defaultName, OptionsMenu);
		pages.set('preferences', PreferencesMenu);
		pages.set('controls', ControlsMenu);
		resetPage();
		super.create();
	}

	function setPage(name:String)
	{
		var index:Int = -1;
		if (currentPage != null)
		{
			index = members.indexOf(currentPage);
			currentPage.kill();
			remove(currentPage, true);
			currentPage.destroy();
			currentPage = null;
		}
		if (pages.exists(name))
		{
			currentPage = Type.createInstance(pages.get(name), []);
			currentPage.onSwitch.add(setPage);
			if (name == defaultName)
				currentPage.onExit.add(exitToMainMenu);
			else
				currentPage.onExit.add(resetPage);
			if (index < 0)
				add(currentPage);
			else
				insert(index, currentPage);
		}
		currentName = name;
	}

	inline function resetPage()
	{
		setPage(defaultName);
	}

	function exitToMainMenu()
	{
		if (currentPage != null)
			currentPage.enabled = false;
		// Main.switchState(new MainMenuState());
		FlxG.switchState(new MainMenuState());
	}
}
