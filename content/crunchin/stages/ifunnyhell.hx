var stageDirectory:String = 'stages/ifunnyhell/';

var platform:FlxSprite;
var blackScreen:FlxSprite;

var ifuMode:Bool = false;
var ifuBopping = false;

var pillars = [];
var closepillar:FlxSprite;
var light_closepillar:FlxSprite;

function onLoad(){
    var abyss:FlxSprite = new FlxSprite(-200, -200).loadGraphic(Paths.image(stageDirectory + 'abyss'));
    abyss.scrollFactor.set(0.1, 0.1);
    abyss.scale.set(1.5, 1.5);
    add(abyss);

    flycrowave = new FlxSprite(-900, -300).loadGraphic(Paths.image(stageDirectory  + 'flycrowave'));
    flycrowave.scrollFactor.set(0.025, 0.025);
    flycrowave.scale.set(0.5, 0.5);
    add(flycrowave);


    flames = new FlxSprite(550, -100);
    flames.frames = Paths.getSparrowAtlas(stageDirectory + 'FLAMESFLAMESBURNINGFLAMES');
    flames.animation.addByPrefix('idle', 'FlamesBurn', 24, true);
    flames.alpha = 0.2;
    flames.animation.play('idle');
    flames.scale.set(3, 3);
    flames.zIndex = 3;
    flames.blend = BlendMode.ADD;
    add(flames);

    var darkpillar:FlxSprite = new FlxSprite(-30, -400).loadGraphic(Paths.image(stageDirectory + 'darkpillar'));
    darkpillar.scrollFactor.set(0.4, 0.4);
    darkpillar.scale.set(1.5, 1.5);
    darkpillar.zIndex = 2;
    add(darkpillar);
    pillars.push(darkpillar);

    farpillar = new FlxSprite(-525, 900).loadGraphic(Paths.image(stageDirectory + 'farpillar'));
    farpillar.scrollFactor.set(0.55, 0.55);
    farpillar.zIndex = 2;
    add(farpillar);
    pillars.push(farpillar);

    light_farpillar = new FlxSprite(-525, 900).loadGraphic(Paths.image(stageDirectory + 'farpillar-light'));
    light_farpillar.scrollFactor.set(0.55, 0.55);
    light_farpillar.alpha = 0;
    light_farpillar.zIndex = 2;
    add(light_farpillar);
    pillars.push(light_farpillar);

    midpillar = new FlxSprite(-385, 1100).loadGraphic(Paths.image(stageDirectory + 'midpillar'));
    midpillar.scrollFactor.set(0.75, 0.75);
    midpillar.zIndex = 2;
    add(midpillar);
    pillars.push(midpillar);

    light_midpillar = new FlxSprite(-385, 1100).loadGraphic(Paths.image(stageDirectory + 'midpillar-light'));
    light_midpillar.scrollFactor.set(0.75, 0.75);
    light_midpillar.alpha = 0;
    light_midpillar.zIndex = 2;
    add(light_midpillar);
    pillars.push(light_midpillar);

    closepillar = new FlxSprite(-300, 1300).loadGraphic(Paths.image(stageDirectory + 'closepillar'));
    closepillar.scrollFactor.set(1, 1);
    closepillar.zIndex = 2;
    add(closepillar);
    pillars.push(closepillar);

    light_closepillar = new FlxSprite(-300, 1300).loadGraphic(Paths.image(stageDirectory + 'closepillar-light'));
    light_closepillar.scrollFactor.set(1, 1);
    light_closepillar.alpha = 0;
    light_closepillar.zIndex = 2;
    add(light_closepillar);
    pillars.push(light_closepillar);

    blackScreen = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
    blackScreen.cameras = [game.camHUD];
    blackScreen.screenCenter();
    blackScreen.scrollFactor.set();

    platform = new FlxSprite(1625, 725).loadGraphic(Paths.image(stageDirectory + 'legacy_platform'));
    platform.zIndex = 2;
    add(platform);

    // heehee
    fart();
}

// im a very mature person. i will name all of my functions fart and have the variables be poop.
var done = false;
function fart(){
    done = !done;
    var newPos = FlxG.random.float(1200, -500);
    // trace(newPos);
    FlxTween.tween(flycrowave, {x: done ? 1700 : -900, y: newPos}, 30, {ease: FlxEase.linear, onComplete: fart});
}

function onCreatePost(){
    game.gf.ghostsEnabled = false;
    game.dad.ghostsEnabled = false;
    gfGroup.scrollFactor.set(0.4, 0.4);
    gfGroup.x += 5;
    gfGroup.y += 90;
    add(blackScreen);
    FlxTween.tween(blackScreen, {alpha: 0}, 4, {ease: FlxEase.quadIn, onComplete: function(twn:FlxTween){
        remove(blackScreen);
    }});

    brimstone = new FlxSprite().loadGraphic(Paths.image(stageDirectory + 'brimstone', 'shared'));
    brimstone.alpha = 0.7;
    brimstone.scale.set(2, 2);
    brimstone.screenCenter();
    brimstone.scrollFactor.set(0.1, 0.1);
    brimstone.blend = BlendMode.ADD;
    add(brimstone);

    for(fuck in [game.playFields, game.notes, game.playHUD]){
        game.remove(fuck);
        game.stage.add(fuck);
    }

    game.playFields.members[2].owner = game.gf;
    game.playFields.members[2].cameras = [game.camGame];
    for(m in game.playFields.members[2].members){ m.alpha = 0; m.scrollFactor.set(0.4, 0.4);}

    modManager.setValue("transformX", 125, 2);
    modManager.setValue("transformY", -800, 2);
    modManager.setValue("mini", -1.625, 2);
    modManager.setValue("flip", -2, 2);
    modManager.setValue("stealth", 0.125, 2);
    modManager.setValue("alpha", 0.125, 2);

    // var offset = 50;
    // modManager.setValue("transform0X", -offset, 2);
    // modManager.setValue("transform1X", -114 - offset, 2);
    // modManager.setValue("transform2X", 114 + offset, 2);
    // modManager.setValue("transform3X", offset, 2);

    game.playHUD.zIndex = 0;
    game.playFields.zIndex = 1;
    for(fuck in pillars) fuck.zIndex = 3;
    game.notes.zIndex = 4;
    for(fuck in [light_closepillar, closepillar]) fuck.zIndex = 5;
    game.gfGroup.zIndex = 6;
    game.dadGroup.zIndex = 7;
    platform.zIndex = 8;
    game.boyfriendGroup.zIndex = 9;
    game.refreshZ(game.stage);

    // var yPos:Float = ClientPrefs.downScroll ? -750 : 750;
    // modManager.queueEase(264 * 4, 266 * 4, "transform2Y", yPos, 'elasticOut', 1);
    // modManager.queueEase(265 * 4, 267 * 4, "transform1Y", yPos, 'elasticOut', 1);
    // modManager.queueEase(266 * 4, 268 * 4, "transform0Y", yPos, 'elasticOut', 1);
    // modManager.queueEase(268 * 4, 270 *4, "transform3Y", yPos, 'elasticOut', 1);
}

function onSpawnNotePost(note){
    if(note.lane > 1) {
        note.cameras = [game.camGame];
        note.scrollFactor.set(0.4, 0.4);
    }
}

function onEvent(eventName){
    if(eventName == 'Change Character') game.gf.ghostsEnabled = false;
}

function onUpdate(elapsed){
    flycrowave.angle += 0.25;

    var yPos = 750;
    if(ClientPrefs.downScroll)
        yPos = -750;
    switch(game.curBeat)
    {
        case 260:
            game.isCameraOnForcedPos = true;
            game.camFollow.x = 1375;
            game.camFollow.y = 450;
        case 261: //261
            if(gf.animOffsets.exists('approach'))
                gf.playAnim('approach', true);
                gf.specialAnim = true;
        case 262 | 263:
            if(gf.animation.curAnim.name == 'approach' && gf.animation.curAnim.finished) //gf.curCharacter == 'ifusmall'
                gf.visible = false;

        case 264:
            if(gf.animation.curAnim.name == 'approach' && gf.animation.curAnim.finished)
                gf.visible = false;
        case 265:
            if(gf.animation.curAnim.name == 'approach' && gf.animation.curAnim.finished)
                gf.visible = false;
        case 391:
            camGame.shake(0.015, 0.5);
    }
}

function onStepHit(){
    switch(game.curStep)
    {
        case 128:
            game.camGame.shake(0.01, 7.1);
            game.camHUD.shake(0.0025, 7.1);

            FlxTween.tween(farpillar, {y: -715}, 7);
            FlxTween.tween(light_farpillar, {y: -715}, 7);
        case 400:
            game.defaultCamZoom = 0.525;
        case 408:
            game.defaultCamZoom = 0.55;
        case 416:
            game.defaultCamZoom = 0.5;
        case 608:
            game.camGame.shake(0.01, 7.1);
            game.camHUD.shake(0.0025, 7.1);

            FlxTween.tween(midpillar, {y: -715}, 7);
            FlxTween.tween(light_midpillar, {y: -715}, 7);
        case 928:
            game.camGame.shake(0.01, 7.1);
            game.camHUD.shake(0.0025, 7.1);
        
            FlxTween.tween(closepillar, {y: -715}, 7);
            FlxTween.tween(light_closepillar, {y: -715}, 7);
        case 1099:
            FlxTween.tween(light_closepillar, {alpha: 1}, 2, {ease: FlxEase.sineOut, onComplete: function(twn:FlxTween){
                closepillar.visible = false;
            }});
            FlxTween.tween(light_midpillar, {alpha: 1}, 2, {ease: FlxEase.sineOut, onComplete: function(twn:FlxTween){
                midpillar.visible = false;
            }});
            FlxTween.tween(light_farpillar, {alpha: 1}, 2, {ease: FlxEase.sineOut, onComplete: function(twn:FlxTween){
                farpillar.visible = false;
            }});
        case 1104:
            ifuMode = true;
            game.camFollow.y = 375;
            FlxTween.tween(brimstone, {y: -400}, 0.1);
        case 1168:
            ifuBopping = true;
        case 2096:
            ifuBopping = false;
    }

    if(curStep % 2 == 0 && ifuBopping)
    {
        FlxG.camera.zoom += 0.015;
        camHUD.zoom += 0.015;
    }
}

function onBeatHit(){
    if(game.curBeat % 2 == 0 && ifuMode)
        {
            FlxTween.tween(light_farpillar, {"scale.x": 1.015, "scale.y": 1.015}, 0.1, {ease: FlxEase.quartInOut, onComplete: function(twn:FlxTween){
                FlxTween.tween(light_farpillar, {"scale.x": 1, "scale.y": 1}, 0.1, {ease: FlxEase.quartInOut});
                
                FlxTween.tween(light_midpillar, {"scale.x": 1.03, "scale.y": 1.03}, 0.1, {ease: FlxEase.quartInOut, onComplete: function(twn2:FlxTween){
                    FlxTween.tween(light_midpillar, {"scale.x": 1, "scale.y": 1}, 0.1, {ease: FlxEase.quartInOut});

                    FlxTween.tween(light_closepillar, {"scale.x": 1.05, "scale.y": 1.05}, 0.1, {ease: FlxEase.quartInOut, onComplete: function(twn3:FlxTween){
                        FlxTween.tween(light_closepillar, {"scale.x": 1, "scale.y": 1}, 0.1, {ease: FlxEase.quartInOut});
                    }});
                }});
            }});   
        }
    switch(game.curBeat){
        case 30:
            FlxTween.tween(camGame, {zoom: 0.9}, 1.2, {ease: FlxEase.quintIn});
        case 32:
            camHUD.flash(FlxColor.WHITE, 1);
        case 150:
            game.defaultCamZoom = 0.6;
        case 152:
            game.defaultCamZoom = 0.5;
            game.camHUD.flash(FlxColor.WHITE, 1);
        case 232:
            game.camHUD.flash(FlxColor.WHITE, 1);
        case 264:
            game.defaultCamZoom = 0.55;
        case 265:
            game.defaultCamZoom = 0.6;
        case 266:
            game.defaultCamZoom = 0.65;
        case 267:
            game.defaultCamZoom = 0.7;
        case 268:
            game.defaultCamZoom = 0.75;
        case 269:
            game.defaultCamZoom = 0.8;
        case 270:
            game.defaultCamZoom = 0.85;
        case 271:
            game.defaultCamZoom = 0.9;
        case 272:
            FlxTween.tween(game.camGame, {zoom: 1.1}, 1.8, {ease: FlxEase.quintIn});
        case 275:
            game.defaultCamZoom = 0.5;
        case 276:
            game.camHUD.flash(FlxColor.WHITE, 1);
        case 390:
            FlxTween.tween(game.camGame, {zoom: 0.9}, 1.2, {ease: FlxEase.quintIn});
        case 392:
            game.camHUD.flash(FlxColor.WHITE, 1);
        case 528:
            game.camHUD.flash(FlxColor.WHITE, 1);
    }
}