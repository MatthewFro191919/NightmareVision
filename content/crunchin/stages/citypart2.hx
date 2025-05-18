var stageDirectory1 = 'stages/trollsad/';
var stageDirectory2 = 'stages/citypart2/';
var doubtGroupAssets:FlxTypedGroup;
var hopeGroupAssets:FlxTypedGroup;
var rain:FlxSprite;

function onLoad(){
    GameOverSubstate.characterName = 'RoachDIE';
    
    doubtGroupAssets = new FlxTypedGroup();
    add(doubtGroupAssets);

    var sky:FlxSprite = new FlxSprite(100, -200).loadGraphic(Paths.image(stageDirectory1 + 'trollcloudysky'));
    sky.scrollFactor.set(0, 0);
    doubtGroupAssets.add(sky);

    var farcloud:FlxSprite = new FlxSprite(400, 350).loadGraphic(Paths.image(stageDirectory1 + 'trollcloudyfarcloud'));
    farcloud.scrollFactor.set(0.9, 0.9);
    farcloud.ID = 3;
    doubtGroupAssets.add(farcloud);

    var closecloud:FlxSprite = new FlxSprite(300, 200).loadGraphic(Paths.image(stageDirectory1 + 'trollcloudyclosecloud'));
    closecloud.scrollFactor.set(0.9, 0.9);
    closecloud.ID = 4;
    doubtGroupAssets.add(closecloud);

    var bgsad:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image(stageDirectory1 + 'trollcloudydiner'));
    bgsad.scrollFactor.set(0.9, 0.9);
    doubtGroupAssets.add(bgsad);

    var fgsad:FlxSprite = new FlxSprite(83, 83).loadGraphic(Paths.image(stageDirectory1 + 'trollcloudyalley'));
    fgsad.scrollFactor.set(1, 1);
    doubtGroupAssets.add(fgsad);

    var magnet = new FlxSprite(-250, 1000);
    // preload
    magnet.loadGraphic(Paths.image(stageDirectory1 + 'magnet'));
    magnet.scrollFactor.set(0.9, 0.9);
    magnet.visible = false;
    magnet.ID = 6;
    doubtGroupAssets.add(magnet);

    var darkTrash = new FlxSprite(25, 1050);
    darkTrash.loadGraphic(Paths.image(stageDirectory1 + 'trashfall'));
    darkTrash.loadGraphic(Paths.image(stageDirectory1 + 'trashdark'));
    darkTrash.scrollFactor.set(1, 1);
    darkTrash.ID = 5;
    doubtGroupAssets.add(darkTrash);
    
    hopeGroupAssets = new FlxTypedGroup();
    hopeGroupAssets.visible = false;
    add(hopeGroupAssets);

    var thesky:FlxSprite = new FlxSprite(-850, -70).loadGraphic(Paths.image(stageDirectory2 + 'orangesky'));
    thesky.scrollFactor.set(0.875, 0.875);
    hopeGroupAssets.add(thesky);

    var clouds1:FlxSprite = new FlxSprite(-600, -100).loadGraphic(Paths.image(stageDirectory2 + 'ogfarclouds'));
    clouds1.scrollFactor.set(0.88, 0.88);
    hopeGroupAssets.add(clouds1);

    var clouds2:FlxSprite = new FlxSprite(-700, -100).loadGraphic(Paths.image(stageDirectory2 + 'ogmidclouds'));
    clouds2.scrollFactor.set(0.885, 0.885);
    hopeGroupAssets.add(clouds2);

    var clouds3:FlxSprite = new FlxSprite(-950, -100).loadGraphic(Paths.image(stageDirectory2 + 'ogcloseclouds'));
    clouds3.scrollFactor.set(0.9, 0.9);
    hopeGroupAssets.add(clouds3);

    var theroad:FlxSprite = new FlxSprite(-875, 0).loadGraphic(Paths.image(stageDirectory2 + 'ogroad'));
    theroad.scrollFactor.set(0.9, 0.9);
    hopeGroupAssets.add(theroad);

    rain = new FlxSprite(0, 0);
    rain.frames = Paths.getSparrowAtlas(stageDirectory1 + 'trollrain2');
    rain.animation.addByPrefix('rain', 'RainFallAAAAAAAAAA', 24, true);
    rain.flipX = true;
    rain.alpha = 0.2;
    rain.animation.play('rain');
    rain.scale.set(2, 2);
    rain.scrollFactor.set();
    rain.screenCenter();
    add(rain);
    rain.zIndex = 999;
    // rain.visible = false;
    // foreground.add(rain);

    Paths.sound('THE_hope_trashcan');
    game.addCharacterToList('Troll-hope',  1);
    game.addCharacterToList('troll-think',  1);
}

var speed:Float = 0.1;
var intensity:Float = 100;
var e:Float = 0;
var dady:Float = 0;
var floaty:Bool = false;

function onUpdate(elapsed){
    if(floaty){
        e += 0.1;
        game.dad.y = dady + Math.sin(e * speed / (ClientPrefs.framerate / 60)) * intensity;
        // trace(game.dad.y);
    }
}

function onStepHit(){
    switch(game.curStep)
    {
        case 256:
            // game.isCameraOnForcedPos = true;
            game.isCameraOnForcedPos = true;
            game.camFollow.x = (game.boyfriend.getGraphicMidpoint().x - 200);
            game.camFollow.y =  (game.boyfriend.getGraphicMidpoint().y - 235);
            FlxTween.num(FlxG.camera.zoom, 1.1, 0.325, {ease: FlxEase.quadIn, onUpdate: (t)->{
                game.defaultCamZoom = t.value;
            }});
        case 263:
            FlxTween.num(FlxG.camera.zoom, 1.45, 0.6, {ease: FlxEase.quadOut, onUpdate: (t)->{
                game.defaultCamZoom = t.value;
            }});
            // FlxTween.tween(FlxG.camera, {zoom: 1.45}, 0.6, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween){
            //     game.defaultCamZoom = 1.45;
            // }});
        case 264:
            for(i in 0...doubtGroupAssets.members.length)
            {	
                switch(doubtGroupAssets.members[i].ID)
                {
                    case 5:
                        doubtGroupAssets.members[i].loadGraphic(Paths.image(stageDirectory1 + 'trashfall'));
                        doubtGroupAssets.members[i].x -= 75;
                    case 6:
                        doubtGroupAssets.members[i].visible = true;
                }
            }
            FlxG.sound.play(Paths.sound('THE_hope_trashcan'));

        case 272:
            FlxTween.num(FlxG.camera.zoom, 0.95, 0.5, {ease: FlxEase.quadOut, onUpdate: (t)->{
                game.defaultCamZoom = t.value;
            }});
            game.isCameraOnForcedPos = false;
        case 528:
            game.defaultCamZoom = 0.975;
        case 532:
            game.defaultCamZoom = 1;
        case 540:
            game.defaultCamZoom = 0.95;
        case 544 | 548:
            game.defaultCamZoom += 0.055;
        case 604:
            game.defaultCamZoom = 0.975;
        case 606:
            game.defaultCamZoom = 0.985;
        case 656:
            game.defaultCamZoom = 0.975;
        case 660:
            game.defaultCamZoom = 1;
        case 664:
            game.defaultCamZoom = 0.95;
        case 668 | 670:
            game.defaultCamZoom += 0.055;
        case 672 | 676:
            game.defaultCamZoom += 0.075;
        case 680:
            game.defaultCamZoom = 0.95;
        case 732:
            game.defaultCamZoom = 0.95;
        case 744:
            game.defaultCamZoom = 0.95;
        case 784:
            FlxTween.num(FlxG.camera.zoom, 0.975, 0.3, {ease: FlxEase.quadOut, onUpdate: (t)->{
                game.defaultCamZoom = t.value;
            }});
        case 788:
            FlxTween.num(FlxG.camera.zoom, 1, 0.15, {ease: FlxEase.quadOut, onUpdate: (t)->{
                game.defaultCamZoom = t.value;
            }});
        case 792:
            FlxTween.num(FlxG.camera.zoom, 1.1, 0.375, {ease: FlxEase.quadOut, onUpdate: (t)->{
                game.defaultCamZoom = t.value;
            }});
        case 800:
            FlxTween.num(FlxG.camera.zoom, 0.95, 0.3, {ease: FlxEase.quadOut, onUpdate: (t)->{
                game.defaultCamZoom = t.value;
            }});
        case 1032:
            game.isCameraOnForcedPos = true;
            game.camFollow.x = (game.boyfriend.getGraphicMidpoint().x - 200);
            game.camFollow.y =  (boyfriend.getGraphicMidpoint().y - 235);
            FlxTween.num(FlxG.camera.zoom, 1.15, 0.5, {ease: FlxEase.quadOut, onUpdate: (t)->{
                game.defaultCamZoom = t.value;
            }});
        case 1036:
            FlxTween.num(FlxG.camera.zoom, 1.35, 0.5, {ease: FlxEase.quadOut, onUpdate: (t)->{
                game.defaultCamZoom = t.value;
            }});
        case 1040:
            game.isCameraOnForcedPos = false;
            for(i in 0...doubtGroupAssets.members.length)
            {	
                switch(doubtGroupAssets.members[i].ID)
                {
                    case 6:
                        doubtGroupAssets.members[i].visible = false;
                }
            }
        case 1044:
            game.defaultCamZoom = 0.95;
        case 1184:
            game.camZooming = false;
            FlxTween.tween(FlxG.camera, {zoom: 1.5}, 12, {ease: FlxEase.quintOut, onComplete: function(twn:FlxTween){
                game.camZooming = true;
                game.defaultCamZoom = 1.5;
            }});
        case 1208:
            FlxG.sound.play(Paths.sound('magnet_umbrella_thing_i_guess'));
        case 1216:
            game.camHUD.flash(FlxColor.WHITE, 3);
        case 1217:
            doubtGroupAssets.visible = false;
            hopeGroupAssets.visible = true;
            FlxTween.cancelTweensOf(FlxG.camera);
            game.camZooming = false;
            FlxTween.num(FlxG.camera.zoom, 0.7, 2, {ease: FlxEase.quintOut, onUpdate: (t)->{
                game.defaultCamZoom = t.value;
            }});
            floaty = true;
            dady = game.dad.y;
        case 1967:
            game.isCameraOnForcedPos = true;
            floaty = false;

            var dadPos = dad.y;
            FlxTween.tween(dad, {y: dadPos - 1200}, 3, {ease: FlxEase.quadIn});

    }
}