package entities;

import flixel.math.FlxMath;
import flixel.math.FlxVector;
import flixel.math.FlxPoint;
import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxSpriteUtil.DrawStyle;
import flixel.util.FlxSpriteUtil.LineStyle;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;
import flixel.FlxSprite;

using flixel.util.FlxSpriteUtil;

class FlockAgent extends ISelectable {
	public var influenceRadius:Float;
	public var avoidanceRadius:Float;

	private var _graphic:FlxSprite;
	private var _up:FlxPoint = new FlxPoint(0.0, 0.0);

	public function new() {
		super();
		_graphic = new FlxSprite();
		_graphic.makeGraphic(20, 20, FlxColor.TRANSPARENT, false);
		var lineStyle:LineStyle = {color: FlxColor.BLUE, thickness: 1};
		_graphic.drawTriangle(0, 0, 20, FlxColor.GREEN, lineStyle);
		_graphic.x = _graphic.width / 2.0;
		_graphic.y = _graphic.height / 2.0;
		add(_graphic);
	}

	override public function update(delta:Float):Void {
		super.update(delta);
		var targetAngle = _up.angleBetween(velocity);
		_graphic.angle += (targetAngle - _graphic.angle) * 0.05;
	}

	public function calculateCohesion(context:List<FlockAgent>, ?outV:FlxVector):FlxVector {
		if (outV == null) {
			outV = new FlxVector();
		}
		if (context == null || context.length == 0) {
			outV.x = 0.0;
			outV.y = 0.0;
			return outV;
		}
		var totalX = 0.0;
		var totalY = 0.0;
		for (agent in context) {
			totalX += agent.x;
			totalY += agent.y;
		}
		var len = context.length;
		outV.x = (totalX / len) - x;
		outV.y = (totalY / len) - y;
		return outV;
	}

	public function calculateAvoidance(context:List<FlockAgent>, ?outV:FlxVector):FlxVector {
		if (outV == null) {
			outV = new FlxVector();
		}
		if (context == null || context.length == 0) {
			outV.x = 0.0;
			outV.y = 0.0;
			return outV;
		}
		var totalX = 0.0;
		var totalY = 0.0;
		var nAvoid = 0;
		for (agent in context) {
			var dist = FlxMath.distanceBetween(this, agent);
			if (dist < avoidanceRadius) {
				totalX -= agent.x - x;
				totalY -= agent.y - y;
				nAvoid += 1;
			}
		}

		if (nAvoid > 0) {
			outV.x = totalX / nAvoid;
			outV.y = totalY / nAvoid;
		}
		outV.normalize();
		return outV;
	}

	public function calculateAlignment(context:List<FlockAgent>, ?outV:FlxVector):FlxVector {
		if (outV == null) {
			outV = new FlxVector();
		}
		if (context == null || context.length == 0) {
			outV.x = 0.0;
			outV.y = 0.0;
			return outV;
		}
		var totalX = 0.0;
		var totalY = 0.0;
		for (agent in context) {
			totalX += agent.velocity.x;
			totalY += agent.velocity.y;
		}
		outV.x = totalX / context.length;
		outV.y = totalY / context.length;

		return outV;
	}

	public function calculateTarget(target:FlxVector, ?outV:FlxVector):FlxVector {
		if (outV == null) {
			outV = new FlxVector();
		}
		outV.x = target.x - x;
		outV.y = target.y - y;

		return outV;
	}
}
