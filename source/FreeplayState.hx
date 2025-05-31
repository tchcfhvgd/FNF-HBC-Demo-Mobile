package;

#if desktop
import Discord.DiscordClient;
#end
import editors.ChartingState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import lime.utils.Assets;
import flixel.sound.FlxSound;
import openfl.utils.Assets as OpenFlAssets;


import flixel.FlxBasic;
import flixel.FlxObject;
import flixel.util.FlxTimer;


import WeekData;
#if MODS_ALLOWED
import sys.FileSystem;
#end

using StringTools;

class FreeplayState extends MusicBeatState
{
	var songs:Array<SongMetadata> = [];

	var selector:FlxText;
	private static var curSelected:Int = 0;
	var curDifficulty:Int = 0;
	private static var lastDifficultyName:String = '';

	var diffBG:FlxSprite;
	var diffText:FlxText;

	var scoreBG:FlxSprite;
	var lerpScore:Int = 0;
	var lerpRating:Float = 0;
	var intendedScore:Int = 0;
	var intendedRating:Float = 0;
	var intendedMisses:Int = -1;

	public static var resettingScore:Bool = false;

	private var grpSongs:FlxTypedGroup<FlxText>;
	private var grpSongBG:FlxTypedGroup<FlxSprite>;
	private var curPlaying:Bool = false;

	private var iconArray:Array<HealthIcon> = [];

	var bg:FlxSprite;
	var intendedColor:Int;
	var colorTween:FlxTween;


	public static var inSubstate:Bool = false;
	var inTv:Bool = false;


	static var lastEnteredWeek:String = null;


	var freeplayOffset:Float;

	
	var weekList:Array<String> = [
		'Grand Opening',
		'King of the Court',
		'Shattered Innocence',
		'The House Always Wins',
		'wtf kms its mommy mearest from friday night funkin wtf',
		'Remember',
		'Casualties',
		'Revisions'
	];

	var weekListNames:Array<String> = [
		'Prologue',
		'Pico',
		'Spookers',
		'Nene',
		'kmsweek',
		'Remember',
		'Casualties',
		'Revisions'
	];


	var playerSongs:Array<String> = [
		'Amomos',
		'Atonement',
		'Devotion',
		'Second Coming',
		'Spookychrome',
		'Empty Memories',
		'Unmanageable',
		'LORE'
	];

	static var oldCamPos:Array<Float> = [];

	

	static var curTapeSelected:Int = 0;

	var tv:FlxSprite;
	var tvScreen:FlxSprite;

	var scoreTxt:FlxText;
	var infoTxt:FlxText;
	var txtFormat:FlxTextFormat;
	var scoreFormat:FlxTextFormat;


	var baseShelf:FlxSprite;

	var shelfPrologue:FlxSprite;
	var shelfPico:FlxSprite;
	var shelfSpookers:FlxSprite;
	var shelfNene:FlxSprite;
	var shelfKms:FlxSprite;
	var shelfRemember:FlxSprite;
	var shelfCasualties:FlxSprite;
	var shelfRevisions:FlxSprite;



	var tapePrologue:FlxSprite;
	var tapePico:FlxSprite;
	var tapeSpookers:FlxSprite;
	var tapeNene:FlxSprite;
	var tapeKms:FlxSprite;
	var tapeRemember:FlxSprite;
	var tapeCasualties:FlxSprite;
	var tapeRevisions:FlxSprite;

	var ratingSplit:Array<String>;

	var arrow:FlxSprite;

	static var selectingTape:Bool = true;

	static var selectingSong:Bool = false;

	static var inTrans:Bool = false;



	var camFollow:FlxObject;
	var camFollowPos:FlxObject;

	//songselect and shelfassets (middle) need a for loop




	function weekIsCompleted(name:String){
		return StoryMenuState.weekCompleted.get(name);
	}


	var tapeShit:Array<FlxBasic> = [];


	override function create()
	{
		//Paths.clearStoredMemory();
		//Paths.clearUnusedMemory();

		FlxG.mouse.visible = false;


		persistentUpdate = true;
		PlayState.isStoryMode = false;
		WeekData.reloadWeekFiles(false);





			arrow = new FlxSprite(660, -600);
			arrow.frames = Paths.getSparrowAtlas('freeplaymenu/freeplay_arrow');
			arrow.animation.addByPrefix('idle', "arrow0", 24);
			arrow.animation.play('idle');
			arrow.scale.set(0.5, 0.5);
			arrow.antialiasing = ClientPrefs.globalAntialiasing;


			baseShelf = new FlxSprite(-895, 950);
			baseShelf.frames = Paths.getSparrowAtlas('freeplaymenu/freeplay_base');
			baseShelf.animation.addByPrefix('idle', "base0", 1);
			baseShelf.animation.play('idle');
			baseShelf.scale.set(0.48, 0.45);
			baseShelf.antialiasing = ClientPrefs.globalAntialiasing;

			// Shelf Y difference : +150 , +155 for first
			// Tape Y difference: + 45 from respecitve shelf, +155 from each other


			shelfPrologue = new FlxSprite(-170, -30);
			shelfPrologue.frames = Paths.getSparrowAtlas('freeplaymenu/shelfassets');
			shelfPrologue.animation.addByPrefix('idle', "shelf top0", 1);
			shelfPrologue.animation.play('idle');
			add(shelfPrologue);
			shelfPrologue.scale.set(0.7, 0.7);
			shelfPrologue.antialiasing = ClientPrefs.globalAntialiasing;

			//if (weekIsCompleted('Prologue')) {
				tapePrologue = new FlxSprite(-90, 20);
				tapePrologue.frames = Paths.getSparrowAtlas('freeplaymenu/tapes');
				tapePrologue.animation.addByPrefix('idle', "prologuetape0", 1);
				tapePrologue.animation.play('idle');
				add(tapePrologue);
				tapePrologue.scale.set(0.7, 0.7);
				tapePrologue.antialiasing = ClientPrefs.globalAntialiasing;
			//}

			///

			shelfPico = new FlxSprite(-170, 125);
			shelfPico.frames = Paths.getSparrowAtlas('freeplaymenu/shelfassets');
			shelfPico.animation.addByPrefix('idle', "shelf0", 1);
			shelfPico.animation.play('idle');
			add(shelfPico);
			shelfPico.scale.set(0.7, 0.7);
			shelfPico.antialiasing = ClientPrefs.globalAntialiasing;

			//if (weekIsCompleted('Pico')) {
				tapePico = new FlxSprite(-90, 170);
				tapePico.frames = Paths.getSparrowAtlas('freeplaymenu/tapes');
				tapePico.animation.addByPrefix('idle', "picotape0", 1);
				tapePico.animation.play('idle');
				add(tapePico);
				tapePico.scale.set(0.7, 0.7);
				tapePico.antialiasing = ClientPrefs.globalAntialiasing;
			//}

			///

			shelfSpookers = new FlxSprite(-170, 275);
			shelfSpookers.frames = Paths.getSparrowAtlas('freeplaymenu/shelfassets');
			shelfSpookers.animation.addByPrefix('idle', "shelf0", 1);
			shelfSpookers.animation.play('idle');
			add(shelfSpookers);
			shelfSpookers.scale.set(0.7, 0.7);
			shelfSpookers.antialiasing = ClientPrefs.globalAntialiasing;

			//if (weekIsCompleted('Spookers')) {
				tapeSpookers = new FlxSprite(-90, 320);
				tapeSpookers.frames = Paths.getSparrowAtlas('freeplaymenu/tapes');
				tapeSpookers.animation.addByPrefix('idle', "spookytape0", 1);
				tapeSpookers.animation.play('idle');
				add(tapeSpookers);
				tapeSpookers.scale.set(0.7, 0.7);
				tapeSpookers.antialiasing = ClientPrefs.globalAntialiasing;
			//}
			

			///

			shelfNene = new FlxSprite(-170, 425);
			shelfNene.frames = Paths.getSparrowAtlas('freeplaymenu/shelfassets');
			shelfNene.animation.addByPrefix('idle', "shelf0", 1);
			shelfNene.animation.play('idle');
			add(shelfNene);
			shelfNene.scale.set(0.7, 0.7);
			shelfNene.antialiasing = ClientPrefs.globalAntialiasing;




			///

			shelfKms = new FlxSprite(-170, 575);
			shelfKms.frames = Paths.getSparrowAtlas('freeplaymenu/shelfassets');
			shelfKms.animation.addByPrefix('idle', "shelf0", 1);
			shelfKms.animation.play('idle');
			add(shelfKms);
			shelfKms.scale.set(0.7, 0.7);
			shelfKms.antialiasing = ClientPrefs.globalAntialiasing;



			///

			shelfRemember = new FlxSprite(-170, 725);
			shelfRemember.frames = Paths.getSparrowAtlas('freeplaymenu/shelfassets');
			shelfRemember.animation.addByPrefix('idle', "shelf0", 1);
			shelfRemember.animation.play('idle');
			add(shelfRemember);
			shelfRemember.scale.set(0.7, 0.7);
			shelfRemember.antialiasing = ClientPrefs.globalAntialiasing;



			///

			shelfCasualties = new FlxSprite(-170, 875);
			shelfCasualties.frames = Paths.getSparrowAtlas('freeplaymenu/shelfassets');
			shelfCasualties.animation.addByPrefix('idle', "shelf0", 1);
			shelfCasualties.animation.play('idle');
			add(shelfCasualties);
			shelfCasualties.scale.set(0.7, 0.7);
			shelfCasualties.antialiasing = ClientPrefs.globalAntialiasing;



			///

			shelfRevisions = new FlxSprite(-170, 1025);
			shelfRevisions.frames = Paths.getSparrowAtlas('freeplaymenu/shelfassets');
			shelfRevisions.animation.addByPrefix('idle', "shelf bottom0", 1);
			shelfRevisions.animation.play('idle');
			add(shelfRevisions);
			shelfRevisions.scale.set(0.7, 0.7);
			shelfRevisions.antialiasing = ClientPrefs.globalAntialiasing;







			//if (weekIsCompleted('Nene')) { // Nene, April fools, remember, casualties and revisions tapes are unlocked here
				tapeNene = new FlxSprite(-90, 470);
				tapeNene.frames = Paths.getSparrowAtlas('freeplaymenu/tapes');
				tapeNene.animation.addByPrefix('idle', "nenetape0", 1);
				tapeNene.animation.play('idle');
				add(tapeNene);
				tapeNene.scale.set(0.7, 0.7);
				tapeNene.antialiasing = ClientPrefs.globalAntialiasing;


				tapeKms = new FlxSprite(-90, 620);
				tapeKms.frames = Paths.getSparrowAtlas('freeplaymenu/tapes');
				tapeKms.animation.addByPrefix('idle', "mmtape0", 1);
				tapeKms.animation.play('idle');
				add(tapeKms);
				tapeKms.scale.set(0.7, 0.7);
				tapeKms.antialiasing = ClientPrefs.globalAntialiasing;


				tapeRemember = new FlxSprite(-90, 770);
				tapeRemember.frames = Paths.getSparrowAtlas('freeplaymenu/tapes');
				tapeRemember.animation.addByPrefix('idle', "lilatape0", 1);
				tapeRemember.animation.play('idle');
				add(tapeRemember);
				tapeRemember.scale.set(0.7, 0.7);
				tapeRemember.antialiasing = ClientPrefs.globalAntialiasing;



				tapeCasualties = new FlxSprite(-90, 920);
				tapeCasualties.frames = Paths.getSparrowAtlas('freeplaymenu/tapes');
				tapeCasualties.animation.addByPrefix('idle', "devtape0", 1);
				tapeCasualties.animation.play('idle');
				add(tapeCasualties);
				tapeCasualties.scale.set(0.7, 0.7);
				tapeCasualties.antialiasing = ClientPrefs.globalAntialiasing;



				tapeRevisions = new FlxSprite(-90, 1070);
				tapeRevisions.frames = Paths.getSparrowAtlas('freeplaymenu/tapes');
				tapeRevisions.animation.addByPrefix('idle', "revisiontape0", 1);
				tapeRevisions.animation.play('idle');
				add(tapeRevisions);
				tapeRevisions.scale.set(0.7, 0.7);
				tapeRevisions.antialiasing = ClientPrefs.globalAntialiasing;

			//}



			tv = new FlxSprite(250, 390, Paths.image('freeplaymenu/tv'));
			tv.scale.set(0.66666667, 0.66666667);
			
			tv.antialiasing = ClientPrefs.globalAntialiasing;

			tvScreen = new FlxSprite(tv.x + 325, tv.y + 125);
			tvScreen.scale.set(0.66666667, 0.66666667);
			tvScreen.frames = Paths.getSparrowAtlas('freeplaymenu/freeplay_tvscreen');
			tvScreen.animation.addByPrefix('on', "tv screen0", 24, false);
			tvScreen.animation.addByPrefix('off', "tv screenOFF0", 24, false);
			
			tvScreen.animation.finishCallback = function(name:String) {
				if (name == 'on') {
					tvScreen.visible = false;

					bg.visible = true; //show the shit!
					grpSongs.visible = true;
					grpSongBG.visible = true;
					infoTxt.visible = true;
					scoreTxt.visible = true;

					diffBG.visible = true;
					diffText.visible = true;

					changeDiff();
					updateScore();
					updateFreeplayItems();
					
					for (i in 0...iconArray.length)
						{
							iconArray[i].visible = true;
						}

					selectingSong = true;
				}

				if (name == 'off') {
					closeComputer();
				}
			}

			tvScreen.antialiasing = ClientPrefs.globalAntialiasing;

			bg = new FlxSprite(570, 550).loadGraphic(Paths.image('menuDesat'));
			bg.antialiasing = ClientPrefs.globalAntialiasing;
			bg.scale.set(0.6, 0.7);
			bg.visible = false;

			add(bg);

			add(tvScreen);
			
			add(tv);

			camFollow = new FlxObject(0, 0, 1, 1);
			camFollowPos = new FlxObject(0, 0, 1, 1);
			add(camFollow);
			add(camFollowPos);

			camFollow.screenCenter();
			camFollowPos.screenCenter();


			FlxG.camera.follow(camFollowPos, null, 1);

			//FlxG.camera.zoom = 0.5;



		
		



			if (!weekIsCompleted('Prologue')) tapePrologue.visible = false;
			if (!weekIsCompleted('Pico')) tapePico.visible = false;
			if (!weekIsCompleted('Spookers')) tapeSpookers.visible = false;


			if (!weekIsCompleted('Nene')) {
				tapeNene.visible = false;
				tapeKms.visible = false;
				tapeRemember.visible = false;
				tapeCasualties.visible = false;
				tapeRevisions.visible = false;

			}
			
			tapeShit.push(tapePrologue);
			tapeShit.push(tapePico);
			tapeShit.push(tapeSpookers);
			tapeShit.push(tapeNene);
			tapeShit.push(tapeKms);
			tapeShit.push(tapeRemember);
			tapeShit.push(tapeCasualties);
			tapeShit.push(tapeRevisions);
			

			add(baseShelf);

			add(arrow);


		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		

		changeTapeSelection(curTapeSelected);





		var swag:Alphabet = new Alphabet(1, 0, "swag");

		// JUST DOIN THIS SHIT FOR TESTING!!!
		/* 
			var md:String = Markdown.markdownToHtml(Assets.getText('CHANGELOG.md'));

			var texFel:TextField = new TextField();
			texFel.width = FlxG.width;
			texFel.height = FlxG.height;
			// texFel.
			texFel.htmlText = md;

			FlxG.stage.addChild(texFel);

			// scoreText.textField.htmlText = md;

			trace(md);
		 */

		var textBG:FlxSprite = new FlxSprite(0, FlxG.height - 26).makeGraphic(FlxG.width, 26, 0xFF000000);
		textBG.alpha = 0.6;
		//add(textBG);

		#if PRELOAD_ALL
		var leText:String = "Press SPACE to listen to the Song / Press CTRL to open the Gameplay Changers Menu / Press RESET to Reset your Score and Accuracy.";
		var size:Int = 16;
		#else
		var leText:String = "Press CTRL to open the Gameplay Changers Menu / Press RESET to Reset your Score and Accuracy.";
		var size:Int = 18;
		#end
		var text:FlxText = new FlxText(textBG.x, textBG.y + 4, FlxG.width, leText, size);
		text.setFormat(Paths.font("vcr.ttf"), size, FlxColor.WHITE, RIGHT);
		text.scrollFactor.set();
		//add(text);


		if (selectingSong) {
			inTrans = true;
			openComputer(weekList[curTapeSelected]);
			bg.visible =  true;
		}


		super.create();
	}

	override function closeSubState() {
		//changeSelection(0, false);
		persistentUpdate = true;

		

		super.closeSubState();

		//trace(resettingScore);
		if (resettingScore){
			resettingScore = false;
			scoreTxt.text = 'SCORE: ' + 0 + '\n' + '0.00% ';
		}


		new FlxTimer().start(0.25, function(tmr:FlxTimer)
			{
				inSubstate = false;
			});
	}

	public function addSong(songName:String, weekNum:Int, songCharacter:String, color:Int)
	{
		songs.push(new SongMetadata(songName, weekNum, songCharacter, color));
	}

	function weekIsLocked(name:String):Bool {
		var leWeek:WeekData = WeekData.weeksLoaded.get(name);
		return (!leWeek.startUnlocked && leWeek.weekBefore.length > 0 && (!StoryMenuState.weekCompleted.exists(leWeek.weekBefore) || !StoryMenuState.weekCompleted.get(leWeek.weekBefore)));
	}

	/*public function addWeek(songs:Array<String>, weekNum:Int, weekColor:Int, ?songCharacters:Array<String>)
	{
		if (songCharacters == null)
			songCharacters = ['bf'];

		var num:Int = 0;
		for (song in songs)
		{
			addSong(song, weekNum, songCharacters[num]);
			this.songs[this.songs.length-1].color = weekColor;

			if (songCharacters.length != 1)
				num++;
		}
	}*/

	var instPlaying:Int = -1;
	public static var vocals:FlxSound = null;
	var holdTime:Float = 0;



	override function update(elapsed:Float)
	{	
		//trace('diff: ' + lastDifficultyName + ' curdiff: ' + curDifficulty);
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		lerpScore = intendedScore;
		lerpRating = intendedRating;

		ratingSplit = Std.string(Highscore.floorDecimal(intendedRating * 100, 2)).split('.');
		if(ratingSplit.length < 2) { //No decimals, add an empty space
			ratingSplit.push('');
		}
		
		while(ratingSplit[1].length < 2) { //Less than 2 decimals in it, add decimals then
			ratingSplit[1] += '0';
		}

		
		//positionHighscore();

		var upP = controls.UI_UP_P;

		var downP = controls.UI_DOWN_P;

		var leftP = controls.UI_LEFT_P;
		var rightP = controls.UI_RIGHT_P;

		var accepted = controls.ACCEPT;
		var space = FlxG.keys.justPressed.SPACE;
		var ctrl = FlxG.keys.justPressed.CONTROL;

		var shiftMult:Int = 1;
		//if(FlxG.keys.pressed.SHIFT) shiftMult = 3;


		var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);

		if (selectingTape) {

		if (cast(tapeShit[curTapeSelected], FlxSprite).y > camFollowPos.y) { // Camera moves down to tape
		camFollowPos.setPosition(
			FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal),
			FlxMath.lerp(camFollowPos.y, cast(tapeShit[curTapeSelected], FlxSprite).y, lerpVal)
		);
		} else if (cast(tapeShit[curTapeSelected], FlxSprite).y < camFollowPos.y - (FlxG.height / 2) ) { // Camera moves up to tape
            camFollowPos.setPosition(
                FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal),
                FlxMath.lerp(camFollowPos.y, cast(tapeShit[curTapeSelected], FlxSprite).y + (FlxG.height / 2), lerpVal)
            );
        }

		}





		if (!selectingTape && selectingSong && !inSubstate && !inTrans) { // SELECTING A SONG



		if(songs.length >= 1)
		{
			if (upP)
			{
				changeSelection(-1);
				//holdTime = 0;
			}
			if (downP)
			{
				changeSelection(1);
				//holdTime = 0;
			}

			if (leftP)
				{
					changeDiff(-1);
					changeSelection(0, false);
				}

			if (rightP)
				{
					changeDiff(1);
					changeSelection(0, false);
				}

			//if (leftP || rightP) changeDiff();

			/*if(controls.UI_DOWN || controls.UI_UP)
			{
				var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
				holdTime += elapsed;
				var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

				if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
				{
					changeSelection((checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult));
					changeDiff();
				}
			}*/

			/*if(FlxG.mouse.wheel != 0)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
				changeSelection(-shiftMult * FlxG.mouse.wheel, false);
				changeDiff();
			}*/
		}



		} else if (selectingTape && !selectingSong && !inSubstate && !inTrans) { // SELECTING A TAPE!!!


			if (controls.BACK)
				{
					persistentUpdate = false;
					if(colorTween != null) {
						colorTween.cancel();
					}
					FlxG.sound.play(Paths.sound('cancelMenu'));
					MusicBeatState.switchState(new MainMenuState());
				}


			if(tapeShit.length > 1)
				{
					if (upP)
					{
						changeTapeSelection(curTapeSelected - 1);
						//holdTime = 0;
					}
					if (downP)
					{
						changeTapeSelection(curTapeSelected + 1);
						//holdTime = 0;
					}
		
					/*if(controls.UI_DOWN || controls.UI_UP)
					{
						var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
						holdTime += elapsed;
						var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);
		
						if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
						{
							changeTapeSelection((checkNewHold - checkLastHold) * (controls.UI_UP ? -1 : 1));
							changeDiff();
						}
					}*/
		
					/*if(FlxG.mouse.wheel != 0)
					{
						//FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
						changeTapeSelection(-shiftMult * FlxG.mouse.wheel, false);
						changeDiff();
					}*/
				}



			}

		



		if (!selectingTape && selectingSong && !inSubstate && !inTrans) { // SONG SELECTION


	
			if (controls.BACK && !inSubstate && !inTrans)
			{
				selectingSong = false;

				tvScreen.visible = true;
				tvScreen.animation.play('off');
				bg.visible = false;
				inTrans = true;
				resetSongs();
				

				
				//closeComputer();
			}




		if(ctrl)
		{
			persistentUpdate = false;
			inSubstate = true;
			openSubState(new FreeplayGameChangers());

		}
		else if(space)
		{
			/*if(instPlaying != curSelected)
			{
				#if PRELOAD_ALL
				destroyFreeplayVocals();
				FlxG.sound.music.volume = 0;
				Paths.currentModDirectory = songs[curSelected].folder;
				var poop:String = Highscore.formatSong(songs[curSelected].songName.toLowerCase(), curDifficulty);
				PlayState.SONG = Song.loadFromJson(poop, songs[curSelected].songName.toLowerCase());
				if (PlayState.SONG.needsVoices)
					vocals = new FlxSound().loadEmbedded(Paths.voices(PlayState.SONG.song));
				else
					vocals = new FlxSound();

				FlxG.sound.list.add(vocals);
				FlxG.sound.playMusic(Paths.inst(PlayState.SONG.song), 0.7);
				vocals.play();
				vocals.persist = true;
				vocals.looped = true;
				vocals.volume = 0.7;
				instPlaying = curSelected;
				#end
			}*/
		}

		else if (accepted && !inSubstate && !inTrans)
		{	
			//changeSelection();
			

		//	persistentUpdate = false;
			var songLowercase:String = Paths.formatToSongPath(songs[curSelected].songName);
			var poop:String = Highscore.formatSong(songLowercase, curDifficulty);
			/*#if MODS_ALLOWED
			if(!sys.FileSystem.exists(Paths.modsJson(songLowercase + '/' + poop)) && !sys.FileSystem.exists(Paths.json(songLowercase + '/' + poop))) {
			#else
			if(!OpenFlAssets.exists(Paths.json(songLowercase + '/' + poop))) {
			#end
				poop = songLowercase;
				curDifficulty = 1;
				trace('Couldnt find file');
			}*/
			trace(poop);

			FlxG.sound.music.fadeOut(0.8, 0);
			FlxG.sound.play(Paths.sound('confirmMenu'));
			grpSongBG.members[curSelected].animation.play('flash');
			inTrans = true;


			new FlxTimer().start(1, function(tmr:FlxTimer)
				{
	
							FlxG.sound.music.volume = 0;
							FlxG.sound.music.stop();


							PlayState.SONG = Song.loadFromJson(poop, songLowercase);
							PlayState.isStoryMode = false;
							PlayState.storyDifficulty = curDifficulty;

							trace('CURRENT WEEK: ' + WeekData.getWeekFileName());
							if(colorTween != null) {
								colorTween.cancel();
							}
							//trace(curDifficulty);
			
							LoadingState.loadAndSwitchState(new PlayState());
							inTrans = false;
						
					

				});

			
		}
		else if(controls.RESET)
		{
			//persistentUpdate = false;
			inSubstate = true;
			openSubState(new FreeplayResetScoreSubState(songs[curSelected].songName, curDifficulty, songs[curSelected].songCharacter));
			FlxG.sound.play(Paths.sound('scrollMenu'));
		}


		} else if (selectingTape && !selectingSong && !inSubstate && !inTrans){ // SELECTING TAPE

			if (accepted && !inTrans){
				trace('Current Week: ' + weekListNames[curTapeSelected] + ' Completed: ' + weekIsCompleted(weekListNames[curTapeSelected]));

				if (weekIsCompleted(weekListNames[curTapeSelected]) || weekIsCompleted('Nene')) {

					selectingTape = false;
					inTrans = true;
					oldCamPos = [];
					oldCamPos = [camFollowPos.x, camFollowPos.y];

					openComputer(weekList[curTapeSelected]);

				}

			}




		}






		/*if (FlxG.mouse.justMoved && selectingTape && !selectingSong && !inSubstate && !inTrans)  // yea nvm lol the cam moving makes this impossible
			{
				for (i in 0...tapeShit.length)
				{
					if (i != curTapeSelected)
					{
						if (FlxG.mouse.overlaps(tapeShit[i]) && !FlxG.mouse.overlaps(tapeShit[curTapeSelected]))
						{
							//FlxG.sound.play(Paths.sound('scrollMenu'));
							changeTapeSelection(i);
						}
					}
				}
			}*/
			//persistentUpdate = true;
		//}






		super.update(elapsed);
	}

	function resetSongs() {
		if (grpSongs != null) {
			for (i in 0...grpSongs.members.length)
				{
					grpSongs.members[i].destroy();
				}
			grpSongs.clear();
			grpSongs.destroy();
			}

			if (grpSongBG != null) {
			for (i in 0...grpSongBG.members.length)
				{
					grpSongBG.members[i].destroy();
				}
			grpSongBG.clear();
			grpSongBG.destroy();
		}

		for (j in 0...iconArray.length)
			{
				iconArray[j].destroy();
			}
		iconArray = [];
		songs = [];	//song shit dies

	//	txtFormat.destroy(); cant be destroyed lolz
		infoTxt.destroy();
		scoreTxt.destroy();

		diffBG.destroy();
		diffText.destroy();
	}

	function getMissRating(misses) {
		if (intendedScore == 0 || misses < 0) {
			return '';
		} else if (misses == 0 && ratingSplit[0] == '100') {
			return '(SFC)';
		} else if (misses == 0){
			return '(FC)';
		} else if (misses > 0 && misses < 10) {
			return '(SDCB)';
		} else return '(Clear)';
	}
	
	function makeSongShit(){
		inTrans = false;
					if (!selectingSong) {
						tvScreen.animation.play('on');
						tvScreen.visible = true;
					}
					//song shit shows up

					var leWeek:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[curTapeSelected]);
					var leSongs:Array<String> = [];
					var leChars:Array<String> = [];

					for (j in 0...leWeek.songs.length)
					{
					leSongs.push(leWeek.songs[j][0]);
					leChars.push(leWeek.songs[j][1]);
					}

					WeekData.setDirectoryFromWeek(leWeek);
					for (song in leWeek.songs)
					{
						var colors:Array<Int> = song[2];
						if(colors == null || colors.length < 3)
						{
							colors = [146, 113, 253];
						}
						addSong(song[0], curTapeSelected, song[1], FlxColor.fromRGB(colors[0], colors[1], colors[2]));
					}
		//}
					WeekData.loadTheFirstEnabledMod();
				
					grpSongBG = new FlxTypedGroup<FlxSprite>();
					add(grpSongBG);
					grpSongBG.visible = false;

					grpSongs = new FlxTypedGroup<FlxText>();
					add(grpSongs);
					grpSongs.visible = false;

					for (i in 0...songs.length)
					{
						var songText:FlxText = new FlxText(730, 680 + (i * 70), FlxG.width, songs[i].songName, 50);


					//	if (songText.text == 'Angels Grace') songText.text = 'Angel\'s Grace';
					//	if (songText.text == 'Angels Grace V5') songText.text = 'Angel\'s Grace V5';

						//if (songText.text == 'Dragged Down To Hell') songText.scale.x = 0.7;


						songText.setFormat(Paths.font("SigmarOne.ttf"), 50, FlxColor.BLACK, LEFT);
						songText.antialiasing = ClientPrefs.globalAntialiasing;
						songText.scale.y = 0.9;
						songText.wordWrap = false;
						songText.ID = i;
						//songText.isMenuItem = true;
						//songText.targetY = i - curSelected;
						grpSongs.add(songText);






						var songBG:FlxSprite = new FlxSprite();
						songBG.frames = Paths.getSparrowAtlas('freeplaymenu/songselect');
						songBG.animation.addByPrefix('idle', 'song back0', 1, true);
						songBG.animation.addByPrefix('selected', 'song back selected0', 24, false);
						songBG.animation.addByPrefix('flash', 'song back selected FLASH0', 24, true);
						
						songBG.scale.set(0.48, 0.5);
						songBG.updateHitbox();
						songBG.x = songText.x + 135;
						songBG.y = songText.y + 15; 
						grpSongBG.add(songBG);
			
						songBG.ID = i;
						updateFreeplayItems();

						


						
			

						//insert(members.indexOf(tvScreen)-1, grpSongs);
						//insert(members.indexOf(tvScreen)-1, grpSongBG);


						Paths.currentModDirectory = songs[i].folder;
						var icon:HealthIcon = new HealthIcon(songs[i].songCharacter);
						icon.antialiasing = ClientPrefs.globalAntialiasing;
						icon.x = songText.x - 60;
						icon.y = songText.y - 580;
			

						for (j in 0...playerSongs.length)
						{
							if (songs[i].songName == playerSongs[j]) icon.flipX = true;
						}




						icon.scale.set(0.6, 0.6);
						icon.visible = false;
						icon.ID = i;
						// using a FlxGroup is too much fuss!
						iconArray.push(icon);
						//insert(members.indexOf(tvScreen)-1, icon);
						add(icon);

						//insert(members.indexOf(icon), tvScreen);



						var maxWidth = 980;
						if (songText.width > maxWidth)
						{	
							switch(songText.text){
								case 'Dragged Down To Hell':
									songText.scale.x = 0.55;
									songText.x -= 135;
								case 'Apathetic Wrath':
									songText.scale.x = 0.7;
									songText.x -= 50;
								case 'Dragged Down To Hell V1':
									songText.scale.x = 0.485;
									songText.x -= 180;
								default:
									songText.scale.x = maxWidth / songText.width;
							}
						}
						//songText.snapToPosition();
					}
				
				txtFormat = new FlxTextFormat();
				txtFormat.leading = -12;

				scoreFormat = new FlxTextFormat();
				scoreFormat.leading = -10;

				scoreTxt = new FlxText(0, 0, FlxG.width, '', 19);
				scoreTxt.setFormat(Paths.font("SigmarOne.ttf"), 19, FlxColor.BLACK, LEFT);
				scoreTxt.addFormat(scoreFormat);
				add(scoreTxt);
				scoreTxt.antialiasing = ClientPrefs.globalAntialiasing;
				
				scoreTxt.visible = false;
					
				infoTxt = new FlxText(0, 0, FlxG.width, '', 18);
				infoTxt.wordWrap = false;
				infoTxt.autoSize = false;
				infoTxt.setFormat(Paths.font("SigmarOne.ttf"), 18, FlxColor.BLACK, LEFT);
				infoTxt.antialiasing = ClientPrefs.globalAntialiasing;
				infoTxt.addFormat(txtFormat);
				add(infoTxt);
			//	infoTxt.fieldHeight = 50;
				infoTxt.scale.y = 1.2;
				infoTxt.updateHitbox();
				infoTxt.visible = false;




				/*for (i in 0...iconArray.length)
				{
				iconArray[i].visible = false;
				}*/
				WeekData.setDirectoryFromWeek();


				

				//add(scoreText);

				

				trace('LAST WEEK: ' + lastEnteredWeek, ' THIS WEEK: ' + weekList[curTapeSelected]);
				//trace(lastEnteredWeek == weekList[curTapeSelected]);
				if (lastEnteredWeek == null || lastEnteredWeek != weekList[curTapeSelected]) curSelected = 0;
				lastEnteredWeek = weekList[curTapeSelected];

				
				


				

				Paths.currentModDirectory = songs[curSelected].folder;
				PlayState.storyWeek = songs[curSelected].week;



				CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();
				var diffStr:String = WeekData.getCurrentWeek().difficulties;
			//	trace(diffStr);
				if(diffStr != null) diffStr = diffStr.trim(); //Fuck you HTML5
		
				if(diffStr != null && diffStr.length > 0)
				{
					var diffs:Array<String> = diffStr.split(',');
					var i:Int = diffs.length - 1;
					while (i > 0)
					{
						if(diffs[i] != null)
						{
							diffs[i] = diffs[i].trim();
							if(diffs[i].length < 1) diffs.remove(diffs[i]);
						}
						--i;
					}
		
					if(diffs.length > 0 && diffs[0].length > 0)
					{
						//trace(diffs);
						CoolUtil.difficulties = diffs;
					}
				}
				
			/*	if(CoolUtil.difficulties.contains(CoolUtil.defaultDifficulty))
				{
					curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(CoolUtil.defaultDifficulty)-1));
				}
				else
				{*/
					//curDifficulty = 0;
				//}
		
				/*var newPos:Int = CoolUtil.difficulties.indexOf(lastDifficultyName);
				//trace('Pos of ' + lastDifficultyName + ' is ' + newPos);
				if(newPos > -1)
				{
					curDifficulty = newPos;
				}*/


				if(curSelected >= songs.length) curSelected = 0;
				bg.color = songs[curSelected].color;
				intendedColor = bg.color;


				
				diffBG = new FlxSprite(1365, 1095);
				diffBG.frames = Paths.getSparrowAtlas('freeplaymenu/songselect');
				diffBG.animation.addByPrefix('idle', 'song back0', 1, true);
				diffBG.animation.play('idle');
				diffBG.visible = false;
				diffBG.antialiasing = ClientPrefs.globalAntialiasing;
				
						
				diffBG.scale.set(0.2, 0.5);
				diffBG.updateHitbox();


				diffText = new FlxText(diffBG.x - 545, diffBG.y, FlxG.width, '< ' + getDiff() + ' >', 40);
				diffText.setFormat(Paths.font("Apocalypse Grunge.ttf"), 40, FlxColor.WHITE, CENTER);
				diffText.visible = false;
				diffText.antialiasing = ClientPrefs.globalAntialiasing;


				if (weekListNames[curTapeSelected] != 'Remember' && weekListNames[curTapeSelected] != 'Casualties' && weekListNames[curTapeSelected] != 'Revisions') {
					add(diffBG);
					add(diffText);
				}

				

			
				insert(members.indexOf(diffText)+1, tvScreen);


				changeSelection(0, false);
				changeDiff();
				updateScore();
				fixScorePos();
				updateFreeplayItems();
				changeDiff();
			


					
	}


	//Y VALUES FOR PUSHING
	// Num, Num+15, Num-580

	//ID:1 - SongText: 750 SongBG: 765, Icon: 170
	//ID:2 - SongText: 820 SongBG: 835, Icon: 240
	//ID:3 - SongText: 890 SongBG: 905, Icon: 310

	function getDiff() {
		if (CoolUtil.difficultyString() != null) {
		//	trace(CoolUtil.difficultyString());
			if (CoolUtil.difficultyString() == 'HARD'){
				return 'CANON';
			}  else if (CoolUtil.difficultyString() == 'NORMAL') {
				return 'EASIER';
			} else return CoolUtil.difficultyString();
		} else return '';
	}



	function updateFreeplayItems(){
		if (!inTrans && !inSubstate) 
		{

			grpSongBG.forEach(function(spr:FlxSprite) //Iterate over all freeplay bgs
			{

					
				if (spr.ID != curSelected) // Plays the animations
				{
				spr.animation.play('idle');
				spr.updateHitbox();
				} else {
				spr.animation.play('selected');
				spr.updateHitbox();
				}





				// SELECTION PUSHES OTHER SHIT DOWN FUCK ME HOW DO I DO THIS
	
	
				if(spr.ID > curSelected) // SongBG push
				{
					freeplayOffset = 100;

					switch(spr.ID)
					{
						case 1:
							spr.y = 750 + 15 + freeplayOffset;
						case 2:
							spr.y = 820 + 15 + freeplayOffset;
						case 3:
							spr.y = 890 + 15 + freeplayOffset;
					}

					grpSongs.forEach(function(text:FlxText)
					{		
						if (text.ID > curSelected) // SongText push
						{
							switch(text.ID)
							{
								case 1:
								text.y = 750 + freeplayOffset;
								case 2:
								text.y = 820 + freeplayOffset;
								case 3:
								text.y = 890 + freeplayOffset;
							}
						}
					});


					for (icon in 0...iconArray.length) // Icon push
					{
						if (iconArray[icon].ID > curSelected)
						{
							switch (iconArray[icon].ID)
							{
							case 1:
							iconArray[icon].y = 750 - 580 + freeplayOffset;
							case 2:
							iconArray[icon].y = 820 - 580 + freeplayOffset;
							case 3:
							iconArray[icon].y = 890 - 580 + freeplayOffset;
							}
						}
					}



				} else { // NORMAL FREEPLAY SPRITE POSITIONS


					switch(spr.ID) // SongBG NO push
					{
						case 1:
							spr.y = 750 + 15;
						case 2:
							spr.y = 820 + 15;
						case 3:
							spr.y = 890 + 15;
					}

					grpSongs.forEach(function(text:FlxText)
					{		
						switch(text.ID) // SongText NO push
						{
							case 1:
							text.y = 750;
							case 2:
							text.y = 820;
							case 3:
							text.y = 890;
						}
					});


					for (icon in 0...iconArray.length) // Icon NO push
					{
						switch (iconArray[icon].ID)
						{
							case 1:
							iconArray[icon].y = 750 - 580;
							case 2:
							iconArray[icon].y = 820 - 580;
							case 3:
							iconArray[icon].y = 890 - 580;
						}
					}
				}
	
					

			});
			
			

			if (infoTxt != null && grpSongs.members[curSelected] != null) {
				//updateScore();
			
				infoTxt.x = grpSongs.members[curSelected].x + 145;
				infoTxt.y = grpSongs.members[curSelected].y + 70;

				switch(grpSongs.members[curSelected].text){
					case 'Dragged Down To Hell':
						infoTxt.text = 'Enjoy the ride, Boyfriend.\n The show has only \njust begun..';
						infoTxt.x += 135;
						
						scoreTxt.x += 135;


					case 'Sacrilege':
						infoTxt.text = 'Business is as usual in\nHell, but something \nfeels off..';
						
					case 'Shachath':
						infoTxt.text = 'Pico and Darnell realize\ntheir only way to\nsave Boyfriend is to\nfight back.';

					case 'Angels Grace':
						infoTxt.text = 'Darnell has left,\nleaving Pico to take\none last stand.';


					case 'Amomos':
						infoTxt.text = 'Skid just so happened \nto be in the wrong \nplace at the wrong \ntime...';

					case 'Atonement':
						infoTxt.text = 'Pump was in the right place at the\nright time, and\ndespite all odds,\nhe made a difference.';

					case 'Devotion':
						infoTxt.text = 'Hope can only get you so far.';

					case 'Second Coming':
						infoTxt.text = 'Somehow, they\'re still awake.\nThey wont be going\ndown that easy.';


					case 'Flashy Sins':
						infoTxt.text = 'Nene joins the battle,\nmaking herself a\nflashy entrance.';

					case 'Apathetic Wrath':
						infoTxt.text = 'Beginning to free Darnell, Nene\ngains the upper hand.\nHopefully her luck\nwill last..';
						infoTxt.x += 50;

						scoreTxt.x += 50;

					case 'paralyzed':
						infoTxt.text = 'wtf pico time';

					case 'stronger':
						infoTxt.text = 'mom starts to uncorrupt pico will she win???';

					case 'final chance':
						infoTxt.text = 'fuck';


					case 'Underage User':
						infoTxt.text = 'boyfriend continues to\nharass children';

					case 'Spookychrome':
						infoTxt.text = 'When Pump got knocked out in\nDevotion, he didn\'t get\nthe luxury of being\nunconscious.';

					case 'Empty Memories':
						infoTxt.text = 'Surely they\'ll be back\nany day now.. right?';


					case 'Unmanageable':
						infoTxt.text = 'Try as you might, you can\nonly do so much when\nyou\'re surrounded.';

					case 'LORE':
						infoTxt.text = 'The origins of the corruption\nremain unknown,\nbut someone has\na theory.';


					case 'Angels Grace V5':
						infoTxt.text = 'An official remaster\nof the original\nAngel\'s Grace';

					case 'Dragged Down To Hell V1':
						infoTxt.text = 'Where it all started,\nthe first version\nof the first\nsong of the mod.';
						infoTxt.x += 180;

						scoreTxt.x += 180;
						
					default:
						infoTxt.text = 'bottom text';
				}

				//infoTxt.fieldHeight = 0;
			}


			

		}
	}
	
	function updateScore(){
		
		if (songs[curSelected] != null){
			intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
			intendedRating = Highscore.getRating(songs[curSelected].songName, curDifficulty);
			intendedMisses = Highscore.getMisses(songs[curSelected].songName, curDifficulty);
		


			ratingSplit = Std.string(Highscore.floorDecimal(intendedRating * 100, 2)).split('.');
			if(ratingSplit.length < 2) { //No decimals, add an empty space
				ratingSplit.push('');
			}
		
			while(ratingSplit[1].length < 2) { //Less than 2 decimals in it, add decimals then
				ratingSplit[1] += '0';
			}

		}
		

		if (scoreTxt != null && grpSongs.members[curSelected] != null) {
			scoreTxt.x = grpSongs.members[curSelected].x + 405;

			switch (grpSongs.members[curSelected].ID){
				case 0:
				scoreTxt.y = 680 + 108;

				case 1:
				scoreTxt.y = 750 + 108;

				case 2:
				scoreTxt.y = 820 + 108;

				case 3:
				scoreTxt.y = 890 + 108;
			}


			scoreTxt.text = 'SCORE: ' + intendedScore + '\n' + ratingSplit.join('.') + '% ' + getMissRating(intendedMisses);
			//trace(intendedMisses);
		}

	//	fixScorePos();
	}


	function openComputer(week:String) {
		
		if (!selectingSong) {

			FlxTween.tween(FlxG.camera, {zoom: 1.5}, 2, {type: ONESHOT, ease: FlxEase.cubeInOut}); // fuck it we zoom

			FlxTween.tween(arrow, {alpha: 0}, 2, {type: ONESHOT, ease: FlxEase.cubeInOut}); // fuck it we fade

			FlxTween.tween(camFollowPos, {x: tv.x + (tv.width / 2) - 15, y: tv.y + (tv.height / 2) - 15}, 2, {ease: FlxEase.cubeInOut, onComplete: // fuck it we move
				function(freeplayTween:FlxTween) {
					
					
					makeSongShit();
					curDifficulty = 0;
					fixScorePos();





					


			
				

				

			}});

		} else { //basically the same thing but skipping the animation stuff, selecting song true
			//freeplayTween.onComplete(freeplayTween);
			makeSongShit();
			FlxG.camera.zoom = 1.5;
			arrow.alpha = 0;
			camFollowPos.x = tv.x + (tv.width / 2) - 15;
			camFollowPos.y = tv.y + (tv.height / 2) - 15;
			tvScreen.visible = false;


			inTrans = false;
			selectingTape = false;
			selectingSong = true;
			grpSongs.visible = true;
			grpSongBG.visible = true;
			infoTxt.visible = true;
			scoreTxt.visible = true;

			diffBG.visible = true;
			diffText.visible = true;

			for (i in 0...iconArray.length)
				{
				iconArray[i].visible = true;
				}

			if (grpSongs != null) fixScorePos();
			


			
		}




		////////// init songs


		//for (i in 0...WeekData.weeksList.length) {

			

		/*		//KIND OF BROKEN NOW AND ALSO PRETTY USELESS//

		var initSonglist = CoolUtil.coolTextFile(Paths.txt('freeplaySonglist'));
		for (i in 0...initSonglist.length)
		{
			if(initSonglist[i] != null && initSonglist[i].length > 0) {
				var songArray:Array<String> = initSonglist[i].split(":");
				addSong(songArray[0], 0, songArray[1], Std.parseInt(songArray[2]));
			}
		}*/


		

	}

	function fixScorePos(){
		if (grpSongs.members[curSelected].text != null) {
			switch(grpSongs.members[curSelected].text){
				case 'Dragged Down To Hell':
					scoreTxt.x += 135;
				
				case 'Apathetic Wrath':
					scoreTxt.x += 50;
	
				case 'Dragged Down To Hell V1':
					scoreTxt.x += 180;
			}
		}
	}	

	function fixScorePosSubtract(){
		if (grpSongs.members[curSelected].text != null) {
			switch(grpSongs.members[curSelected].text){
				case 'Dragged Down To Hell':
					scoreTxt.x -= 135;
				
				case 'Apathetic Wrath':
					scoreTxt.x -= 50;
	
				case 'Dragged Down To Hell V1':
					scoreTxt.x -= 180;
			}
		}
	}	

	
	function closeComputer() {
		//inTv = true;
		//lastEnteredWeek = weekList[curTapeSelected];
		//trace('LAST WEEK: ' + lastEnteredWeek);


				
		FlxTween.tween(FlxG.camera, {zoom: 1}, 3, {type: ONESHOT, ease: FlxEase.cubeInOut}); // fuck it we zoom

		FlxTween.tween(arrow, {alpha: 1}, 3, {type: ONESHOT, ease: FlxEase.cubeInOut}); // fuck it we fade

		FlxTween.tween(camFollowPos, {x: oldCamPos[0], y: oldCamPos[1]}, 3, {ease: FlxEase.cubeInOut, onComplete: // fuck it we move
			function(twn:FlxTween) {
				selectingTape = true;
				selectingSong = false;
				inTv = false;
				inTrans = false;


			}}
		);
	}




	public static function destroyFreeplayVocals() {
		if(vocals != null) {
			vocals.stop();
			vocals.destroy();
		}
		vocals = null;
	}

	function changeDiff(change:Int = 0)
	{
		//if (!selectingTape && selectingSong) {

		curDifficulty += change;

		if (curDifficulty < 0)
			curDifficulty = CoolUtil.difficulties.length-1;
		if (curDifficulty >= CoolUtil.difficulties.length)
			curDifficulty = 0;

		//trace(curDifficulty);

		lastDifficultyName = CoolUtil.difficulties[curDifficulty];

		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
		intendedRating = Highscore.getRating(songs[curSelected].songName, curDifficulty);
		intendedMisses = Highscore.getMisses(songs[curSelected].songName, curDifficulty);
		#end

		


		PlayState.storyDifficulty = curDifficulty;


		diffText.text = '< ' + getDiff() + ' >';

		updateScore();


		//}
	}


	function changeTapeSelection(change:Int = 0, playSound:Bool = false)
	{
		curTapeSelected = change;

		if (curTapeSelected >= tapeShit.length)
			curTapeSelected = 0;
		if (curTapeSelected < 0)
			curTapeSelected = tapeShit.length - 1;

		

		if (curTapeSelected == 0 && tapePrologue != null){
			arrow.y = tapePrologue.y;

		} else if (curTapeSelected == 1 && tapePico != null){
			arrow.y = tapePico.y;

		} else if (curTapeSelected == 2 && tapeSpookers != null){
			arrow.y = tapeSpookers.y;

		} else if (curTapeSelected == 3 && tapeNene != null){
			arrow.y = tapeNene.y;

		} else if (curTapeSelected == 4 && tapeKms != null){
			arrow.y = tapeKms.y;

		} else if (curTapeSelected == 5 && tapeRemember != null){
			arrow.y = tapeRemember.y;

		} else if (curTapeSelected == 6 && tapeCasualties != null){
			arrow.y = tapeCasualties.y;
		
		} else if (curTapeSelected == 7 && tapeRevisions != null){
			arrow.y = tapeRevisions.y;

		}

	}



	function changeSelection(change:Int = 0, playSound:Bool = true)
	{
		if (!selectingTape && selectingSong) {
			
		
		if(playSound) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = songs.length - 1;
		if (curSelected >= songs.length)
			curSelected = 0;
		
		
			
		

		var newColor:Int = songs[curSelected].color;
		if(newColor != intendedColor) {
			if(colorTween != null) {
				colorTween.cancel();
			}
			intendedColor = newColor;
			colorTween = FlxTween.color(bg, 1, bg.color, intendedColor, {
				onComplete: function(twn:FlxTween) {
					colorTween = null;
				}
			});
		}


		// selector.y = (70 * curSelected) + 30;


		var bullShit:Int = 0;

	//	for (i in 0...iconArray.length)
	//	{
	//		iconArray[i].alpha = 1;
	//	}

		














		Paths.currentModDirectory = songs[curSelected].folder;
		PlayState.storyWeek = songs[curSelected].week;

	
		updateScore();
		//fixScorePos();
		updateFreeplayItems();

	}

	}
}

class SongMetadata
{
	public var songName:String = "";
	public var week:Int = 0;
	public var songCharacter:String = "";
	public var color:Int = -7179779;
	public var folder:String = "";

	public function new(song:String, week:Int, songCharacter:String, color:Int)
	{
		this.songName = song;
		this.week = week;
		this.songCharacter = songCharacter;
		this.color = color;
		this.folder = Paths.currentModDirectory;
		if(this.folder == null) this.folder = '';
	}
}