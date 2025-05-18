import flixel.text.FlxText;
import funkin.data.Conductor;
import funkin.utils.WindowUtil;

var stageDirectory:String = 'stages/';
var madNessCheck:Bool = false;

var subtitles:FlxText;
var blackbartop:FlxSprite;
var blackbarbottom:FlxSprite;

var textTween:FlxTween;
var textTimer:FlxTimer;

var bbTween1:FlxTween;
var bbTween2:FlxTween;
var bbEnabled:Bool = false;

function onLoad(){
    var scrollFactor = 0.95;

    var offsetX = -400;
    var offsetY = -400;

    var scaleX = 0.77;
    var scaleY = 0.77;

    var bg1:BGSprite = new BGSprite(stageDirectory + 'halloween/bg1', offsetX - 200, offsetY, 0.51, 0.51);
    bg1.scale.set(scaleX, scaleY);
    bg1.antialiasing = ClientPrefs.globalAntialiasing;
    add(bg1);

    var bg2:BGSprite = new BGSprite(stageDirectory + 'halloween/bg2', offsetX - 190, offsetY, 0.54, 0.54);
    bg2.scale.set(scaleX, scaleY);
    bg2.antialiasing = ClientPrefs.globalAntialiasing;
    add(bg2);

    pooper = new BGSprite(stageDirectory + 'halloween/poop', 900, 200, 0.6, 0.6, ['idle copy 2']);
    pooper.animation.addByPrefix('poopmaness', 'poopmaness', 28, false);
    pooper.antialiasing = ClientPrefs.globalAntialiasing;
    add(pooper);

    var bg3:BGSprite = new BGSprite(stageDirectory + 'halloween/bg3', offsetX - 100, offsetY, 0.7, 0.7);
    bg3.scale.set(scaleX + 0.1, scaleY);
    bg3.antialiasing = ClientPrefs.globalAntialiasing;
    add(bg3);

    // add(gfGroup);

    bop = new BGSprite(stageDirectory + 'halloween/skeletone', 300, 345, 0.7, 0.7, ['CROWD']);
    bop.scale.set(1.3, 1.3);
    bop.antialiasing = ClientPrefs.globalAntialiasing;
    bop.zIndex = 1;
    add(bop);

    // add(dadGroup);

    var bg4:BGSprite = new BGSprite(stageDirectory + 'halloween/bg4', offsetX, offsetY, 1, 1);
    bg4.scale.set(scaleX, scaleY);
    bg4.antialiasing = ClientPrefs.globalAntialiasing;
    bg4.zIndex = 3;
    add(bg4);
}

function onCreatePost(){
    game.dad.scrollFactor.set(0.7, 0.7);
    game.gf.scrollFactor.set(0.68, 0.68);
    game.dadGroup.zIndex = 2;
    game.refreshZ(game.stage);

    modManager.setValue("alpha", 1, 2);
    modManager.setValue("transformY", 200, 2);
    modManager.setValue("flip", 0.0625, 2);
    modManager.setValue("mini", 0.1, 2);
    modManager.queueEase(380, 384, "alpha", 0, 'quadInOut', 2);
    modManager.queueEase(380, 384, "mini", 0.1, 'quadInOut');
    modManager.queueEase(380, 384, "flip", 0.0625, 'quadInOut');
    modManager.queueEase(380, 384, "transformX", -115, 'quadInOut', 1);
    modManager.queueEase(380, 384, "transformX", 115, 'quadInOut', 0);
    modManager.queueEase(380, 384, "transformY", 0, 'quadInOut', 2);

    modManager.queueEase(576, 580, "alpha", 1, 'quadOut', 2);
    modManager.queueEase(576, 580, "mini", 0, 'bounceOut');
    modManager.queueEase(576, 580, "flip", 0, 'bounceOut');
    modManager.queueEase(576, 580, "transformX", 0, 'bounceOut');
    
    var three = game.playFields.members[2];
    three.owner = game.gf;

    modManager.queueFuncOnce(564, (s,s2)->{
        madNessCheck = true;
        pooper.animation.play('poopmaness');
        game.isCameraOnForcedPos = true;
        game.defaultCamZoom += 0.25;
        game.camFollow.x = (pooper.getMidpoint().x + 50);
        game.camFollow.y = (pooper.getMidpoint().y - 25);

        pooper.offset.set(200, 0);
        pooper.animation.finishCallback = function(name){
            if(name == 'poopmaness')
            {
                game.defaultCamZoom -= 0.25;
                game.isCameraOnForcedPos = false;
                madNessCheck = false;
                pooper.offset.set(0, 0);
                pooper.dance(true);
            }
        };
    });

    game.modManager.queueFuncOnce(696, (s,s2)->{
        game.isCameraOnForcedPos = true;
        game.cameraSpeed = 0.25;
        game.camFollow.x = (pooper.getMidpoint().x + 50);
        game.camFollow.y = (pooper.getMidpoint().y - 25);
        FlxTween.num(game.defaultCamZoom, 1.4, (Conductor.stepCrotchet / 1000) * 22, {ease: FlxEase.quadOut, onUpdate: (t)->{ game.defaultCamZoom = t.value; }});
    });

    game.modManager.queueFuncOnce(720, (s,s2)->{
        game.isCameraOnForcedPos = false;
        game.cameraSpeed = 1;
        FlxTween.num(game.defaultCamZoom, 1, (Conductor.stepCrotchet / 1000) * 4, {ease: FlxEase.quadOut, onUpdate: (t)->{ game.defaultCamZoom = t.value; }});
    });

    subtitles = new FlxText(FlxG.width / 2, FlxG.height - 200, 0, "", 16);
    subtitles.setFormat(Paths.font("pixel.otf"), 16, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    subtitles.scrollFactor.set();
    subtitles.borderSize = 2;
    subtitles.alpha = 0;
    subtitles.cameras = [game.camHUD];
    add(subtitles);

    blackbartop = new FlxSprite().makeGraphic(FlxG.width * 2, 300, FlxColor.BLACK);
    blackbartop.cameras = [game.camHUD];
    blackbartop.screenCenter(FlxAxes.X);
    blackbartop.y = (((FlxG.height / 2) - blackbartop.height / 2) - FlxG.height / 2) - 320;
    add(blackbartop);

    blackbarbottom = new FlxSprite().makeGraphic(FlxG.width * 2, 300, FlxColor.BLACK);
    blackbarbottom.cameras = [game.camHUD];
    blackbarbottom.y = (((FlxG.height / 2) - blackbarbottom.height / 2) + FlxG.height / 2) + 320;
    blackbarbottom.screenCenter(FlxAxes.X);
    add(blackbarbottom);

    MISTAKE = new FlxSprite();
    MISTAKE.frames = Paths.getSparrowAtlas('MISTAKEDEATH');
    MISTAKE.animation.addByPrefix('death', 'MISTAKEDEATH deathLoop', 24, true);
    MISTAKE.antialiasing = ClientPrefs.globalAntialiasing;
    MISTAKE.screenCenter();
    MISTAKE.cameras = [game.camOther];
    MISTAKE.visible = false;
    add(MISTAKE);
}

var can = true;
function onGameOver(){
    if(can){
        FlxG.sound.music.stop();
        game.vocals.stop();
        FlxG.sound.music.volume = 0;
        game.vocals.volume = 0;
        game.persistentUpdate = false;
        game.persistentDraw = false;
        
        MISTAKE.visible = true;
        FlxG.sound.play(Paths.sound('MISTAKEDEATH'));
        MISTAKE.animation.play('death');
    
        new FlxTimer().start(3, function(tmr){
            WindowUtil.crashTheFuckingGame();
        });
        can = false;    
    }

    return Function_Stop;
}

function onBeatHit(){
    if(!madNessCheck)
        pooper.dance(true);
    bop.animation.play('CROWD', true);
}

function onEvent(eventName, value1, value2){
    switch(eventName){
        case 'Clear Subtitles':
            clearSubtitles();
        case 'Set/Add Subtitles':
            var value_1 = Std.string(value1);
            var boolCheck = false;

            if(value2 != null && Std.parseInt(value2) == 1)
            {
                boolCheck = true;
            }

            if(value1 != null)
            {
                addSubtitles(value1, boolCheck);
            }
    }
}

function onUpdate(elapsed){
    if(subtitles != null){
        if(subtitles.x != (FlxG.width / 2) - subtitles.width / 2)
            subtitles.x = (FlxG.width / 2) - subtitles.width / 2;
    }
}

function addSubtitles(text:String, ?addon:Bool = false)
{	
    switch(addon)
    {
        case true:
            subtitles.text += text;
            subtitles.alpha = 1;
        case false:
            subtitles.alpha = 1;
            subtitles.text = text;
    }

    if(textTween != null)
    {
        textTween.cancel();
    }
    if(textTimer != null)
    {
        textTimer.cancel();
    }

    if(!bbEnabled)
    {
        bbEnabled = true;
        blackBars(true);
    }

    textTimer = new FlxTimer().start(5, function(tmr:FlxTimer) {
        textTween = FlxTween.tween(subtitles, {alpha: 0}, 1, {ease: FlxEase.bounceOut, onComplete: function(twn:FlxTween){
            textTween = null;
            subtitles.alpha = 0;
            subtitles.text = '';

            bbEnabled = false;
            blackBars(false);
        }});
    });
}

function blackBars(enabled:Bool)
{	
    switch(enabled)
    {
        case true:
            if(bbTween1 != null)
            {
                bbTween1.cancel();
            }

            if(bbTween2 != null)
            {
                bbTween2.cancel();
            }

            var y1 = (((FlxG.height / 2) - blackbartop.height / 2) - FlxG.height / 2);
            var y2 = (((FlxG.height / 2) - blackbarbottom.height / 2) + FlxG.height / 2);

            bbTween1 = FlxTween.tween(blackbartop, {y: y1 + 10}, 0.5, {ease: FlxEase.quintOut, onComplete: function(twn:FlxTween){
                bbTween1 = FlxTween.tween(blackbartop, {y: y1}, 0.25, {ease: FlxEase.bounceOut, onComplete: function(twn:FlxTween){
                    bbTween1 = null;
                }});
            }});

            bbTween2 = FlxTween.tween(blackbarbottom, {y: y2 - 10}, 0.5, {ease: FlxEase.quintOut, onComplete: function(twn:FlxTween){
                bbTween2 = FlxTween.tween(blackbarbottom, {y: y2}, 0.25, {ease: FlxEase.bounceOut, onComplete: function(twn:FlxTween){
                    bbTween2 = null;
                }});
            }});
        case false:
            if(bbTween1 != null)
            {
                bbTween1.cancel();
            }

            if(bbTween2 != null)
            {
                bbTween2.cancel();
            }

            var y1 = (((FlxG.height / 2) - blackbartop.height / 2) - FlxG.height / 2) - 320;
            var y2 = (((FlxG.height / 2) - blackbarbottom.height / 2) + FlxG.height / 2) + 320;

            bbTween1 = FlxTween.tween(blackbartop, {y: y1 + 10}, 0.5, {ease: FlxEase.quintOut, onComplete: function(twn:FlxTween){
                bbTween1 = FlxTween.tween(blackbartop, {y: y1}, 0.25, {ease: FlxEase.bounceOut, onComplete: function(twn:FlxTween){
                    bbTween1 = null;
                }});
            }});

            bbTween2 = FlxTween.tween(blackbarbottom, {y: y2 - 10}, 0.5, {ease: FlxEase.quintOut, onComplete: function(twn:FlxTween){
                bbTween2 = FlxTween.tween(blackbarbottom, {y: y2}, 0.25, {ease: FlxEase.bounceOut, onComplete: function(twn:FlxTween){
                    bbTween2 = null;
                }});
            }});
    }
}

function clearSubtitles()
{
    if(textTween != null)
    {
        textTween.cancel();
    }
    if(textTimer != null)
    {
        textTimer.cancel();
    }

    bbEnabled = false;
    blackBars(false);

    textTween = FlxTween.tween(subtitles, {alpha: 0}, 1, {ease: FlxEase.bounceOut, onComplete: function(twn:FlxTween){
        textTween = null;
        subtitles.alpha = 0;
        subtitles.text = '';
    }});
}