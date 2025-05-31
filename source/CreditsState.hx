package;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
#if MODS_ALLOWED
import sys.FileSystem;
import sys.io.File;
#end
import lime.utils.Assets;

using StringTools;

class CreditsState extends MusicBeatState
{
	var curSelected:Int = -1;

	private var grpOptions:FlxTypedGroup<FlxText>;

	private var grpSongBG:FlxTypedGroup<FlxSprite>;
	private var iconSelectArray:Array<FlxSprite> = [];

	private var iconArray:Array<FlxSprite> = [];
	private var creditsStuff:Array<Array<String>> = [];

	var bg:FlxSprite;

	var bookBG:FlxSprite;
	var largeSquare:FlxSprite;
	var largeSquareSelected:FlxSprite;
	var header:FlxText;
	var descText:FlxText;

	var intendedColor:Int;
	var colorTween:FlxTween;

	var selection:FlxSprite;

	var offsetThing:Float = 20;

	override function create()
	{	

		FlxG.mouse.visible = true;
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Viewing Credits", null);
		#end

		persistentUpdate = true;
		bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		add(bg);
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;

		bookBG = new FlxSprite().loadGraphic(Paths.image('creditsbg/creditsmenu'));
		add(bookBG);
		bookBG.screenCenter();
		bookBG.antialiasing = ClientPrefs.globalAntialiasing;

		largeSquare = new FlxSprite().loadGraphic(Paths.image('creditsbg/largeiconbg'));
		largeSquare.screenCenter();
		add(largeSquare);
		largeSquare.antialiasing = ClientPrefs.globalAntialiasing;

		largeSquareSelected = new FlxSprite().loadGraphic(Paths.image('creditsbg/largeiconbgSelected'));
		largeSquareSelected.screenCenter();
		add(largeSquareSelected);
		largeSquareSelected.visible = false;
		largeSquareSelected.antialiasing = ClientPrefs.globalAntialiasing;


		header = new FlxText(55, 30, FlxG.width, 'Credits', 80);
		header.setFormat(Paths.font("Courgette-Regular.ttf"), 80, FlxColor.BLACK, LEFT);
		add(header);
		header.antialiasing = ClientPrefs.globalAntialiasing;
		
		grpOptions = new FlxTypedGroup<FlxText>();
		add(grpOptions);


		grpSongBG = new FlxTypedGroup<FlxSprite>();
	



		#if MODS_ALLOWED
		var path:String = 'modsList.txt';
		if(FileSystem.exists(path))
		{
			var leMods:Array<String> = CoolUtil.coolTextFile(path);
			for (i in 0...leMods.length)
			{
				if(leMods.length > 1 && leMods[0].length > 0) {
					var modSplit:Array<String> = leMods[i].split('|');
					if(!Paths.ignoreModFolders.contains(modSplit[0].toLowerCase()) && !modsAdded.contains(modSplit[0]))
					{
						if(modSplit[1] == '1')
							pushModCreditsToList(modSplit[0]);
						else
							modsAdded.push(modSplit[0]);
					}
				}
			}
		}

		var arrayOfFolders:Array<String> = Paths.getModDirectories();
		arrayOfFolders.push('');
		for (folder in arrayOfFolders)
		{
			pushModCreditsToList(folder);
		}
		#end

		var pisspoop:Array<Array<String>> = [ //Name - Icon name - Description - Link - BG Color
			['NyaadiaUwU',		'nyaadiauwu',		'Director, Cutscene Artist, Animator, Sprite Artist, Musician', 'https://www.youtube.com/@buttercakeee',	'4c2f5c'],
			['Funny Man',		'funny',		'Musician',							 'https://www.youtube.com/c/funnymanisfunny',								'a4049c'],
			['WeegeeDude',		'weegee',		'Musician',							 'https://www.youtube.com/channel/UCg5XT_4bgwoOIz2WuomQcCg',								'047704'],
			['Ciovo',		'ciovo',		'Programmer',							 'https://www.youtube.com/channel/UCkGqVof19D21g7EYMhSc-Pg',								'5a544c'],
			['Iris (UB)',		'iris',		'Programmer',							 'https://www.youtube.com/channel/UCexN8DfrLVEZIxYhuFwJ1iA',								'cc1c44'],
			['VojBra',		'vojsiii',		'Main Charter',							 'https://x.com/voj_bra',								'e49c64'],
			['Targety',		'targety',		'Sprite + Background Artist, Charter',							 'https://www.youtube.com/channel/UC7vsrUiSHs4GhJVQXUMj0UA',								'd8cccc'],
			['LazeTheDayAway',		'Laze_Icons',		'Sprite Concept Designer + Artist',							 'https://www.youtube.com/channel/UC4QPs1NMnWMHnwomiLqmHsA',								'fb6304'],
			['Canumvenati',		'comedy',		'Sprite Artist',							 'https://www.youtube.com/channel/UCJfvyjSsUgnXbwzwmbLRMDw',								'cb9e44'],
			['SMG2',		'SMG2',		'Charter',							 'https://www.youtube.com/@smg2547',								'383c40'],
			['Greew',		'greew',		'Sprite Artist and Animator',							 'https://www.youtube.com/channel/UC2HvmF6w0q-7RV5-ymKZz6w',								'afadc0'],
			['CharliePK',		'charliereal2',		'Icon Artist',							 'https://www.youtube.com/c/UnknownCharlie69',								'242334'],
			['MAT',		'mat',		'Concept and Sprite Artist',							 'https://x.com/MAT_DoesStuff',								'b44434'],
			['ImThatBlueWolf',		'wolf',		'Musician',							 'https://www.youtube.com/channel/UCWp91xhi1378g1tA1GjP-xw',								'0444bc'],
			['Pot',		'pot',		'Artist and Animator',							 'https://x.com/MAT_DoesStuff',								'a4a4a4'],
			['AveryMadness',		'avery',		'Programmer',							 'https://x.com/AveryMadness',								'7c5c2c'],
			['Spingo',		'spingo',		'Artist and Animator',							 'https://www.youtube.com/channel/UC7PXdjvIJ-qJWBYIN0Zh7jA',								'f4eaf3'],
			['bakugo',		'bakugo',		'Creator of the Demo Build + Charter & Programmer',							 'https://www.youtube.com/@CommanderVideo_',								'7be7ea'],
			['Mikytoon',		'mikytoon',		"Week portrait + Loading screen Artist",							 'https://x.com/Mikytoon64',								'342c2a'],
			['Memey',		'memeythememe',		"Created the cutscene for 'Underage User'",							 'https://www.youtube.com/channel/UCuEVCGzo3UJP4LYHUirhIFg',								'fae15b'],
			['DyanEstella',		'dyan',		'dyan',							 'https://www.youtube.com/@DyanEstella::5c869d',								'5c869d'],
			['PhantomFear',		'phantomfear',		'Creator of FNF Corruption',							 'https://www.youtube.com/@phantomfearyt',								'08e49f'],
		];
		
		for(i in pisspoop){
			creditsStuff.push(i);
		}
	
		for (i in 0...creditsStuff.length)
		{
			var isSelectable:Bool = !unselectableCheck(i);
			var optionText:FlxText = new FlxText(380, 360, FlxG.width, creditsStuff[i][0], 80);
			optionText.setFormat(Paths.font("Univers 85 Extra Black Regular.otf"), 80, FlxColor.BLACK, CENTER);
			optionText.antialiasing = ClientPrefs.globalAntialiasing;
			//optionText.snapToPosition();
			grpOptions.add(optionText);

			if(isSelectable) {
				if(creditsStuff[i][5] != null)
				{
					Paths.currentModDirectory = creditsStuff[i][5];
				}

				var icon:FlxSprite = new FlxSprite(881, 69).loadGraphic(Paths.image('credits/' + creditsStuff[i][1]));
				icon.origin.set(icon.width / 2, icon.height / 2);
				icon.scale.set(1.8, 1.8);
				icon.antialiasing = ClientPrefs.globalAntialiasing;
				icon.updateHitbox();
				//icon.xAdd = optionText.width + 10;
				//icon.sprTracker = optionText;
	
				// using a FlxGroup is too much fuss!
				iconArray.push(icon);
				add(icon);
				Paths.currentModDirectory = '';

				if(curSelected == -1) curSelected = i;





				var iconicon:FlxSprite = new FlxSprite().loadGraphic(Paths.image('credits/' + creditsStuff[i][1]));
				iconSelectArray.push(iconicon);

				iconicon.scale.set(0.55, 0.55); // Made every icon 150x150 so it was easier to scale to 100x100
				iconicon.updateHitbox();
				iconicon.antialiasing = ClientPrefs.globalAntialiasing;
				add(iconicon);


				var songBG:FlxSprite = new FlxSprite(30 + (i * 100), 140).loadGraphic(Paths.image('creditsbg/iconbg'));
				songBG.antialiasing = ClientPrefs.globalAntialiasing;
				grpSongBG.add(songBG);

				//iconicon.x = songBG.x + 12;
				//iconicon.y = songBG.y + 12;


			}
		}

		add(grpSongBG);

		for (i in 0...5) {
			if (grpSongBG.members[i + 5] != null) {
				grpSongBG.members[i + 5].x = 30 + (i * 100);
				grpSongBG.members[i + 5].y = 140 + 105;
			}
			
			if (grpSongBG.members[i + 10] != null) {
				grpSongBG.members[i + 10].x = 30 + (i * 100);
				grpSongBG.members[i + 10].y = 140 + 210;
			}

			if (grpSongBG.members[i + 15] != null) {
				grpSongBG.members[i + 15].x = 30 + (i * 100);
				grpSongBG.members[i + 15].y = 140 + 315;
			}

			if (grpSongBG.members[i + 20] != null) {
				grpSongBG.members[i + 20].x = 30 + (i * 100);
				grpSongBG.members[i + 20].y = 140 + 420;
			}
		}

		for (a in 0...iconSelectArray.length) {
			iconSelectArray[a].x = grpSongBG.members[a].x + 9;
			iconSelectArray[a].y = grpSongBG.members[a].y + 10;
		}


		descText = new FlxText(768, FlxG.height-200, 500, "", 45);
		descText.setFormat(Paths.font("Courgette-Regular.ttf"), 45, FlxColor.BLACK, CENTER/*, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK*/);
		descText.bold = true;
		descText.antialiasing = ClientPrefs.globalAntialiasing;
		descText.scrollFactor.set();
		//descText.borderSize = 2.4;
		add(descText);

		selection = new FlxSprite().loadGraphic(Paths.image('creditsbg/selectedbg'));
		selection.antialiasing = ClientPrefs.globalAntialiasing;
		add(selection);

		bg.color = getCurrentBGColor();
		intendedColor = bg.color;
		changeSelection();
		
		addTouchPad("UP_DOWN", "A_B");
		
		super.create();
	}

	var quitting:Bool = false;
	var holdTime:Float = 0;
	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if(!quitting)
		{
			if(creditsStuff.length > 1)
			{

				var shiftMult:Int = 1;
				if(FlxG.keys.pressed.SHIFT) shiftMult = 3;

				var upP = controls.UI_LEFT_P;
				var downP = controls.UI_RIGHT_P;

				if (upP)
				{
					changeSelection(curSelected -1);
					holdTime = 0;
				}
				if (downP)
				{
					changeSelection(curSelected + 1);
					holdTime = 0;
				}

				if(controls.UI_DOWN || controls.UI_UP)
				{
					var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
					holdTime += elapsed;
					var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

					if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
					{
						changeSelection(curSelected + (checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult));
					}
				}
			}

			if(controls.ACCEPT && (creditsStuff[curSelected][3] == null || creditsStuff[curSelected][3].length > 4) || FlxG.mouse.justPressed && FlxG.mouse.overlaps(grpSongBG.members[curSelected]) || FlxG.mouse.justPressed && FlxG.mouse.overlaps(iconArray[curSelected])) {
				CoolUtil.browserLoad(creditsStuff[curSelected][3]);
			}
			if (controls.BACK)
			{
				if(colorTween != null) {
					colorTween.cancel();
				}
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new MainMenuState());
				quitting = true;
			}
		}
		
		
		super.update(elapsed);





		if (FlxG.mouse.justMoved)
			{
				for (i in 0...creditsStuff.length)
				{
					if (i != curSelected)
					{
						if (FlxG.mouse.overlaps(grpSongBG.members[i]) && !FlxG.mouse.overlaps(grpSongBG.members[curSelected]))
						{
							//FlxG.sound.play(Paths.sound('scrollMenu'));
							changeSelection(i);
						}

						if (FlxG.mouse.overlaps(iconArray[curSelected]) && !FlxG.mouse.overlaps(grpSongBG.members[curSelected]) && !FlxG.mouse.overlaps(grpSongBG.members[i])) largeSquareSelected.visible = true else largeSquareSelected.visible = false;
					}
				}
			}
	}

	function changeSelection(change:Int = -2)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		do {
			if (change > -2) curSelected = change;
			
			if (curSelected < 0)
				curSelected = creditsStuff.length - 1;
			if (curSelected >= creditsStuff.length)
				curSelected = 0;
		} while(unselectableCheck(curSelected));

		selection.x = grpSongBG.members[curSelected].x;
		selection.y = grpSongBG.members[curSelected].y;

		var newColor:Int =  getCurrentBGColor();
		if(newColor != intendedColor) {
			if(colorTween != null) {
				colorTween.cancel();
			}
			intendedColor = newColor;
			colorTween = FlxTween.color(bg, 0.8, bg.color, intendedColor, {
				onComplete: function(twn:FlxTween) {
					colorTween = null;
				}
			});
		}



		var maxWidth = 470;
		for (i in 0...grpOptions.members.length) {
			grpOptions.members[i].alpha = 0;

			if (grpOptions.members[i].textField.textWidth > maxWidth) grpOptions.members[i].scale.set(maxWidth / grpOptions.members[i].textField.textWidth, maxWidth / grpOptions.members[i].textField.textWidth);
		}
		grpOptions.members[curSelected].alpha = 1;

		for (j in 0...iconArray.length)
		{
			iconArray[j].alpha = 0;
		}
		iconArray[curSelected].alpha = 1;
		
		
		descText.text = creditsStuff[curSelected][2];
		//descText.y = FlxG.height - descText.height + offsetThing - 60;

	}

	#if MODS_ALLOWED
	private var modsAdded:Array<String> = [];
	function pushModCreditsToList(folder:String)
	{
		if(modsAdded.contains(folder)) return;

		var creditsFile:String = null;
		if(folder != null && folder.trim().length > 0) creditsFile = Paths.mods(folder + '/data/credits.txt');
		else creditsFile = Paths.mods('data/credits.txt');

		if (FileSystem.exists(creditsFile))
		{
			var firstarray:Array<String> = File.getContent(creditsFile).split('\n');
			for(i in firstarray)
			{
				var arr:Array<String> = i.replace('\\n', '\n').split("::");
				if(arr.length >= 5) arr.push(folder);
				creditsStuff.push(arr);
			}
			creditsStuff.push(['']);
		}
		modsAdded.push(folder);
	}
	#end

	function getCurrentBGColor() {
		var bgColor:String = creditsStuff[curSelected][4];
		if(!bgColor.startsWith('0x')) {
			bgColor = '0xFF' + bgColor;
		}
		return Std.parseInt(bgColor);
	}

	private function unselectableCheck(num:Int):Bool {
		return creditsStuff[num].length <= 1;
	}
}