#if FEATURE_HSCRIPT
package;

import hscript.Interp; // wouldn't this count as an unused import? why you gotta be so weird haxe
import flixel.FlxBasic;
import hscript.*;
import openfl.Lib;

/**
 * For Hscript support, based on Wednesday's infedelity.
 * Credit: Yoshicrafter & lunarcleint.
 */
class Script extends FlxBasic
{
	public var hscript:Interp;

	public override function new()
	{
		super();
		hscript = new Interp();
	}

	public function runScript(script:String)
	{
		var parser = new hscript.Parser();

		try
		{
			var ast = parser.parseString(script);

			hscript.execute(ast);
		}
		catch (e)
		{
			Lib.application.window.alert(e.message, "HSCRIPT ERROR!1111");
		}
	}

	public inline function setVariable(name:String, val:Dynamic)
	{
		hscript.variables.set(name, val);
	}

	public inline function getVariable(name:String):Dynamic
	{
		return hscript.variables.get(name);
	}

	public inline function variableExists(name:String):Dynamic
	{
		return hscript.variables.exists(name);
	}

	public function executeFunc(funcName:String, ?args:Array<Any>):Dynamic
	{
		if (hscript == null)
			return null;

		if (hscript.variables.exists(funcName))
		{
			var func = hscript.variables.get(funcName);
			if (args == null)
			{
				var result = null;
				try
				{
					result = func();
				}
				catch (e)
				{
					trace('$e');
				}
				return result;
			}
			else
			{
				var result = null;
				try
				{
					result = Reflect.callMethod(null, func, args);
				}
				catch (e)
				{
					trace('$e');
				}
				return result;
			}
		}
		return null;
	}

	public override function destroy()
	{
		super.destroy();
		hscript = null;
	}
}
#end

// Based on Psych engine Extra
// @author Starmapo
// @co-author MemeHoovy
#if FEATURE_HSCRIPT
class HscriptTools extends Interp
{
	var useDefaultVars = false;

	public function new() {
		if (useDefaultVars)
			defaultVars();

		super();
	}

	public function defaultVars(){
		// haxe variables
		variables.set('Math', Math);
		variables.set('Std', Std);
		variables.set('Type', Type);
		variables.set('FlxBasic', FlxBasic);

		// FNF variables
		variables.set('curBpm', Conductor.bpm);
		variables.set('bpm', Conductor.bpm);
		variables.set('crochet', Conductor.crochet);
		variables.set('stepCrochet', Conductor.stepCrochet);
		variables.set('signatureNumerator', Conductor.timeSignature[0]);
		variables.set('signatureDenominator', Conductor.timeSignature[1]);
		variables.set('scrollSpeed', PlayState.SONG.speed);
		variables.set('isStoryMode', PlayState.isStoryMode);
		variables.set('difficulty', PlayState.storyDifficulty);
	}
}
#end