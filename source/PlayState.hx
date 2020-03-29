package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;

class PlayState extends FlxState
{
	var totem:FlxSprite; 
	
	override public function create():Void
	{
		super.create();
		totem = new FlxSprite();
		totem.x = FlxG.width/2;
		totem.y = FlxG.height/2;
		totem.loadGraphic(AssetPaths.dock_totem__png, false, 64, 64);
		add(totem);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
