package entities;

import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxSpriteUtil.DrawStyle;
import flixel.util.FlxSpriteUtil.LineStyle;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import render.WorldConstants;

using flixel.util.FlxSpriteUtil;

class ISelectable extends FlxSpriteGroup {
	private var _range:FlxSprite;
	private var _isSelected:Bool;

	public function new(radius:Float) {
		super();
		_range = new FlxSprite();

		var rangeRadii = 32;
		var rangeWidth = rangeRadii * 2;
		var rangeHeight = Std.int(rangeRadii * 2 * WorldConstants.HEIGHT_RATIO);
		_range = new FlxSprite();
		_range.makeGraphic(rangeWidth, rangeHeight, FlxColor.TRANSPARENT, true);
		var lineStyle:LineStyle = {color: FlxColor.RED, thickness: 1};
		var drawStyle:DrawStyle = {smoothing: true};
		_range.drawEllipse(0, 0, rangeWidth, rangeHeight, FlxColor.fromRGB(255, 0, 0, 128), lineStyle, drawStyle);
		_range.x = _range.width / -2;
		
		add(_range);

		_isSelected = false;
		_range.visible = _isSelected;
	}

	override public function update(delta:Float):Void {
		super.update(delta);
		if (FlxG.mouse.justPressed) {
			_isSelected = FlxG.mouse.overlaps(this);
			_range.visible = _isSelected;
		}
	}

	public function setHighlightYOffset(y:Float):Void {
		// Assumes that all objects are as deep as they are wide
		// Aligns the center of this selectable with where the center should
		//  roughly be
		_range.y = width / 2 - _range.height / 2 - width * WorldConstants.HEIGHT_RATIO / 2;
	}
}
