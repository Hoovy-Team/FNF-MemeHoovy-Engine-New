/*
 * Apache License, Version 2.0
 *
 * Copyright (c) 2022 MemeHoovy
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at:
 *     http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/**
 * A class that helps optimize the game.
 */
package;

#if cpp
import cpp.NativeGc;
import cpp.vm.Gc;
#elseif hl
import hl.Gc;
#elseif java
import java.vm.Gc;
#elseif neko
import neko.vm.Gc;
#end
import flixel.FlxG;
import openfl.Assets;

class MemoryTools {
	inline public static function clearMinor() {
		#if (cpp || java || neko)
		Gc.run(false);
		#end
	}

	inline public static function runGC():Void
	{
		#if cpp
		NativeGc.compact();
		NativeGc.run(true);
		#elseif hl
		Gc.major();
		#elseif (java || neko)
		Gc.run(true);
		#end
	}

    inline public static function disableGC():Void
    {
        #if (cpp || hl)
        Gc.enable(false);
        #end
    }

    inline public static function totalMemoryUsed(){
		#if cpp
		return Gc.memInfo64(Gc.MEM_INFO_USAGE);
		#elseif sys
		return System.totalMemory;
		#else
		return openfl.system.System.totalMemory;
		#end
    }

    // basically openfl garbage collector
    inline public static function takeOutTheTrash():Void
    {
        openfl.system.System.gc();
    }

	// taken from forever engine, cuz optimization very pog.
	// thank you shubs :)
    // I took this from kade engine >:)
	public static function dumpCache()
	{
		///* SPECIAL THANKS TO HAYA
		@:privateAccess
		for (key in FlxG.bitmap._cache.keys())
		{
			var obj = FlxG.bitmap._cache.get(key);
			if (obj != null)
			{
				Assets.cache.removeBitmapData(key);
				FlxG.bitmap._cache.remove(key);
				obj.destroy();
			}
		}
		Assets.cache.clear("songs");
		// */
	}
}