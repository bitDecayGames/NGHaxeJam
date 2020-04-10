package entities;

import flixel.math.FlxVector;

class Path {
	public var points:Array<FlxVector>;

	private var zero:FlxVector;

	public function new() {
		points = new Array<FlxVector>();
		zero = new FlxVector(0, 0);
	}

	public function addPoint(point:FlxVector):Void {
		points.push(point);
	}

	public function nearestPointOnLineFrom(p:FlxVector):FlxVector {
		if (points.length <= 1) {
			return new FlxVector(p.x, p.y);
		} else {
			return nearestPointOnSegment(p, points[0], points[1]);
		}
	}

	private function nearestPointOnSegment(p:FlxVector, a:FlxVector, b:FlxVector):FlxVector {
		var v = new FlxVector(b.x - a.x, b.y - a.y);
		var u = new FlxVector(a.x - p.x, a.y - p.y);
		var vu = v.x * u.x + v.y * u.y;
		var vv = v.x * v.x + v.y * v.y;
		var t = -vu / vv;
		if (t >= 0 && t <= 1) {
			return vectorToSegment2D(t, zero, a, b);
		}
		var g0 = sqDiag2D(vectorToSegment2D(0, p, a, b));
		var g1 = sqDiag2D(vectorToSegment2D(1, p, a, b));
		if (g0 <= g1) {
			return new FlxVector(a.x, a.y);
		} else {
			return new FlxVector(b.x, b.y);
		}
	}

	private function vectorToSegment2D(t:Float, p:FlxVector, a:FlxVector, b:FlxVector):FlxVector {
		return new FlxVector((1.0 - t) * a.x + t * b.x - p.x, (1.0 - t) * a.y + t * b.y - p.y);
	}

	private function sqDiag2D(p:FlxVector):Float {
		return p.x * p.x + p.y * p.y;
	}
}
