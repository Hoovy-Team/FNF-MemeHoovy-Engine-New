/*
 * Apache License, Version 2.0
 *
 * Copyright (c) 2022 MemeHoovy & 504brandon & Wither362
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

package;

import haxe.Json;
import haxe.Exception;
import openfl.utils.Assets;
#if polymod
import polymod.Polymod;
import polymod.format.ParseRules.JSONParseFormat;
#end

class JsonTools extends JSONParseFormat
{
	/**
	 * [Description] Loads a JSON file from the specified path.
	 * @param json The JSON file to load.
	 * @param library The library for the location of the JSON file.
	 */
	public static function loadJSON(json:String, ?library:String)
	{
		var jsonPath = Assets.getText(Paths.jsonAnywhere(json, library));

		if (!Assets.exists(jsonPath))
			return null;

		try
		{
			var jsonParsed = Json.parse(jsonPath);
			//
			return jsonParsed;
		}
		catch (e)
		{
			throw e;
		}
	}

	/**
	 * [Description] Loads a JSON file from the specified path. (But does not include safety measures.)
	 * @param json The JSON file to load.
	 * @param library The library for the location of the JSON file.
	 */
	public static function unsafeLoadJSON(json:String, ?library:String)
	{
		var jsonPath = Assets.getText(Paths.jsonAnywhere(json, library));

		if (!Assets.exists(jsonPath))
			return null;

		var jsonParsed = Json.parse(jsonPath);
		return jsonParsed;
	}

	/**
	 * [Description] Loads a JSON file from the specified path & converts it into a string.
	 * @param json The JSON file to load.
	 * @param library The library for the location of the JSON file.
	 */
	public static function StringifyJSON(json:String, ?library:String):Null<String>
	{
		var jsonPath = Assets.getText(Paths.jsonAnywhere(json, library));

		if (!Assets.exists(jsonPath)) return null;

		var jsonParsed = Json.parse(jsonPath);
		var stringedJSON = Json.stringify(jsonParsed);

		return stringedJSON;
		/*else if (Std.isOfType(StringedJSON, Json)){
				throw new Exception('Invalid Stringed JSON: ' + Json.stringify(stringedJSON));
			}
			else if (!Std.isOfType(StringedJSON, String)){
				throw new Exception('Unknown Stringed JSON: ' + stringedJSON);
			}
			else
				return null; */
	}

	/**
	 * [Description] Loads a JSON file from the specified path & converts it into a string. (But without safety measures).
	 * @param json The JSON file to load.
	 * @param library The library for the location of the JSON file.
	 */
	public static function unsafeStringifyJSON(json:String, ?library:String):Null<String>
	{
		var jsonPath = Assets.getText(Paths.jsonAnywhere(json, library));

		if (!Assets.exists(jsonPath))
			return null;

		var jsonParsed = Json.parse(jsonPath);

		var stringedJSON = Json.stringify(jsonParsed);

		return stringedJSON;
	}

	#if polymod
	override private function _mergeObjects(a:Dynamic, b:Dynamic, signatureSoFar:String = ''):Dynamic
	{
		if (Std.isOfType(a, Array) && Std.isOfType(b, Array))
		{
			// if they are both arrays, merge the values cuz fuck you regular polymod :3

			var c:Array<Dynamic> = [];

			var d:Array<Dynamic> = a;
			var e:Array<Dynamic> = b;

			for (x in d)
			{
				c.push(x);
			}

			for (x in e)
			{
				c.push(x);
			}

			return c;
		}
		else if (!Std.isOfType(a, Array) && !Std.isOfType(b, Array))
		{
			var aPrimitive = isPrimitive(a);
			var bPrimitive = isPrimitive(b);

			if (aPrimitive && bPrimitive)
			{
				// if they are both primitives, stomp with b
				return b;
			}
			else if (aPrimitive != bPrimitive)
			{
				// if they are incompatible, stomp with a
				return a;
			}
			else
			{
				// if they are both objects, merge their values
				for (field in Reflect.fields(b))
				{
					if (Reflect.hasField(a, field))
					{
						// If a & b share a field, merge that field recursively
						var aValue = Reflect.field(a, field);
						var bValue = Reflect.field(b, field);
						var mergedValue = copyVal(_mergeObjects(aValue, bValue, '$signatureSoFar.$field'));

						Reflect.setField(a, field, mergedValue);
					}
					else
					{
						// If b has a field that a doesn't have, add it to a
						Reflect.setField(a, field, Reflect.field(b, field));
					}
				}
			}
		}
		else
		{
			// if they're incompatible types, return a
			var aArr = Std.isOfType(a, Array) ? 'array' : 'object';
			var bArr = Std.isOfType(b, Array) ? 'array' : 'object';

			Polymod.warning(MERGE, "JSON can't merge @ (" + signatureSoFar + ") because base is (" + aArr + ") but payload is (" + bArr + ')');
		}

		return a;
	}
	}
	#end
