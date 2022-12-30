package polymod.backends;

#if polymod

import haxe.io.Bytes;
import polymod.Polymod.FrameworkParams;
import polymod.backends.PolymodAssets.PolymodAssetType;
import polymod.backends.PolymodAssetLibrary;

class StubBackend implements IBackend
{
	public var polymodLibrary:PolymodAssetLibrary;

	public function new()
	{
	}

	public function init(?params:FrameworkParams):Bool
	{
		return false;
	}

	public function destroy():Void
	{
	}

	public function clearCache():Void
	{
	}

	public function exists(id:String):Bool
	{
		return false;
	}

	public function get(id:String):Bool
	{
		return false;
	}

	public function getBytes(id:String):Bytes
	{
		return null;
	}

	public function getText(id:String):String
	{
		return null;
	}

	public function getPath(id:String):String
	{
		return null;
	}

	public function list(type:PolymodAssetType = null):Array<String>
	{
		return [];
	}

	public function stripAssetsPrefix(id:String):String
	{
		return id;
	}
}
#end