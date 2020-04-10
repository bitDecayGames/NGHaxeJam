package audio;

import flixel.system.FlxSound;
import entities.ISelectable;
import sys.FileSystem;
import Std;
import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxSpriteUtil.DrawStyle;
import flixel.util.FlxSpriteUtil.LineStyle;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;
import flixel.FlxSprite;

using flixel.util.FlxSpriteUtil;

class BitdecaySound {

	public var flxSounds:Array<FlxSound> = new Array();

	public function new(soundPath:String, MaxConcurrent:Int = 1) {

		var exists = FileSystem.exists(soundPath);
		if (!exists) {
			throw 'Unable to find sound file: $soundPath';
		}

		for (i in 0...MaxConcurrent) {
			flxSounds.push(FlxG.sound.load(soundPath));
		}

	}

	public function play() {
		for (flxSound in flxSounds) {
			if (!flxSound.playing){
				flxSound.play();
				return;
			}
		}

		// If everything is currently playing, just reset the first one
		flxSounds[0].play(true);
	}
}
