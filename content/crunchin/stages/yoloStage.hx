var stageDirectory:String = 'stages/yolo/';
var cityObjects = [];
var bgSpeeds:Array<Float> = [4000, 3000, 2500, 2000, 1600, 600, 300, 150, 60];
var bgSpeedMult:Float = 0.8;
var reloading:Bool = false;

var sky2:FlxBackdrop;
var road2:FlxBackdrop;
var tunnelEntrance:FlxTiledSprite;
var tunnelTransition:FlxSprite;
var tunnelTransition2:FlxSprite;
var truck:FlxSprite;
var canMoveTunnel = false;
var fuckoff = false;

var canCar:Bool = false;
var car:FlxSprite;
var wheels:FlxSprite;

var gunTrail:FlxSprite;
var chamber:FlxSprite;
var bulletCount:Int = 6;

var skipIntro = false;
var comicPanel:FlxSprite;

var warning:FlxSprite;

function onGameOverStart(){
    GameOverSubstate.instance.updateCamera = false;
    GameOverSubstate.instance.camFollowPos.setPosition(GameOverSubstate.instance.boyfriend.getGraphicMidpoint().x, GameOverSubstate.instance.boyfriend.getGraphicMidpoint().y);
}

function onLoad(){

    var roadHeight:Float = 800;


    var sky:FlxBackdrop = new FlxBackdrop(Paths.image(stageDirectory + 'city/sky'), FlxAxes.X, 0, 0);
    sky.ID = 7;
    sky.y = roadHeight - (sky.height + 300);

    var road:FlxBackdrop = new FlxBackdrop(Paths.image(stageDirectory + 'city/road'), FlxAxes.X, 0, 0);
    road.ID = 2;
    road.y = roadHeight - road.height;

    var bg:FlxBackdrop = new FlxBackdrop(Paths.image(stageDirectory + 'city/bg'), FlxAxes.X, 0, 0);
    bg.ID = 5;
    bg.y = roadHeight - (bg.height + 150);

    var bg2:FlxBackdrop = new FlxBackdrop(Paths.image(stageDirectory + 'city/bg1'), FlxAxes.X, 0, 0);
    bg2.ID = 3;
    bg2.y = roadHeight - (bg2.height + 300);

    var bg3:FlxBackdrop = new FlxBackdrop(Paths.image(stageDirectory + 'city/bg2'), FlxAxes.X, 0, 0);
    bg3.ID = 3;
    bg3.y = roadHeight - (bg3.height + 150);

    add(sky);
    add(bg3);
    add(bg);
    add(bg2);
    add(road);

    sky2 = new FlxBackdrop(Paths.image(stageDirectory + 'coolercity/yolostage-cityfar'), FlxAxes.X, 0, 0);
    sky2.scale.set(2,2);
    sky2.updateHitbox();
    sky2.ID = 8;
    sky2.visible = false;
    sky2.y = (roadHeight + 200) - (sky.height);
    sky2.y -= 800;

    road2 = new FlxBackdrop(Paths.image(stageDirectory + 'coolercity/road'), FlxAxes.X, 0, 0);
    road2.ID = 2;
    road2.visible = false;
    road2.y = roadHeight - 450;
    
    add(sky2);
    add(road2);    


    tunnelEntrance = new FlxBackdrop(Paths.image(stageDirectory + 'tunnel/tunnel'), FlxAxes.Y, 0, 0);
    tunnelEntrance.ID = 0;
    tunnelEntrance.y = (roadHeight - (tunnelEntrance.height)) + 27.5;

    tunnelTransition = new FlxSprite(1900).loadGraphic(Paths.image(stageDirectory + 'tunnel/tunnelentry'));
    tunnelTransition.y = ((roadHeight - (tunnelTransition.height + 4)) + 10) + 27.5;
   
    tunnelTransition2 = new FlxSprite(1900).loadGraphic(Paths.image(stageDirectory + 'tunnel/tunnelexit'));
    tunnelTransition2.y = ((roadHeight - (tunnelTransition.height + 4)) + 10) + 27.5;

    add(tunnelTransition);
    add(tunnelTransition2);
    add(tunnelEntrance);
    tunnelEntrance.x = (tunnelTransition.x + tunnelTransition.width) - 27.5;
    // tunnelEntrance.alpha = 0;

    truck = new FlxSprite();
    truck.frames = Paths.getSparrowAtlas(stageDirectory + 'nowplayingtruck');
    truck.animation.addByPrefix('idle', 'za truck instance 1', 24, true);
    truck.animation.play('idle');
    truck.scale.set(2.5,2.5);
    truck.updateHitbox();
    add(truck);
    truck.y -= 500;
    truck.x = FlxG.width;
    truck.antialiasing = true;

    car = new FlxSprite(-362 - 1000, 310).loadGraphic(Paths.image(stageDirectory + 'Car_body'));
    add(car);

    wheels = new FlxSprite(-420 - 1000, 520);
    wheels.frames = Paths.getSparrowAtlas(stageDirectory + 'Yolo-tires');
    wheels.animation.addByPrefix('idle', 'Yolo-tires loop', 24, true);
    wheels.animation.play('idle');
    add(wheels);

    cityObjects = [
        "firstSection" => [bg, bg3, bg2, road, sky]
        "tunnel" => []
        "coolerCity" => [sky2, road2]
    ];
}

function onUpdate(elapsed){
    for(key in cityObjects.keys()){
        var arr = cityObjects[key];

        for(obj in arr)
        {
            if(obj.alpha == 1) obj.velocity.x = -bgSpeeds[obj.ID] * bgSpeedMult;
        }
    }
    
    if(canMoveTunnel){
        tunnelEntrance.velocity.x = -4000 * bgSpeedMult;
        tunnelTransition.velocity.x = -4000 * bgSpeedMult;
    }
    if(fuckoff){
        tunnelTransition2.velocity.x = -4000 * bgSpeedMult;
        sky2.visible = true;
        road2.visible = true;
    }

    if(reloading){
        game.dad.animSuffix = '-load';
        game.dad.idleSuffix = '-load';
        // stop idling fatty
        game.gf.danceEveryNumBeats = 99999999;
    }else{
        // please idle. im sorry for being so rude
        game.gf.danceEveryNumBeats = 2;
        game.dad.animSuffix = '';
        game.dad.idleSuffix = '';
    }

    if(!StringTools.endsWith(game.dad.animation.curAnim.name, game.dad.animSuffix))
        game.dad.animation.play(game.dad.animation.curAnim.name + game.dad.animSuffix, true);

    if(ClientPrefs.mechanics){
        gunTrail.alpha -= 0.075 * (elapsed/(1/60));
        if(gunTrail.alpha < 0) gunTrail.alpha = 0;
        gunTrail.x = (game.playerStrums.members[4].x - (gunTrail.width / 4)) + 10;    
    }


    FlxG.watch.addQuick('reloading?', reloading);
    FlxG.watch.addQuick('bullet count', bulletCount);

}

var black:FlxSprite;
var intended:Float;
function onCreatePost(){
    // game.cpuControlled = true;
    GameOverSubstate.deathSoundName = 'yolodie';
    GameOverSubstate.characterName = 'roach-car-dead';

    for(i in 0...5){
        if(ClientPrefs.downScroll){
            game.script_SUSTAINOffsets[i].x = -42.5;
            game.script_SUSTAINENDOffsets[i].x = -42.5;    
        }else{
            game.script_SUSTAINOffsets[i].x = 42.5;
            game.script_SUSTAINENDOffsets[i].x = 42.5;    
        }
    }

    if(PlayState.SONG.keys > 4){
        PlayState.instance.keysArray = [
            ClientPrefs.copyKey(ClientPrefs.keyBinds.get('note_left')),
            ClientPrefs.copyKey(ClientPrefs.keyBinds.get('note_down')),
            ClientPrefs.copyKey(ClientPrefs.keyBinds.get('note_up')),
            ClientPrefs.copyKey(ClientPrefs.keyBinds.get('note_right')),
            [32, 0]
        ];
        modManager.setValue('alpha4', 1);
        modManager.setValue("transform4Y", -100, 0);
    }

    // modManager.setValue("reverse", 1);

    black = new FlxSprite();
    black.makeGraphic(1280, 720, FlxColor.BLACK);
    black.cameras = [game.camHUD];
    add(black);


    var fuck = stageDirectory + (ClientPrefs.mechanics ? 'dont_get_hurt' : 'pusy');
    warning = new FlxSprite().loadGraphic(Paths.image(fuck));
    warning.camera = game.camOther;
    warning.blend = BlendMode.ADD;
    warning.scale.set(0.75, 0.75);
    warning.updateHitbox();
    warning.screenCenter();
    if(ClientPrefs.mechanics) warning.y += 32.5;
    add(warning);    

    if(!skipIntro){
        game.isCameraOnForcedPos = true;
        intended = game.camFollow.y;
        game.camFollow.y = -125;    
        game.defaultCamZoom = 1.5;
    }
    black.visible = !skipIntro;

    if(ClientPrefs.mechanics){

        gunTrail = new FlxSprite();
        gunTrail.frames = Paths.getSparrowAtlas('guntrail-lite');
        gunTrail.animation.addByPrefix('shoot 1', 'guntrail-lite 1', 24, false);
        gunTrail.animation.addByPrefix('shoot 2', 'guntrail-lite 2', 24, false);
        gunTrail.alpha = 1;
        gunTrail.animation.play('shoot 1', true);
        gunTrail.camera = game.camHUD;
        add(gunTrail);
    
        chamber = new FlxSprite();
        chamber.frames = Paths.getSparrowAtlas('GunMechanicUI');
        for(i in 1...7){
            chamber.animation.addByPrefix('LOAD' + i, 'LOAD' + i, 24, false);
            chamber.animation.addByPrefix('FIRE' + i, 'FIRE' + i, 24, false);
        }
        chamber.animation.play('LOAD6', true);
        chamber.camera = game.camHUD;
        add(chamber);
        chamber.alpha = 0;

        var pos = ClientPrefs.downScroll ? -chamber.height : FlxG.height;
        chamber.setPosition((FlxG.width / 4) * 3, pos);
    }

    remove(game.gfGroup);
    insert(members.indexOf(game.boyfriendGroup), game.gfGroup);

    comicPanel = new FlxSprite().loadGraphic(Paths.image(stageDirectory + 'comic/fuckingcar'));
    comicPanel.camera = game.camHUD;
    comicPanel.scale.set(0.75, 0.75);
    comicPanel.updateHitbox();
    comicPanel.screenCenter();
    comicPanel.x = -comicPanel.width;
    add(comicPanel);

    modManager.queueFuncOnce(242, (s,s2)->{
        FlxTween.tween(comicPanel, {x: 0}, 1, {ease: FlxEase.quartOut});
    });
    modManager.queueEase(242, 244, "alpha", 1, "quadIn", 1);

    modManager.queueFuncOnce(254, (s,s2)->{
        FlxTween.tween(comicPanel, {x: -comicPanel.width, alpha: 0}, 0.5, {ease: FlxEase.quartIn});
    });
    modManager.queueEase(254, 256, "alpha", 0, "quadIn", 1);

    modManager.queueFuncOnce(370, (s,s2)->{
        comicPanel.loadGraphic(Paths.image(stageDirectory + 'comic/selfdefense'));
        comicPanel.scale.set(0.625, 0.625);
        comicPanel.updateHitbox();  
        comicPanel.screenCenter();
        comicPanel.x = -comicPanel.width;
        comicPanel.alpha = 1; 

        FlxTween.tween(comicPanel, {x: 0}, 1, {ease: FlxEase.quartOut});
    });
    modManager.queueEase(370, 372, "alpha", 1, "quadIn", 1);

    modManager.queueFuncOnce(376, (s,s2)->{
        FlxTween.num(bgSpeedMult, 1.25, 4, {ease: FlxEase.quadIn, onUpdate: (t:FlxTween)->{
            bgSpeedMult = t.value;
        }});
    });
    modManager.queueEase(378, 380, "alpha", 0, "quadIn", 1);

    modManager.queueFuncOnce(382, (s,s2)->{
        FlxTween.tween(comicPanel, {x: -comicPanel.width, alpha: 0}, 0.5, {ease: FlxEase.quartIn});
    });

    if(ClientPrefs.mechanics){
        modManager.queueEase(368, 378, "transformX", -64, 'quadInOut', 0);
        modManager.queueEase(368, 378, "transform4X", -112 * 2, 'quadInOut', 0);
        modManager.queueEase(368, 378, "transform2X", 112, 'quadInOut', 0);
        modManager.queueEase(368, 378, "transform3X", 112, 'quadInOut', 0);
        modManager.queueEase(378, 382, "transform4Y", 0, 'quadOut', 0);
        modManager.queueEase(378, 382, "alpha4", 0, 'quadOut', 0);            

        modManager.queueFuncOnce(368, (s,s2)->{
            var pos = ClientPrefs.downScroll ? 20 : FlxG.height - chamber.height;
            FlxTween.tween(chamber, {alpha: 1, y: pos}, 2, {ease: FlxEase.quadOut});
        });
    
    }


    modManager.queueFuncOnce(1280, tunnel);

    //1536
    modManager.queueFuncOnce(1536, exittunnel);

    modManager.queueFuncOnce(1664, (s,s2)->{
        var time = 1.75;

        truck.visible = false;

        FlxTween.num(game.camFollow.x, game.camFollow.x + 475, time, {ease: FlxEase.quadInOut, onUpdate: (t)->{
            game.camFollow.x = t.value; 
        }});
        FlxTween.num(game.camFollow.y, game.camFollow.y - 225, time, {ease: FlxEase.quadInOut, onUpdate: (t)->{
            game.camFollow.y = t.value; 
        }});

        FlxTween.num(0.7, 0.4, time, {ease: FlxEase.quadOut, onUpdate: (t)->{
            game.defaultCamZoom = t.value;
        }});
    });

    modManager.queueFuncOnce(1792, (s,s2)->{
        var objectsiwannapoop = [game.dadGroup, game.boyfriendGroup, game.gfGroup, car, wheels];

        for(fuck in objectsiwannapoop){
            FlxTween.tween(fuck, {x: fuck.x + (700 * 4)}, 6, {ease: FlxEase.quadIn});
        }
    });

    game.gfGroup.zIndex = 999;
    game.refreshZ(game.stage);

    // game.playHUD.alpha = 0;
    for(FUCK in game.playHUD.members) FUCK.alpha = 0;
}

var len:Float = 10;
function onSongStart(){
    if(!skipIntro){
        black.visible = false;
        FlxG.camera.flash(FlxColor.BLACK, len * 0.75);
        for(FUCK in game.playHUD.members) FlxTween.tween(FUCK, {alpha: 1}, len * 0.75);
        FlxTween.tween(warning, {alpha: 0, "scale.x": 0.25, "scale.y": 0.25}, len * 0.75);

        FlxTween.num(game.defaultCamZoom, 0.7325, len / 2, {ease: FlxEase.quadOut, onUpdate: (t)->{
            game.camGame.zoom = t.value;
            game.defaultCamZoom = t.value;
        }});
        FlxTween.tween(game.camFollow, {y: intended}, len, {ease: FlxEase.quadInOut, onComplete: ()->{
            game.isCameraOnForcedPos = false;
            FlxTween.tween(truck, {x: -truck.width - 1350}, 17, {onComplete: ()->{ canCar = true; }});
        }});
    }
}

function onSpawnNotePost(note){
    if(note.noteType == 'yolo shoot' || note.noteType == 'yolo reload') note.noAnimation = true;
    if(note.noteData == 4) note.missHealth = 0.45;

    // if(note.isSustainNote) {
    //     note.offsetX = -42.5;
    // }

}

var time = 1.75;
function tunnel(){
    canMoveTunnel = true;
    new FlxTimer().start(time, ()->{
        tunnelEntrance.repeatAxes = FlxAxes.X;
        FlxTween.num(bgSpeedMult, 1.75, time * 2, {ease: FlxEase.quadIn, onUpdate: (t:FlxTween)->{
            bgSpeedMult = t.value;
        }});
    });
    // FlxTween.tween(tunnelTransition, {x: -2000 - tunnelTransition.width}, time);
    // }});
    // FlxTween.tween(tunnelEntrance, {x: -2000}, time);
}

function exittunnel(){
    canMoveTunnel = false;
    fuckoff = true;
    tunnelEntrance.repeatAxes = FlxAxes.Y;
    tunnelEntrance.x = -1000;
    tunnelTransition2.x = (tunnelEntrance.x + tunnelEntrance.width) - 20;
    sky2.x = -1350;

    new FlxTimer().start(time, ()->{
        game.isCameraOnForcedPos = true;
        
        FlxTween.num(bgSpeedMult, 3, time, {ease: FlxEase.quadOut, onUpdate: (t:FlxTween)->{
            bgSpeedMult = t.value;
        }});
    });
}

var poop = 1;
var dir = ['LEFT', 'DOWN', 'UP', 'RIGHT'];
function opponentNoteHit(note){
    switch(note.noteType){
        case 'yolo shoot':
            reloading = false;
            game.dad.animSuffix = '';
            game.dad.idleSuffix = '';

            if(!note.isSustainNote){
                game.gf.playAnim('sing' + dir[note.noteData], true);
                game.gf.holdTimer = 0;
                game.gf.alpha = 1;    

                game.camGame.zoom += 0.075;
                game.camGame.shake(0.025, 0.05);

                if(!ClientPrefs.mechanics){
                    poop = FlxG.random.int(1,3, [poop]);
                    game.triggerEventNote('Play Animation', 'dodge' + poop, 'boyfriend');
                }
            }
            if(game.gf.animation.curAnim.name != 'idle'){
                game.dad.playAnim('sing' + dir[note.noteData] + '-shoot', true);
                game.dad.holdTimer = 0;        
            }else{
                game.dad.playAnim('sing' + dir[note.noteData], true);
                game.dad.holdTimer = 0;
            }

        default:
            if(!reloading) game.gf.playAnim('idle', true);
    }
}

var poop:Int = FlxG.random.int(1,3);
function goodNoteHit(note){
    if(note.noteData == 4){
        setBulletCount(-1);
        gunTrail.alpha = 1;
        gunTrail.animation.play('shoot ' + FlxG.random.int(1,2), true);

        poop = FlxG.random.int(1,3, [poop]);
        game.triggerEventNote('Play Animation', 'dodge' + poop, 'boyfriend');
    }
}

function noteMiss(note){
    if(note.noteData == 4) setBulletCount(-1);
}

var load:Int = 1;
function onEvent(eventName, value1, value2){
    if(eventName == 'reload'){
        reloading = true;
        if(value1 != 'done'){
            game.gf.alpha = 1;
            game.gf.playAnim(load + 'load', true);
            game.gf.holdTimer = 0;

            load += 1;
            if(load > 2){
                load = 1;
                setBulletCount(1);
            } 

            if(game.dad.animation.curAnim.name == 'idle')
                game.triggerEventNote('Play Animation', 'idle-load', 'dad');
        }else{
            game.gf.animation.play('endload', true);
            new FlxTimer().start(0.8, (t:FlxTimer)->{
                reloading = false;
                if(game.dad.animation.curAnim.name == 'idle-load'){
                    game.triggerEventNote('Play Animation', 'idle', 'dad');
                    game.gf.playAnim('idle', true);
                }
            });
            // return shit dies i guess
        }
    }
}

var anim:String = 'FIRE';
var displayCount:Int = 6;
function setBulletCount(change:Int){
    bulletCount += change;
    if(bulletCount > 6) bulletCount = 6;
    if(bulletCount < 0) bulletCount = 1;
    
    if(change == 1){
        anim = 'LOAD';
        displayCount = bulletCount;
    } 
    if(change == -1) {
        anim = 'FIRE';
        displayCount = bulletCount + 1;
    }
    if(ClientPrefs.mechanics)
        chamber.animation.play(anim + displayCount, true);
}