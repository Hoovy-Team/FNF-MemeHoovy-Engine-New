package;

import Song.SwagSong;

typedef BPMChangeEvent =
{
	var stepTime:Int;
	var songTime:Float;
	var bpm:Int;
}

class Conductor
{
	public static var timeSignature:Array<Int> = [4, 4];
	public static var bpm:Int = 100;
	public static var crochet(default, set):Float = ((60 / bpm) * 4000) / timeSignature[1]; // beats in milliseconds
	public static var normalizedCrochet(get, never):Float;
	public static var stepCrochet(default, set):Float = crochet / 4; // steps in milliseconds
	public static var normalizedStepCrochet(get, never):Float;
	public static var songPosition:Float;
	public static var lastSongPos:Float;
	public static var offset:Float = 0;

	public static var safeFrames(default, null):Int = 10;
	public static var safeZoneOffset(default, default):Float = (safeFrames / 60) * 1000; // is calculated in create(), is safeFrames in milliseconds

	public static var bpmChangeMap:Array<BPMChangeEvent> = [];

	public function new()
	{
	}

	public static function mapBPMChanges(song:SwagSong)
	{
		bpmChangeMap = [];

		var curBPM:Int = song.bpm;
		var totalSteps:Int = 0;
		var totalPos:Float = 0;
		for (i in 0...song.notes.length)
		{
			if (song.notes[i].changeBPM && song.notes[i].bpm != curBPM)
			{
				curBPM = song.notes[i].bpm;
				var event:BPMChangeEvent = {
					stepTime: totalSteps,
					songTime: totalPos,
					bpm: curBPM
				};
				bpmChangeMap.push(event);
			}

			var deltaSteps:Int = song.notes[i].lengthInSteps;
			totalSteps += deltaSteps;
			totalPos += calculateCrochet(curBPM, timeSignature[1])/4 * deltaSteps;
		}
		trace("new BPM map BUDDY " + bpmChangeMap);
	}

	inline public static function changeBPM(newBpm:Int)
	{
		if (newBpm > 0) {
			bpm = newBpm;
			updateCrochet();
		}
	}

	inline static public function calculateCrochet(bpm:Int, denominator:Int)
	{
		return (60 / bpm) * 4000 / denominator;
	}

	static function updateCrochet() {
		crochet = calculateCrochet(bpm, timeSignature[1]);
		stepCrochet = crochet / 4;
	}

	inline static public function calculateStepCrochet()
	{
		return crochet / 4;
	}

	inline static function set_crochet(newCrotchet:Float):Float
	{
		return crochet = calculateCrochet(bpm, timeSignature[1]); // why do I oversimplify things like this?
	}

	inline static function set_stepCrochet(v:Float):Float
	{
		return stepCrochet = calculateStepCrochet();
	}

	inline static function get_normalizedCrochet():Float
	{
		return crochet * (timeSignature[1] / 4);
	}

	inline public static function get_normalizedStepCrochet():Float
	{
		return stepCrochet * (timeSignature[1] / 4);
	}

	inline static public function setTimeSignature(newSignature:Array<Int>)
	{
		final backupSignature = [4, 4];
		try
		{
			if (newSignature[0] > 0 && newSignature[1] > 0)
			{
				timeSignature = newSignature.copy();
			}
		}
		catch (e)
		{
			trace("You fubbernucked your time signature: " + newSignature.toString());
			newSignature = backupSignature.copy();
		}
	}
}
