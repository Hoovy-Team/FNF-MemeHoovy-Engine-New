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

class MemoryTools {
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

    // made these easier ig because fuck it, why not?
    inline public static function clearCache():Void
    {
        FlxG.bitmap.clearCache();
    }

    inline static public function dumpCache():Void
    {
        FlxG.bitmap.dumpCache();
    }

    inline static public function unDumpCache():Void
    {
        FlxG.bitmap.undumpCache();
    }

    inline public static function clearUnusedCache():Void
    {
        FlxG.bitmap.clearUnused();
    }    
}