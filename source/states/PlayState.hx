package states;

import entities.Totem;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;

class PlayState extends FlxState
{
	var totem:Totem; 
	
	override public function create():Void
	{
		super.create();
		totem = new Totem();
		totem.screenCenter();
		add(totem);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
