package modcharts;

import flixel.tweens.FlxTween;
import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.FlxG;

// VERY UNFINISHED CODE
// modchart support because yes (and also psych engine has modchart support soooo)

class Modchart {
    public function new() {}

    /**
     * [Description] Rotates a strum, like in some Rhythm games.
     * @param strum The strum to rotate. Might have to use `strumLineNotes.forEachAlive`
     * @param amount Amount to rotate. Example : 500
     */
    public static inline function rotateStrum(strum:FlxSprite, amount:Float):Void {
        strum.angle += Math.PI * amount;
    }

    /**
     * [Description] Rotates the strumLine, like in VDAB:Definitive Edition
     * @param strum The strum to rotate. Might have to use `strumLineNotes.forEachAlive`
     */
    public static inline function coolRotations(strum:FlxSprite):Void {
        FlxTween.tween(strum, {angle: 360}, Conductor.crochet / 1000 * 2, {ease: FlxEase.cubeInOut});
    }

    /**
     * [Description] Moves the notes in a snake-ish pattern.
     * @param note The note(s) to move.
     */
    public static inline function wigglyNotes(note:Note):Void {
        note.x = note.x + (Math.sin(FlxG.elapsed * 2) + Conductor.normalizedCrochet / 1000);
    }
}