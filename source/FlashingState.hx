package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

class FlashingState extends MusicBeatState
{
	public static var leftState:Bool = false;

	var warnText:FlxText;
	var warnSprite:FlxSprite;

	var canChoose:Bool = false;

	override function create()
	{
		super.create();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);

		warnSprite = new FlxSprite().loadGraphic(Paths.image('disclaimer'));
		warnSprite.screenCenter();
		warnSprite.alpha = 0;
		add(warnSprite);


		FlxTween.tween(warnSprite, {alpha: 1}, 2.5, {
			onComplete: function (twn:FlxTween) {
				canChoose = true;
			}});

		warnText = new FlxText(0, 0, FlxG.width,
			"Hey, watch out!\n
			This Mod contains some flashing lights!\n
			Press ENTER to disable them now or go to Options Menu.\n
			Press ESCAPE to ignore this message.\n
			You've been warned!",
			32);
		warnText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		warnText.screenCenter(Y);
		//add(warnText);
	}

	override function update(elapsed:Float)
	{
		if(!leftState) {
			//var back:Bool = controls.BACK;
			if (controls.ACCEPT && canChoose) {
				leftState = true;
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;

				ClientPrefs.flashing = true;
				ClientPrefs.saveSettings();
				
				FlxG.sound.play(Paths.sound('cancelMenu'), 1);
					FlxTween.tween(warnSprite, {alpha: 0}, 1, {
						onComplete: function (twn:FlxTween) {
							MusicBeatState.switchState(new TitleState());
						}});
			}
		}
		super.update(elapsed);
	}
}
