package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.sound.FlxSound;

import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.net.curl.CURLCode;
import flixel.graphics.FlxGraphic;
import WeekData;

using StringTools;

class StoryMenuState extends MusicBeatState
{
	public static var weekCompleted:Map<String, Bool> = new Map<String, Bool>();

	var scoreText:FlxText;

	var pageNum:FlxText;

	private static var lastDifficultyName:String = '';
	var curDifficulty:Int = 1;

	var txtWeekTitle:FlxText;
	var bgSprite:FlxSprite;

	var bookBG:FlxSprite;

	private static var curWeek:Int = 0;

	var txtTracklist:FlxText;

	var grpWeekText:FlxTypedGroup<MenuItem>;
	var grpWeekCharacters:FlxTypedGroup<MenuCharacter>;

	//var grpLocks:FlxTypedGroup<FlxSprite>;

	var difficultySelectors:FlxGroup;
	var sprDifficulty:FlxText;
	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;

	var loadedWeeks:Array<WeekData> = [];

	var tracksSprite:FlxText;

	var lock:FlxSprite;
	var lockText:FlxText;


	var blackScreen:FlxSprite;



	function weekIsCompleted(name:String){
		return StoryMenuState.weekCompleted.get(name);
	}



	override function create()
	{
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();
		FlxG.mouse.visible = false;
		

		PlayState.isStoryMode = true;
		WeekData.reloadWeekFiles(true);
		if(curWeek >= WeekData.weeksList.length) curWeek = 0;
		persistentUpdate = persistentDraw = true;


		if (curWeek == 3 && weekIsCompleted('Nene')) curWeek = 4;
		


		bookBG = new FlxSprite(0, 0, Paths.image('storymenu/bookbg'));
		bookBG.antialiasing = ClientPrefs.globalAntialiasing;
		bookBG.scale.set(0.66666667, 0.66666667);
		bookBG.updateHitbox();
		bookBG.screenCenter();


		scoreText = new FlxText(300, 580, 1280, "SCORE: 49324858", 50);
		scoreText.setFormat(Paths.font("Cookie-Regular.ttf"), 50, FlxColor.BLACK, CENTER);
		scoreText.antialiasing = ClientPrefs.globalAntialiasing;
		scoreText.scale.y = 1.1;
		//scoreText.color = 0xFF000000;



		pageNum = new FlxText(520, 625, 1280, "", 50);
		pageNum.setFormat(Paths.font("Cookie-Regular.ttf"), 50, FlxColor.BLACK, CENTER);
		pageNum.antialiasing = ClientPrefs.globalAntialiasing;
		//pageNum.scale.y = 1.1;
		//pageNum.color = 0xFF000000;

		txtWeekTitle = new FlxText(10, 60, 700, "", 60);
		txtWeekTitle.setFormat(Paths.font("Courgette-Regular.ttf"), 60, FlxColor.BLACK, CENTER);
		txtWeekTitle.alpha = 1;
		txtWeekTitle.antialiasing = ClientPrefs.globalAntialiasing;

		var rankText:FlxText = new FlxText(0, 10);
		rankText.text = 'RANK: GREAT';
		rankText.setFormat(Paths.font("Courgette-Regular.ttf"), 32);
		rankText.size = scoreText.size;
		rankText.screenCenter(X);

		var ui_tex = Paths.getSparrowAtlas('storymenu/menu_assets');
		var bgYellow:FlxSprite = new FlxSprite(0, 56).makeGraphic(FlxG.width, 386, 0xFFF9CF51);

		//bgSprite = new FlxSprite(-1078, -1212);
		bgSprite = new FlxSprite(147, 212.5);
		bgSprite.antialiasing = ClientPrefs.globalAntialiasing;
		//bgSprite.scale.set(0.14, 0.13); holy fuck i shouldve just downscaled the images in pdn this shit was so slow
		//bgSprite.updateHitbox();

		

		grpWeekText = new FlxTypedGroup<MenuItem>();
		add(grpWeekText);

		var blackBarThingie:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, 56, FlxColor.BLACK);
		//add(blackBarThingie);

		grpWeekCharacters = new FlxTypedGroup<MenuCharacter>();

		//grpLocks = new FlxTypedGroup<FlxSprite>();
		

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Selecting a Chapter", null);
		#end

		var num:Int = 0;
		for (i in 0...WeekData.weeksList.length)
		{
			var weekFile:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[i]);
			var isLocked:Bool = weekIsLocked(WeekData.weeksList[i]);
			if(!isLocked || !weekFile.hiddenUntilUnlocked)
			{
				loadedWeeks.push(weekFile);
				WeekData.setDirectoryFromWeek(weekFile);
				var weekThing:MenuItem = new MenuItem(0, bgSprite.y + 396, WeekData.weeksList[i]);
				weekThing.y += ((weekThing.height + 20) * num);
				weekThing.targetY = num;
				grpWeekText.add(weekThing);

				weekThing.screenCenter(X);
				weekThing.visible = false;

				weekThing.antialiasing = ClientPrefs.globalAntialiasing;
				// weekThing.updateHitbox();

				// Needs an offset thingie

				num++;
			}
		}

		WeekData.setDirectoryFromWeek(loadedWeeks[0]);
		var charArray:Array<String> = loadedWeeks[0].weekCharacters;
		for (char in 0...3)
		{
			var weekCharacterThing:MenuCharacter = new MenuCharacter((FlxG.width * 0.25) * (1 + char) - 150, charArray[char]);
			weekCharacterThing.y += 70;
			grpWeekCharacters.add(weekCharacterThing);
		}

		



		CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();
		if(lastDifficultyName == '')
		{
			lastDifficultyName = CoolUtil.defaultDifficulty;
		}
		curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(lastDifficultyName)));
		
		//sprDifficulty = new FlxSprite(0, leftArrow.y);
		//sprDifficulty.antialiasing = ClientPrefs.globalAntialiasing;
		//difficultySelectors.add(sprDifficulty);


	

		//add(bgYellow);
		add(bookBG);
		add(bgSprite);

					lock = new FlxSprite(840, 425);
					lock.frames = ui_tex;
					lock.animation.addByPrefix('lock', 'LOCKED0');
					lock.animation.play('lock');
					lock.antialiasing = ClientPrefs.globalAntialiasing;
					add(lock);
					lock.visible = false;
					

					lockText = new FlxText(815, 525, 250, "Beat previous weeks to unlock!", 40);
					lockText.alignment = CENTER;
					lockText.font = Paths.font("Cookie-Regular.ttf");
					lockText.antialiasing = ClientPrefs.globalAntialiasing;
					lockText.color = 0xFF000000;
					lockText.bold = true;
					add(lockText);
					lockText.visible = false;

		//add(grpLocks);

		difficultySelectors = new FlxGroup();
		add(difficultySelectors);

		leftArrow = new FlxSprite(865, 510);
		leftArrow.frames = ui_tex;
		leftArrow.animation.addByPrefix('idle', "arrowdown0");
		leftArrow.animation.addByPrefix('press', "arrowdown select0");
		leftArrow.animation.play('idle');
		leftArrow.antialiasing = ClientPrefs.globalAntialiasing;
		difficultySelectors.add(leftArrow);

		rightArrow = new FlxSprite(865, 390);
		rightArrow.frames = ui_tex;
		rightArrow.animation.addByPrefix('idle', 'arrow up0');
		rightArrow.animation.addByPrefix('press', "arrow up select0", 24, false);
		rightArrow.animation.play('idle');
		rightArrow.antialiasing = ClientPrefs.globalAntialiasing;
		difficultySelectors.add(rightArrow);

		sprDifficulty = new FlxText(600, leftArrow.y - 60, FlxG.width, "", 64);
		sprDifficulty.alignment = CENTER;
		sprDifficulty.font = Paths.font("Courgette-Regular.ttf");
		sprDifficulty.color = 0xFF000000;
		sprDifficulty.bold = true;
		sprDifficulty.antialiasing = ClientPrefs.globalAntialiasing;
		difficultySelectors.add(sprDifficulty);

		//add(grpWeekCharacters);

		tracksSprite = new FlxText(700, 55, 0, "Verses", 64);
		tracksSprite.antialiasing = ClientPrefs.globalAntialiasing;
		tracksSprite.font = rankText.font;
		tracksSprite.color = 0xFF000000;
		add(tracksSprite);

		txtTracklist = new FlxText(FlxG.width * 0.05, tracksSprite.y + 125, 0, "", 40);
		txtTracklist.alignment = LEFT;
		txtTracklist.font = rankText.font;
		txtTracklist.color = 0xFF000000;
		txtTracklist.antialiasing = ClientPrefs.globalAntialiasing;
		add(txtTracklist);
		// add(rankText);
		add(scoreText);
		add(txtWeekTitle);
		add(pageNum);




		blackScreen = new FlxSprite().makeGraphic(1, 1, FlxColor.BLACK);
		blackScreen.scale.set(FlxG.width, FlxG.height);
		blackScreen.screenCenter();
		blackScreen.alpha = 0.0001;
		add(blackScreen);


		
		changeDifficulty();
		updateText();

		changeWeek();
		changeDifficulty();
		updateText();

		super.create();
	}
	

	override function closeSubState() {
		persistentUpdate = true;
		changeWeek();
		super.closeSubState();
	}



	override function update(elapsed:Float)
	{
		// scoreText.setFormat('VCR OSD Mono', 32);
		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, CoolUtil.boundTo(elapsed * 30, 0, 1)));
		if(Math.abs(intendedScore - lerpScore) < 10) lerpScore = intendedScore;



		var ratingSplit:Array<String> = Std.string(Highscore.floorDecimal(intendedRating * 100, 2)).split('.');
		if(ratingSplit.length < 2) { //No decimals, add an empty space
			ratingSplit.push('');
		}
		
		while(ratingSplit[1].length < 2) { //Less than 2 decimals in it, add decimals then
			ratingSplit[1] += '0';
		}

		//scoreText.text = 'PERSONAL BEST: ' + lerpScore + ' (' + ratingSplit.join('.') + '%)';
		if (intendedScore > 0){
			scoreText.text = '' + intendedScore + ' - ' + ratingSplit.join('.') + '% (' + getRating(intendedRating) + ')';
		 } else{
			scoreText.text = '0';
		 }

		// FlxG.watch.addQuick('font', scoreText.font);

		if (!movedBack && !selectedWeek)
		{
			var upP = controls.UI_LEFT_P;
			var downP = controls.UI_RIGHT_P;
			if (upP)
			{
				changeWeek(-1);
				FlxG.sound.play(Paths.sound('pageFlip'));
			}

			if (downP)
			{
				changeWeek(1);
				FlxG.sound.play(Paths.sound('pageFlip'));
			}

			if(FlxG.mouse.wheel != 0)
			{
				FlxG.sound.play(Paths.sound('pageFlip'), 0.4);
				changeWeek(-FlxG.mouse.wheel);
				changeDifficulty();
			}

			if (controls.UI_UP)
				rightArrow.animation.play('press')
			else
				rightArrow.animation.play('idle');

			if (controls.UI_DOWN)
				leftArrow.animation.play('press');
			else
				leftArrow.animation.play('idle');

			if (controls.UI_UP_P)
				changeDifficulty(1);
			else if (controls.UI_DOWN_P)
				changeDifficulty(-1);
			else if (upP || downP)
				changeDifficulty();

			if(FlxG.keys.justPressed.CONTROL)
			{
				persistentUpdate = false;
				openSubState(new GameplayChangersSubstate());
			}
			else if(controls.RESET)
			{
				persistentUpdate = false;
				openSubState(new ResetScoreSubState('', curDifficulty, '', curWeek));
				//FlxG.sound.play(Paths.sound('scrollMenu'));
			}
			else if (controls.ACCEPT)
			{
				selectWeek();
			}
		}

		if (controls.BACK && !movedBack && !selectedWeek)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			movedBack = true;
			LoadingState.loadSprite = null;
			MusicBeatState.switchState(new MainMenuState());
		}

		super.update(elapsed);

		//grpLocks.forEach(function(lock:FlxSprite)
		//{
			//lock.y = grpWeekText.members[lock.ID].y;
			//lock.visible = (lock.y > FlxG.height / 2);
	//	});

		if (leftArrow.animation.curAnim.name == "press") { // subtract to go right/down
			leftArrow.offset.set(17.5, 11.5 - 2.5);
			leftArrow.scale.set(0.6, 0.6);

		} else {
			leftArrow.offset.set(0, 0);
			leftArrow.scale.set(0.8, 0.8);
		}

		if (rightArrow.animation.curAnim.name == "press") {
			rightArrow.offset.set(17.5, 11.5 + 2.5);
			rightArrow.scale.set(0.6, 0.6);

		} else {
			rightArrow.offset.set(0, 0);
			rightArrow.scale.set(0.8, 0.8);
		}

	}

	var movedBack:Bool = false;
	var selectedWeek:Bool = false;
	var stopspamming:Bool = false;

	function selectWeek()
	{
		if (!weekIsLocked(loadedWeeks[curWeek].fileName))
		{
			if (stopspamming == false)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));

				//grpWeekText.members[curWeek].startFlashing();

				for (char in grpWeekCharacters.members)
				{
					if (char.character != '' && char.hasConfirmAnimation)
					{
						char.animation.play('confirm');
					}
				}
				stopspamming = true;
			}

			// We can't use Dynamic Array .copy() because that crashes HTML5, here's a workaround.
			var songArray:Array<String> = [];
			var leWeek:Array<Dynamic> = loadedWeeks[curWeek].songs;
			for (i in 0...leWeek.length) {
				songArray.push(leWeek[i][0]);
			}

			// Nevermind that's stupid lmao
			PlayState.storyPlaylist = songArray;
			PlayState.isStoryMode = true;

			PlayState.initialPlaylist = songArray.length;

			selectedWeek = true;

			var diffic = CoolUtil.getDifficultyFilePath(curDifficulty);
			if(diffic == null) diffic = '';

			PlayState.storyDifficulty = curDifficulty;

			PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());
			PlayState.campaignScore = 0;
			PlayState.campaignMisses = 0;
			PlayState.campaignRating = [];

			LoadingState.loadSprite = loadedWeeks[curWeek].fileName;

			//trace(LoadingState.loadSprite);
			

			FlxTween.tween(FlxG.camera, {zoom: 2}, 7, {type: ONESHOT, ease: FlxEase.cubeInOut});
			FlxG.sound.music.fadeOut(3, 0);


			new FlxTimer().start(0.5, function(tmr:FlxTimer)
				{
					FlxTween.tween(blackScreen, {alpha: 1}, 2.5, {onComplete:
						function(twn:FlxTween) {
							LoadingState.loadAndSwitchState(new PlayState(), true);
							FreeplayState.destroyFreeplayVocals();
						}}
					);

				});

		} else {
			FlxG.sound.play(Paths.sound('cancelMenu'));
		}
	}

	var tweenDifficulty:FlxTween;
	function changeDifficulty(change:Int = 0):Void
	{
		curDifficulty += change;

		if (curDifficulty < 0)
			curDifficulty = CoolUtil.difficulties.length-1;
		if (curDifficulty >= CoolUtil.difficulties.length)
			curDifficulty = 0;

		WeekData.setDirectoryFromWeek(loadedWeeks[curWeek]);

		var diff:String = CoolUtil.difficulties[curDifficulty].toUpperCase();
		var newImage:FlxGraphic = Paths.image('menudifficulties/' + Paths.formatToSongPath(diff));
		//trace(Paths.currentModDirectory + ', menudifficulties/' + Paths.formatToSongPath(diff));
		if (diff == 'HARD') diff = 'CANON' else if (diff == 'NORMAL') diff = 'EASIER';

		if(sprDifficulty.text != diff)
		{
			sprDifficulty.text = diff;

			//sprDifficulty.font = Paths.font("Courgette-Regular.ttf");
			//sprDifficulty.alpha = 0;
			sprDifficulty.color = 0xFF000000;
			sprDifficulty.x = leftArrow.x - 570;
			sprDifficulty.y = leftArrow.y - 65;

			if(tweenDifficulty != null) tweenDifficulty.cancel();
			tweenDifficulty = FlxTween.tween(sprDifficulty, {y: leftArrow.y - 65, alpha: 1}, 0.07, {onComplete: function(twn:FlxTween)
			{
				tweenDifficulty = null;
			}});
		}
		lastDifficultyName = diff;

		#if !switch
		intendedScore = Highscore.getWeekScore(loadedWeeks[curWeek].fileName, curDifficulty);
		intendedRating = Highscore.getWeekRating(loadedWeeks[curWeek].fileName, curDifficulty);

		#end
	}

	function getRating(value:Float = 0) {
		if (value == 0) return '';

		else if (value <= 0.5)  return 'F';

		else if (value >= 0.9)  return 'A';

		else if (value >= 0.8)  return 'B';

		else if (value >= 0.7)  return 'C';

		else return 'D';
	}


	var lerpScore:Int = 0;
	var intendedScore:Int = 0;

	var intendedRating:Float = 0;

	function changeWeek(change:Int = 0):Void
	{
		curWeek += change;

		if (curWeek >= loadedWeeks.length)
			curWeek = 0;
		if (curWeek < 0)
			curWeek = loadedWeeks.length - 1;

		var leWeek:WeekData = loadedWeeks[curWeek];
		WeekData.setDirectoryFromWeek(leWeek);

		var leName:String = leWeek.storyName;
		txtWeekTitle.text = leName.toUpperCase();
		txtWeekTitle.bold = true;
		
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Selecting a Chapter", "Viewing: " + leName);
		#end

		if (leName.toUpperCase() == 'SHATTERED INNOCENCE') {
			txtWeekTitle.size = 52;
			//txtWeekTitle.scale.x = 0.9;
			txtWeekTitle.scale.y = 1;

			//txtWeekTitle.size = 60;
			//txtWeekTitle.scale.x = 1;
			txtWeekTitle.y = 65;
			txtWeekTitle.fieldWidth = 700;
			txtWeekTitle.x = 0;

		} else if (leName.toUpperCase() == 'THE HOUSE ALWAYS WINS') {
			//txtWeekTitle.size = 55;
			txtWeekTitle.y = 30;

			txtWeekTitle.size = 60;
			txtWeekTitle.scale.x = 1;
			txtWeekTitle.scale.y = 0.85;
			txtWeekTitle.fieldWidth = 700;
			txtWeekTitle.x = 10;
			//txtWeekTitle.y = 60;

		} else if (leName == 'wtf kms its mommy mearest from friday night funkin wtf') {
			txtWeekTitle.size = 30;
			//txtWeekTitle.size = 60;
			txtWeekTitle.scale.x = 1;
			txtWeekTitle.scale.y = 1;
			txtWeekTitle.y = 60;
			txtWeekTitle.fieldWidth = 600;
			txtWeekTitle.x = 50;

		} else {
			txtWeekTitle.size = 60;
			txtWeekTitle.scale.x = 1;
			txtWeekTitle.scale.y = 1;
			txtWeekTitle.y = 60;
			txtWeekTitle.fieldWidth = 700;
			txtWeekTitle.x = 10;

		}
		
		
		//txtWeekTitle.x = (txtWeekTitle.width + 30);

		var bullShit:Int = 0;

		var unlocked:Bool = !weekIsLocked(leWeek.fileName);
		for (item in grpWeekText.members)
		{
			item.targetY = bullShit - curWeek;
			if (item.targetY == Std.int(0) && unlocked)
				item.alpha = 1;
			else
				item.alpha = 0.6;
			bullShit++;
		}

		bgSprite.visible = true;
		var assetName:String = leWeek.weekBackground;
		if(assetName == null || assetName.length < 1) {
			bgSprite.visible = false;
		} else {
			bgSprite.loadGraphic(Paths.image('menubackgrounds/' + assetName));
		}


			PlayState.storyWeek = curWeek;
			

		CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();
		var diffStr:String = WeekData.getCurrentWeek().difficulties;
		if(diffStr != null) diffStr = diffStr.trim(); //Fuck you HTML5
		difficultySelectors.visible = true;

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
				CoolUtil.difficulties = diffs;
			}
		}
		
		if(CoolUtil.difficulties.contains(CoolUtil.defaultDifficulty))
		{
			curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(CoolUtil.defaultDifficulty)-1));
		}
		else
		{
			curDifficulty = 0;
		}

		var newPos:Int = CoolUtil.difficulties.indexOf(lastDifficultyName);
		//trace('Pos of ' + lastDifficultyName + ' is ' + newPos);
		if(newPos > -1)
		{
			curDifficulty = newPos;
		}
		changeDifficulty();
		updateText();
	}

	function weekIsLocked(name:String):Bool {
		var leWeek:WeekData = WeekData.weeksLoaded.get(name);
		return (!leWeek.startUnlocked && leWeek.weekBefore.length > 0 && (!weekCompleted.exists(leWeek.weekBefore) || !weekCompleted.get(leWeek.weekBefore)));
	}

	function updateText()
	{
		var weekArray:Array<String> = loadedWeeks[curWeek].weekCharacters;
		for (i in 0...grpWeekCharacters.length) {
			grpWeekCharacters.members[i].changeCharacter(weekArray[i]);
		}

		var leWeek:WeekData = loadedWeeks[curWeek];
		var stringThing:Array<String> = [];
		for (i in 0...leWeek.songs.length) {
			stringThing.push(leWeek.songs[i][0]);
		}

		txtTracklist.text = '';

		var weekLocked:Bool = weekIsLocked(leWeek.fileName);
		if (weekLocked) { //Week is locked, song names are obscured

		for (i in 0...stringThing.length)
		{
			txtTracklist.text += '- ' + '??????' + '\n';
		} 

			leftArrow.visible = false;
			rightArrow.visible = false;
			sprDifficulty.visible = false;
			scoreText.visible = false;
			lock.visible = true;
			lockText.visible = true;

		} else {
		for (i in 0...stringThing.length) // Week is unlocked
			{
				if (stringThing[i] == 'Angels Grace') {
					txtTracklist.text += '- ' + 'Angel\'s Grace' + '\n';

				} else {

				txtTracklist.text += '- ' + stringThing[i] + '\n';
				}
			} 


			leftArrow.visible = true;
			rightArrow.visible = true;
			sprDifficulty.visible = true;
			scoreText.visible = true;
			lock.visible = false;
			lockText.visible = false;

		}


		if (curWeek == 0) {
			pageNum.text = 'i';
		} else if (curWeek == 1) {
			pageNum.text = 'ii';
		} else if (curWeek == 2) {
			pageNum.text = 'iii';
		} else if (curWeek == 3) {
			pageNum.text = 'iv';
		} else if (curWeek == 4) {
			pageNum.text = 'v';
		} else {
			pageNum.text = '' + (curWeek + 1);
		}


		//txtTracklist.text = txtTracklist.text.toUpperCase();

		//txtTracklist.screenCenter(X);
		txtTracklist.x = tracksSprite.x;

		#if !switch
		intendedScore = Highscore.getWeekScore(loadedWeeks[curWeek].fileName, curDifficulty);
		
		intendedRating = Highscore.getWeekRating(loadedWeeks[curWeek].fileName, curDifficulty);
		#end
	}
}
