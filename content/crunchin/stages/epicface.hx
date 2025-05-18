import flixel.math.FlxMath;

var stageDirectory = 'stages/epicface/';
var epicDark:Bool;

var bus:BGSprite;
var busLights:BGSprite;
var darkbg1:BGSprite;
var darkbg2:BGSprite;
var darkbg3:BGSprite;
var darkbg4:BGSprite;
var darkbg5:BGSprite;
var darkbg6:BGSprite;
var derpSit:FlxSprite;
var epicoverlay:BGSprite;
var epicSpin:FlxSprite;
var e_spin_angle:Float = 0;

var busTween1:FlxTween;
var busTween2:FlxTween;
var busTween3:FlxTween;
var busTween4:FlxTween;
var busTween5:FlxTween;
var busTween6:FlxTween;
var busTween7:FlxTween;
var busTween8:FlxTween;

var epicFaceMeter:Bool = false;
var epicMeter:FlxSprite;
var epicY:Float;
var epicHits:Int = 0;

var layershit1 = [];
var layershit2 = [];
var layershit3 = [];

var fuckingBalancing:StringMap = new StringMap();
fuckingBalancing.set("smile", [5, 7.5]);
fuckingBalancing.set("order-up", [7.5, 10]);
fuckingBalancing.set("last-course", [10, 12]);

function onLoad(){
    GameOverSubstate.characterName = 'RoachDIEFlip';
    epicDark = PlayState.SONG.song.toLowerCase() == 'last-course';

    var scrollFactor = 0.95;

    var offsetX = -400;
    var offsetY = -400;

    var scaleX = 0.8;
    var scaleY = 0.8;

    if(epicDark)
    {
        epicSpin = new FlxSprite(-1000, -2050).loadGraphic(Paths.image(stageDirectory + 'SPIN_THIS_FUCKING_THING'));
        epicSpin.scrollFactor.set(0.3, 0.2);
        epicSpin.alpha = 0.0000001;
        add(epicSpin);

        darkbg1 = new BGSprite(stageDirectory + 'darkbg1', offsetX, offsetY, 0.7, 0.7);
        darkbg1.scale.set(scaleX, scaleY);
        darkbg1.antialiasing = ClientPrefs.globalAntialiasing;
        add(darkbg1);

        darkbg2 = new BGSprite(stageDirectory + 'darkbg2', offsetX + 50, offsetY, 0.8, 0.8);
        darkbg2.scale.set(scaleX, scaleY);
        darkbg2.antialiasing = ClientPrefs.globalAntialiasing;
        add(darkbg2);

        derpBench = new BGSprite(stageDirectory + 'derpnight', offsetX + 50, offsetY, 0.8, 0.8);
        derpBench.scale.set(scaleX, scaleY);
        derpBench.antialiasing = ClientPrefs.globalAntialiasing;
        add(derpBench);

        bus = new BGSprite(stageDirectory + 'nightbus', 200, 200, 0.8, 0.8, ['nightbus loop'], true, 12);
        bus.scale.set(scaleX - 0.2, scaleY - 0.2);
        bus.antialiasing = ClientPrefs.globalAntialiasing;
        add(bus);

        busLights = new BGSprite(stageDirectory + 'nightbus-flare', 200, 200, 0.8, 0.8, ['nightbus-flare loop'], true, 12);
        busLights.blend = BlendMode.ADD;
        busLights.scale.set(scaleX - 0.2, scaleY - 0.2);
        busLights.antialiasing = ClientPrefs.globalAntialiasing;
        add(busLights);

        darkbg3 = new BGSprite(stageDirectory + 'darkbg3', offsetX, offsetY, 0.9, 0.9);
        darkbg3.scale.set(scaleX, scaleY);
        darkbg3.antialiasing = ClientPrefs.globalAntialiasing;
        add(darkbg3);

        // add(gfGroup);
        layershit1 = [epicSpin, darkbg1, darkbg2, derpBench, bus, busLights, busLights, darkbg3];

        darkbg4 = new BGSprite(stageDirectory + 'darkbg4', offsetX, offsetY, 1, 1);
        darkbg4.scale.set(scaleX, scaleY);
        darkbg4.antialiasing = ClientPrefs.globalAntialiasing;
        add(darkbg4);
        
        darkbg5 = new BGSprite(stageDirectory + 'darkbg5', offsetX, offsetY, 1, 1);
        darkbg5.scale.set(scaleX, scaleY);
        darkbg5.antialiasing = ClientPrefs.globalAntialiasing;
        add(darkbg5);

        layershit2 = [darkbg4, darkbg5];
    }
    else
    {
        var bg1:BGSprite = new BGSprite(stageDirectory + 'bg1', offsetX, offsetY, 0.7, 0.7);
        bg1.scale.set(scaleX, scaleY);
        bg1.antialiasing = ClientPrefs.globalAntialiasing;
        add(bg1);

        var bg2:BGSprite = new BGSprite(stageDirectory + 'bg2', offsetX + 50, offsetY, 0.8, 0.8);
        bg2.scale.set(scaleX, scaleY);
        bg2.antialiasing = ClientPrefs.globalAntialiasing;
        add(bg2);

        var bg3:BGSprite = new BGSprite(stageDirectory + 'bg3', offsetX, offsetY, 0.9, 0.9);
        bg3.scale.set(scaleX, scaleY);
        bg3.antialiasing = ClientPrefs.globalAntialiasing;
        add(bg3);

        // add(gfGroup);
        layershit1 = [bg1, bg2, bg3];

        var bg4:BGSprite = new BGSprite(stageDirectory + 'bg4', offsetX, offsetY, 1, 1);
        bg4.scale.set(scaleX, scaleY);
        bg4.antialiasing = ClientPrefs.globalAntialiasing;
        add(bg4);

        if(PlayState.SONG.song.toLowerCase() == 'order-up')
        {
            // derpSit = new BGSprite(stageDirectory + 'OrderupStageDerp', 1272, 250, 1, 1, ['OrderupStageDerp bop'], false, 6);
            derpSit = new FlxSprite(1272, 250);
            derpSit.frames = Paths.getSparrowAtlas(stageDirectory + 'OrderupStageDerp');
            derpSit.animation.addByPrefix('idle', 'OrderupStageDerp bop', 12, false);
            derpSit.animation.play('idle');
            derpSit.scale.set(scaleX, scaleY);
            derpSit.antialiasing = ClientPrefs.globalAntialiasing;
            add(derpSit);

        }
        
        var bg5:BGSprite = new BGSprite(stageDirectory + 'bg5', offsetX, offsetY, 1, 1);
        bg5.scale.set(scaleX, scaleY);
        bg5.antialiasing = ClientPrefs.globalAntialiasing;
        add(bg5);

        layershit2 = [bg4, bg5];
        if(derpSit!=null) layershit2.push(derpSit);
    }

    if(epicDark)
    {
        darkbg6 = new BGSprite('epicface/darkbg6', -400, -400, 1, 1);
        darkbg6.scale.set(0.8, 0.8);
        darkbg6.antialiasing = ClientPrefs.globalAntialiasing;
        add(darkbg6);

        epicoverlay = new BGSprite('epicface/darkoverlay', -400, -400, 1, 1);
        epicoverlay.alpha = 0.23;
        epicoverlay.scale.set(0.8, 0.8);
        epicoverlay.blend = BlendMode.ADD;
        add(epicoverlay);

        blackScreen = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
        blackScreen.alpha = 0.0000001;
        blackScreen.cameras = [game.camHUD];
        blackScreen.screenCenter();
        blackScreen.scrollFactor.set();
        add(blackScreen);

        layershit3=[darkbg6, epicoverlay];
    }
    else
    {
        var bg6:BGSprite = new BGSprite('epicface/bg6', -400, -400, 1, 1);
        bg6.scale.set(0.8, 0.8);
        bg6.antialiasing = ClientPrefs.globalAntialiasing;
        add(bg6);

        var overlay = new BGSprite('epicface/overlay', -400, -400, 1, 1);
        overlay.alpha = 0.23;
        overlay.scale.set(0.8, 0.8);
        overlay.blend = BlendMode.ADD;
        add(overlay);
        layershit3=[bg6,overlay];
    }
}

var countdownShit = [];
function onCreatePost(){
    GameOverSubstate.characterName = 'RoachDIEFlip';

    // layering stuff. dw about it!
    for(fuck in layershit1){ fuck.zIndex = 0; }
    game.gfGroup.zIndex = 1;
    for(fuck in layershit2){ fuck.zIndex = 2; }
    game.dadGroup.zIndex = 3;
    game.boyfriendGroup.zIndex = 4;
    for(fuck in layershit3){ fuck.zIndex = 5; }
    game.refreshZ(game.stage);

    if(!PlayState.isStoryMode) setupShit();

    if(PlayState.SONG.song.toLowerCase() == 'last-course'){
        var epicScale:Float = 0.75;
        epicDistractionBG = new FlxSprite();
        epicDistractionBG.cameras = [camHUD];
        epicDistractionBG.frames = Paths.getSparrowAtlas('distractions/epic-crowd');
        epicDistractionBG.setGraphicSize(Std.int(epicDistractionBG.width * epicScale));
        epicDistractionBG.animation.addByPrefix('idle', 'epic-crowd loop', 12, true);
        epicDistractionBG.animation.play('idle');
        epicDistractionBG.screenCenter();
        epicDistractionBG.alpha = 0;

        insert(members.indexOf(game.notes) + 1, epicDistractionBG);
    }

    if(ClientPrefs.mechanics){
        var epicScale:Float = 0.75;
        epicDistractionBG = new FlxSprite();
        epicDistractionBG.cameras = [camHUD];
        epicDistractionBG.frames = Paths.getSparrowAtlas('distractions/epic-crowd');
        epicDistractionBG.setGraphicSize(Std.int(epicDistractionBG.width * epicScale));
        epicDistractionBG.animation.addByPrefix('idle', 'epic-crowd loop', 12, true);
        epicDistractionBG.animation.play('idle');
        epicDistractionBG.screenCenter();
    
        epicDistractionFG = new FlxSprite();
        epicDistractionFG.cameras = [camHUD];
        epicDistractionFG.frames = Paths.getSparrowAtlas('distractions/epic-thruster');
        epicDistractionFG.setGraphicSize(Std.int(epicDistractionFG.width * 0.6));
        epicDistractionFG.animation.addByPrefix('idle', 'epic-thruster oyeah', 20, true);
        epicDistractionFG.animation.play('idle');
        epicDistractionFG.screenCenter();
        epicDistractionFG.x += FlxG.width;
        if(ClientPrefs.downScroll){
            epicDistractionBG.angle = 180;
            epicDistractionFG.angle = 180;
            epicDistractionFG.y -= FlxG.height * 1.5;
        }
        else{
            epicDistractionFG.y += FlxG.height * 1.5;
        }
    
        epicMeter = new FlxSprite();
        epicMeter.cameras = [camHUD];
        epicMeter.screenCenter();
        epicMeter.setPosition(epicMeter.x + 490, epicMeter.y - 220);
        epicY = epicMeter.y;
        epicMeter.frames = Paths.getSparrowAtlas('epicbar');
        for(i in 0...6)
        {
            var fps = 24;
            switch(i)
            {
                case 0:
                    fps = 2;
                case 1:
                    fps = 6;
                case 2:
                    fps = 6;
                case 3:
                    fps = 12;
                case 4:
                    fps = 12;
            }
            epicMeter.animation.addByPrefix(i, 'epicbar ' + i, fps, true);
        }
        epicMeter.animation.play('0');
    
        insert(members.indexOf(game.notes) + 1, epicMeter);
        insert(members.indexOf(game.notes) + 1, epicDistractionFG);
        insert(members.indexOf(game.notes) + 1, epicDistractionBG);
    
    }

    game.playHUD.zIndex = 2;
    game.refreshZ();

    var _spr1 = new FlxSprite().loadGraphic(Paths.image('ready'));
    _spr1.scrollFactor.set();
    _spr1.updateHitbox();
    _spr1.screenCenter();
    _spr1.y += FlxG.height;
    _spr1.antialiasing = true;
    _spr1.cameras = [game.camHUD];
    add(_spr1);
    var _spr2 = new FlxSprite().loadGraphic(Paths.image('set'));
    _spr2.scrollFactor.set();
    _spr2.updateHitbox();
    _spr2.screenCenter();
    _spr2.x -= FlxG.width;
    _spr2.angle = -3;
    _spr2.antialiasing = true;
    _spr2.cameras = [game.camHUD];
    add(_spr2);
    var _spr3 = new FlxSprite().loadGraphic(Paths.image('go'));
    _spr3.scrollFactor.set();
    _spr3.updateHitbox();
    _spr3.screenCenter();
    _spr3.x += FlxG.width;
    _spr3.angle = 3;
    _spr3.antialiasing = true;
    _spr3.cameras = [game.camHUD];
    add(_spr3);
    countdownShit = [_spr1, _spr2, _spr3];
    // for(fuck in [game.notes, game.playerStrums, game.opponentStrums, epicDistractionBG, epicDistractionFG, epicMeter, game.playHUD]){ game.refreshZ(fuck); }
}
function setupShit(){
    game.playHUD.flipBar();
    game.playHUD.healthBar.setColors(FlxColor.fromRGB(boyfriend.healthColorArray[0], boyfriend.healthColorArray[1], boyfriend.healthColorArray[2]), FlxColor.fromRGB(dad.healthColorArray[0], dad.healthColorArray[1], dad.healthColorArray[2]));
    modManager.setValue("opponentSwap", 1);
}

function onCountdownTick(tick){ 
    switch(tick){
        case 0:
            if(PlayState.isStoryMode) setupShit();
    }
    if(tick % 2 == 0 && derpSit != null) 
        derpSit.animation.play('idle');
}


var epicGoingLeft:Bool = true;
var epicStop:Bool = false;
var epicTimer:FlxTimer;

function onUpdate(elapsed){
    if(epicMeter != null){
        epicMeterCheck();
        epicDistractionsCheck(elapsed);    
    }
   if(epicHits > 0)
    {
        if(epicTimer == null)
        {
            epicTimer = new FlxTimer().start(fuckingBalancing.get(PlayState.SONG.song.toLowerCase())[1], (tmr)->{
                epicHits-= 1;
                epicTimer = null;
            });
        }
    }

    if(PlayState.SONG.song.toLowerCase() == 'last-course' && busLights != null)
    {
        busLights.x = bus.x;
        busLights.y = bus.y;
        busLights.scale.x = bus.scale.x;
        busLights.scale.y = bus.scale.y;
    }

    if(epicSpin != null){
        e_spin_angle += 20 * elapsed;
        epicSpin.angle = FlxMath.lerp(epicSpin.angle, e_spin_angle, FlxMath.bound(elapsed * 7, 0, 1));
    }
}

function goodNoteHit(note){
     if(note.noteType == 'EpicNote') epicNoteHit(1); 
}

function epicNoteHit(increment:Int){
    epicHits += increment;

    if(epicHits < 0){
        epicHits = 0;
    }else if(epicHits > 5){
        epicHits = 5;
    }

    if(epicHits > 0)
    {
        if(epicTimer != null){
            epicTimer.cancel();
        }

        epicTimer = new FlxTimer().start(fuckingBalancing.get(PlayState.SONG.song.toLowerCase())[1], function(tmr){
            epicHits-=1;
            epicTimer = null;
        });
    }
}

function epicDistractionsCheck(elapsed){
    if(epicStop) return;

    var originalYPos = ((FlxG.height - epicDistractionBG.height) / 2) + 150 + ((FlxG.height / ((epicHits <= 0) ? 4 : 6.5)) * (5 - epicHits)); //temporary logic
    if(ClientPrefs.downScroll){
        originalYPos = ((FlxG.height - epicDistractionBG.height) / 2) - 150 - ((FlxG.height / ((epicHits <= 0) ? 4 : 6.5)) * (5 - epicHits));
    }
    epicDistractionBG.y = FlxMath.lerp(epicDistractionBG.y, originalYPos, FlxMath.bound(elapsed * 5, 0, 1));

    var e_targetY = ((FlxG.height - epicDistractionFG.height) / 2) + 50;
    if(ClientPrefs.downScroll){
        e_targetY = ((FlxG.height - epicDistractionFG.height) / 2) - 50;
    }
    var e_targetX = ((FlxG.width - epicDistractionFG.width) / 2) + ((epicGoingLeft) ? -FlxG.width : FlxG.width);
    var e_mult = 3;

    epicDistractionFG.flipX = (ClientPrefs.downScroll) ? epicGoingLeft : !epicGoingLeft;

    if(epicHits < 5){
        e_targetY += FlxG.height * 1.5 * ((ClientPrefs.downScroll) ? -1 : 1);
        e_mult = 3;

        if(game.modchartTweens.exists('distractiontween')){
            game.modchartTweens.get('distractiontween').cancel();
            game.modchartTweens.remove('distractiontween');
        }
    }
    else{
        if(!game.modchartTweens.exists('distractiontween')){
            epicDistractionFG.x = ((FlxG.width - epicDistractionFG.width) / 2) + ((!epicGoingLeft) ? -FlxG.width : FlxG.width);
            game.modchartTweens.set('distractiontween', FlxTween.tween(epicDistractionFG, {x: e_targetX}, 8, {ease: FlxEase.linear, onComplete: function(twn:FlxTween){
                epicGoingLeft = !epicGoingLeft;
                game.modchartTweens.remove('distractiontween');
            }}));
        }
        //epicDistractionFG.x = FlxMath.lerp(epicDistractionFG.x, e_targetX, CoolUtil.boundTo(elapsed * 3, 0, 1));
    }
    epicDistractionFG.y = FlxMath.lerp(epicDistractionFG.y, e_targetY, FlxMath.bound(elapsed * e_mult, 0, 1));
}

function epicMeterCheck()
{
    if(epicMeter != null)
    {
        if(epicHits < 0){
            epicHits = 0;
        }else if(epicHits > 5){
            epicHits = 5;
        }
        if(epicMeter.animation.curAnim.name != '' + epicHits && (epicHits >= 0 && epicHits <= 5)){
            epicMeter.animation.play(epicHits);
            
            // animation :D //
            epicMeter.y = epicY;
            var e_y = epicMeter.y;
            epicMeter.y += 12;
            FlxTween.tween(epicMeter, {y: e_y}, 0.5, {ease: FlxEase.elasticOut});
        }
    }
}

function onStepHit(){
    if(PlayState.SONG.song.toLowerCase() != 'last-course') return;

    switch(game.curStep){
        case 160:
            game.defaultCamZoom = 0.95;
            FlxG.camera.zoom = game.defaultCamZoom;
            var _spr = countdownShit[0];
            _spr.visible = true;

            var _x = (FlxG.width - _spr.width) / 2;
            var _y = (FlxG.height - _spr.height) / 2;
            FlxTween.tween(_spr, {x: _x, y: _y -25, angle: 0}, 0.175, {eae: FlxEase.quintOut, onComplete: (twn)->{
                FlxTween.tween(_spr, {x: _x, y: _y}, 0.175, {ease: FlxEase.elasticOut, onComplete: (twn)->{
                    FlxTween.tween(_spr, {alpha: 0.000001}, 0.175, {ease: FlxEase.quadOut, onComplete: function(twn){
                        _spr.visible = false;
                    }});
                }});
            }});
        case 164:
            game.defaultCamZoom = 1;
            FlxG.camera.zoom = game.defaultCamZoom;

            var _spr = countdownShit[1];
            _spr.visible = true;

            var _x = (FlxG.width - _spr.width) / 2;
            var _y = (FlxG.height - _spr.height) / 2;
            FlxTween.tween(_spr, {x: _x + 25, y: _y, angle: 3}, 0.175, {ease: FlxEase.quintOut, onComplete: function(twn){
                FlxTween.tween(_spr, {x: _x, y: _y, angle: 0}, 0.175, {ease: FlxEase.elasticOut, onComplete: function(twn){
                    FlxTween.tween(_spr, {alpha: 0.000001}, 0.175, {ease: FlxEase.quadOut, onComplete: function(twn){
                        _spr.visible = false;

                    }});
                }});
            }});
        case 168:
            game.defaultCamZoom = 1.05;
            FlxG.camera.zoom = game.defaultCamZoom;
            var _spr = countdownShit[2];
            _spr.visible = true;

            var _x = (FlxG.width - _spr.width) / 2;
            var _y = (FlxG.height - _spr.height) / 2;
            FlxTween.tween(_spr, {x: _x - 25, y: _y, angle: -3}, 0.175, {ease: FlxEase.quintOut, onComplete: function(twn){
                FlxTween.tween(_spr, {x: _x, y: _y, angle: 0}, 0.175, {ease: FlxEase.elasticOut, onComplete: function(twn){
                    FlxTween.tween(_spr, {alpha: 0.000001}, 0.175, {ease: FlxEase.quadOut, onComplete: function(twn){
                        _spr.visible = false;
                        game.modchartTweens.remove("countdownThing3");
                    }});
                }});
            }});
        case 172:
            if(blackScreen != null){
                blackScreen.alpha = 1;
            }
        case 176:
            game.defaultCamZoom = 0.9;
            FlxG.camera.zoom = game.defaultCamZoom;
            game.triggerEventNote("Add Camera Zoom", "0.03", "0.015");
            game.camGame.flash(FlxColor.WHITE, 2);
            if(blackScreen != null){
                blackScreen.alpha = 0.0000001;
            }
        case 1712:
            epicStop = true;
            FlxTween.tween(blackScreen, {alpha: 1}, 1);
            FlxTween.tween(epicDistractionBG, {alpha: 0.000001}, 1);
        
            case 1728: //1728 //now add in the background goobers
            var arr:Array<FlxSprite> = [bus, busLights, darkbg1, darkbg2, darkbg3, darkbg4, darkbg5, darkbg6, epicoverlay];
            for(obj in arr){
                if(obj != null){
                    obj.alpha = 0.000001;
                }
            }

            if(epicSpin != null){
                epicSpin.alpha = 1;
            }

            if(epicDistractionBG != null){
                epicStop = true;
                epicDistractionBG.cameras = [camGame];
                epicDistractionBG.scrollFactor.set(1.2, 1);
                epicDistractionBG.scale.set(1, 1);
                epicDistractionBG.setPosition(0, 200);
                epicDistractionBG.angle = 0;

                epicDistractionBG.zIndex = 0;
                epicSpin.zIndex = 1;
                game.refreshZ(game.stage);
                // remove(epicDistractionBG);
                // insert(members.indexOf(epicSpin) + 1, epicDistractionBG);
            }

            if(ClientPrefs.mechanics){
                epicDistractionFG.alpha = 0.00000001;
            }
            
            gfGroup.alpha = 0.0000001;
            dadGroup.color = FlxColor.BLACK;
            boyfriendGroup.color = FlxColor.BLACK;
        case 1744: //1744
            epicDistractionBG.alpha = 1;
            if(blackScreen != null){
                blackScreen.alpha = 0.0000001;
            }
            game.camHUD.flash(FlxColor.WHITE, 2);
        case 2128:
            FlxTween.tween(blackScreen, {alpha: 1}, 12);
    }
}

function onBeatHit(){
    if(game.curBeat % 2 == 0 && derpSit != null)
        derpSit.animation.play('idle');

    if(PlayState.SONG.song.toLowerCase() == 'last-course'){
        switch(curBeat)
        {
            case 16:
                busTween1 = FlxTween.tween(bus, {x: bus.x - 400}, 5, {ease: FlxEase.quadOut});
                busTween2 = FlxTween.tween(bus, {y: bus.y + 20}, 5, {ease: FlxEase.quadOut});
                busTween3 = FlxTween.tween(bus.scale, {y: bus.scale.y + 0.2}, 5.5, {ease: FlxEase.quadOut});
                busTween4 = FlxTween.tween(bus.scale, {x: bus.scale.x + 0.2}, 5.5, {ease: FlxEase.quadOut, onComplete: function(twn3:FlxTween){
                    bus.animation.curAnim.paused = true;
                    busLights.animation.curAnim.paused = true;
                }});
            case 96:
                bus.animation.curAnim.paused = false;
                busLights.animation.curAnim.paused = false;
    
                derpBench.visible = false;
    
                busTween5 = FlxTween.tween(bus, {x: bus.x - 400}, 4, {ease: FlxEase.cubeIn});
                busTween6 = FlxTween.tween(bus, {y: bus.y + 20}, 4, {ease: FlxEase.cubeIn});
                busTween7 = FlxTween.tween(bus.scale, {y: bus.scale.y + 0.2}, 4, {ease: FlxEase.cubeIn});
                busTween8 = FlxTween.tween(bus.scale, {x: bus.scale.x + 0.2}, 4, {ease: FlxEase.cubeIn});
        }
    }
}