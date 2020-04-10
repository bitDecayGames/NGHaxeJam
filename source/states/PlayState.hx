package states;

import flixel.math.FlxVector;
import flixel.system.FlxSound;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;
import entities.Totem;
import entities.Flock;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import entities.Path;
import debug.PathDebugger;

class PlayState extends FlxState {
	override public function create():Void {
		bgColor = FlxColor.BLACK;
		super.create();

		var flock = new Flock();
		flock.screenCenter();
		add(flock);

		var enemyPath = new Path();
		enemyPath.addPoint(new FlxVector(0, 0));
		enemyPath.addPoint(new FlxVector(100, 100));
		var pathDebugger = new PathDebugger();
		pathDebugger.pathToDebug = enemyPath;
		// add(pathDebugger); // todo: there is a bug with the debugger...
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
	}
}
