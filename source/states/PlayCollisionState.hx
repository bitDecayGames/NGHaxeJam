package states;

import flixel.util.FlxCollision;
import flixel.util.FlxSpriteUtil.DrawStyle;
import flixel.util.FlxSpriteUtil.LineStyle;
import flixel.util.FlxColor;
import entities.Totem;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;

using flixel.util.FlxSpriteUtil;

class PlayState extends FlxState
{
	var totem:Totem;
	var test:FlxSprite;
	var test2:FlxSprite;
	var align:FlxSprite;
	
	override public function create():Void
	{
		FlxG.debugger.visible = true;
		FlxG.debugger.drawDebug = true;
		bgColor = FlxColor.RED;
		super.create();
		totem = new Totem();
		totem.screenCenter();
		add(totem);

		test2 = new FlxSprite();
		test2.loadGraphic(AssetPaths.shot__png);
		test2.setPosition(32, 32);
		test2.centerOffsets(true);
		add(test2);

		test = new FlxSprite();
		test.loadGraphic(AssetPaths.shot__png);
		test.setPosition(32, 32);
		test.centerOffsets(true);
		add(test);

		align = new FlxSprite();
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

		
		if (FlxCollision.pixelPerfectCheck(test, test2)) {
			bgColor = FlxColor.BROWN;
		} else if (test.overlaps(test2)) {
			bgColor = FlxColor.GRAY;
		} else {
			bgColor = FlxColor.fromRGB(20, 20, 20);
		}
	}
}
