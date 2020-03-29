package states;

import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.addons.ui.FlxUIState;

class MainMenuState extends FlxUIState {
	var _btnPlay:FlxButton;
	var _btnTiles:FlxButton;
	var _btnEditor:FlxButton;
	var _btnDoob:FlxButton;

	override public function create():Void {
		super.create();
		bgColor = FlxColor.TRANSPARENT;

		_btnPlay = new FlxButton(0, 0, "Play", () -> FlxG.switchState(new PlayState()));
		_btnPlay.updateHitbox();
		_btnPlay.screenCenter();
		add(_btnPlay);
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
	}
}
