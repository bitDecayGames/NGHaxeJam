package entities;

import flixel.group.FlxSpriteGroup;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.FlxSprite;

class Totem extends ISelectable {
	var needsNewTarget:Bool;

	var totem:FlxSprite;
	var bullets:FlxGroup;
	var activeTarget:FlxSprite;
	var remove_count:Int;
	var setCount:Int;

	var shotSpeed:Float = 1;
	var shotTimer:Float = 1;

	var targets:FlxSpriteGroup;

	public function new(shotSpeed:Float, bulletGroup:FlxGroup) {
		super(128);
		bullets = bulletGroup;
		targets = new FlxSpriteGroup();
		needsNewTarget = true;

		totem = new FlxSprite();
		totem.loadGraphic(AssetPaths.human_totem__png, false, 16, 32);
		totem.x = totem.width / -2.0;
		totem.y = totem.height / -2.0;

		setHighlightYOffset(totem);
		
		add(totem);
		this.shotSpeed = shotSpeed;
		shotTimer = shotSpeed;
	}

	override public function update(delta:Float):Void {
		super.update(delta);

		if (activeTarget != null && activeTarget.alive) {
			if (!FlxG.pixelPerfectOverlap(activeTarget, _range, 1)) {
				needsNewTarget = true;
				remove_count++;
				FlxG.watch.addQuick("Remove target count: ", remove_count);
			}
		}

		if (shotTimer > 0) {
			shotTimer -= delta;
		} else {
			if (needsNewTarget) {
				setNewTarget();
			}
			if (activeTarget != null && activeTarget.alive) {
				shoot();
				shotTimer += shotSpeed;
			}
		}

		FlxG.watch.addQuick("size at clear: ", targets.length);
		targets.clear();
	}

	function shoot():Void {
		var targetPos = activeTarget.getGraphicMidpoint();
		var dir = targetPos.subtractPoint(getGraphicMidpoint());
		var newShot = new SimpleShot(activeTarget, 200);
		newShot.x = newShot.width / -2.0 + x;
		newShot.y = newShot.height / -2.0 + y;
		bullets.add(newShot);
	}

	public function addTarget(enemy:FlxSprite):Void {
		targets.add(enemy);
	}

	function setNewTarget():Void {
		targets.sort(byProximity);
		activeTarget = targets.getFirstAlive();
		if (activeTarget != null) {
			setCount++;
			FlxG.watch.addQuick("New Target count: ", setCount);
		}
	}

	private function byProximity(Order:Int, V1:FlxSprite, V2:FlxSprite):Int {
		var v1Dist = V1.getMidpoint().distanceTo(getMidpoint());
		var v2Dist = V2.getMidpoint().distanceTo(getMidpoint());

		if (v2Dist < v1Dist) {
			Order *= -1;
		}

		return Order;
	}
}
