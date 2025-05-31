package options;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxCamera;
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
import openfl.Lib;

using StringTools;

class ModSettingsSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Mod Settings';
		rpcTitle = 'Mod Settings Menu'; //for Discord Rich Presence

		var option:Option = new Option('Dodge Mechanic',
			"Replaces the automatic dodges in Angel's Grace with manual ones.",
			'useDodgeMechanic',
			'bool',
			true);
		addOption(option);
		
		var option:Option = new Option('Heart Mechanic',
			"If checked, you must continually press 'Space' \nto keep the heart bar filled in Second Coming",
			'useHeartMechanic',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Show Ratings',
			'If unchecked, hides the rating and combo number.',
			'ratingsEnabled',
			'bool',
			false);
		addOption(option);
		
		var option:Option = new Option('Time Text',
			'If unchecked, the Time Text will be hidden.',
			'timeTxt',
			'bool',
			false);
		addOption(option);
		
		var option:Option = new Option('Showcase Mode',
			'Hides the FPS, Score, and Botplay text.',
			'showFPS',
			'bool',
			false);
		addOption(option);
		option.onChange = onChangeFPSCounter;

		super();
	}

	function onChangeFPSCounter()
		{
			if(Main.fpsVar != null)
				Main.fpsVar.visible = !ClientPrefs.showFPS;
		}

}