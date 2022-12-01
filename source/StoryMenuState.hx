package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.net.curl.CURLCode;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class StoryMenuState extends MusicBeatState
{
	var scoreText:FlxText;
	var easy:FlxSprite;
	var normal:FlxSprite;
	var hard:FlxSprite;

	var weekData:Array<Dynamic> = [
		['Tutorial'],
		['Emancipation', 'Gunned-Down', 'Extrication'],
		['Saint-Savagery', 'Dispatch', "Glammed"],
		['Distress', 'Xenophobia', "Killer"],
		['Mayhem', "Devitalization", "Devastation"],
		['Blissfull-Ignorance', 'Disconnction', 'Short-Circuit','Banishment'],
		['Bedeviled', 'Affliction', 'Familiar-Finale'],
		['SaveState', 'Chances','Full-Circle','Soliloquy','Take-Two']
	];
	var curDifficulty:Int = 1;

	public static var weekUnlocked:Array<Bool> = [true, true, true, true, true, true, true];

	var weekCharacters:Array<Dynamic> = [
		['', 'bf', 'gf'],
		['dad', 'bf', 'gf'],
		['spooky', 'bf', 'gf'],
		['pico', 'bf', 'gf'],
		['mom', 'bf', 'gf'],
		['parents-christmas', 'bf', 'gf'],
		['senpai', 'bf', 'gf']
	];

	var weekNames:Array<String> = [
		"How to corrupt",
		"On the run",
		"Target Spotted",
		"No more Games",
		"Where did she go",
		"trace('ignorant')",
		"I Found you",
		"Rewind"
	];

	var txtWeekTitle:FlxText;

	var curWeek:Int = 0;

	var txtTracklist:FlxText;
	var trackimage:FlxSprite;

	var grpWeekText:FlxTypedGroup<MenuItem>;

	var grpLocks:FlxTypedGroup<FlxSprite>;

	var difficultySelectors:FlxGroup;
	var sprDifficulty:FlxSprite;
	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;
	var weekThing:MenuItem;


	
	var blackthing2:FlxSprite;
	var blackthing:FlxSprite;
	var menu1:FlxSprite;
	var menu2:FlxSprite;
	var menu3:FlxSprite;
	var menu4:FlxSprite;
	var menu5:FlxSprite;
	var menu6:FlxSprite;
	var menu7:FlxSprite;
	var menu8:FlxSprite;
	

	override function create()
	{
		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Story Mode Menu", null);
		#end

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		if (FlxG.sound.music != null)
		{
			if (!FlxG.sound.music.playing)
				FlxG.sound.playMusic(Paths.music('storySong0'));
		}
		FlxG.sound.music.stop();
		FlxG.sound.playMusic(Paths.music('storySong0'));
		persistentUpdate = persistentDraw = true;

		scoreText = new FlxText(10, 684, 0, "SCORE: 49324858", 36);
		scoreText.setFormat("VCR OSD Mono", 32);

		txtWeekTitle = new FlxText(1020, 670, 0, "", 32);
		txtWeekTitle.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, RIGHT);
		txtWeekTitle.alpha = 0.7;

		var yellowBG:FlxSprite = new FlxSprite(0, 56).makeGraphic(FlxG.width, 400, 0xFFF9CF51);
		add(yellowBG);
		yellowBG.visible = false;

		menu1 = new FlxSprite(0, -50).loadGraphic(Paths.image('menubackgrounds/menu_stage'));
		menu1.screenCenter();
		add(menu1);
		
		menu2 = new FlxSprite(0, -50).loadGraphic(Paths.image('menubackgrounds/menu_philly'));
		menu2.screenCenter();
		add(menu2);

		menu3 = new FlxSprite(0, -50).loadGraphic(Paths.image('menubackgrounds/menu_limo'));
		menu3.screenCenter();
		add(menu3);

		menu4 = new FlxSprite(0, -50).loadGraphic(Paths.image('menubackgrounds/menu_halloween'));
		menu4.screenCenter();
		add(menu4);

		menu5 = new FlxSprite(0, -50).loadGraphic(Paths.image('menubackgrounds/menu_philly'));
		menu5.screenCenter();
		add(menu5);

		menu6 = new FlxSprite(0, -50).loadGraphic(Paths.image('menubackgrounds/menu_school'));
		menu6.screenCenter();
		add(menu6);

		menu7 = new FlxSprite(0, -50).loadGraphic(Paths.image('menubackgrounds/menu_stage'));
		menu7.screenCenter();
		add(menu7);

		menu8 = new FlxSprite(0, -50);
		menu8.frames = Paths.getSparrowAtlas('menubackgrounds/menu_static');
		menu8.animation.addByPrefix('static', 'static', false);
		menu8.screenCenter();
		add(menu8);


		blackthing = new FlxSprite(10,50).loadGraphic(Paths.image('storyBlackThing'));
		//blackthing.screenCenter();
		add(blackthing);

		blackthing2 = new FlxSprite(0, 0).loadGraphic(Paths.image('storyBlackThing2'));
	//	blackthing2.screenCenter();


		var rankText:FlxText = new FlxText(0, 10);
		rankText.text = 'RANK: GREAT';
		rankText.setFormat(Paths.font("vcr.ttf"), 32);
		rankText.size = scoreText.size;
		rankText.screenCenter(X);

		var ui_tex = Paths.getSparrowAtlas('campaign_menu_UI_assets');


		grpWeekText = new FlxTypedGroup<MenuItem>();
		add(grpWeekText);

		var blackBarThingie:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, 56, FlxColor.BLACK);
		add(blackBarThingie);


		grpLocks = new FlxTypedGroup<FlxSprite>();
		add(grpLocks);

		trace("Line 70");

		for (i in 0...weekData.length)
		{
			weekThing = new MenuItem(0, 0, i);
			weekThing.y += ((weekThing.height + 20) * i);
			weekThing.targetY = i;
			grpWeekText.add(weekThing);
			

			//weekThing.screenCenter(X);
			weekThing.antialiasing = true;
			// weekThing.updateHitbox();

			// Needs an offset thingie
			if (!weekUnlocked[i])
			{
				var lock:FlxSprite = new FlxSprite(weekThing.width + 10 + weekThing.x);
				lock.frames = ui_tex;
				lock.animation.addByPrefix('lock', 'lock');
				lock.animation.play('lock');
				lock.ID = i;
				lock.antialiasing = true;
				grpLocks.add(lock);
			}
		}

		trace("Line 96");
		add(blackthing2);


		difficultySelectors = new FlxGroup();
		add(difficultySelectors);

		trace("Line 124");

		leftArrow = new FlxSprite(430 , 635);
		leftArrow.frames = ui_tex;
		leftArrow.animation.addByPrefix('idle', "arrow left");
		leftArrow.animation.addByPrefix('press', "arrow push left");
		leftArrow.animation.play('idle');
		difficultySelectors.add(leftArrow);

		easy = new FlxSprite(leftArrow.x + 130, leftArrow.y + 20).loadGraphic(Paths.image('menudifficulties/easy'));
		changeDifficulty();

		normal = new FlxSprite(leftArrow.x + 60, leftArrow.y + 20).loadGraphic(Paths.image('menudifficulties/normal'));
		changeDifficulty();

		hard = new FlxSprite(leftArrow.x + 130, leftArrow.y + 20).loadGraphic(Paths.image('menudifficulties/hard'));
		changeDifficulty();


		difficultySelectors.add(easy);
		difficultySelectors.add(normal);
		difficultySelectors.add(hard);

		rightArrow = new FlxSprite(easy.x + hard.width + 50, leftArrow.y);
		rightArrow.frames = ui_tex;
		rightArrow.animation.addByPrefix('idle', 'arrow right');
		rightArrow.animation.addByPrefix('press', "arrow push right", 24, false);
		rightArrow.animation.play('idle');
		difficultySelectors.add(rightArrow);

		trace("Line 150");


	//	yellowBG.visible = false;


		trackimage = new FlxSprite(1020, 50).loadGraphic(Paths.image('Menu_Tracks'));
		add(trackimage);
		
		txtWeekTitle = new FlxText(1020, 670, 0, "", 32);
		txtWeekTitle.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, RIGHT);
		txtWeekTitle.alpha = 0.7;
		txtTracklist = new FlxText(960, 50, 0, "", 32);
		txtTracklist.alignment = CENTER;
		txtTracklist.font = rankText.font;
		txtTracklist.color = 0xFFe55777;
		add(txtTracklist);
		// add(rankText);
		add(scoreText);
		add(txtWeekTitle);

		updateText();

		trace("Line 165");

		#if mobileC
		addVirtualPad(FULL, A_B);
		#end

		super.create();
	}

	override function update(elapsed:Float)
	{
		menu8.animation.play('static');
		 switch(curWeek){
		 	case 0:
		 		menu1.visible = true;
		 		menu2.visible = false;
		 		menu3.visible = false;
		 		menu4.visible = false;
		 		menu5.visible = false;
		 		menu6.visible = false;
		 		menu7.visible = false;
		 		menu8.visible = false;
		 	case 1:
				menu1.visible = false;
				menu2.visible = true;
				menu3.visible = false;
				menu4.visible = false;
				menu5.visible = false;
				menu6.visible = false;
				menu7.visible = false;
				menu8.visible = false;
		 	case 2:
				menu1.visible = false;
				menu2.visible = false;
				menu3.visible = true;
				menu4.visible = false;
				menu5.visible = false;
				menu6.visible = false;
				menu7.visible = false;
				menu8.visible = false;
		 	case 3:
				menu1.visible = false;
				menu2.visible = false;
				menu3.visible = false;
				menu4.visible = true;
				menu5.visible = false;
				menu6.visible = false;
				menu7.visible = false;
				menu8.visible = false;
		 	case 4:
				menu1.visible = false;
				menu2.visible = false;
				menu3.visible = false;
				menu4.visible = false;
				menu5.visible = true;
				menu6.visible = false;
				menu7.visible = false;
				menu8.visible = false;
		 	case 5:
				menu1.visible = false;
				menu2.visible = false;
				menu3.visible = false;
				menu4.visible = false;
				menu5.visible = false;
				menu6.visible = true;
				menu7.visible = false;
				menu8.visible = false;
		 	case 6:	
				menu1.visible = false;
				menu2.visible = false;
				menu3.visible = false;
				menu4.visible = false;
				menu5.visible = false;
				menu6.visible = false;
				menu7.visible = true;
				menu8.visible = false;
		 	case 7:		
		 		menu1.visible = false;
		 		menu2.visible = false;
		 		menu3.visible = false;
		 		menu4.visible = false;
		 		menu5.visible = false;
		 		menu6.visible = false;
		 		menu7.visible = false;
		 		menu8.visible = true;				
		 }
	/*	FlxTween.tween(menu1, {x: 100}, 3,{type: FlxTween.PINGPONG});
		FlxTween.tween(menu2, {x: 100}, 3,{type: FlxTween.PINGPONG});
		FlxTween.tween(menu3, {x: 100}, 3,{type: FlxTween.PINGPONG});
		FlxTween.tween(menu4, {x: 100}, 3,{type: FlxTween.PINGPONG});
		FlxTween.tween(menu5, {x: 100}, 3,{type: FlxTween.PINGPONG});
		FlxTween.tween(menu6, {x: 100}, 3,{type: FlxTween.PINGPONG});
		FlxTween.tween(menu7, {x: 100}, 3,{type: FlxTween.PINGPONG});
		FlxTween.tween(menu8, {x: 100}, 3,{type: FlxTween.PINGPONG}); */
		FlxG.watch.addQuick('blackthing',blackthing);
		FlxG.watch.addQuick('Track ',txtTracklist);
		FlxG.watch.addQuick('Left Arrow ',leftArrow);
		switch (curDifficulty)
		{
			case 0:
				easy.visible = true;
				normal.visible = false;
				hard.visible = false;
			case 1:
				easy.visible = false;
				normal.visible = true;
				hard.visible = false;
			case 2:
				easy.visible = false;
				normal.visible = false;
				hard.visible = true;
		}
		if(menu1.x == 100){
			new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					FlxTween.tween(menu1, {x: 0}, 3);
				});
		}
		else if(menu1.x == 0){
			new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					FlxTween.tween(menu1, {x: 100}, 3);
				});
		}
		if(menu2.x == 100){
			new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					FlxTween.tween(menu2, {x: 0}, 3);
				});
		}
		else if(menu2.x == 0){
			new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					FlxTween.tween(menu2, {x: 100}, 3);
				});
		}
		if(menu3.x == 100){
			new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					FlxTween.tween(menu3, {x: 0}, 3);
				});
		}
		else if(menu3.x == 0){
			new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					FlxTween.tween(menu3, {x: 100}, 3);
				});
		}
		if(menu4.x == 100){
			new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					FlxTween.tween(menu4, {x: 0}, 3);
				});
		}
		else if(menu4.x == 0){
			new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					FlxTween.tween(menu4, {x: 100}, 3);
				});
		}
		if(menu5.x == 100){
			new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					FlxTween.tween(menu5, {x: 0}, 3);
				});
		}
		else if(menu5.x == 0){
			new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					FlxTween.tween(menu5, {x: 100}, 3);
				});
		}
		if(menu6.x == 100){
			new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					FlxTween.tween(menu6, {x: 0}, 3);
				});
		}
		else if(menu6.x == 0){
			new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					FlxTween.tween(menu6, {x: 100}, 3);
				});
		}
		if(menu7.x == 100){
			new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					FlxTween.tween(menu7, {x: 0}, 3);
				});
		}
		else if(menu7.x == 0){
			new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					FlxTween.tween(menu7, {x: 100}, 3);
				});
		}
		if(menu8.x == 100){
			new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					FlxTween.tween(menu8, {x: 0}, 3);
				});
		}
		else if(menu8.x == 0){
			new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					FlxTween.tween(menu8, {x: 100}, 3);
				});
		}														
		// scoreText.setFormat('VCR OSD Mono', 32);
		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, 0.5));

		scoreText.text = "WEEK SCORE:" + lerpScore;

		txtWeekTitle.text = weekNames[curWeek].toUpperCase();
		txtWeekTitle.x = FlxG.width - (txtWeekTitle.width + 10);

		// FlxG.watch.addQuick('font', scoreText.font);

		difficultySelectors.visible = weekUnlocked[curWeek];

		grpLocks.forEach(function(lock:FlxSprite)
		{
			lock.y = grpWeekText.members[lock.ID].y;
		});

		if (!movedBack)
		{
			if (!selectedWeek)
			{
				if (controls.UP_P)
				{
					changeWeek(-1);
				}

				if (controls.DOWN_P)
				{
					changeWeek(1);
				}

				if (controls.RIGHT)
					rightArrow.animation.play('press')
				else
					rightArrow.animation.play('idle');

				if (controls.LEFT)
					leftArrow.animation.play('press');
				else
					leftArrow.animation.play('idle');

				if (controls.RIGHT_P)
					changeDifficulty(1);
				if (controls.LEFT_P)
					changeDifficulty(-1);
			}

			if (controls.ACCEPT)
			{
				selectWeek();
			}
		}

		if (controls.BACK && !movedBack && !selectedWeek)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			movedBack = true;
			FlxG.switchState(new MainMenuState());
		}

		super.update(elapsed);
	}

	var movedBack:Bool = false;
	var selectedWeek:Bool = false;
	var stopspamming:Bool = false;
	override function beatHit()
		{
			menu8.animation.play('static');
			super.beatHit();
		}
	function selectWeek()
	{
		if (weekUnlocked[curWeek])
		{
			if (stopspamming == false)
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));

				grpWeekText.members[curWeek].startFlashing();
				stopspamming = true;
			}

			PlayState.storyPlaylist = weekData[curWeek];
			PlayState.isStoryMode = true;
			selectedWeek = true;

			var diffic = "";

			switch (curDifficulty)
			{
				case 0:
					diffic = '-easy';
				case 2:
					diffic = '-hard';
			}

			PlayState.storyDifficulty = curDifficulty;

			PlayState.SONG = Song.loadFromJson(StringTools.replace(PlayState.storyPlaylist[0]," ", "-").toLowerCase() + diffic, StringTools.replace(PlayState.storyPlaylist[0]," ", "-").toLowerCase());
			PlayState.storyWeek = curWeek;
			PlayState.campaignScore = 0;
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				LoadingState.loadAndSwitchState(new PlayState(), true);
			});
		}
	}

	function changeDifficulty(change:Int = 0):Void
	{
		curDifficulty += change;

		if (curDifficulty < 0)
			curDifficulty = 2;
		if (curDifficulty > 2)
			curDifficulty = 0;



		// USING THESE WEIRD VALUES SO THAT IT DOESNT FLOAT UP
		intendedScore = Highscore.getWeekScore(curWeek, curDifficulty);

		#if !switch
		intendedScore = Highscore.getWeekScore(curWeek, curDifficulty);
		#end

//		FlxTween.tween(sprDifficulty, {y: leftArrow.y + 15, alpha: 1}, 0.07);
	}

	var lerpScore:Int = 0;
	var intendedScore:Int = 0;

	function changeWeek(change:Int = 0):Void
	{
		curWeek += change;

		if (curWeek >= weekData.length)
			curWeek = 0;
		if (curWeek < 0)
			curWeek = weekData.length - 1;

		var bullShit:Int = 0;

		for (item in grpWeekText.members)
		{
			item.targetY = bullShit - curWeek;
			if (item.targetY == Std.int(0) && weekUnlocked[curWeek])
				item.alpha = 1;
			else
				item.alpha = 0.6;
			bullShit++;
		}

		FlxG.sound.play(Paths.sound('scrollMenu'));

		updateText();
	}

	function updateText()
	{
		txtTracklist.text = "\n";
		var stringThing:Array<String> = weekData[curWeek];

		for (i in stringThing)
			{
				txtTracklist.text += "\n" + i;
			}

		#if !switch
		intendedScore = Highscore.getWeekScore(curWeek, curDifficulty);
		#end
	}
}
