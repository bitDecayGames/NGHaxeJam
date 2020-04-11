package entities;

import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.FlxSprite;

class Spawner extends FlxSprite {
	private var spawnSpacing:Float;
	private var timer:Float;
	private var group:FlxGroup;

	private var spawnCount:Int;

	public function new(spacingSeconds:Float, enemyGroup:FlxGroup) {
		super();
		spawnSpacing = spacingSeconds;
		group = enemyGroup;
	}

	override public function update(delta:Float):Void {
		super.update(delta);

		timer -= delta;
		if (timer <= 0) {
			timer += spawnSpacing;
			spawn();
		}
	}

	private function spawn():Void {
		FlxG.watch.addQuick("Spawned: ", spawnCount++);
		var enemy = new FlxSprite();
		enemy.loadGraphic(AssetPaths.test_enemy__png);
		enemy.setPosition(this.x, this.y);
		enemy.velocity.set(0, 70);
		enemy.health = 2;
		group.add(enemy);
	}
}