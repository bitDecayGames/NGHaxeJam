package;

import states.MainMenuState;
import states.PlayState;
import states.PlayCollisionState;
import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite {
	public function new() {
		super();
		addChild(new FlxGame(0, 0, PlayCollisionState));
	}
}
