package ui;

class CheckboxThingie extends FNFSprite
{
	public var daValue(default, set):Bool;

	override public function new(x:Float, y:Float, state:Bool = false)
	{
		super(x, y);
		frames = Paths.getSparrowAtlas('checkboxThingie');
		animation.addByPrefix('static', 'Check Box unselected', 24, false);
		animation.addByPrefix('checked', 'Check Box selecting animation', 24, false);
		addOffset('checked', 17, 70);
		antialiasing = true;
		setGraphicSize(Std.int(width * 0.7));
		updateHitbox();
		daValue = state;
		animation.finish();
	}

	function set_daValue(state:Bool)
	{
		playAnim(state ? 'checked' : 'static', state);
		return state;
	}
}
