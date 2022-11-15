package ui;

class TextTypedMenuItem extends MenuTypedItem
{
	override public function setItem(text:String, ?callback:Void->Void)
	{
		if (label != null)
		{
			label.text = text;
			label.alpha = alpha;
			width = label.width;
			height = label.height;
		}
		super.setItem(text, callback);
	}

	override function set_label(atlasText:AtlasText)
	{
		super.set_label(atlasText);
		setItem(name, callback);
		return atlasText;
	}
}
