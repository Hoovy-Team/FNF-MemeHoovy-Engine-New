package;

import flixel.FlxState;
import Conductor.BPMChangeEvent;
import flixel.FlxG;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.ui.FlxUIState;
import flixel.math.FlxRect;
import flixel.util.FlxTimer;

#if GAMEJOLT_ALLOWED
import gamejolt.GJClient;
#end

class MusicBeatState extends FlxUIState
{
	private var curStep:Int = 0;
	private var curBeat:Int = 0;
	private var controls(get, never):Controls;

	#if GAMEJOLT_ALLOWED
	private static var pingTrigger:FlxTimer;
	#end

	inline function get_controls():Controls
		return PlayerSettings.player1.controls;

	override function create()
	{
		destroySubStates = false; // Avoid Crashing with SubMenus on theur reutilization
		if (transIn != null)
			trace('reg ' + transIn.region);

		super.create();
	}

	override function update(elapsed:Float)
	{
		// everyStep();
		var oldStep:Int = curStep;

		updateCurStep();
		updateBeat();

		if (oldStep != curStep && curStep > 0)
			stepHit();

		if (FlxG.stage != null)
			if (FlxG.stage.frameRate != 150)
				FlxG.stage.frameRate = 150;

		#if GAMEJOLT_ALLOWED
		pingTrigger = new FlxTimer();
		pingTrigger.start(5, function (tmr:FlxTimer) {GJClient.pingSession();}, 0);
		#end

		super.update(elapsed);
	}

	private function updateBeat():Void
	{
		curBeat = Math.floor(curStep / 4);
	}

	private function updateCurStep():Void
	{
		var lastChange:BPMChangeEvent = {
			stepTime: 0,
			songTime: 0,
			bpm: 0
		}
		for (i in 0...Conductor.bpmChangeMap.length)
		{
			if (Conductor.songPosition >= Conductor.bpmChangeMap[i].songTime)
				lastChange = Conductor.bpmChangeMap[i];
		}

		curStep = lastChange.stepTime + Math.floor((Conductor.songPosition - lastChange.songTime) / Conductor.stepCrochet);
	}

	public static function switchState(nextState:FlxState)
	{
		#if GAMEJOLT_ALLOWED
		if (pingTrigger.active)
		{
			pingTrigger.cancel();
			pingTrigger.destroy();
		}
		#end

		FlxG.switchState(nextState);
	}

	public function stepHit():Void
	{
		if (curStep % 4 == 0)
			beatHit();
	}

	public function beatHit():Void
	{
		// do literally nothing dumbass
	}
}
