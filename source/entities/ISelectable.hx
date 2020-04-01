package entities;

import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxSpriteUtil.DrawStyle;
import flixel.util.FlxSpriteUtil.LineStyle;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;
import flixel.FlxSprite;

using flixel.util.FlxSpriteUtil;

class ISelectable extends FlxSpriteGroup {
	private var _highlightCircle:FlxSprite;
	private var _isSelected:Bool;

	public function new() {
		super();
		_highlightCircle = new FlxSprite();
		var canvasHeight = 98;
		var canvasWidth = 162;
		_highlightCircle.makeGraphic(canvasWidth, canvasHeight, FlxColor.TRANSPARENT, true);
		var lineStyle:LineStyle = {color: FlxColor.BLUE, thickness: 1};
		var drawStyle:DrawStyle = {smoothing: true};
		var circHeight = 50;
		var circWidth = 160;
		_highlightCircle.drawEllipse((canvasWidth - circWidth) / 2, (canvasHeight - circHeight) / 2, circWidth, circHeight,
			FlxColor.fromRGB(150, 150, 230, 128), lineStyle, drawStyle);
		_highlightCircle.x = _highlightCircle.width / -2.0;
		_highlightCircle.y = _highlightCircle.height / -2.0;

		add(_highlightCircle);
		_highlightCircle.alpha = 0;
		_isSelected = false;
	}

	override public function update(delta:Float):Void {
		super.update(delta);
		if (FlxG.mouse.justPressed) {
			_isSelected = FlxG.mouse.overlaps(this);
			if (_isSelected) {
				_highlightCircle.alpha = 1;
			} else {
				_highlightCircle.alpha = 0;
			}
		}
	}

	public function setHighlightYOffset(y:Float):Void {
		_highlightCircle.y = _highlightCircle.height / -2.0 + y;
	}
}
