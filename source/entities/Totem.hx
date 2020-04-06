package entities;

import Std;
import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxSpriteUtil.DrawStyle;
import flixel.util.FlxSpriteUtil.LineStyle;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;
import flixel.FlxSprite;

using flixel.util.FlxSpriteUtil;

class Totem extends ISelectable {
	var totem:FlxSprite;

	var bullets:FlxGroup;

	var shotSpeed:Float = 1;
	var shotTimer:Float = 1;

	private var _range:FlxSprite;

	private var distortion:Float = .5;

	public function new(shotSpeed:Float, bulletGroup:FlxGroup) {
		super();
		bullets = bulletGroup;
		totem = new FlxSprite();
		totem.loadGraphic(AssetPaths.human_totem__png, false, 16, 32);
		totem.x = totem.width / -2.0;
		totem.y = totem.height / -2.0;

		setHighlightYOffset(totem.height / 2.0);

		var rangeRadii = 32;
		var rangeWidth = rangeRadii * 2;
		var rangeHeight = Std.int(rangeRadii * 2 * distortion);
		_range = new FlxSprite();
		_range.makeGraphic(rangeWidth, rangeHeight, FlxColor.TRANSPARENT, true);
		var lineStyle:LineStyle = {color: FlxColor.RED, thickness: 1};
		var drawStyle:DrawStyle = {smoothing: true};
		_range.drawEllipse(0, 0, rangeWidth, rangeHeight, FlxColor.fromRGB(255, 0, 0, 128), lineStyle, drawStyle);
		_range.x = _range.width / -2;
		
		// align the range circle with where the center of the totem would be on the ground
		_range.y = totem.height / 2 - _range.height / 2 - totem.width * distortion / 2;

		// add(_highlightCircle);

		add(_range);
		add(totem);
		this.shotSpeed = shotSpeed;
		shotTimer = shotSpeed;
	}

	override public function update(delta:Float):Void {
		super.update(delta);

		_range.visible = _isSelected;

		shotTimer -= delta;
		if (shotTimer <= 0) {
			shoot();
			shotTimer += shotSpeed;
		}
	}

	function shoot():Void {
		var mousePos = FlxG.mouse.getPositionInCameraView();
		var dir = mousePos.subtractPoint(getPosition());
		var newShot = new SimpleShot(dir, 100, 5);
		newShot.x = newShot.width / -2.0 + x;
		newShot.y = newShot.height / -2.0 + y;
		bullets.add(newShot);
	}
}
