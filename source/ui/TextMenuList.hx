package ui;

import ui.MenuTypedList;

class TextMenuList extends MenuTypedList<TextMenuItem>
{
	public function createItem(?x:Float = 0, ?y:Float = 0, text:String, font:String = AtlasFont.Bold, ?callback:Void->Void, ?fireInstantly:Bool = false)
	{
		var item:TextMenuItem = new TextMenuItem(x, y, text, font, callback);
		item.fireInstantly = fireInstantly;
		return addItem(text, item);
	}
}
