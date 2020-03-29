package entities;

import flixel.math.FlxPoint;
import flixel.math.FlxVector;
import flixel.FlxSprite;

class SimpleShot extends FlxSprite {
	private var life:Float = 2;

	public function new(direction:FlxVector, speed:Float) {
		super();
		velocity = direction.normalize().scale(speed);
		loadGraphic(AssetPaths.shot__png);
	}

	override public function update(delta:Float):Void {
		super.update(delta);
		life -= delta;
		if (life <= 0) {
			destroy();
		}
	}
}