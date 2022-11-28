package;

import Controls.KeyboardScheme;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class MainMenuState extends MusicBeatState
{
	var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;

	#if !switch
	var optionShit:Array<String> = ['story mode', 'freeplay', 'options'];
	#else
	var optionShit:Array<String> = ['story mode', 'freeplay'];
	#end

	var newGaming:FlxText;
	var newGaming2:FlxText;
	public static var firstStart:Bool = true;
	var eyes:FlxSprite;

	public static var nightly:String = "";

	public static var kadeEngineVer:String = "1.5.1" + nightly;
	public static var gameVer:String = "0.2.7.1";

	var magenta:FlxSprite;
	var camFollow:FlxObject;
	public static var finishedFunnyMove:Bool = false;

	var story:FlxSprite;
	var freeplay:FlxSprite;
	var options:FlxSprite;
	var bfmenu:FlxSprite;
	

	override function create()
	{
		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		persistentUpdate = persistentDraw = true;



		bfmenu = new FlxSprite(-644, -360).loadGraphic(Paths.image('boyfriendMenu'));
		bfmenu.updateHitbox();
		//bfmenu.screenCenter();
		bfmenu.antialiasing = true;
		add(bfmenu);		

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var eyes:FlxSprite = new FlxSprite(0, -50).loadGraphic(Paths.image('iAmInYouWalls'));
		eyes.scrollFactor.x = 0;
		eyes.scrollFactor.y = 0.10;
		eyes.setGraphicSize(Std.int(eyes.width * 1));
		eyes.updateHitbox();
		eyes.screenCenter(X);
		eyes.antialiasing = true;
		add(eyes);

		story = new FlxSprite(-860, -160).loadGraphic(Paths.image('mainmenu/menu_story_mode'));
		story.frames = Paths.getSparrowAtlas('mainmenu/menu_story_mode'); 
		story.animation.addByPrefix('selected', 'story_mode basic', 24);
		story.animation.addByPrefix('not', 'story_mode white', 24);
		menuItems.add(story);
		story.antialiasing = true;
		story.setGraphicSize(Std.int(story.width * 0.5));


		freeplay = new FlxSprite(-830, -60).loadGraphic(Paths.image('mainmenu/menu_freeplay'));
		freeplay.frames = Paths.getSparrowAtlas('mainmenu/menu_freeplay');
		freeplay.animation.addByPrefix('selected', 'freeplay basic', 24);
		freeplay.animation.addByPrefix('not', 'freeplay white', 24);
		menuItems.add(freeplay);
		freeplay.antialiasing = true;
		freeplay.setGraphicSize(Std.int(freeplay.width * 0.5));


		options = new FlxSprite(-830, 60).loadGraphic(Paths.image('mainmenu/menu_options'));
		options.frames = Paths.getSparrowAtlas('mainmenu/menu_options');
		options.animation.addByPrefix('selected', 'options basic', 24);
		options.animation.addByPrefix('not', 'options white', 24);
		menuItems.add(options);
		options.antialiasing = true;
		options.setGraphicSize(Std.int(options.width * 0.5));


		var bg:FlxSprite = new FlxSprite(0, -50).loadGraphic(Paths.image('ligmaball'));
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.10;
		bg.setGraphicSize(Std.int(bg.width * 1));
		bg.updateHitbox();
		bg.screenCenter(X);
		bg.antialiasing = true;
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);
		// magenta.scrollFactor.set();

		options.animation.play('not');
		freeplay.animation.play('not');

		var tex = Paths.getSparrowAtlas('FNF_main_menu_assets');

	/*	for (i in 0...optionShit.length)
		{
			var menuItem:FlxSprite = new FlxSprite(0, FlxG.height * 1.6);
			menuItem.frames = tex;
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItem.screenCenter(X);
			menuItems.add(menuItem);
			menuItem.scrollFactor.set();
			menuItem.antialiasing = true;
			if (firstStart)
				FlxTween.tween(menuItem,{y: 60 + (i * 160)},1 + (i * 0.25) ,{ease: FlxEase.expoInOut, onComplete: function(flxTween:FlxTween) 
					{ 
						finishedFunnyMove = true; 
						changeItem();
					}});
			else
				menuItem.y = 60 + (i * 160);
		}
 */
		FlxTween.tween(story, {x: -660}, 1, {ease: FlxEase.expoInOut});	
		FlxTween.tween(freeplay, {x: -630}, 1, {ease: FlxEase.expoInOut});	
		FlxTween.tween(options, {x: -630}, 1, {ease: FlxEase.expoInOut});	
		finishedFunnyMove = true;
		firstStart = false;

		FlxG.camera.follow(camFollow, null, 0.60 * (60 / FlxG.save.data.fpsCap));

		var versionShit:FlxText = new FlxText(5, FlxG.height - 18, 0, gameVer +  (Main.watermarks ? " FNF - " + kadeEngineVer + " Kade Engine" : ""), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();


		if (FlxG.save.data.dfjk)
			controls.setKeyboardScheme(KeyboardScheme.Solo, true);
		else
			controls.setKeyboardScheme(KeyboardScheme.Duo(true), true);

		changeItem();

		#if mobileC
		addVirtualPad(UP_DOWN, A_B);
		#end

		super.create();
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		FlxG.watch.addQuick('Bf menu',bfmenu);
		FlxG.watch.addQuick('Story',story);
		FlxG.watch.addQuick('options',options);
		FlxG.watch.addQuick('Freeplay',freeplay);
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if (!selectedSomethin)
		{
			if (controls.UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (controls.DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK)
			{
				FlxG.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
				if (optionShit[curSelected] == 'donate')
				{
					fancyOpenURL("https://www.kickstarter.com/projects/funkin/friday-night-funkin-the-full-ass-game");
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));
					

							if (FlxG.save.data.flashing)
							{
								new FlxTimer().start(1, function(tmr:FlxTimer)
								{
									goToState();
								});
							}
							else
							{
								new FlxTimer().start(1, function(tmr:FlxTimer)
								{
									goToState();
								});
							}
				}
			}
		}

		super.update(elapsed);

	/*	menuItems.forEach(function(spr:FlxSprite)
		{
			spr.screenCenter(X);
		}); */
	}
	
	function goToState()
		{
			var daChoice:String = optionShit[curSelected];
	
			switch (daChoice)
			{
				case 'story mode':
					FlxG.switchState(new StoryMenuState());
					trace("Story Menu Selected");
					FlxTween.tween(story, {x: -960}, 1, {ease: FlxEase.expoInOut});	
					FlxTween.tween(freeplay, {x: -930}, 1, {ease: FlxEase.expoInOut});	
					FlxTween.tween(options, {x: -930}, 1, {ease: FlxEase.expoInOut});	
				case 'freeplay':
					FlxG.switchState(new FreeplayState());
	
					trace("Freeplay Menu Selected");
					FlxTween.tween(story, {x: -960}, 1, {ease: FlxEase.expoInOut});	
					FlxTween.tween(freeplay, {x: -930}, 1, {ease: FlxEase.expoInOut});	
					FlxTween.tween(options, {x: -930}, 1, {ease: FlxEase.expoInOut});	
				case 'options':
					FlxG.switchState(new OptionsMenu());
					FlxTween.tween(story, {x: -960}, 1, {ease: FlxEase.expoInOut});	
					FlxTween.tween(freeplay, {x: -930}, 1, {ease: FlxEase.expoInOut});	
					FlxTween.tween(options, {x: -930}, 1, {ease: FlxEase.expoInOut});	
			}
		}
		override function beatHit()
			{
				super.beatHit();

			}
	public function changeItem(huh:Int = 0)
		{
			curSelected += huh;
	
			if (curSelected >= menuItems.length)
				curSelected = 0;
			if (curSelected < 0)
				curSelected = menuItems.length - 1;

			switch(curSelected){
				case 0:
					story.animation.play('not');
					freeplay.animation.play('selected');
					options.animation.play('selected');
				case 1:
					story.animation.play('selected');
					freeplay.animation.play('not');
					options.animation.play('selected');
				case 2:	
					story.animation.play('selected');
					freeplay.animation.play('selected');
					options.animation.play('not');		
			}
		}

	/*function changeItem(huh:Int = 0)
	{
		if (finishedFunnyMove)
		{
			curSelected += huh;

			if (curSelected >= menuItems.length)
				curSelected = 0;
			if (curSelected < 0)
				curSelected = menuItems.length - 1;
		}
		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');

			if (spr.ID == curSelected && finishedFunnyMove)
			{
				spr.animation.play('selected');
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);
			}

			spr.updateHitbox();
		});
	}*/
}
