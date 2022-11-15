package;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxGradient;
import flixel.util.FlxDestroyUtil;

class FadeSubstate extends FlxSubState
{
	public var finishCallback:Void->Void;
	public var isTransIn(default, null):Bool;

	var leTween:FlxTween;
	var transBlack:FlxSprite;
	var transGradient:FlxSprite;

	public function new(duration:Float, isTransIn:Bool, ?finishCallback:Void->Void)
	{
		super();

		this.isTransIn = isTransIn;
		this.finishCallback = finishCallback;

		var zoom:Float = FlxMath.bound(FlxG.camera.zoom, 0.05, 1);
		var width:Int = Std.int(FlxG.width / zoom);
		var height:Int = Std.int(FlxG.height / zoom);
		transGradient = FlxGradient.createGradientFlxSprite(width, height, (isTransIn ? [0x0, FlxColor.BLACK] : [FlxColor.BLACK, 0x0]));
		transGradient.scrollFactor.set();
		add(transGradient);

		transBlack = new FlxSprite().makeGraphic(width, height + 400, FlxColor.BLACK);
		transBlack.scrollFactor.set();
		add(transBlack);

		transGradient.x -= (width - FlxG.width) / 2;
		transBlack.x = transGradient.x;

		if (isTransIn)
			transGradient.y = transBlack.y - transBlack.height;
		else
		{
			transGradient.y = -transGradient.height;
			transBlack.y = transGradient.y - transBlack.height + 50;
		}
		leTween = FlxTween.tween(transGradient, {y: transGradient.height + 50}, duration, {
			onComplete: function(twn:FlxTween)
			{
				if (isTransIn)
					close();
				else if (finishCallback != null)
					finishCallback();
			},
			ease: FlxEase.linear
		});

		var cam = FlxG.cameras.list[FlxG.cameras.list.length - 1];
		transBlack.cameras = [cam];
		transGradient.cameras = [cam];
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (isTransIn)
			transBlack.y = transGradient.y + transGradient.height;
		else
			transBlack.y = transGradient.y - transBlack.height;
	}

	override function destroy()
	{
		if (leTween != null)
		{
			if (finishCallback != null)
				finishCallback();
			leTween.cancel();
			leTween = null;
		}

		transBlack = FlxDestroyUtil.destroy(transBlack);
		transGradient = FlxDestroyUtil.destroy(transGradient);

		super.destroy();
	}
}
