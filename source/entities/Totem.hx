package entities;

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

	var shotSpeed:Float = 1;
	var shotTimer:Float = 1;

	public function new(shotSpeed:Float) {
		super();
		totem = new FlxSprite();
		totem.loadGraphic(AssetPaths.dock_totem__png, false, 64, 64);
		totem.x = totem.width / -2.0;
		totem.y = totem.height / -2.0;

		setHighlightYOffset(totem.height / 2.0);

		add(totem);
		this.shotSpeed = shotSpeed;
		shotTimer = shotSpeed;
	}

	override public function update(delta:Float):Void {
		super.update(delta);
		shotTimer -= delta;
		if (shotTimer <= 0) {
			shoot();
			shotTimer += shotSpeed;
		}
	}

	function shoot():Void {
		var mousePos = FlxG.mouse.getPositionInCameraView();
		var dir = mousePos.subtractPoint(getPosition());
		var newShot = new SimpleShot(dir, 1000, 0.25);
		newShot.x = newShot.width / -2.0;
		newShot.y = newShot.height / -2.0;
		add(newShot);
	}
}
