package actions;

import flixel.input.keyboard.FlxKey;
import flixel.input.actions.FlxAction.FlxActionDigital;

class Actions {

	var up = new FlxActionDigital();
	var down = new FlxActionDigital();
	var left = new FlxActionDigital();
	var right = new FlxActionDigital();
	var confirm = new FlxActionDigital();

	public function new() {
		up.addKey(FlxKey.W, PRESSED);
		up.addKey(FlxKey.UP, PRESSED);
		
		down.addKey(FlxKey.S, PRESSED);
		down.addKey(FlxKey.DOWN, PRESSED);
		
		left.addKey(FlxKey.A, PRESSED);
		left.addKey(FlxKey.LEFT, PRESSED);
		
		right.addKey(FlxKey.D, PRESSED);
		right.addKey(FlxKey.RIGHT, PRESSED);
		
		confirm.addKey(FlxKey.SPACE, PRESSED);
	}
}