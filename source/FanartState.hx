package;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.FlxCamera;
import flixel.util.FlxTimer;
#if MODS_ALLOWED
import sys.FileSystem;
import sys.io.File;
#end
import lime.utils.Assets;

using StringTools;

class FanartState extends MusicBeatState
{
	var curSelected:Int = 0;

	var weekBG:FlxSprite;


	var camOther:FlxCamera;
	var blackScreen:FlxSprite;

	var directories:Array<String> = [
		'Prologue',
		'Pico',
		'CandyShop',
		'CandyShopDay',
		'CandyShopNight',
		'Nene',
	];

	var curArtNames:Array<String> = [];

	var curArt:Array<FlxSprite> = [];
	var curText:Array<FlxText> = [];

	var textBG:FlxSprite;
	var text:FlxText;

	var curPage:Int = 0;
	var maxPage:Int = -1;

	var pageCount:FlxSprite;
	var pageTxt:FlxText;

	var fanartTxt:FlxText;

	var topRow:FlxTypedGroup<FlxSprite>;
	var bottomRow:FlxTypedGroup<FlxSprite>;
	

	override function create()
	{	

		//Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

		FlxG.mouse.visible = false;
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Viewing Fanart", null);
		#end

		persistentUpdate = true;


		weekBG = new FlxSprite().loadGraphic(Paths.image('fanartmenu/' + directories[curSelected] + '/_background'));
		add(weekBG);
		weekBG.screenCenter();
		weekBG.antialiasing = ClientPrefs.globalAntialiasing;

		pageCount = new FlxSprite().loadGraphic(Paths.image('fanartmenu/pageCount'));
		add(pageCount);
		pageCount.screenCenter();
		pageCount.antialiasing = ClientPrefs.globalAntialiasing;

		pageTxt = new FlxText(FlxG.width - 240, 20, FlxG.width, '', 5);
		pageTxt.setFormat(Paths.font("Courgette-Regular.ttf"), 40, FlxColor.WHITE, LEFT);
		add(pageTxt);
		pageTxt.antialiasing = ClientPrefs.globalAntialiasing;


		fanartTxt = new FlxText(20, 15, FlxG.width, 'Fanart Time!', 5);
		fanartTxt.setFormat(Paths.font("UniversityRomanStdBold.OTF"), 70, FlxColor.WHITE, LEFT);
		add(fanartTxt);
		fanartTxt.antialiasing = ClientPrefs.globalAntialiasing;
		fanartTxt.borderSize = 1;
		fanartTxt.borderColor = 0xFFd50000;
		fanartTxt.borderStyle = FlxTextBorderStyle.OUTLINE;


		camOther = new FlxCamera();
		camOther.bgColor.alpha = 0;

		FlxG.cameras.add(camOther, false);


		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		blackScreen.screenCenter();
		blackScreen.alpha = 0.0001;
		add(blackScreen);
		blackScreen.cameras = [camOther];
		


		changeWeekSelection();


		

		//var leText:String = "Press CTRL to open the Gameplay Changers Menu / Press RESET to Reset your Score and Accuracy.";
		var leText:String = "Press LEFT/RIGHT to switch pages - Press UP/DOWN to switch category.";
		var size:Int = 15;
		
		text = new FlxText(0, 0, FlxG.width, leText, size);
		text.setFormat(Paths.font("vcr.ttf"), size, FlxColor.WHITE, LEFT);
		text.scrollFactor.set();


		textBG = new FlxSprite(370, 25).makeGraphic(Math.ceil(text.textField.textWidth) + 5, 26, 0xFF000000);
		textBG.alpha = 0.6;

		text.x = textBG.x;
		text.y = textBG.y + 4;


		add(textBG);
		add(text);

		super.create();

	}



	function loadArtTxt(folder:String)
	{
		var txtFile:String = null;
		txtFile = Paths.getPath('images/fanartmenu/' + folder + '/_art.txt', openfl.utils.AssetType.TEXT);
		
		if (FileSystem.exists(txtFile))
		{
			var firstarray:Array<String> = File.getContent(txtFile).split('\n');
			//trace(firstarray);
			for(i in firstarray)
			{
				var arr:Array<String> = i.replace(' ', '').replace('\n', '').replace('\r', '').replace('\"', '').replace('\'', '').replace('\\', '').replace('\t', '').split("::"); // Remove spaces and whatever those dumbass things are
			//	trace(arr[1]);

				curArtNames.insert(Std.parseInt(arr[0]), arr[1]);
			}
		}

		topRow = new FlxTypedGroup<FlxSprite>();
		add(topRow);
		//topRow.screenCenter(X);
		//topRow.y += 85;
		//topRow.x -= FlxG.width/2;

		bottomRow = new FlxTypedGroup<FlxSprite>();
		add(bottomRow);
		//bottomRow.screenCenter(X);
		//bottomRow.y += 405;
		//bottomRow.x -= FlxG.width/2;
	}

	function clearArt() { // Art txt needs to be loaded again after
		curArtNames = [];
		curPage = 0;

		for (i in 0...curArt.length) {
			curArt[i].destroy();
		}
		curArt = [];

		for (i in 0...curText.length) {
			curText[i].destroy();
		}
		curText = [];

		topRow.clear();
		bottomRow.clear();

		topRow.destroy();
		bottomRow.destroy();
	}

	function clearCurArt() { // Simply destroys the current art, does not need to reload Art txt
		for (i in 0...curArt.length) {
			curArt[i].destroy();
		}
		curArt = [];

		for (i in 0...curText.length) {
			curText[i].destroy();
		}
		curText = [];

		topRow.clear();
		bottomRow.clear();
	}


	function switchPage(change:Int = 0, playSound:Bool = false) 
	{
		/*if (change != 0) {
			if (textBG != null) textBG.destroy();
			if (text != null) text.destroy();
		}*/

		if (playSound) FlxG.sound.play(Paths.sound('pageFlip'), 0.6);
		
			curPage += change;
			
		if (curPage < 0)
			curPage = maxPage - 1;
		if (curPage > maxPage - 1)
			curPage = 0;


		clearCurArt();

		pageTxt.text = 'Page ' + (curPage+1) + ' / ' + maxPage;

		switch(curPage) 
		{
			case 0:
				for (i in 0...5) {
					if (curArtNames[i] != null) {
						//trace('fanartmenu/' + directories[curSelected] + '/' + curArtNames[i]);
						var art:FlxSprite = new FlxSprite(10 + (i * 300), 100).loadGraphic(Paths.image('fanartmenu/' + directories[curSelected] + '/' + curArtNames[i]));
						curArt.push(art);
						
						var text:FlxText = new FlxText(0, 0, FlxG.width, curArtNames[i], 1);
						curText.push(text);
					}
				}
			
			case 1:
				for (i in 5...10) {
					if (curArtNames[i] != null) {
						//trace('fanartmenu/' + directories[curSelected] + '/' + curArtNames[i]);
						var art:FlxSprite = new FlxSprite(10 + ((i-5) * 300), 100).loadGraphic(Paths.image('fanartmenu/' + directories[curSelected] + '/' + curArtNames[i]));
						curArt.push(art);

						var text:FlxText = new FlxText(0, 0, FlxG.width, curArtNames[i], 1);
						curText.push(text);
						
					}
				}	

			case 2:
				for (i in 10...15) {
					if (curArtNames[i] != null) {
						//trace('fanartmenu/' + directories[curSelected] + '/' + curArtNames[i]);
						var art:FlxSprite = new FlxSprite(10 + ((i-10) * 300), 100).loadGraphic(Paths.image('fanartmenu/' + directories[curSelected] + '/' + curArtNames[i]));
						curArt.push(art);
						
						var text:FlxText = new FlxText(0, 0, FlxG.width, curArtNames[i], 1);
						curText.push(text);
					}
				}	

			case 3:
				for (i in 15...20) {
					if (curArtNames[i] != null) {
						//trace('fanartmenu/' + directories[curSelected] + '/' + curArtNames[i]);
						var art:FlxSprite = new FlxSprite(10 + ((i-15) * 300), 100).loadGraphic(Paths.image('fanartmenu/' + directories[curSelected] + '/' + curArtNames[i]));
						curArt.push(art);
						
						var text:FlxText = new FlxText(0, 0, FlxG.width, curArtNames[i], 1);
						curText.push(text);
					}
				}	

			case 4:
				for (i in 20...25) {
					if (curArtNames[i] != null) {
						//trace('fanartmenu/' + directories[curSelected] + '/' + curArtNames[i]);
						var art:FlxSprite = new FlxSprite(10 + ((i-20) * 300), 100).loadGraphic(Paths.image('fanartmenu/' + directories[curSelected] + '/' + curArtNames[i]));
						curArt.push(art);
						
						var text:FlxText = new FlxText(0, 0, FlxG.width, curArtNames[i], 1);
						curText.push(text);
					}
				}	

			case 5:
				for (i in 25...30) {
					if (curArtNames[i] != null) {
						//trace('fanartmenu/' + directories[curSelected] + '/' + curArtNames[i]);
						var art:FlxSprite = new FlxSprite(10 + ((i-25) * 300), 100).loadGraphic(Paths.image('fanartmenu/' + directories[curSelected] + '/' + curArtNames[i]));
						curArt.push(art);
						
						var text:FlxText = new FlxText(0, 0, FlxG.width, curArtNames[i], 1);
						curText.push(text);
					}
				}	

			case 6:
				for (i in 30...35) {
					if (curArtNames[i] != null) {
						//trace('fanartmenu/' + directories[curSelected] + '/' + curArtNames[i]);
						var art:FlxSprite = new FlxSprite(10 + ((i-30) * 300), 100).loadGraphic(Paths.image('fanartmenu/' + directories[curSelected] + '/' + curArtNames[i]));
						curArt.push(art);
						
						var text:FlxText = new FlxText(0, 0, FlxG.width, curArtNames[i], 1);
						curText.push(text);
					}
				}	

			case 7:
				for (i in 35...40) {
					if (curArtNames[i] != null) {
						//trace('fanartmenu/' + directories[curSelected] + '/' + curArtNames[i]);
						var art:FlxSprite = new FlxSprite(10 + ((i-35) * 300), 100).loadGraphic(Paths.image('fanartmenu/' + directories[curSelected] + '/' + curArtNames[i]));
						curArt.push(art);
						
						var text:FlxText = new FlxText(0, 0, FlxG.width, curArtNames[i], 1);
						curText.push(text);
					}
				}
				
			case 8:
				for (i in 40...45) {
					if (curArtNames[i] != null) {
						//trace('fanartmenu/' + directories[curSelected] + '/' + curArtNames[i]);
						var art:FlxSprite = new FlxSprite(10 + ((i-40) * 300), 100).loadGraphic(Paths.image('fanartmenu/' + directories[curSelected] + '/' + curArtNames[i]));
						curArt.push(art);
						
						var text:FlxText = new FlxText(0, 0, FlxG.width, curArtNames[i], 1);
						curText.push(text);
					}
				}	

			case 9:
				for (i in 45...50) {
					if (curArtNames[i] != null) {
						//trace('fanartmenu/' + directories[curSelected] + '/' + curArtNames[i]);
						var art:FlxSprite = new FlxSprite(10 + ((i-45) * 300), 100).loadGraphic(Paths.image('fanartmenu/' + directories[curSelected] + '/' + curArtNames[i]));
						curArt.push(art);
						
						var text:FlxText = new FlxText(0, 0, FlxG.width, curArtNames[i], 1);
						curText.push(text);
					}
				}	

			case 10:
				for (i in 50...55) {
					if (curArtNames[i] != null) {
						//trace('fanartmenu/' + directories[curSelected] + '/' + curArtNames[i]);
						var art:FlxSprite = new FlxSprite(10 + ((i-50) * 300), 100).loadGraphic(Paths.image('fanartmenu/' + directories[curSelected] + '/' + curArtNames[i]));
						curArt.push(art);
						
						var text:FlxText = new FlxText(0, 0, FlxG.width, curArtNames[i], 1);
						curText.push(text);
					}
				}
				
			case 11:
				for (i in 55...60) {
					if (curArtNames[i] != null) {
						//trace('fanartmenu/' + directories[curSelected] + '/' + curArtNames[i]);
						var art:FlxSprite = new FlxSprite(10 + ((i-55) * 300), 100).loadGraphic(Paths.image('fanartmenu/' + directories[curSelected] + '/' + curArtNames[i]));
						curArt.push(art);
						
						var text:FlxText = new FlxText(0, 0, FlxG.width, curArtNames[i], 1);
						curText.push(text);
					}
				}	

			case 12:
				for (i in 60...65) {
					if (curArtNames[i] != null) {
						//trace('fanartmenu/' + directories[curSelected] + '/' + curArtNames[i]);
						var art:FlxSprite = new FlxSprite(10 + ((i-60) * 300), 100).loadGraphic(Paths.image('fanartmenu/' + directories[curSelected] + '/' + curArtNames[i]));
						curArt.push(art);
						
						var text:FlxText = new FlxText(0, 0, 1, curArtNames[i], 1);
						curText.push(text);
					}
				}	

			default:
				trace(curPage + '/ ' + maxPage + ' no exist');
		}
		
		var offsetShit:Int = 110;

		var maxWidth:Int = 325;
		var maxHeight:Int = 260;
		for (i in 0...curArt.length) {

			if (curArt[i].height >= curArt[i].width * 0.8) {
				if (curArt[i].height > maxHeight) curArt[i].scale.set(maxHeight/curArt[i].height, maxHeight/curArt[i].height);
			} else {
				if (curArt[i].width > maxWidth) curArt[i].scale.set(maxWidth/curArt[i].width, maxWidth/curArt[i].width);
			}

			curArt[i].x = 0;
			curArt[i].y = 0;

			curArt[i].updateHitbox();

			//curArt[i].origin.set(curArt[i].width / 2, curArt[i].height / 2);

			curArt[i].antialiasing = ClientPrefs.globalAntialiasing;

			

		}


		if (curArt[0] != null && curArt[1] != null && curArt[0].width + curArt[1].width >= 600) { // Images are bigger, 2 on top, 3 on bottom
			//trace('bigger');

			for (i in 0...2) {
				if (curArt[i] != null) topRow.add(curArt[i]);
			}
			topRow.add(curArt[1]);

			for (j in 2...5) {
				if (curArt[j] != null) bottomRow.add(curArt[j]);
			}


			curArt[0].screenCenter(X);

			if (curArt[1] != null) {
				curArt[1].screenCenter(X);

				curArt[0].x -= (offsetShit + curArt[0].width/2);
				curArt[1].x += (offsetShit + curArt[1].width/2);
			}

		/*	if (curArt[2] != null) {
				curArt[2].x = curArt[1].x + offsetShit;
			}*/


			if (curArt[2] != null) {
				curArt[2].screenCenter(X);
			}

			if (curArt[3] != null){
				curArt[3].screenCenter(X);
				curArt[2].x -= (offsetShit + curArt[2].width/2);
				curArt[3].x += (offsetShit + curArt[3].width/2);
			}

			if (curArt[4] != null) {
				curArt[3].screenCenter(X);
				curArt[2].x = curArt[3].x - offsetShit - curArt[2].width;
				curArt[4].x = curArt[3].x + (curArt[3].x - curArt[2].x);

				if (curArt[4].x + curArt[4].width >= FlxG.width) curArt[4].x -= curArt[4].width / 1.9; // If last srite in b row is offscreen, subtract half width from x
				else if (curArt[4].x - (curArt[3].x + curArt[3].width) <= 25) curArt[4].x += curArt[4].width / 1.9; // If last sprite in b row is too close to middle sprite, add half width to x
			}

			


		} else { // 3 on top, 2 on bottom
			//trace('smaller');
			
			for (i in 0...3) {
				if (curArt[i] != null) topRow.add(curArt[i]);
			}

			for (j in 3...5) {
				if (curArt[j] != null) bottomRow.add(curArt[j]);
			}


			curArt[0].screenCenter(X);

			if (curArt[1] != null) {
				curArt[1].screenCenter(X);

				curArt[0].x -= (offsetShit + curArt[0].width/2);
				curArt[1].x += (offsetShit + curArt[1].width/2);
			}

			if (curArt[2] != null) {
				curArt[1].screenCenter(X);
				curArt[0].x = curArt[1].x - offsetShit - curArt[0].width;
				curArt[2].x = curArt[1].x + (curArt[1].x - curArt[0].x);


				if (curArt[2].x + curArt[2].width >= FlxG.width) curArt[2].x -= curArt[2].width / 1.9; // If last sprite in t row is offscreen, subtract half width from x
				else if (curArt[2].x - (curArt[1].x + curArt[1].width) <= 25) curArt[2].x += curArt[2].width / 1.9; // If last sprite in t row is too close to middle sprite, add half width to x

			}


			



			
			if (curArt[3] != null){
				curArt[3].screenCenter(X);
			}

			if (curArt[4] != null) {
				curArt[4].screenCenter(X);

				curArt[3].x -= (offsetShit + curArt[3].width/2);
				curArt[4].x += (offsetShit + curArt[4].width/2);
			}
		}

		for (a in topRow.members) a.y += 85;
		for (b in bottomRow.members) b.y += 405;



		// text shit time!!!!!!!!!!

		// PICO + CANDYSHOP: gleamingstar -> .gleamingstar
			// NENE: valerie -> ___.valerie.___

		for (text in curText){
		//	if (text.text == 'gleamingstar') text.text = '.gleamingstar';
		//	else if (text.text == 'valerie') text.text = '___.valerie.___';

			var untrimmed:Array<String> = [text.text];
			
			var thing:Array<String> = untrimmed[0].replace('gleamingstar', '.gleamingstar').replace('valerie', '___.valerie.___').split('-'); // idk why these names never registered with the symbols
			text.text = thing[0];

			text.setFormat(Paths.font("Eurostile Extended Regular.ttf"), 40, FlxColor.WHITE, CENTER);
			text.antialiasing = ClientPrefs.globalAntialiasing;
			text.wordWrap = false;

			text.borderSize = 1;
			text.borderColor = 0xFFd50000;
			text.borderStyle = FlxTextBorderStyle.OUTLINE;

			add(text);
		}

		for (i in 0...curText.length){
			curText[i].fieldWidth = 0;
			curText[i].x = curArt[i].x;
			curText[i].y = curArt[i].y + curArt[i].height;

			if (curText[i].textField.textWidth > curArt[i].width) curText[i].scale.set(curArt[i].width / curText[i].textField.textWidth, curArt[i].width / curText[i].textField.textWidth);
			curText[i].updateHitbox();
		}
	}


	function getMaxPage(){
		switch(directories[curSelected]){
			case 'Prologue':
				maxPage = 4;
			
			case 'Pico':
				maxPage = 10;

			case 'CandyShop':
				maxPage = 6;

			case 'CandyShopDay':
				maxPage = 8;

			case 'CandyShopNight':
				maxPage = 5;

			case 'Nene':
				maxPage = 6;

			default:
				maxPage = 12;
			
		}
	}


	var quitting:Bool = false;
	var inTrans:Bool = false;
	
	override function update(elapsed:Float)
	{

		var upP = controls.UI_UP_P;
		var downP = controls.UI_DOWN_P;

		var rightP = controls.UI_RIGHT_P;
		var leftP = controls.UI_LEFT_P;





		if (!quitting && !inTrans)
		{
			if (controls.BACK)
			{
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new MainMenuState());
				quitting = true;
			}


			if (downP)
			{
				changeWeekSelection(-1, true);
			}


			if (upP)
			{
				changeWeekSelection(1, true);
			}


			/*if(controls.UI_LEFT || controls.UI_RIGHT)
			{
				changeWeekSelection();
			}*/

			if (rightP)
			{
				switchPage(1, true);
			}	

			if (leftP)
			{
				switchPage(-1, true);
			}

		
		}





		super.update(elapsed);
		
	}

	function changeWeekSelection(change:Int = 0, playSound:Bool = false)
	{
		if (change != 0) {
			inTrans = true;
			//if (textBG != null) textBG.destroy();
			//if (text != null) text.destroy();
		}

		if (playSound) FlxG.sound.play(Paths.sound('scrollMenu'), 0.8);

		curSelected += change;
			
		if (curSelected < 0)
				curSelected = directories.length - 1;
		if (curSelected >= directories.length)
				curSelected = 0;
	


		if (change != 0) {
			blackScreen.alpha = 1;
			

			new FlxTimer().start(0.3, function(tmr:FlxTimer)
			{	
				
				//inTrans = false;
				
				FlxTween.tween(blackScreen, {alpha: 0.0001}, 0.5, {onComplete:
						function(twn:FlxTween) {
							inTrans = false;
						}}
					);
			});
		}


		new FlxTimer().start(0.05, function(tmr:FlxTimer)
			{	
				weekBG.loadGraphic(Paths.image('fanartmenu/' + directories[curSelected] + '/_background'));

				if (curArtNames[0] != null) clearArt(); // Clear prev art
		
				loadArtTxt(directories[curSelected]); // Load new art directory
		
				getMaxPage();
		
				switchPage(); // Create art
		
		
				Paths.clearUnusedMemory();
			
			});
		
		
	}
}