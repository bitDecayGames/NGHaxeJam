package states;

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
	var align:FlxSprite;
	
	override public function create():Void
	{
		bgColor = FlxColor.RED;
		super.create();
		totem = new Totem();
		totem.screenCenter();
		add(totem);

		test = new FlxSprite();
		test.loadGraphic(AssetPaths.shot__png);
		test.setPosition(32, 32);
		test.centerOffsets(true);
		test.offset.x = 16;
		test.offset.y = 16;
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

		if (test.pixelsOverlapPoint(FlxG.mouse.getPosition())) {
			bgColor = FlxColor.BROWN;
		} else {
			bgColor = FlxColor.GRAY;
		}
	}
}
