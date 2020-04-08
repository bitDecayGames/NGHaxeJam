package states;

import flixel.system.FlxSound;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;
import entities.Totem;
import entities.Flock;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;

class PlayState extends FlxState {
	override public function create():Void {
		bgColor = FlxColor.BLACK;
		super.create();

		var flock = new Flock();
		flock.screenCenter();
		add(flock);
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
	}
}
