import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.util.FlxColor;

import flixel.text.FlxText;

using StringTools;

class FreeplayResetScoreSubState extends MusicBeatSubstate
{
	var bg:FlxSprite;
	var alphabetArray:Array<FlxText> = [];
	var icon:HealthIcon;
	var onYes:Bool = false;
	var yesText:FlxText;
	var noText:FlxText;

	var song:String;
	var difficulty:Int;
	var week:Int;

	// Week -1 = Freeplay
	public function new(song:String, difficulty:Int, character:String, week:Int = -1)
	{
		this.song = song;
		this.difficulty = difficulty;
		this.week = week;

		super();

		

		var name:String = song;
		if(week > -1) {
			name = WeekData.weeksLoaded.get(WeekData.weeksList[week]).weekName;
		}
		name += ' (' + CoolUtil.difficulties[difficulty] + ')?';

		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0;
		bg.scrollFactor.set();
		add(bg);

		var tooLong:Float = (name.length > 18) ? 0.8 : 1; //Fucking Winter Horrorland
		var text:FlxText = new FlxText(0, 760, "Reset the score of", true);
		text.setFormat(Paths.font("Apocalypse Grunge.ttf"), 75, FlxColor.WHITE, CENTER);
		text.screenCenter(X);
		alphabetArray.push(text);
		text.alpha = 0;

		text.x += 550;
		text.scale.set(0.8, 0.8);
		text.antialiasing = ClientPrefs.globalAntialiasing;

		add(text);
		var text:FlxText = new FlxText(0, text.y + 140, name, true);
		text.setFormat(Paths.font("Apocalypse Grunge.ttf"), 60, FlxColor.WHITE, CENTER);
		text.scale.x = tooLong;
		text.screenCenter(X);

		text.antialiasing = ClientPrefs.globalAntialiasing;
		text.x += 550;
		text.scale.set(0.8, 0.8);

		if(week == -1) text.x += 60 * tooLong;
		alphabetArray.push(text);
		text.alpha = 0;
		add(text);
		if(week == -1) {
			icon = new HealthIcon(character);
			icon.setGraphicSize(Std.int(icon.width * tooLong));
			icon.updateHitbox();
			icon.scale.set(0.8, 0.8);
			icon.setPosition(text.x - 530 - icon.width + (10 * tooLong), text.y - 580);
			icon.alpha = 0;
			add(icon);
		}

		yesText = new FlxText(0, text.y + 150, FlxG.width, 'Yes', 50);
		yesText.screenCenter(X);
		yesText.setFormat(Paths.font("Apocalypse Grunge.ttf"), 50, FlxColor.WHITE, CENTER);
		//yesText.x -= 200;
		yesText.x += 450;
		yesText.antialiasing = ClientPrefs.globalAntialiasing;
		add(yesText);
		noText = new FlxText(0, text.y + 150, FlxG.width, 'No', 50);
		noText.setFormat(Paths.font("Apocalypse Grunge.ttf"), 50, FlxColor.WHITE, CENTER);
		noText.screenCenter(X);
		//noText.x += 200;
		noText.x += 650;
		noText.antialiasing = ClientPrefs.globalAntialiasing;
		add(noText);
		updateOptions();
		
		addTouchPad("LEFT_RIGHT", "A_B");
		addTouchPadCamera();
	}

	override function update(elapsed:Float)
	{	
		//FlxG.camera.zoom = 0.5;

		bg.alpha += elapsed * 1.5;
		if(bg.alpha > 0.6) bg.alpha = 0.6;

		for (i in 0...alphabetArray.length) {
			var spr = alphabetArray[i];
			spr.alpha += elapsed * 2.5;
		}
		if(week == -1) icon.alpha += elapsed * 2.5;

		if(controls.UI_LEFT_P || controls.UI_RIGHT_P) {
			FlxG.sound.play(Paths.sound('scrollMenu'), 1);
			onYes = !onYes;
			updateOptions();
		}
		if(controls.BACK) {
			FlxG.sound.play(Paths.sound('cancelMenu'), 1);
			close();
		} else if(controls.ACCEPT) {
			if(onYes) {
				if(week == -1) {
					FreeplayState.resettingScore = true;
					Highscore.resetSong(song, difficulty);
				} else {
					Highscore.resetWeek(WeekData.weeksList[week], difficulty);
				}
			}
			FlxG.sound.play(Paths.sound('cancelMenu'), 1);
			close();
		}
		super.update(elapsed);
	}

	function updateOptions() {
		var scales:Array<Float> = [0.75, 1];
		var alphas:Array<Float> = [0.6, 1.25];
		var confirmInt:Int = onYes ? 1 : 0;

		yesText.alpha = alphas[confirmInt];
		yesText.scale.set(scales[confirmInt], scales[confirmInt]);
		noText.alpha = alphas[1 - confirmInt];
		noText.scale.set(scales[1 - confirmInt], scales[1 - confirmInt]);
		if(week == -1) icon.animation.curAnim.curFrame = confirmInt;
	}
}