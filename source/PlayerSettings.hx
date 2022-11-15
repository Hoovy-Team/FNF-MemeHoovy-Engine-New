package;

import flixel.input.gamepad.FlxGamepad;
import Controls;
import flixel.FlxG;

class PlayerSettings
{
	static public var numPlayers(default, null) = 0;
	static public var player1(default, null):PlayerSettings;

	// static public var player2(default, null):PlayerSettings;
	public var id(default, null):Int;

	public final controls:Controls;

	function new(id)
	{
		this.id = id;
		controls = new Controls('player$id', KeyboardScheme.None);
		var setDefault:Bool = true;
		var saveControls = FlxG.save.data.controls;
		if (saveControls != null)
		{
			var keys = null;
			if (id == 0 && saveControls.p1 != null && saveControls.p1.keys != null)
			{
				keys = saveControls.p1.keys;
			}
			else if (id == 1 && saveControls.p2 != null && saveControls.p2.keys != null)
			{
				keys = saveControls.p2.keys;
			}
			if (keys != null)
			{
				setDefault = false;
				// trace('loaded key data: ' + Json.stringify(keys));
				controls.fromSaveData(keys, Keys);
			}
		}
		if (setDefault)
		{
			controls.setKeyboardScheme(KeyboardScheme.Solo);
		}
	}

	function addGamepad(pad:FlxGamepad)
	{
		var setDefault:Bool = true;
		var saveControls = FlxG.save.data.controls;
		if (saveControls != null)
		{
			var buttons = null;
			if (id == 0 && saveControls.p1 != null && saveControls.p1.pad != null)
			{
				buttons = saveControls.p1.pad;
			}
			else if (id == 1 && saveControls.p2 != null && saveControls.p2.pad != null)
			{
				buttons = saveControls.p2.pad;
			}
			if (buttons != null)
			{
				setDefault = false;
				// trace('loaded pad data: ' + Json.stringify(buttons));
				controls.addGamepadWithSaveData(pad.id, buttons);
			}
		}
		if (setDefault)
		{
			controls.addDefaultGamepad(pad.id);
		}
	}

	public function saveControls()
	{
		if (FlxG.save.data.controls == null)
		{
			FlxG.save.data.controls = {};
		}
		var keydata = null;
		if (id == 0)
		{
			if (FlxG.save.data.controls.p1 == null)
			{
				FlxG.save.data.controls.p1 = {};
			}
			keydata = FlxG.save.data.controls.p1;
		}
		else
		{
			if (FlxG.save.data.controls.p2 == null)
			{
				FlxG.save.data.controls.p2 = {};
			}
			keydata = FlxG.save.data.controls.p2;
		}
		var savedata = controls.createSaveData(Keys);
		if (savedata != null)
			keydata.keys = savedata;
		if (controls.gamepads.length > 0)
		{
			savedata = controls.createSaveData(Gamepad(controls.gamepads[0]));
			if (savedata != null)
				keydata.pad = savedata;
		}
		FlxG.save.flush();
	}

	static public function init():Void
	{
		if (player1 == null)
		{
			player1 = new PlayerSettings(0);
			numPlayers++;
		}

		FlxG.gamepads.deviceConnected.add(function(pad:FlxGamepad)
		{
			player1.addGamepad(pad);
		});

		var numGamepads = FlxG.gamepads.numActiveGamepads;
		if (numGamepads > 0)
		{
			if (FlxG.gamepads.getByID(0) == null)
				throw 'Unexpected null gamepad. id:0';

			player1.controls.addDefaultGamepad(0);
		}
	}
}
