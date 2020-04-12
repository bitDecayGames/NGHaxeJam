package states;

import audio.BitdecaySound;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;
import entities.Totem;
import entities.Flock;
import flixel.FlxG;
import flixel.FlxState;

import audio.BitdecaySoundBank;

class PlayState extends FlxState {
	var totem:Totem;
	// var sound:BitdecaySound;

	var bullets:FlxGroup;

	override public function create():Void {
		bgColor = FlxColor.BLACK;
		super.create();

		bullets = new FlxGroup();
		add(bullets);

		totem = new Totem(0.1, bullets);
		totem.screenCenter();
		add(totem);

		var totem2 = new Totem(0.8, bullets);
		totem2.setPosition(totem.x + 100, totem.y + 10);
		add(totem2);

		var flock = new Flock();
		flock.screenCenter();
		add(flock);

		BitdecaySoundBank.Instance().PlaySongIfNonePlaying(BitdecaySongs.MainTheme);
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		if (FlxG.mouse.justPressed) {
			BitdecaySoundBank.Instance().PlaySound(BitdecaySounds.Shoot);
		}
	}
}
