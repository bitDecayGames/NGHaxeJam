package entities;

import flixel.math.FlxRandom;
import flixel.math.FlxVector;
import flixel.math.FlxPoint;
import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxSpriteUtil.DrawStyle;
import flixel.util.FlxSpriteUtil.LineStyle;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.math.FlxMath;

using flixel.util.FlxSpriteUtil;

class Flock extends FlxSpriteGroup {
	private var agents:List<FlockAgent>;
	private var cohesionScale = 0.0001;
	private var avoidanceScale = 10.0;
	private var alignmentScale = 0.5;
	private var targetScale = 0.005;
	private var clamp = 100.0;

	public function new() {
		super();
		agents = new List<FlockAgent>();
		spawn();
	}

	private function spawn() {
		var rnd = new FlxRandom();
		var spawnRadius = 100.0;
		for (i in 0...20) {
			var agent = new FlockAgent();
			agent.x = rnd.float() * spawnRadius;
			agent.y = rnd.float() * spawnRadius;
			agent.influenceRadius = 50.0;
			agent.avoidanceRadius = 40.0;
			add(agent);
			agents.add(agent);
		}
	}

	override public function update(delta:Float):Void {
		super.update(delta);
		var context = new List<FlockAgent>();
		var cohesion:FlxVector = null;
		var avoidance:FlxVector = null;
		var alignment:FlxVector = null;
		var target:FlxVector = null;
		var mousePos = FlxG.mouse.getPosition();
		mousePos = new FlxPoint(FlxG.width / 2.0, FlxG.height / 2.0);
		var vel:FlxVector = null;
		for (agent in agents) {
			context = getNearby(agent, context);
			cohesion = agent.calculateCohesion(context, cohesion).scale(cohesionScale);
			avoidance = agent.calculateAvoidance(context, avoidance).scale(avoidanceScale);
			alignment = agent.calculateAlignment(context, alignment).scale(alignmentScale);
			target = agent.calculateTarget(mousePos, target).scale(targetScale);
			vel = new FlxVector(cohesion.x + avoidance.x + alignment.x + target.x, cohesion.y + avoidance.y + alignment.y + target.y);
			agent.velocity.x += vel.x;
			agent.velocity.y += vel.y;
			agent.velocity = _clampVector(clamp, agent.velocity);
		}

		if (FlxG.keys.justPressed.SPACE) {
			spawn();
		}
	}

	public function getNearby(agent:FlockAgent, ?context:List<FlockAgent>):List<FlockAgent> {
		if (context == null) {
			context = new List<FlockAgent>();
		} else {
			context.clear();
		}
		for (otherAgent in agents) {
			if (otherAgent != agent && FlxMath.distanceBetween(agent, otherAgent) < agent.influenceRadius) {
				context.add(otherAgent);
			}
		}
		return context;
	}

	private function _clamp(min:Float, max:Float, v:Float):Float {
		return Math.max(min, Math.min(max, v));
	}

	private function _clampVector(max:Float, v:FlxVector):FlxVector {
		if (v.length > clamp) {
			v.normalize().scale(clamp);
		}
		return v;
	}
}
