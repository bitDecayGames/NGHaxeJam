package states;

import flixel.util.FlxColor;
import entities.Totem;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;

class PlayState extends FlxState {
	var totem:Totem;

	override public function create():Void {
		bgColor = FlxColor.RED;
		super.create();
		totem = new Totem(0.1);
		totem.screenCenter();
		add(totem);

		var totem2 = new Totem(0.8);
		totem2.setPosition(totem.x + 100, totem.y + 10);
		add(totem2);
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
	}
}
