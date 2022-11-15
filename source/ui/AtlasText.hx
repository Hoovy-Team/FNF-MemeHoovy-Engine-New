package ui;

import flixel.util.FlxDestroyUtil;
import flixel.util.FlxStringUtil;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;

class AtlasText extends FlxTypedSpriteGroup<AtlasChar>
{
	static var fonts:Map<String, AtlasFontData> = new Map<String, AtlasFontData>();

	public static function clearCache()
	{
		for (key => font in fonts)
		{
			fonts.remove(key);
			FlxDestroyUtil.destroy(font);
		}
	}

	public var text(default, set):String = '';
	public var font:AtlasFontData;

	override public function new(?x:Float = 0, ?y:Float = 0, text:String, fontType:String = AtlasFont.Default)
	{
		if (!fonts.exists(fontType))
			fonts.set(fontType, new AtlasFontData(fontType));
		font = fonts.get(fontType);
		super(x, y);
		this.text = text;
	}

	function set_text(text:String = '')
	{
		var casedText:String = restrictCase(text);
		var casedTextOld:String = restrictCase(this.text);
		this.text = text;
		if (casedText == casedTextOld)
		{
			return text;
		}
		if (casedText.indexOf(casedTextOld) == 0)
		{
			appendTextCased(casedText.substr(casedTextOld.length));
			return this.text;
		}
		group.kill();
		if (casedText == '')
		{
			return this.text;
		}
		appendTextCased(casedText);
		return this.text;
	}

	public function restrictCase(text:String)
	{
		switch (font.caseAllowed)
		{
			case Both:
				return text;
			case Upper:
				return text.toUpperCase();
			case Lower:
				return text.toLowerCase();
		}
	}

	public function appendTextCased(text:String)
	{
		var length:Int = group.countLiving();
		var nextX:Float = 0;
		var nextY:Float = 0;
		if (length == -1)
		{
			length = 0;
		}
		else if (length > 0)
		{
			var char:AtlasChar = group.members[length - 1];
			nextX = char.x + char.width - x;
			nextY = char.y + char.height - font.maxHeight - y;
		}
		var split:Array<String> = text.split('');
		for (char in split)
		{
			switch (char)
			{
				case '\n':
					nextX = 0;
					nextY += font.maxHeight;
				case ' ':
					nextX += 40;
				default:
					var spr:AtlasChar;
					if (length >= group.members.length)
					{
						spr = new AtlasChar(null, null, font.atlas, char);
					}
					else
					{
						spr = group.members[length];
						spr.revive();
						spr.char = char;
						spr.alpha = 1;
					}
					spr.x = nextX;
					spr.y = nextY + font.maxHeight - spr.height;
					add(spr);
					nextX += spr.width;
					length++;
			}
		}
	}

	override public function toString()
	{
		var x:LabelValuePair = LabelValuePair.weak('x', this.x);
		var y:LabelValuePair = LabelValuePair.weak('y', this.y);
		var text:LabelValuePair = LabelValuePair.weak('text', this.text);
		return 'InputItem, ' + FlxStringUtil.getDebugString([x, y, text]);
	}
}

class AtlasFontData implements IFlxDestroyable
{
	static var upperChar:EReg = new EReg('^[A-Z]\\d+$', '');
	static var lowerChar:EReg = new EReg('^[a-z]\\d+$', '');

	public var atlas(default, null):FlxAtlasFrames;
	public var maxHeight(default, null):Float = 0;
	public var caseAllowed(default, null):Case = Both;

	public function new(font:String)
	{
		atlas = Paths.getSparrowAtlas('fonts/' + font.toLowerCase());

		var hasUpper:Bool = false;
		var hasLower:Bool = false;
		for (framedata in atlas.frames)
		{
			maxHeight = Math.max(maxHeight, framedata.frame.height);
			if (!hasUpper)
				hasUpper = upperChar.match(framedata.name);
			if (!hasLower)
				hasLower = lowerChar.match(framedata.name);
		}
		if (hasUpper != hasLower)
			caseAllowed = hasUpper ? Upper : Lower;
	}

	public function destroy()
	{
		atlas = FlxDestroyUtil.destroy(atlas);
	}
}
