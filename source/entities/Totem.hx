package entities;

import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxSpriteUtil.DrawStyle;
import flixel.util.FlxSpriteUtil.LineStyle;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;
import flixel.FlxSprite;

using flixel.util.FlxSpriteUtil;

class Totem extends FlxSpriteGroup {
	var highlightCircle:FlxSprite;
	var totem:FlxSprite;

	var shotSpeed:Float = 1;
	var shotTimer:Float = 1;
	
	public function new() {
		super();
		totem = new FlxSprite();
		totem.loadGraphic(AssetPaths.dock_totem__png, false, 64, 64);

		highlightCircle = new FlxSprite();
		var canvasHeight = 98;
		var canvasWidth = 162;
		highlightCircle.makeGraphic(canvasWidth, canvasHeight, FlxColor.TRANSPARENT, true);
		var lineStyle:LineStyle = {color: FlxColor.BLUE, thickness: 1};
		var drawStyle:DrawStyle = {smoothing: true};
		var circHeight = 50;
		var circWidth = 160;
		highlightCircle.drawEllipse(
			(canvasWidth-circWidth)/2, (canvasHeight-circHeight)/2,
			circWidth, circHeight,
			FlxColor.fromRGB(150, 150, 230, 128),
			lineStyle, drawStyle);
		
		// align
		highlightCircle.y = (totem.height - 10) - highlightCircle.height/2;
		totem.x = highlightCircle.origin.x - totem.width/2;
		totem.y = 1;
		
		// sort order
		add(highlightCircle);
		add(totem);
	}

	override public function update(delta:Float):Void {
		super.update(delta);
		highlightCircle.update(delta);
		totem.update(delta);

		shotTimer -= delta;
		if (shotTimer <= 0) {
			shoot();
			shotTimer += shotSpeed;
		}
	}

	function shoot():Void {
		var mousePos = FlxG.mouse.getPositionInCameraView();
		var dir = mousePos.subtractPoint(totem.getPosition());
		var newShot = new SimpleShot(dir, 100);
	
		add(newShot);
	}
}