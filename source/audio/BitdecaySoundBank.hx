package audio;

import flixel.FlxG;

enum BitdecaySongs {
	MainTheme;
}

enum BitdecaySounds {
	Shoot;
	Hit;
}

typedef SoundInfo = {
	var name:BitdecaySounds;
	var instances:Int;
	var paths:Array<String>;
}

class BitdecaySoundBank {

	public var flxSounds:Array<SoundInfo> = [
		{name: BitdecaySounds.Shoot, instances: 10, paths: [AssetPaths.beep1__ogg, AssetPaths.beep2__ogg, AssetPaths.beep3__ogg]},
		{name: BitdecaySounds.Hit, instances: 10, paths: [AssetPaths.thisye__ogg]}
	];

	public var flxSongs:Map<BitdecaySongs, String> = [ 
		BitdecaySongs.MainTheme => AssetPaths.Song4__ogg 
	];

	public var sounds:Map<BitdecaySounds, BitdecaySound> = new Map();

	private static var instance:BitdecaySoundBank;
	public static function Instance():BitdecaySoundBank{
		if (instance == null){
			instance = new BitdecaySoundBank();
		}
		return instance;
	}

	private function new () {
		trace('Instantiating sound engine');
		for(flxSound in flxSounds) {
			sounds[flxSound.name] = new BitdecaySound(flxSound.paths, flxSound.instances);
		}
	}

	public function PlaySound(soundName:BitdecaySounds) {
		var sound = sounds[soundName];
		if (sound == null) {
			throw 'Tried to play sound effect ($soundName), but it was not found';
		}
		sound.play();
	}

	public function PlaySongIfNonePlaying(songName:BitdecaySongs) {
		if (FlxG.sound.music == null)
		{
			var songPath = flxSongs[songName];
			if (songPath == null) {
				throw 'Tried to get song ($songName), but it was not found';
			}

			FlxG.sound.playMusic(songPath, 1, true);
		}
	}
}
