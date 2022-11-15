package ui;

class OptionsMenu extends Page
{
	var items:TextMenuList;

	override public function new()
	{
		super();
		add(items = new TextMenuList());
		createLinkedItem('preferences');
		createLinkedItem('controls');
		createItem('exit', exit);
	}

	public function createItem(label:String, ?callback:Void->Void)
	{
		var item:TextMenuItem = items.createItem(0, 100 + 100 * items.length, label, AtlasFont.Bold, callback);
		item.screenCenter(X);
		return item;
	}

	public function createLinkedItem(label:String, ?page:String)
	{
		if (page == null)
			page = label;
		return createItem(label, function()
		{
			onSwitch.dispatch(page);
		});
	}

	override function set_enabled(state:Bool)
	{
		items.enabled = state;
		return super.set_enabled(state);
	}
}
