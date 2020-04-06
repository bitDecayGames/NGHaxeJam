package entities;

import flixel.math.FlxPoint;
import flixel.FlxSprite;

class OffsetSprite extends FlxSprite {
	var posOffset:FlxPoint;

	public static function newWithOffsetPoint(posOff:FlxPoint):OffsetSprite {
		return new OffsetSprite(posOff.x, posOff.y);
	}

	public static function newWithOffset(x:Float, y:Float):OffsetSprite {
		return new OffsetSprite(x, y);
	}

	private function new(x:Float, y:Float) {
		super();
		posOffset = FlxPoint.get().set(x, y);
	}

	override function setPosition(x:Float=0, y:Float=0):Void {
		super.setPosition(x - posOffset.x, y - posOffset.y);
	}
}