package entities;

import flixel.math.FlxPoint;
import flixel.math.FlxVector;
import flixel.FlxSprite;

class SimpleShot extends FlxSprite {
	private var target:FlxSprite;
	private var direction:FlxPoint;
	private var speed:Float;

	public function new(target:FlxSprite, speed:Float) {
		super();
		this.target = target;
		direction = FlxPoint.get();
		this.speed = speed;
		loadGraphic(AssetPaths.projectiles_2__png);
	}

	override public function update(delta:Float):Void {
		super.update(delta);
		target.getGraphicMidpoint(direction);
		velocity = cast (direction.subtractPoint(getGraphicMidpoint()), FlxVector).normalize().scale(speed);
	}

	override public function kill() {
		direction.put();
		destroy();
	}
}
