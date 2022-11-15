package ui;

import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.util.FlxSignal.FlxTypedSignal;

class Page extends FlxGroup
{
	public var onSwitch:FlxTypedSignal<String->Void> = new FlxTypedSignal<String->Void>();
	public var onExit:FlxTypedSignal<Void->Void> = new FlxTypedSignal<Void->Void>();

	public var enabled(default, set):Bool = true;
	public var canExit:Bool = true;

	public function exit()
	{
		onExit.dispatch();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (enabled)
		{
			updateEnabled(elapsed);
		}
	}

	function updateEnabled(elapsed:Float)
	{
		if (canExit && PlayerSettings.player1.controls.BACK)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			onExit.dispatch();
		}
	}

	function set_enabled(state:Bool)
	{
		return enabled = state;
	}

	public function openPrompt(prompt:Prompt, ?callback:Void->Void)
	{
		enabled = false;
		prompt.closeCallback = function()
		{
			enabled = true;
			if (callback != null)
				callback();
		}
		FlxG.state.openSubState(prompt);
	}

	override public function destroy()
	{
		super.destroy();
		onSwitch.removeAll();
	}
}
