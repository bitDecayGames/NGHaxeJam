package audio;

import flixel.FlxG;

enum BitdecaySongs {
	BattleForHome;
}

enum BitdecaySounds {
	Arrow;
	HitEnemy;
	Build;
}

typedef SoundInfo = {
	var name:String;
	var instances:Int;
	var paths:Array<String>;
	var soundClip:BitdecaySound;
}

typedef MusicInfo = {
	var name:String;
	var path:String;
	var volume:Float;
}

class BitdecaySoundBank {

	public var flxSounds:Map<BitdecaySounds, SoundInfo> = [
		BitdecaySounds.Arrow => {name: Std.string(BitdecaySounds.Arrow), instances: 10, paths: [AssetPaths.Arrow1__ogg, AssetPaths.Arrow2__ogg, AssetPaths.Arrow3__ogg], soundClip: null},
		BitdecaySounds.HitEnemy => {name: Std.string(BitdecaySounds.HitEnemy), instances: 10, paths: [AssetPaths.HitEnemy1__ogg, AssetPaths.HitEnemy2__ogg, AssetPaths.HitEnemy3__ogg], soundClip: null},
		BitdecaySounds.Build => {name: Std.string(BitdecaySounds.Build), instances: 10, paths: [AssetPaths.build1__ogg, AssetPaths.build2__ogg, AssetPaths.build3__ogg, AssetPaths.build4__ogg, AssetPaths.build5__ogg, AssetPaths.build6__ogg, AssetPaths.build7__ogg, AssetPaths.build8__ogg], soundClip: null}
	];

	public var flxSongs:Map<BitdecaySongs, MusicInfo> = [ 
		BitdecaySongs.BattleForHome => {name: Std.string(BitdecaySongs.BattleForHome), path:AssetPaths.BattleForHome__ogg, volume: .8}
	];

	public var loopingSoundUniqueId:Int = 1;
	public var loopingSounds:Map<Int, BitdecaySound> = new Map();

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
			trace('loading data for ${flxSound.name}');
			flxSound.soundClip = new BitdecaySound(flxSound.name, flxSound.paths, flxSound.instances);
		}
	}

	public function PlaySound(soundName:BitdecaySounds) {
		var soundInfo = flxSounds[soundName];
		if (soundInfo == null) {
			throw 'Tried to play sound effect ($soundName), but it was not found';
		}
		soundInfo.soundClip.play();
	}

	public function PlaySoundLooped(soundName:BitdecaySounds):Int {
		var soundInfo = flxSounds[soundName];
		if (soundInfo == null) {
			throw 'Tried to load a looping sound effect ($soundName), but it was not found';
		}
		var soundId = loopingSoundUniqueId;
		loopingSounds[soundId] = new BitdecaySound(soundInfo.name, soundInfo.paths, 1);
		loopingSounds[soundId].play();

		loopingSoundUniqueId++;
		return soundId;
	}

	// This doesn't explicitly clean up the old sound. Does that happen for free?
	public function StopSoundLooped(loopedSoundId:Int) {
		var loopingSound = loopingSounds[loopedSoundId];
		if (loopingSound == null) {
			throw 'Tried to stop a looping sound effect (Id: $loopedSoundId), but it was not found';
		}
		loopingSound.stop();
		loopingSounds.remove(loopedSoundId);
	}

	public function PlaySongIfNonePlaying(songName:BitdecaySongs) {
		if (FlxG.sound.music == null)
		{
			var musicInfo = flxSongs[songName]; 
			if (musicInfo == null) {
				throw 'Tried to get song ($songName), but it was not found';
			}

			FlxG.sound.playMusic(musicInfo.path, musicInfo.volume, true);
		}
	}

	public function Update() {
		for(loopingSound in loopingSounds) {
			if (!loopingSound.isPlaying()) {
				loopingSound.play();
			}
		}
	}
}
