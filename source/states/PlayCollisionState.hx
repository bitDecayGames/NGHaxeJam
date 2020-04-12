package states;

import flixel.group.FlxGroup;
import flixel.util.FlxCollision;
import flixel.util.FlxSpriteUtil.DrawStyle;
import flixel.util.FlxSpriteUtil.LineStyle;
import flixel.util.FlxColor;
import entities.Totem;
import entities.Spawner;
import entities.Player;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;

using flixel.util.FlxSpriteUtil;

import audio.BitdecaySoundBank;

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
	
	var buildSoundId:Int = 0;

	override public function create():Void
	{
		FlxG.debugger.visible = true;
		FlxG.debugger.drawDebug = true;
		bgColor = FlxColor.BLACK;
		super.create();

		projectiles = new FlxGroup();
		enemies = new FlxGroup();
		characters = new FlxGroup();
		towers = new FlxGroup();

		add(projectiles);
		add(enemies);
		add(characters);
		add(towers);


		totem = new Totem(1, projectiles);
		totem.screenCenter();
		totem.x += 50;
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

		var spawner = new Spawner(2, enemies);
		spawner.setPosition(FlxG.width/2, 100);
		add(spawner);

		var player = new Player();
		player.setPosition(100, 100);
		add(player);
		
		BitdecaySoundBank.Instance().PlaySongIfNonePlaying(BitdecaySongs.BattleForHome);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		test2.setPosition(FlxG.mouse.x, FlxG.mouse.y);

		// bgColor = FlxColor.fromRGB(20, 20, 20);
		FlxG.overlap(enemies, projectiles, damage, checkHit);
		FlxG.overlap(enemies, towers, addTarget, checkHit);

		if (FlxG.mouse.justPressed) {
			// BitdecaySoundBank.Instance().PlaySound(BitdecaySounds.Shoot);
			// BitdecaySoundBank.Instance().PlaySound(BitdecaySounds.Arrow);
			if (buildSoundId == 0){
				buildSoundId = BitdecaySoundBank.Instance().PlaySoundLooped(BitdecaySounds.Build);
			}
		}
		if (FlxG.mouse.justPressedRight) {
			if (buildSoundId != 0){
				BitdecaySoundBank.Instance().StopSoundLooped(buildSoundId);
				buildSoundId = 0;
			}
		}
		BitdecaySoundBank.Instance().Update();
	}

	private function checkHit(a:FlxSprite, b:FlxSprite):Bool {
		// bgColor = FlxColor.BROWN;
		return FlxG.pixelPerfectOverlap(a, b, 1);
	}

	private function damage(enemy:FlxSprite, bullet:FlxSprite):Void {
		trace("A collision happened between " + enemy + " and " + bullet);
		bullet.kill();
		enemy.hurt(1);
	}

	private function addTarget(enemy:FlxSprite, zone:FlxSprite):Void {
		totem.addTarget(enemy);
		// bgColor = FlxColor.GRAY;
	}
}
