import funkin.data.Control;
import funkin.data.Highscore;
import flixel.text.FlxText;
import flixel.group.FlxTypedGroup;
import flixel.FlxObject;
import flixel.math.FlxMath;
import funkin.states.FreeplayState;
import funkin.states.MainMenuState;
import funkin.states.LoadingState;
import flixel.addons.transition.FlxTransitionableState;
import funkin.utils.MathUtil;
import funkin.utils.DifficultyUtil;
import funkin.states.editors.HScriptState;

import StringTools;

import funkin.backend.PlayerSettings;
var controls = PlayerSettings.player1.controls;

var custom:Bool = true;
function customMenu(){ return custom; }

var songs:Array<SongMetadata> = [];

var cerealGroup:FlxTypedGroup;
var trollGroup:FlxTypedGroup;
var epicGroup:FlxTypedGroup;
var morecomingGroup:FlxTypedGroup;
var extrasGroup:FlxTypedGroup;

var camFollow:FlxObject;
var camFollowPos:FlxObject;

var songs:Array<SongMetadata> = [];

var selector:FlxText;
var curSelected:Int = 0;
var curDifficulty:Int = -1;
var lastDifficultyName:String = '';

var scoreBG:FlxSprite;
var scoreText:FlxText;
var lerpScore:Int = 0;
var lerpRating:Float = 0;
var intendedScore:Int = 0;
var intendedRating:Float = 0;

var limits:Array<Float> = [0, 0]; //max and min
var distances:Array<Float> = [
    0,
    0,
    0,
    0,
    0
];
var colours:Array<FlxColor> = [0xFF6e69b6, 0xFF575a64, 0xFFFFA500, 0xFF2b2d35, 0xFF000000];

var sections:Array<String> = [
    'CerealGuySection',
    'TrollFaceSection',
    'EpicFaceSection',
    'MiscSection',
    'morecoming_section',
    'ExtrasSection'
];

var sectionCOMPONENTS:Array<Array<String>> = [ //Multi-dimensional array to load in the assets easily, saves a bunch of time for coding :skull:
    ['FreePlayCGShelf', 'FreeplayChokeALot', 'FreeplayCrunch', 'FreeplayMilkyWay'], //cereal guy
    ['FreePlayTrollFaceShelf', 'FreeplayReunion', 'FreeplayHope', 'FreeplayDoubt'],
    ['FreePlayEpicFaceShelf', 'FreeplaySmile', 'FreeplayOrderUp', 'FreeplayLastCourse'],
    ['miscshelf', 'FreeplayYolo', 'FreeplayRaveGirl', 'FreeplayCrunchMix'],
    ['', 'FreePlayComingSoon!', 'FreeplaySoundtest', 'FreeplayAlert'],
    ['FreeplaySpooky', 'freeplay-gm']
];

var previousSpot:Float = -1;

var curPlaying:Bool = false;
var bg_music:FlxSound;

var bg:FlxSprite;
var intendedColor:Int;
var colorTween:FlxTween;

var backbutton:FlxSprite;
var transition:FlxSprite;
var previousSpot:Float = -1;

var foreGroundSelect:FlxSprite;
var coverArt:FlxSprite;
var isSelected:Bool = false;
var cg_playbutton:FlxSprite;

var curPlaying:Bool = false;
var bg_music:FlxSound;

var backbutton:FlxSprite;
var transition:FlxSprite;

var camMoving = true;

function onCreatePost(){
    if(custom){        
        FlxG.mouse.visible = true;
        Paths.currentModDirectory = 'crunchin';
        WindowUtil.setTitle("Friday Night Crunchin' - Browsing the menus");

        bg_music = new FlxSound().loadEmbedded(Paths.music('below_the_boards'));
        bg_music.looped = true;
        bg_music.volume = 0;
        FlxG.sound.list.add(bg_music);

        bg = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.WHITE);
        bg.screenCenter();
        bg.scrollFactor.set();
        add(bg);

        camFollow = new FlxObject(FlxG.width / 2, FlxG.height / 2, 1, 1);
        camFollowPos = new FlxObject(FlxG.width / 2, FlxG.height / 2, 1, 1);
        
        limits[0] = camFollow.y;

        if(previousSpot != -1) //default value to see difference
        {
            camFollow.y = previousSpot;
            camFollowPos.y = camFollow.y;
            colourCheckFunc(true);
        }
        add(camFollowPos);
        add(camFollow);

        FlxG.camera.follow(camFollowPos, FlxCameraFollowStyle.LOCKON, 1);

        scoreText = new FlxText(FlxG.width * 0.7, 5, 0, "", 32);
        scoreText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, FlxTextAlign.RIGHT);
        //add(scoreText);

        if(curSelected >= songs.length) curSelected = 0;
        if(lastDifficultyName == '')
        {
            lastDifficultyName = DifficultyUtil.defaultDifficulty;
        }
        curDifficulty = Math.round(Math.max(0, DifficultyUtil.defaultDifficulties.indexOf(lastDifficultyName)));

        cerealGroup = new FlxTypedGroup();
        trollGroup = new FlxTypedGroup();
        epicGroup = new FlxTypedGroup();
        morecomingGroup = new FlxTypedGroup();
        miscGroup = new FlxTypedGroup();
        extrasGroup = new FlxTypedGroup();

        add(cerealGroup);
        add(trollGroup);
        add(epicGroup);
        add(miscGroup);
        add(extrasGroup);
        add(morecomingGroup);


        var scale = 0.6666666667; // old amount 0.44171779141
        var freeplayScale = 0.55;
        var oldScale = 0.44171779141;
        for(i in 0...sections.length)
        {
            switch(i)
            {
                case 0:
                    for(x in 0...sectionCOMPONENTS[i].length)
                    {
                        var name = sectionCOMPONENTS[i][x];

                        var sprite:FlxSprite = new FlxSprite();
                        var isSong = StringTools.contains(name, 'Freeplay');
                        if(isSong){
                            sprite.frames = Paths.getSparrowAtlas('freeplay/' + sections[i] + '/' + name);
                            sprite.animation.addByPrefix('idle', name + ' normal', 0, false);
                            sprite.animation.addByPrefix('select', name + ' select', 0, false);
                            sprite.animation.play('idle');
                        }
                        else{
                            sprite.loadGraphic(Paths.image('freeplay/' + sections[i] + '/' + name));
                        }
                        sprite.scale.set(scale, scale);
                        if(x != 0)
                            sprite.updateHitbox();
                        sprite.antialiasing = true;
                        sprite.screenCenter();
                        sprite.y += FlxG.height * i;
                        sprite.ID = x;

                        switch(x)
                        {
                            case 0:
                                distances[i] = sprite.getGraphicMidpoint().y;
                            case 1: //choke a lot
                                sprite.setPosition(sprite.x - 190, sprite.y + 105);
                            case 2: // crunch
                                sprite.setPosition(sprite.x + 35, sprite.y - 150);
                            case 3: //milkyway
                                sprite.setPosition(sprite.x + 165, sprite.y - 40);
                        }

                        cerealGroup.add(sprite);
                    }
                case 1:
                    for(x in 0...sectionCOMPONENTS[i].length)
                    {
                        var name = sectionCOMPONENTS[i][x];
                
                        var sprite:FlxSprite = new FlxSprite();
                        var isSong = StringTools.contains(name, 'Freeplay');
                        if(isSong){
                            sprite.frames = Paths.getSparrowAtlas('freeplay/' + sections[i] + '/' + name);
                            sprite.animation.addByPrefix('idle', name + ' normal', 0, false);
                            sprite.animation.addByPrefix('select', name + ' select', 0, false);
                            sprite.animation.play('idle');
                        }
                        else{
                            sprite.loadGraphic(Paths.image('freeplay/' + sections[i] + '/' + name));
                        }
                        sprite.scale.set(scale, scale);
                        if(x != 0)
                            sprite.updateHitbox();
                        sprite.antialiasing = true;
                        sprite.screenCenter();
                        sprite.y += FlxG.height * i;
                        sprite.ID = x;

                        switch(x)
                        {
                            case 0:
                                distances[i] = sprite.getGraphicMidpoint().y;
                            case 1: // reunion
                                sprite.setPosition(sprite.x - 190, sprite.y + 55);
                            case 2: // hope
                                sprite.setPosition(sprite.x + 160, sprite.y - 66);
                            case 3: // doubt
                                sprite.setPosition(sprite.x - 150, sprite.y - 177);
                        }

                        trollGroup.add(sprite);
                    }
                case 2:
                    for(x in 0...sectionCOMPONENTS[i].length)
                    {
                        var name = sectionCOMPONENTS[i][x];

                        var sprite:FlxSprite = new FlxSprite();
                        var isSong = StringTools.contains(name, 'Freeplay');
                        if(isSong){
                            sprite.frames = Paths.getSparrowAtlas('freeplay/' + sections[i] + '/' + name);
                            sprite.animation.addByPrefix('idle', name + ' normal', 0, false);
                            sprite.animation.addByPrefix('select', name + ' select', 0, false);
                            sprite.animation.play('idle');
                        }
                        else{
                            sprite.loadGraphic(Paths.image('freeplay/' + sections[i] + '/' + name));
                        }
                        sprite.scale.set(scale, scale);
                        if(x != 0)
                            sprite.updateHitbox();
                        sprite.antialiasing = true;
                        sprite.screenCenter();
                        sprite.y += FlxG.height * i;
                        sprite.ID = x;

                        switch(x)
                        {
                            case 0:
                                distances[i] = sprite.getGraphicMidpoint().y;
                            case 1: //smile
                                sprite.setPosition(sprite.x - 210, sprite.y - 31);
                            case 2: //order-up
                                sprite.setPosition(sprite.x - 50, sprite.y + 52);
                            case 3: //last course
                                sprite.setPosition(sprite.x + 170, sprite.y + 170);
                            /*case 2:
                                sprite.setPosition(sprite.x - 175, sprite.y - 125);*/
                        }

                        epicGroup.add(sprite);
                    }
                case 3:
                    for(x in 0...sectionCOMPONENTS[i].length)
                        {
                            var name = sectionCOMPONENTS[i][x];
                            
                            var sprite:FlxSprite = new FlxSprite();
                            var isSong = StringTools.contains(name, 'Freeplay');
                            if(isSong){
                                sprite.frames = Paths.getSparrowAtlas('freeplay/' + sections[i] + '/' + name);
                                sprite.animation.addByPrefix('idle', name + ' normal', 0, false);
                                sprite.animation.addByPrefix('select', name + ' select', 0, false);
                                sprite.animation.play('idle');
                            }
                            else{
                                sprite.loadGraphic(Paths.image('freeplay/' + sections[i] + '/' + name));
                            }
                            sprite.scale.set(scale, scale);
                            if(x != 0)
                                sprite.updateHitbox();
                            sprite.antialiasing = true;
                            sprite.screenCenter();
                            sprite.y += FlxG.height * i;
                            sprite.ID = x;

                            switch(x)
                            {
                                case 0:
                                    distances[i] = sprite.getGraphicMidpoint().y;
                                case 1:
                                    sprite.setPosition(sprite.x - 140, sprite.y - 36);
                                case 2:
                                    sprite.setPosition(sprite.x - 240, sprite.y - 428);
                                // case 3:
                                //     sprite.setPosition(sprite.x + 200, sprite.y + 280);
                                //     if(FlxG.random.bool(25)){
                                //         sprite.angle = -100;
                                //         sprite.y += 30;
                                //     }
                                case 3:
                                    sprite.setPosition(sprite.x + 200, sprite.y - 1915);
                                // case 5:
                                //     sprite.setPosition(sprite.x, sprite.y + 1000);
                            }

                            miscGroup.add(sprite);
                        }
                case 4:
                    for(x in 0...sectionCOMPONENTS[i].length)
                    {
                        var name = sectionCOMPONENTS[i][x];
                        
                        var sprite:FlxSprite = new FlxSprite();
                        var isSong = StringTools.contains(name, 'Freeplay');
                        if(isSong){
                            sprite.frames = Paths.getSparrowAtlas('freeplay/' + sections[i] + '/' + name);
                            if(x != 3){
                                sprite.animation.addByPrefix('idle', name + ' normal', 0, false);
                                sprite.animation.addByPrefix('select', name + ' select', 0, false);
                                sprite.animation.play('idle');    
                            }else{
                                var pref = '';
                                if(FlxG.save.data.CrunchinSongData.get('alert').finished) pref = 'played ';
                                sprite.animation.addByPrefix('idle', 'FreeplayAlert ' + pref + 'normal');
                                sprite.animation.addByPrefix('select', 'FreeplayAlert ' + pref + 'hover');
                                sprite.animation.play('idle');    
                            }


                        }
                        else{
                            sprite.loadGraphic(Paths.image('freeplay/' + sections[i] + '/' + name));
                        }
                        sprite.scale.set(scale, scale);
                        if(x != 0)
                            sprite.updateHitbox();
                        sprite.antialiasing = true;
                        sprite.screenCenter();
                        sprite.y += FlxG.height * i;
                        sprite.ID = x;

                        switch(x)
                        {
                            case 0:
                                distances[i] = sprite.getGraphicMidpoint().y;
                            case 2:
                                sprite.setPosition(sprite.x - 185, sprite.y + 110);
                            case 3:
                                sprite.setPosition(sprite.x, sprite.y + 650);
                        }

                        morecomingGroup.add(sprite);
                    }
                case 5:
                    for(x in 0...sectionCOMPONENTS[i].length)
                    {
                        var name = sectionCOMPONENTS[i][x];

                        var sprite:FlxSprite = new FlxSprite();
                        var isSong = StringTools.contains(name, 'Freeplay');
                        var sectionName = name;

                        if(x != 0){
                            sprite.frames = Paths.getSparrowAtlas('freeplay/' + sections[i] + '/' + name);
                            sprite.animation.addByPrefix('idle', name + ' unselect', 0, false);
                            sprite.animation.addByPrefix('select', name + ' select', 0, false);
    
                            sprite.scale.set(freeplayScale, freeplayScale); //only done for these icons
                            if(x != 0)
                                sprite.updateHitbox();
                            sprite.antialiasing = true;
                            sprite.screenCenter();
                            sprite.y += FlxG.height * i;
                            sprite.ID = x;
                        }else{
                            sprite.loadGraphic(Paths.image('freeplay/' + sections[i] + '/' + name));
                        }

                        switch(x)
                        {
                            case 0:
                                sprite.screenCenter();
                                sprite.y += (FlxG.height * 5) + 177.5;
                                distances[i] = (sprite.getGraphicMidpoint().y + 27.5);
                            case 1:
                                sprite.y += 400;
                                limits[1] = (sprite.getGraphicMidpoint().y + 27.5) - 5;
                                distances[i] = (sprite.getGraphicMidpoint().y + 27.5);
                        }

                        extrasGroup.add(sprite);
                    }
            }
        }
        // limits[1] = 3500;
        var textBG:FlxSprite = new FlxSprite(0, FlxG.height - 26).makeGraphic(FlxG.width, 26, 0xFF000000);
        textBG.scrollFactor.set();
        textBG.alpha = 0.6;

        var leText:String = "Press SPACE to listen to the Song / Press CTRL to open the Gameplay Changers Menu / Press RESET to Reset your Score and Accuracy.";
        var size:Int = 16;
        var text:FlxText = new FlxText(textBG.x, textBG.y + 4, FlxG.width, leText, size);
        text.setFormat(Paths.font("vcr.ttf"), size, FlxColor.WHITE, FlxTextAlign.RIGHT);
        text.scrollFactor.set();

        foreGroundSelect = new FlxSprite().loadGraphic(Paths.image('freeplay/morecoming_section/FreePlaySelectShadow'));
        foreGroundSelect.screenCenter();
        foreGroundSelect.scale.set(scale, scale);
        foreGroundSelect.scrollFactor.set();
        foreGroundSelect.alpha = 0;
        add(foreGroundSelect);

        coverArt = new FlxSprite().loadGraphic(Paths.image('freeplay/CoverArts/unknown'));
        coverArt.scrollFactor.set();
        coverArt.screenCenter();
        coverArt.scale.set(0.35, 0.35);
        coverArt.x -= 250;
        coverArt.visible = false;
        add(coverArt);

        cg_playbutton = new FlxSprite();
        cg_playbutton.frames = Paths.getSparrowAtlas('storymode/play');
        cg_playbutton.animation.addByPrefix('idle', 'play_idle', 24, false);
        cg_playbutton.animation.addByPrefix('select', 'play_select', 24, false);
        cg_playbutton.animation.play('idle');
        cg_playbutton.scale.set(0.5, 0.5);
        cg_playbutton.updateHitbox();
        cg_playbutton.scrollFactor.set();
        cg_playbutton.screenCenter();
        cg_playbutton.x += 350;
        cg_playbutton.alpha = 0;
        add(cg_playbutton);

        backbutton = new FlxSprite();
        backbutton.frames = Paths.getSparrowAtlas('backbutton');
        backbutton.animation.addByPrefix('idle', 'backbutton idle', 24, false);
        backbutton.animation.addByPrefix('hover', 'backbutton hover', 24, false);
        backbutton.animation.addByPrefix('confirm', 'backbutton confirm', 24, false);
        backbutton.animation.play('idle');
        backbutton.scrollFactor.set();
        backbutton.setPosition(10, 10);
        add(backbutton);

        transition = new FlxSprite();
        transition.frames = Paths.getSparrowAtlas('transition_out');
        transition.animation.addByPrefix('idle', 'transition_out idle', 60, false);
        transition.screenCenter();
        transition.scrollFactor.set();
        transition.scale.set(2.5, 2.5);

        add(transition);
        transition.animation.play('idle', false, true);
    }
}
    
var instPlaying:Int = -1;
var vocals:FlxSound = null;
var holdTime:Float = 0;
//var scaleX = 0.44171779141; //this is the new one  
var scaleX = 0.6666666667;

var curSelectx:Int = -1;
var curSelecty:Int = -1;

var color_check:FlxColor;

var ready:Bool = true;
var newVolume:Float = 1;
var thingVolume:Float = 0;
var stop = false;

function colourCheckFunc(?forceColor:Bool = false){
    var getInt:Int = 0;

    for(i in 0...distances.length)
    {
        if(camFollow.y >= distances[i] - 400 && camFollow.y <= distances[i + 1])
        {
            getInt = i;
        }
    }

    switch(getInt)
    {
        case 0:
            stop = false;
            newVolume = 1;
            thingVolume = 0;
        case 1:
            stop = false;
            newVolume = 0.75;
            thingVolume = 0;
        case 2:
            stop = false;
            newVolume = 0.5;
            thingVolume = 0;
        case 3:
            stop = false;
            newVolume = 0.25;
            thingVolume = 0.25;

            if(bg_music != null)
            {
                if(!bg_music.playing)
                {
                    bg_music.play();
                }
                else
                {
                    thingVolume = 1;
                }
            }
        case 4:
            newVolume = 0;

            if(bg_music != null)
            {
                if(!bg_music.playing)
                {
                    bg_music.play();
                }
                else
                    {
                    thingVolume = 1;
                }

                if(FlxG.sound.music.playing && !stop)
                {
                    stop = true;
                    FlxTween.tween(FlxG.sound.music, {volume: 0}, 2, {ease: FlxEase.quadInOut, onComplete: FlxG.sound.music.pause});
                    // FlxG.sound.music.pause();
                }
            }
        default:
            // stop = true;
            // if(FlxG.sound.music.playing)
            // {
            //     FlxTween.tween(FlxG.sound.music, {volume: 0}, 0.5);
            //     FlxG.sound.music.pause();
            // }
    }	

    if(FlxG.sound.music != null && !FlxG.sound.music.playing && getInt <= 3){
        FlxG.sound.music.resume();
    }

    var int_color = colours[getInt];

    if(forceColor){
        color_check = int_color;
        bg.color = int_color;
    }
    else if(int_color != color_check)
    {
        if(colorTween != null)
            colorTween.cancel();
        
        color_check = int_color;

        colorTween = FlxTween.color(bg, 1, bg.color, int_color, {
            onComplete: function(twn:FlxTween) {
                colorTween = null;
            }
        });
    }        
}

function onUpdate(elapsed){
    if(custom){
    // if(FlxG.keys.justPressed.R) FlxG.resetState();    

    if(!stop)  FlxG.sound.music.volume = FlxMath.lerp(FlxG.sound.music.volume, newVolume, FlxMath.bound(elapsed * 3, 0, 1));
    bg_music.volume = FlxMath.lerp(bg_music.volume, thingVolume, FlxMath.bound(elapsed * 3, 0, 1));

		var overlapping = false;
        if(extrasGroup != null){
            cerealGroup.forEach(function(spr:FlxSprite){
                if(FlxG.mouse.overlaps(spr) && spr.ID != 0 && StringTools.contains(sectionCOMPONENTS[0][spr.ID], 'Freeplay') && !overlapping && !isSelected)
                {
                    overlapping = true;
                    if(spr.animation.exists('select')){
                        spr.animation.play('select');
                    }
                    //spr.scale.set(scaleX + 0.01, scaleX + 0.01);
                    curSelectx = spr.ID;
                    curSelecty = 0;
                }
                else
                {
                    //spr.scale.set(scaleX, scaleX);
                    if(spr.animation.exists('idle')){
                        spr.animation.play('idle');
                    }
                }
            });
    
            trollGroup.forEach(function(spr:FlxSprite){
                if(FlxG.mouse.overlaps(spr) && spr.ID != 0 && StringTools.contains(sectionCOMPONENTS[1][spr.ID], 'Freeplay') && !overlapping && !isSelected)
                {
                    overlapping = true;
                    if(spr.animation.exists('select')){
                        spr.animation.play('select');
                    }
                    curSelectx = spr.ID;
                    curSelecty = 1;
                }
                else
                {
                    if(spr.animation.exists('idle')){
                        spr.animation.play('idle');
                    }
                }
            });
    
            epicGroup.forEach(function(spr:FlxSprite){
                if(FlxG.mouse.overlaps(spr) && spr.ID != 0 && StringTools.contains(sectionCOMPONENTS[2][spr.ID], 'Freeplay') && !overlapping && !isSelected)
                {
                    overlapping = true;
                    if(spr.animation.exists('select')){
                        spr.animation.play('select');
                    }
                    curSelectx = spr.ID;
                    curSelecty = 2;
                }
                else
                {
                    if(spr.animation.exists('idle')){
                        spr.animation.play('idle');
                    }
                }
            });
    
            miscGroup.forEach(function(spr:FlxSprite){
                if(FlxG.mouse.overlaps(spr) && spr.ID != 0 && StringTools.contains(sectionCOMPONENTS[3][spr.ID], 'Freeplay') && !overlapping && !isSelected)
                {
                    overlapping = true;
                    if(spr.animation.exists('select')){
                        spr.animation.play('select');
                    }
                    curSelectx = spr.ID;
                    curSelecty = 3;
                }
                else
                {
                    if(spr.animation.exists('idle')){
                        spr.animation.play('idle');
                    }
                }
            });

            morecomingGroup.forEach(function(spr:FlxSprite){
                if(FlxG.mouse.overlaps(spr) && (spr.ID != 0 && spr.ID != 1) && StringTools.contains(sectionCOMPONENTS[4][spr.ID], 'Freeplay') && !overlapping && !isSelected)
                {
                    overlapping = true;
                    if(spr.animation.exists('select')){
                        spr.animation.play('select');
                    }
                    curSelectx = spr.ID;
                    curSelecty = 4;
                }
                else
                {
                    if(spr.animation.exists('idle')){
                        spr.animation.play('idle');
                    }
                }
            });
    
            extrasGroup.forEach(function(spr:FlxSprite){
                if(spr.animation.exists('select')){
                    if(FlxG.mouse.overlaps(spr) && !overlapping && !isSelected && spr.visible)
                    {
                        overlapping = true;

                        if(spr.animation.exists('select')){
                            spr.animation.play('select');
                        }
                        else{
                            spr.scale.set(scaleX + 0.01, scaleX + 0.01);
                        }
                        curSelectx = spr.ID;
                        curSelecty = 5;
                    }
                    else
                    {
                        if(spr.animation.exists('idle')){
                            spr.animation.play('idle');
                        }
                        else{
                            spr.scale.set(scaleX, scaleX);
                        }
                    }
                }
            });
    
        }

		if(isSelected && FlxG.mouse.overlaps(cg_playbutton) && ready)
		{
			cg_playbutton.animation.play('select');

			if(FlxG.mouse.pressed)
			{
				ready = false;

				persistentUpdate = false;
				var actualName = sectionCOMPONENTS[curSelecty][curSelectx].substring(8, sectionCOMPONENTS[curSelecty][curSelectx].length).toLowerCase();

				switch(actualName)
				{
					case 'chokealot':
						actualName = 'choke-a-lot';
					case 'lastcourse':
						actualName = 'last-course';
					case 'orderup':
						actualName = 'order-up';
				}

				var songLowercase:String = Paths.formatToSongPath(actualName);

				PlayState.SONG = Song.loadFromJson(songLowercase + '-hard', songLowercase);
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = curDifficulty;

				if(colorTween != null) {
					colorTween.cancel();
				}
                FlxTransitionableState.skipNextTransIn = true;
                FlxTransitionableState.skipNextTransOut = true;
                transition.animation.play('idle', false, false);
                transition.animation.finishCallback = ()->{
                    LoadingState.loadAndSwitchState(new PlayState());
                }

				FlxG.sound.music.volume = 0;
						
				FreeplayState.destroyFreeplayVocals();
			}
		}
		else
		{
			cg_playbutton.animation.play('idle');
		}

		//
		
		if(!isSelected && !persistentUpdate)
		{
			backbutton.animation.play('confirm');
		}
		else
		{
			if(FlxG.mouse.overlaps(backbutton))
			{
				backbutton.animation.play('hover');
	
				if(persistentUpdate && FlxG.mouse.pressed)
				{
					if(!isSelected)
					{
						persistentUpdate = false;
						if(colorTween != null) {
							colorTween.cancel();
						}
		
						FlxTransitionableState.skipNextTransIn = true;
					
						FlxG.sound.play(Paths.sound('cancelMenu'));
						transition.animation.play('idle');
                        stop = true;
                        FlxTween.cancelTweensOf(FlxG.sound.music);
                        // FlxG.sound.music.volume = 1;
                        if(!FlxG.sound.music.playing)
                            FlxG.sound.music.resume();

                        FlxTween.tween(FlxG.sound.music, {volume: 1}, 2, {ease: FlxEase.quadInOut});

						new FlxTimer().start(1, function(tmr:FlxTimer)
						{
                            FlxG.switchState(new MainMenuState());
						});
					}
					else
					{
						if(ready)
						{
							ready = false;
							FlxTween.tween(foreGroundSelect, {alpha: 0}, 0.5, {ease: FlxEase.quadInOut});
							FlxTween.tween(cg_playbutton, {alpha: 0}, 0.5, {ease: FlxEase.quadInOut});
		
							coverArt.screenCenter(FlxAxes.Y);
							var oldY = coverArt.y + FlxG.height / 1;
		
							FlxTween.tween(coverArt, {y: oldY}, 1, {ease: FlxEase.quintOut, onComplete: function(twn:FlxTween){
								coverArt.visible = false;
								isSelected = false;
								ready = true;
							}});
						}
					}
				}
			}
			else
			{
				backbutton.animation.play('idle');
			}
		}

		//
		
		camFollowPos.x = FlxMath.lerp(camFollowPos.x, camFollow.x, elapsed * 3);
		camFollowPos.y = FlxMath.lerp(camFollowPos.y, camFollow.y, elapsed * 3);

        if(camMoving){
            if (FlxG.mouse.wheel != 0 && !isSelected)
                {
                    camFollow.y += -(FlxG.mouse.wheel * 50);
                }
        
                if(camFollow != null){
                    previousSpot = camFollow.y;
                }
        
                if(!isSelected)
                {
                    if(controls.UI_UP_P)
                    {
                        camFollow.y -= 100;
                    }
        
                    if(controls.UI_DOWN_P)
                    {
                        camFollow.y += 100;
                    }
                }
        
                if(camFollow.y < limits[0])
                    camFollow.y = limits[0];
        
                if(camFollow.y > limits[1])
                    camFollow.y = limits[1];        
        }

		colourCheckFunc();

		if(FlxG.mouse.pressed && (curSelectx != -1 && curSelecty != -1) && !isSelected && ready && overlapping)
		{
			ready = false;
			isSelected = true;

            // trace(curSelecty);

            if(curSelecty != 5){
                FlxTween.tween(foreGroundSelect, {alpha: 1}, 0.5, {ease: FlxEase.quadInOut});
                FlxTween.tween(cg_playbutton, {alpha: 1}, 0.5, {ease: FlxEase.quadInOut});

                coverArt.visible = true;
                coverArt.screenCenter(FlxAxes.Y);
                var oldY:Float = coverArt.y;
                coverArt.y += FlxG.height / 1;
                var stringthing = sectionCOMPONENTS[curSelecty][curSelectx].substring(8, sectionCOMPONENTS[curSelecty][curSelectx].length);

                if(Paths.image('freeplay/CoverArts/' + stringthing) != null)
                {
                    var isRumor:Bool =  (!FlxG.save.data.CrunchinSongData.get('rumor').finished) && (stringthing.toLowerCase() == 'rumor');
                    var isAlert:Bool =  (!FlxG.save.data.CrunchinSongData.get('alert').finished) && (stringthing.toLowerCase() == 'alert');
                    stringthing += (isRumor || isAlert) ? 'Alt1' : '';

                    coverArt.loadGraphic(Paths.image('freeplay/CoverArts/' + stringthing));
                }
                else
                {
                    coverArt.loadGraphic(Paths.image('freeplay/CoverArts/unknown'));
                }
            
                FlxTween.tween(coverArt, {y: oldY}, 1, {ease: FlxEase.quintOut, onComplete: function(twn:FlxTween){
                    ready = true;
                }});
            }
            if(curSelecty == 5){
                camMoving = false;
                camFollow.x = 7.5 + extrasGroup.members[1].getGraphicMidpoint().x;
                camFollow.y = extrasGroup.members[1].getGraphicMidpoint().y;

                FlxTween.num(FlxG.camera.zoom, 12.5, 2, {ease: FlxEase.quadIn, onUpdate: (t)->{
                    FlxG.camera.zoom = t.value;
                }, onComplete: ()->{
                    FlxTransitionableState.skipNextTransIn = true;
                    FlxG.switchState(new HScriptState('TheVoid'));
                }});
                FlxG.camera.fade(FlxColor.ORANGE, 2);
            }
		}

		var accepted = Control.ACCEPT;
		var space = FlxG.keys.justPressed.SPACE;
		var ctrl = FlxG.keys.justPressed.CONTROL;

		var shiftMult:Int = 1;
		if(FlxG.keys.pressed.SHIFT) shiftMult = 3;
    }
}