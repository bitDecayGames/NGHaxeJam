package states;

import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.addons.ui.FlxUIState;

class MainMenuState extends FlxUIState {
	var _btnTiles:FlxButton;
	var _btnEditor:FlxButton;
	var _btnDoob:FlxButton;

	override public function create():Void {
		super.create();
		bgColor = FlxColor.GRAY;

		var _btnLoganPlay = new FlxButton(0, 0, "Logan", () -> FlxG.switchState(new PlayCollisionState()));
		_btnLoganPlay.updateHitbox();
		_btnLoganPlay.screenCenter();
		add(_btnLoganPlay);

		var _btnMikePlay = new FlxButton(0, 0, "Mike", () -> FlxG.switchState(new PlayState()));
		_btnMikePlay.updateHitbox();
		_btnMikePlay.screenCenter();
		add(_btnMikePlay);
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
	}
}
