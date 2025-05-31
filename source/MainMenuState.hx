package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;

import flixel.util.FlxTimer;

using StringTools;

var visitedMenu:Bool;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.6.3'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;
	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;
	
	var optionShit:Array<String> = [
		'storymode',
		'freeplay',
		//#if MODS_ALLOWED 'mods', #end
		//#if ACHIEVEMENTS_ALLOWED 'awards', #end
		'options',
		//#if !switch 'donate', #end
		'credits',
		'fanart'
	];

	var magenta:FlxSprite;
	var camFollow:FlxObject;
	var camFollowPos:FlxObject;
	var debugKeys:Array<FlxKey>;

	var discord:FlxSprite;
	var discordSelected:FlxSprite;

	override function create()
	{
		#if MODS_ALLOWED
		Paths.pushGlobalMods();
		#end
		WeekData.loadTheFirstEnabledMod();

		FlxG.mouse.visible = true;

		visitedMenu = true;

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		camGame = new FlxCamera();
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camAchievement, false);
		FlxG.cameras.setDefaultDrawTarget(camGame, true);

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		//var yScroll:Float = Math.max(0.25 - (0.05 * (optionShit.length - 4)), 0.1);
		var yScroll:Float = 0;
		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('MenuBG'));
		//bg.scrollFactor.set(0, yScroll);
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		camFollowPos = new FlxObject(0, 0, 1, 1);
		add(camFollow);
		add(camFollowPos);

		camFollow.screenCenter();
		camFollowPos.screenCenter();

		if (TitleState.fromTitle) {
		TitleState.fromTitle = false;
		camFollow.y = camFollowPos.y + 1000;
		FlxTween.tween(camFollow, {y: camFollowPos.y}, 1, {type: ONESHOT, ease: FlxEase.cubeInOut});
		}

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		magenta.scrollFactor.set(0, yScroll);
		magenta.setGraphicSize(Std.int(magenta.width * 1.175));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = ClientPrefs.globalAntialiasing;
		magenta.color = 0xFFfd719b;
		add(magenta);
		
		// magenta.scrollFactor.set();

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var scale:Float = 0.66666667;
		bg.scale.set(0.66666667, 0.66666667);
		/*if(optionShit.length > 6) {
			scale = 6 / optionShit.length;
		}*/

		for (i in 0...optionShit.length)
		{
			var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
			var menuItem:FlxSprite = new FlxSprite(710, (i * 135)  + 15 + offset);
			menuItem.scale.x = scale;
			menuItem.scale.y = scale;
			menuItem.frames = Paths.getSparrowAtlas('mainmenu/' + optionShit[i]);
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			//menuItem.screenCenter(X);
			menuItems.add(menuItem);
			var scr:Float = (optionShit.length - 4) * 0.135;
			if(optionShit.length < 6) scr = 0;
			//menuItem.scrollFactor.set(0, scr);
			menuItem.antialiasing = ClientPrefs.globalAntialiasing;
			//menuItem.setGraphicSize(Std.int(menuItem.width * 0.58));
			menuItem.updateHitbox();
			
			menuItem.animation.addByPrefix('idle', "story mode basic", 24);
			menuItem.animation.addByPrefix('selected', "story mode white", 24);
			
			menuItem.animation.addByPrefix('idle', "fanart basic0", 24);
			menuItem.animation.addByPrefix('selected', "fanart0", 24);
		}

		FlxG.camera.follow(camFollowPos, null, 1);

		var versionShit:FlxText = new FlxText(12, FlxG.height - 44, 0, "Menu music by Funny Man", 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		var versionShit:FlxText = new FlxText(12, FlxG.height - 24, 0, "Psych Engine v" + psychEngineVersion, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);


		discord = new FlxSprite(12, FlxG.height - 120).loadGraphic(Paths.image('credits/old/discord'));
		discord.scale.set(0.6, 0.6);
		discord.antialiasing = ClientPrefs.globalAntialiasing;
		discord.updateHitbox();
		discord.scrollFactor.set();
		add(discord);

		discordSelected = new FlxSprite(12, FlxG.height - 160).loadGraphic(Paths.image('credits/old/discordSelected'));
		discordSelected.scale.set(0.6, 0.6);
		discordSelected.antialiasing = ClientPrefs.globalAntialiasing;
		discordSelected.updateHitbox();
		discordSelected.alpha = 0.0001;
		discordSelected.scrollFactor.set();
		add(discordSelected);

		// NG.core.calls.event.logEvent('swag').send();

		changeItem();

		#if ACHIEVEMENTS_ALLOWED
		Achievements.loadAchievements();
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18) {
			var achieveID:Int = Achievements.getAchievementIndex('friday_night_play');
			if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) { //It's a friday night. WEEEEEEEEEEEEEEEEEE
				Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
				giveAchievement();
				ClientPrefs.saveSettings();
			}
		}
		#end

		super.create();
		
		addTouchPad("UP_DOWN", "A_B");
	}

	#if ACHIEVEMENTS_ALLOWED
	// Unlocks "Freaky on a Friday Night" achievement
	function giveAchievement() {
		add(new AchievementObject('friday_night_play', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "friday_night_play"');
	}
	#end

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		FlxG.mouse.visible = true; // hopefully mouse shit maybe idk
		
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
			if(FreeplayState.vocals != null) FreeplayState.vocals.volume += 0.5 * elapsed;
		}

		var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
		camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));

		if (!selectedSomethin)
		{
			if (controls.UI_UP_P || FlxG.keys.justPressed.W)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(curSelected - 1);
			}

			if (controls.UI_DOWN_P || FlxG.keys.justPressed.S)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(curSelected + 1);
			}

	

			if (FlxG.mouse.justMoved)
				{
					for (i in 0...menuItems.members.length)
					{
						if (i != curSelected)
						{
							if (FlxG.mouse.overlaps(menuItems.members[i]) && !FlxG.mouse.overlaps(menuItems.members[curSelected]))
							{
								FlxG.sound.play(Paths.sound('scrollMenu'));
								changeItem(i);
							}
						}
					}

					if (discordSelected != null && discord != null)
					{
						if (FlxG.mouse.overlaps(discordSelected)) {
							discordSelected.alpha = 1;
							discord.alpha = 0;
							
						} else {
							discordSelected.alpha = 0;
							discord.alpha = 1;
						}
					}
				}

			//if (discordSelected != null) trace(FlxG.mouse.overlaps(discordSelected));
			
			if (controls.BACK  || FlxG.mouse.justPressedRight)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));


				FlxTween.tween(camFollow, {y: camFollowPos.y + 1000}, 1.7, {type: ONESHOT, ease: FlxEase.cubeInOut});
						new FlxTimer().start(0.5, function(tmr:FlxTimer)
							{
								MusicBeatState.switchState(new TitleState());
							});
				
			}

			if (controls.ACCEPT || FlxG.mouse.justPressed && FlxG.mouse.overlaps(menuItems.members[curSelected]))
			{
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));

					//if(ClientPrefs.flashing) FlxFlicker.flicker(magenta, 1.1, 0.15, false);

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 0.4, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});

							FlxTween.tween(spr, {x: 900}, 1, {ease: FlxEase.quadOut});
						}
						else
						{
							FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
							{
								var daChoice:String = optionShit[curSelected];
								FlxG.mouse.visible = false;

								switch (daChoice)
								{
									case 'storymode':
										MusicBeatState.switchState(new StoryMenuState());
									case 'freeplay':
										MusicBeatState.switchState(new FreeplayState());
									case 'options':
										LoadingState.loadAndSwitchState(new options.OptionsState());
									case 'credits':
										MusicBeatState.switchState(new CreditsState());
									case 'fanart':
										MusicBeatState.switchState(new FanartState());
								}
							});
						}
					});
				}
			} 

			#if desktop
			else if (FlxG.keys.anyJustPressed(debugKeys))
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}

		if(discordSelected != null && discord != null && FlxG.mouse.justPressed && FlxG.mouse.overlaps(discordSelected) && !selectedSomethin) {
			CoolUtil.browserLoad('https://discord.gg/pKCmDvEqYk');
		}
		

		super.update(elapsed);

		menuItems.forEach(function(spr:FlxSprite)
		{
			//spr.screenCenter(X);
		});


	}

	function changeItem(huh:Int = 0)
	{
		curSelected = huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');
			spr.updateHitbox();

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				var add:Float = 0;
				if(menuItems.length > 4) {
					add = menuItems.length * 8;
				}
				//camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y - add);
				spr.centerOffsets();
			}
		});
	}
}
