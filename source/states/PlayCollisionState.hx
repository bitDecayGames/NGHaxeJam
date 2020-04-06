package states;

import flixel.group.FlxGroup;
import flixel.util.FlxCollision;
import flixel.util.FlxSpriteUtil.DrawStyle;
import flixel.util.FlxSpriteUtil.LineStyle;
import flixel.util.FlxColor;
import entities.Totem;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;

using flixel.util.FlxSpriteUtil;

class PlayCollisionState extends FlxState
{
	var totem:Totem;
	var test:FlxSprite;
	var test2:FlxSprite;
	var align:FlxSprite;

	var projectiles:FlxGroup; // all of the projectiles
	var enemies:FlxGroup; // all of the enemies
	var characters:FlxGroup; // all of the characters
	var towers:FlxGroup; // all of the tower sprites
	
	override public function create():Void
	{
		FlxG.debugger.visible = true;
		FlxG.debugger.drawDebug = true;
		bgColor = FlxColor.RED;
		super.create();

		projectiles = new FlxGroup();
		enemies = new FlxGroup();
		characters = new FlxGroup();
		towers = new FlxGroup();

		add(projectiles);
		add(enemies);
		add(characters);
		add(towers);


		totem = new Totem(10, projectiles);
		totem.screenCenter();
		towers.add(totem);

		test2 = new FlxSprite();
		test2.loadGraphic(AssetPaths.shot__png);
		test2.setPosition(32, 32);
		test2.centerOffsets(true);
		enemies.add(test2);

		test = new FlxSprite();
		test.loadGraphic(AssetPaths.shot__png);
		test.setPosition(32, 32);
		test.centerOffsets(true);
		enemies.add(test);

		align = new FlxSprite();
		var canvasHeight = 32;
		align.makeGraphic(canvasHeight, canvasHeight, FlxColor.TRANSPARENT, true);
		var lineStyle:LineStyle = {color: FlxColor.BLUE, thickness: 1};
		var drawStyle:DrawStyle = {smoothing: true};
		align.drawRect(0, 0, canvasHeight, canvasHeight, FlxColor.GREEN, lineStyle, drawStyle);
		add(align);
		align.setPosition(0,0);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		test2.setPosition(FlxG.mouse.x, FlxG.mouse.y);

		bgColor = FlxColor.fromRGB(20, 20, 20);
		FlxG.overlap(enemies, projectiles, damage, checkHit);
		FlxG.overlap(enemies, towers, addTarget, checkHit);
	}

	private function checkHit(a:FlxSprite, b:FlxSprite):Bool {
		bgColor = FlxColor.BROWN;
		return FlxG.pixelPerfectOverlap(a, b, 1);
	}

	private function damage(enemy:FlxSprite, bullet:FlxSprite):Void {
		trace("A collision happened between " + enemy + " and " + bullet);
		bullet.kill();
	}

	private function addTarget(enemy:FlxSprite, zone:FlxSprite):Void {
		bgColor = FlxColor.GRAY;
	}
}
