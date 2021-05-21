package;

import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;
import openfl.utils.AssetType;
import openfl.utils.Assets as OpenFlAssets;

class Paths
{
	inline public static var SOUND_EXT = #if web "mp3" #else "ogg" #end;

	public static var currentLevel:String;
	public static var currentWeek:String;
	public static var currentMod:String;

	static public function setCurrentLevel(name:String)
	{
		currentLevel = name.toLowerCase();
	}

	static public function setCurrentMod(name:String)
	{
		currentMod = name;
	}

	static public function setCurrentWeek(name:String)
	{
		currentWeek = name;
	}

	static function getPath(file:String, type:AssetType, library:Null<String>)
	{
		if (library != null)
			return getLibraryPath(file, library);

		if (currentLevel != null)
		{
			var levelPath = getLibraryPathForce(file, currentLevel);
			if (OpenFlAssets.exists(levelPath, type))
				return levelPath;

			#if sys
			var levelPath = getPreloadPath('weeks/$currentMod/$currentWeek/'+file);
			if (OpenFlAssets.exists(levelPath, type))
				return levelPath;

			var levelPath = getDynamicWeeksPathForce('weeks/$currentMod/$currentWeek/'+file);
			if (OpenFlAssets.exists(levelPath, type))
				return levelPath;

			#end
		}

		var shared = getLibraryPathForce(file, "shared");
		if (OpenFlAssets.exists(shared, type))
			return shared;

		return getPreloadPath(file);
	}

	static public function getLibraryPath(file:String, library = "preload")
	{
		return if (library == "preload" || library == "default") {
			getPreloadPath(file);
		} else {
			getLibraryPathForce(file, library);
		}
	}

	inline static function getLibraryPathForce(file:String, library:String)
	{
		return '$library:assets/$library/$file';
	}

	inline static function getDynamicWeeksPathForce(file:String)
	{
		return 'weeks:assets/$file';
	}

	inline static function getPreloadPath(file:String)
	{
		return 'assets/$file';
	}

	inline static public function file(file:String, type:AssetType = TEXT, ?library:String)
	{
		return getPath(file, type, library);
	}

	inline static public function lua(key:String,?library:String)
	{
		return getPath('data/$key.lua', TEXT, library);
	}

	inline static public function luaImage(key:String, ?library:String)
	{
		return getPath('data/$key.png', IMAGE, library);
	}

	inline static public function txt(key:String, ?library:String)
	{
		return getPath('data/$key.txt', TEXT, library);
	}

	inline static public function txtWeek(key:String, ?week:String, ?library:String)
	{
		if(week != null) {
			return getPath('$currentMod/$week/tracks/$key.txt', TEXT, library);
		}
		return getPath('$currentMod/tracks/$key.txt', TEXT, library);
	}

	inline static public function txtWeekPath(key:String, ?week:String, ?library:String)
	{
		if(week != null) {
			return 'assets/weeks/$currentMod/$week/tracks/$key.txt';
		}
		return 'assets/weeks/$currentMod/tracks/$key.txt';
	}

	inline static public function xml(key:String, ?library:String)
	{
		return getPath('data/$key.xml', TEXT, library);
	}

	inline static public function jsonWeek(key:String, ?week:String, ?library:String)
	{
		if(week != null) {
			return getPath('$currentMod/$week/tracks/$key.json', TEXT, library);
		}
		return getPath('$currentMod/tracks/$key.json', TEXT, library);
	}

	inline static public function weekPath(key:String, ?week:String, ?library:String)
	{
		if(week != null) {
			return getPath('weeks/$currentMod/$week/tracks/$key', TEXT, library);
		}
		return getPath('weeks/$currentMod/tracks/$key', TEXT, library);
	}

	inline static public function json(key:String, ?library:String)
	{
		return getPath('data/$key.json', TEXT, library);
	}

	static public function sound(key:String, ?library:String)
	{
		return getPath('sounds/$key.$SOUND_EXT', SOUND, library);
	}

	inline static public function soundRandom(key:String, min:Int, max:Int, ?library:String)
	{
		return sound(key + FlxG.random.int(min, max), library);
	}

	inline static public function music(key:String, ?library:String)
	{
		return getPath('music/$key.$SOUND_EXT', MUSIC, library);
	}

	@:deprecated
	inline static public function voices(song:String)
	{
		return 'songs:assets/songs/${song.toLowerCase()}/Voices.$SOUND_EXT';
	}

	@:deprecated
	inline static public function inst(song:String)
	{
		return 'songs:assets/songs/${song.toLowerCase()}/Inst.$SOUND_EXT';
	}

	inline static public function voicesWeek(song:String, ?week:String)
	{
		if(week != null) {
			return 'weeks:assets/weeks/$currentMod/$week/tracks/${song.toLowerCase()}/Voices.$SOUND_EXT';
		}
		return 'weeks:assets/weeks/$currentMod/tracks/${song.toLowerCase()}/Voices.$SOUND_EXT';
	}

	inline static public function voicesWeekPath(song:String, ?week:String)
	{
		if(week != null) {
			return 'assets/weeks/$currentMod/$week/tracks/${song.toLowerCase()}/Voices.$SOUND_EXT';
		}
		return 'assets/weeks/$currentMod/tracks/${song.toLowerCase()}/Voices.$SOUND_EXT';
	}

	inline static public function instWeek(song:String, ?week:String)
	{
		if(week != null) {
			return 'weeks:assets/weeks/$currentMod/$week/tracks/${song.toLowerCase()}/Inst.$SOUND_EXT';
		}
		return 'weeks:assets/weeks/$currentMod/tracks/${song.toLowerCase()}/Inst.$SOUND_EXT';
	}

	inline static public function instWeekPath(song:String, ?week:String)
	{
		if(week != null) {
			return 'assets/weeks/$currentMod/$week/tracks/${song.toLowerCase()}/Inst.$SOUND_EXT';
		}
		return 'assets/weeks/$currentMod/tracks/${song.toLowerCase()}/Inst.$SOUND_EXT';
	}

	inline static public function image(key:String, ?library:String)
	{
		return getPath('images/$key.png', IMAGE, library);
	}

	inline static public function weekTextImage(key:String)
	{
		return getPath('$currentMod/$key.png', IMAGE, "weeks");
	}

	inline static public function doesWeekTextImage(key:String)
	{
		var key = 'weeks:assets/weeks/$currentMod/$key.png';
		if (OpenFlAssets.exists(key, IMAGE))
			return true;
		return false;
	}

	inline static public function font(key:String)
	{
		return 'assets/fonts/$key';
	}

	inline static public function getSparrowAtlas(key:String, ?library:String)
	{
		return FlxAtlasFrames.fromSparrow(image(key, library), file('images/$key.xml', library));
	}

	inline static public function getPackerAtlas(key:String, ?library:String)
	{
		return FlxAtlasFrames.fromSpriteSheetPacker(image(key, library), file('images/$key.txt', library));
	}
}
