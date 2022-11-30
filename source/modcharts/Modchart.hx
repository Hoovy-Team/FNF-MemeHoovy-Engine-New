package modcharts;

import flixel.tweens.FlxTween;
import flixel.FlxSprite;
import flixel.tweens.FlxEase;

// VERY UNFINISHED CODE

class Modchart {
    public function new() {}

    /**
     * [Description] Rotates a strum, like in some Rhythm games.
     * @param strum The strum to rotate. Might have to use `strumLineNotes.forEachAlive`
     * @param amount Amount to rotate. Example : 500
     */
    public static inline function rotateStrum(strum:FlxSprite, amount:Float) {
        strum.angle += Math.PI * amount;
    }

    /**
     * [Description] Rotates the strumLine, like in VDAB:Definitive Edition
     * @param strum The strum to rotate. Might have to use `strumLineNotes.forEachAlive`
     */
    public static inline function coolRotations(strum:FlxSprite):Void {
        FlxTween.tween(strum, {angle: 360}, Conductor.crochet / 1000 * 2, {ease: FlxEase.cubeInOut});
    }
}