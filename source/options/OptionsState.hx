package options;

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
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;

using StringTools;

class OptionsState extends MusicBeatState
{
	var options:Array<String> = ['Mod Settings', 'Controls', 'Adjust Delay and Combo', 'Graphics', 'Visuals and UI', 'Gameplay', 'Mobile Options'];
	private var grpOptions:FlxTypedGroup<Alphabet>;
	private static var curSelected:Int = 0;
	public static var menuBG:FlxSprite;

	function openSelectedSubstate(label:String) {
		if (label != "Adjust Delay and Combo"){
			persistentUpdate = false;
			removeTouchPad();
		}
		switch(label) {
			case 'Mod Settings':
				openSubState(new options.ModSettingsSubState());
			case 'Controls':
				openSubState(new options.ControlsSubState());
			case 'Graphics':
				openSubState(new options.GraphicsSettingsSubState());
			case 'Visuals and UI':
				openSubState(new options.VisualsUISubState());
			case 'Gameplay':
				openSubState(new options.GameplaySettingsSubState());
			case 'Adjust Delay and Combo':
				LoadingState.loadAndSwitchState(new options.NoteOffsetState());
			case 'Mobile Options':
				openSubState(new mobile.options.MobileOptionsSubState());
		}
	}

	var selectorLeft:Alphabet;
	var selectorRight:Alphabet;

	override function create() {
		#if desktop
		DiscordClient.changePresence("Options Menu", null);
		#end
		FlxG.mouse.visible = false;

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.color = 0x00000000;
		bg.updateHitbox();

		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		for (i in 0...options.length)
		{
			var optionText:Alphabet = new Alphabet(0, 0, options[i], true);
			if (options[i] == 'Mod Settings') optionText.color = 0xFFEB6D19;
			optionText.screenCenter();
			optionText.y += (100 * (i - (options.length / 2))) + 50;
			grpOptions.add(optionText);
		}

		selectorLeft = new Alphabet(0, 0, '>', true);
		add(selectorLeft);
		selectorRight = new Alphabet(0, 0, '<', true);
		add(selectorRight);

		changeSelection();
		ClientPrefs.saveSettings();

		addTouchPad("UP_DOWN", "A_B_C");
		
		super.create();
	}

	override function closeSubState() {
		super.closeSubState();
		persistentUpdate = true;
		removeTouchPad();
		addTouchPad("UP_DOWN", "A_B_C");
		ClientPrefs.saveSettings();
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		if (controls.UI_UP_P) {
			changeSelection(curSelected - 1);
		}
		if (controls.UI_DOWN_P) {
			changeSelection(curSelected + 1);
		}


		/*if (FlxG.mouse.justMoved)
			{
				for (i in 0...options.length)
				{
					if (i != curSelected)
					{
						if (FlxG.mouse.overlaps(grpOptions.members[i]) && !FlxG.mouse.overlaps(grpOptions.members[curSelected]))
						{
							//FlxG.sound.play(Paths.sound('scrollMenu'));
							changeSelection(i);
						}
					}
				}
			}*/


		if (controls.BACK  || FlxG.mouse.justPressedRight) {
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}

		/*if (controls.ACCEPT || FlxG.mouse.justPressed && FlxG.mouse.overlaps(grpOptions.members[curSelected])) {
			openSelectedSubstate(options[curSelected]);
		}*/

		if (controls.ACCEPT) {
			openSelectedSubstate(options[curSelected]);
		}
		
		if (touchPad != null && touchPad.buttonC.justPressed) {
			touchPad.active = touchPad.visible = persistentUpdate = false;
			openSubState(new mobile.MobileControlSelectSubState());
		}
	}
	
	function changeSelection(change:Int = 0) {
		curSelected = change;
		if (curSelected < 0)
			curSelected = options.length - 1;
		if (curSelected >= options.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpOptions.members) {
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			if (item.targetY == 0) {
				item.alpha = 1;
				selectorLeft.x = item.x - 63;
				selectorLeft.y = item.y;
				selectorRight.x = item.x + item.width + 15;
				selectorRight.y = item.y;
			}

			if (options[curSelected] == 'Mod Settings') {
				selectorLeft.color = 0xFFEB6D19;
				selectorRight.color = 0xFFEB6D19;
			} else {
				selectorLeft.color = 0xFFFFFFFF;
				selectorRight.color = 0xFFFFFFFF;
			}
		}
		//FlxG.sound.play(Paths.sound('scrollMenu'));
	}
}