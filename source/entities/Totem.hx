package entities;

import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.FlxSprite;

class Totem extends ISelectable {
	var totem:FlxSprite;

	var bullets:FlxGroup;

	var shotSpeed:Float = 1;
	var shotTimer:Float = 1;

	public function new(shotSpeed:Float, bulletGroup:FlxGroup) {
		super(32);
		bullets = bulletGroup;
		totem = new FlxSprite();
		totem.loadGraphic(AssetPaths.human_totem__png, false, 16, 32);
		totem.x = totem.width / -2.0;
		totem.y = totem.height / -2.0;

		setHighlightYOffset(totem.height / 2.0);
		
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
