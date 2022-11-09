package mobile;

import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import mobile.Hitbox;

class Mobilecontrols extends FlxSpriteGroup
{
	public var mode:ControlsGroup = HITBOX;

	public var _hitbox:Hitbox;

	public function new()
	{
		super();

		_hitbox = new Hitbox();
		add(_hitbox);
	}
}

enum ControlsGroup
{
	HITBOX;
}
