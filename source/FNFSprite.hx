package;

// @author Stilic

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class FNFSprite extends FlxSprite
{
	public var animOffsets:Map<String, Array<Float>>;

	public function new(X:Float = 0, Y:Float = 0, ?SimpleGraphic:FlxGraphicAsset)
	{
		super(X, Y, SimpleGraphic);
		animOffsets = new Map<String, Array<Float>>();
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		animation.play(AnimName, Force, Reversed, Frame);

		if (animOffsets.exists(AnimName))
		{
			var daOffset:Array<Float> = animOffsets.get(AnimName);
			offset.set(daOffset[0], daOffset[1]);
		}
		else
			offset.set();
	}

	public function addOffset(name:String, x:Float, y:Float)
	{
		animOffsets.set(name, [x, y]);
	}
}
