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
	private var radius:Int;
	private var _range:FlxSprite;
	private var _isSelected:Bool;

	public function new(radius:Int) {
		super();
		this.radius = radius;

		_range = new FlxSprite();
		var rangeWidth = radius * 2;
		var rangeHeight = Std.int(radius * 2 * WorldConstants.HEIGHT_RATIO);
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

	public function setHighlightYOffset(visualReference:FlxSprite):Void {
		// Assumes that all objects are as deep as they are wide
		// Aligns the center of this selectable with where the center should
		//  roughly be
		_range.y = visualReference.y + visualReference.height - _range.height / 2 - visualReference.width * WorldConstants.HEIGHT_RATIO / 2;
	}
}
