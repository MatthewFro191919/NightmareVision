import flixel.FlxObject;
import funkin.data.Control;
import funkin.utils.DifficultyUtil;
import funkin.states.LoadingState;
import funkin.states.FreeplayState;
import funkin.states.MainMenuState;
import flixel.addons.transition.FlxTransitionableState;

import funkin.backend.PlayerSettings;
var controls = PlayerSettings.player1.controls;

var fuckers:Array<FlxSprite> = [];
var directory = 'freeplay/ExtrasSection/';

var foreGroundSelect:FlxSprite;
var coverArt:FlxSprite;
var isSelected:Bool = false;
var cg_playbutton:FlxSprite;
var backbutton:FlxSprite;

var overlapspr:FlxSprite;
var ready:Bool = true;
var start:Bool = false;
var isSelected:Bool = false;

var songs = ['alert', 'legacy', 'rattled', 'threat', 'rumor'];

var scale = 0.6666666667; // old amount 0.44171779141
var scaleX = 0.6666666667;

var curDifficulty = -1;
var lastDifficultyName:String = '';

var camFollow:FlxObject;
var camFollowPos:FlxObject;
var limits = [550, -1200];

var transition:FlxSprite;

function create(){
    FlxG.sound.playMusic(Paths.music('below_the_boards'));
    FlxTransitionableState.skipNextTransIn = true;

    FlxG.camera.flash(FlxColor.ORANGE, 5);
    FlxTween.num(9, FlxG.camera.zoom, 5, {ease: FlxEase.quartOut, onUpdate: (t)->{
        FlxG.camera.zoom = t.value;
    }, onComplete: ()->{
        start = true;
    }});


    camFollow = new FlxObject(FlxG.width / 2, 550, 1, 1);
    camFollowPos = new FlxObject(FlxG.width / 2, 550, 1, 1);
    FlxG.camera.follow(camFollowPos, FlxCameraFollowStyle.LOCKON, 1);

    var background = new FlxSprite().loadGraphic(Paths.image('freeplay/FreeplayGodmodePurgatory'));
    background.setGraphicSize(1280);
    background.updateHitbox();
    background.screenCenter(FlxAxes.X);
    background.y -= 1600;
    add(background);

    // var pref = '';
    // if(FlxG.save.data.CrunchinSongData.get('alert').finished) pref = 'played ';
    // var alert = new FlxSprite();
    // alert.frames = Paths.getSparrowAtlas(directory + 'FreeplayAlert');
    // alert.animation.addByPrefix('idle', 'FreeplayAlert ' + pref + 'normal');
    // alert.animation.addByPrefix('select', 'FreeplayAlert ' + pref + 'hover');
    // alert.x += 50;
    // alert.y -= 610;
    // alert.ID = 0;
    // add(alert);
    // fuckers.push(alert);

    var pref = '';
    if(FlxG.save.data.CrunchinSongData.get('legacy').finished) pref = 'played ';
    var legacy = new FlxSprite();
    legacy.frames = Paths.getSparrowAtlas(directory + 'FreeplayLegacy');
    legacy.animation.addByPrefix('idle', 'FreeplayLegacy normal');
    legacy.animation.addByPrefix('select', 'FreeplayLegacy hover');
    // legacy.y += 25;
    legacy.screenCenter(FlxAxes.X);
    legacy.x += 85;
    legacy.y -= 200;
    legacy.ID = 1;
    add(legacy);
    fuckers.push(legacy);

    var rattled = new FlxSprite().loadGraphic(Paths.image(directory + 'FreeplayRattled'));
    rattled.screenCenter();
    rattled.ID = 2;
    rattled.x -= 410;
    rattled.y += 210;
    rattled.angle = -8;
    add(rattled);
    fuckers.push(rattled);

    var pref = '';
    if(FlxG.save.data.CrunchinSongData.get('threat').finished) pref = 'played ';

    var threat = new FlxSprite();
    threat.frames = Paths.getSparrowAtlas(directory + 'FreeplayThreat');
    threat.animation.addByPrefix('idle', 'FreeplayThreat ' + pref + 'normal');
    threat.animation.addByPrefix('select', 'FreeplayThreat ' + pref + 'hover');
    threat.screenCenter(FlxAxes.X);
    threat.x += 85;
    threat.y += 375;
    threat.ID = 3;
    add(threat);
    fuckers.push(threat);

    var pref = '';
    if(FlxG.save.data.CrunchinSongData.get('rumor').finished) pref = 'played ';
    var rumor = new FlxSprite();
    rumor.frames = Paths.getSparrowAtlas(directory + 'FreeplayRumor');
    rumor.animation.addByPrefix('idle', 'FreeplayRumor ' + pref + 'normal');
    rumor.animation.addByPrefix('select', 'FreeplayRumor ' + pref + 'hover');
    // rumor.x += 875;
    rumor.screenCenter(FlxAxes.X);
    rumor.x += (rumor.width / 8) + 11;
    rumor.y -= 1358;
    rumor.ID = 4;
    add(rumor);
    fuckers.push(rumor);
    
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
    transition.visible = false;

    for(fuck in fuckers){ fuck.scale.set(scale, scale); if(fuck.animation.exists('idle')){ fuck.animation.play('idle', true); fuck.updateHitbox(); }  }

}

var camMoving = true;

function update(elapsed){
    // if(FlxG.keys.justPressed.R) FlxG.resetState();    

    camFollowPos.x = FlxMath.lerp(camFollowPos.x, camFollow.x, elapsed * 3);
    camFollowPos.y = FlxMath.lerp(camFollowPos.y, camFollow.y, elapsed * 3);

    if(camMoving){
        if(camFollow != null){
            if (FlxG.mouse.wheel != 0 && !isSelected)
                camFollow.y += -(FlxG.mouse.wheel * 50);
    
            if(camFollow.y > limits[0])
                camFollow.y = limits[0];
    
            if(camFollow.y < limits[1])
                camFollow.y = limits[1];

            if(controls.UI_UP_P)
            {
                camFollow.y -= 100;
            }

            if(controls.UI_DOWN_P)
            {
                camFollow.y += 100;
            }
        } 
    }

    if(lastDifficultyName == '')
    {
        lastDifficultyName = DifficultyUtil.defaultDifficulty;
    }
    curDifficulty = Math.round(Math.max(0, DifficultyUtil.defaultDifficulties.indexOf(lastDifficultyName)));


    if(start){  
        var overlapping:Bool = false;
        
        for(fuck in fuckers){
            if(!isSelected){
                if(FlxG.mouse.overlaps(fuck)){
                    overlapping = true;
                    if(fuck.animation.exists('select')){
                        fuck.animation.play('select');
                    }
                    else{
                        fuck.scale.set(scaleX + 0.01, scaleX + 0.01);
                    }    
    
                    if(FlxG.mouse.justPressed) 
                        overlapspr = fuck;
                }else{
                    if(fuck.animation.exists('idle')){
                        fuck.animation.play('idle');
                    }
                    else{
                        fuck.scale.set(scaleX, scaleX);
                    }
                    // overlapsspr = null;
                }
            }
        }

        if(FlxG.mouse.overlaps(backbutton))
        {
            backbutton.animation.play('hover');

            if(FlxG.mouse.justPressed)
            {
                backbutton.animation.play('confirm');

                if(!isSelected && !coverArt.visible)
                {    
                    FlxTransitionableState.skipNextTransIn = true;
                
                    FlxG.sound.play(Paths.sound('cancelMenu'));
                    FlxG.camera.fade(FlxColor.BLACK, 1);

                    new FlxTimer().start(1, function(tmr:FlxTimer)
                    {
                        FlxG.sound.playMusic(Paths.music('freakyMenu'));
                        FlxG.switchState(new FreeplayState());
                    });
                }
                else
                {
                    if(ready)
                    {
                        overlapsspr = null;

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
        }else{
            backbutton.animation.play('idle');
        }
    
        if(overlapping && overlapspr != null && ready && !isSelected && FlxG.mouse.justPressed){
            ready = false;
            isSelected = true;
            FlxTween.tween(foreGroundSelect, {alpha: 1}, 0.5, {ease: FlxEase.quadInOut});
            FlxTween.tween(cg_playbutton, {alpha: 1}, 0.5, {ease: FlxEase.quadInOut});
    
            coverArt.visible = true;
            coverArt.screenCenter(FlxAxes.Y);
            var oldY:Float = coverArt.y;
            coverArt.y += FlxG.height / 1;
    
            if(Paths.image('freeplay/CoverArts/' + songs[overlapspr.ID]) != null)
            {
                var isRumor:Bool = (!FlxG.save.data.CrunchinSongData.get('rumor').finished) && (songs[overlapspr.ID].toLowerCase() == 'rumor');
                var isAlert:Bool = (!FlxG.save.data.CrunchinSongData.get('alert').finished) && (songs[overlapspr.ID].toLowerCase() == 'alert');
                var displaySongLol = songs[overlapspr.ID];
                displaySongLol += (isRumor || isAlert) ? 'Alt1' : '';
    
                coverArt.loadGraphic(Paths.image('freeplay/CoverArts/' + displaySongLol));
            }
            else
            {
                coverArt.loadGraphic(Paths.image('freeplay/CoverArts/unknown'));
            }
            
            FlxTween.tween(coverArt, {y: oldY}, 1, {ease: FlxEase.quintOut, onComplete: function(twn:FlxTween){
                ready = true;
            }});

        }
    
        if(isSelected && FlxG.mouse.overlaps(cg_playbutton) && ready)
            {
                cg_playbutton.animation.play('select');
    
                if(FlxG.mouse.pressed)
                {
                    ready = false;
    
                    var actualName = songs[overlapspr.ID];
    
                    var songLowercase:String = Paths.formatToSongPath(actualName);

                    transition.visible = true;
                    transition.animation.play('idle', false, false);
                    
                    PlayState.SONG = Song.loadFromJson(songLowercase + '-hard', songLowercase);
                    PlayState.isStoryMode = false;
                    PlayState.storyDifficulty = curDifficulty;

                    transition.animation.finishCallback = ()->{
                        LoadingState.loadAndSwitchState(new PlayState());
                        FlxG.sound.music.volume = 0;                        
                    }
                }
            }
            else
            {
                cg_playbutton.animation.play('idle');
            }
    }
}