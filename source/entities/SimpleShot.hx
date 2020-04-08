package entities;

import flixel.math.FlxPoint;
import flixel.math.FlxVector;
import flixel.FlxSprite;

class SimpleShot extends FlxSprite {
	public function new(direction:FlxVector, speed:Float, life:Float) {
		super();
		health = life;
		velocity = direction.normalize().scale(speed);
		loadGraphic(AssetPaths.projectiles_2__png);
	}

	override public function update(delta:Float):Void {
		super.update(delta);
		hurt(delta);
	}

	override public function kill() {
		destroy();
	}
}
