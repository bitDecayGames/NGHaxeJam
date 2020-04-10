package debug;

import flixel.FlxSprite;
import entities.Path;

using flixel.util.FlxSpriteUtil;

class PathDebugger extends FlxSprite {
	public var pathToDebug:Path;

	public function new() {
		super();
	}

	override public function update(delta:Float):Void {
		super.update(delta);
		if (pathToDebug.points.length > 1) {
			for (i in 1...pathToDebug.points.length) {
				var a = pathToDebug.points[i - 1];
				var b = pathToDebug.points[i];
				FlxSpriteUtil.drawLine(this, a.x, a.y, b.x, b.y);
			}
		}
	}
}
