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
		var circHeight = 30;
		var circWidth = 80;
		_highlightCircle.makeGraphic(circWidth + 2, circHeight + 2, FlxColor.TRANSPARENT, true);
		var lineStyle:LineStyle = {color: FlxColor.BLUE, thickness: 1};
		var drawStyle:DrawStyle = {smoothing: true};
		_highlightCircle.drawEllipse(0, 0, circWidth, circHeight, FlxColor.fromRGB(150, 150, 230, 128), lineStyle, drawStyle);
		_highlightCircle.x = _highlightCircle.width / -2.0;
		_highlightCircle.y = _highlightCircle.height / -2.0;

		add(_highlightCircle);
		_isSelected = false;
		_highlightCircle.exists = _isSelected;
	}

	override public function update(delta:Float):Void {
		super.update(delta);
		if (FlxG.mouse.justPressed) {
			_isSelected = FlxG.mouse.overlaps(this);
			_highlightCircle.exists = _isSelected;
		}
	}

	public function setHighlightYOffset(y:Float):Void {
		_highlightCircle.y = _highlightCircle.height / -2.0 + y;
	}
}
