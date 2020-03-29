package entities;

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
	
	public function new() {
		super();
		totem = new FlxSprite();
		totem.loadGraphic(AssetPaths.dock_totem__png, false, 64, 64);

		highlightCircle = new FlxSprite();
		highlightCircle.makeGraphic(162, 98, FlxColor.TRANSPARENT, true);
		var lineStyle:LineStyle = {color: FlxColor.BLUE, thickness: 1};
		var drawStyle:DrawStyle = {smoothing: true};
		var circHeight = 50;
		var circWidth = 160;
		highlightCircle.drawEllipse(
			(162-circWidth)/2, (98-circHeight)/2,
			circWidth, circHeight,
			FlxColor.fromRGB(150, 150, 230, 128),
			lineStyle, drawStyle);
		
		// align
		highlightCircle.y = (totem.height - 10) - highlightCircle.height/2;
		totem.x = highlightCircle.origin.x - totem.width/2;
		
		// sort order
		add(highlightCircle);
		add(totem);
	}

	override public function update(delta:Float):Void {
		highlightCircle.update(delta);
		totem.update(delta);
	}
}