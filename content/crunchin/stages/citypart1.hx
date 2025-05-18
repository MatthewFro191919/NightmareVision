var stageDirectory = 'stages/trollsad/';
var doubtGroupAssets:FlxTypedGroup;
var rain:FlxSprite;

function onLoad(){
    GameOverSubstate.characterName = 'RoachDIE';

    doubtGroupAssets = new FlxTypedGroup();
    add(doubtGroupAssets);

    var sky:FlxSprite = new FlxSprite(100, -200).loadGraphic(Paths.image(stageDirectory + 'trollcloudysky'));
    sky.scrollFactor.set(0, 0);
    doubtGroupAssets.add(sky);

    var skyhappy:FlxSprite = new FlxSprite(100, -200).loadGraphic(Paths.image(stageDirectory + 'trolloskybeta'));
    skyhappy.scrollFactor.set(0, 0);
    skyhappy.ID = 0;
    doubtGroupAssets.add(skyhappy);

    var farcloud:FlxSprite = new FlxSprite(1400, 350).loadGraphic(Paths.image(stageDirectory + 'trollcloudyfarcloud'));
    farcloud.scrollFactor.set(0.9, 0.9);
    farcloud.ID = 3;
    doubtGroupAssets.add(farcloud);

    var closecloud:FlxSprite = new FlxSprite(1400, 200).loadGraphic(Paths.image(stageDirectory + 'trollcloudyclosecloud'));
    closecloud.scrollFactor.set(0.9, 0.9);
    closecloud.ID = 4;
    doubtGroupAssets.add(closecloud);

    var bgsad:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image(stageDirectory + 'trollcloudydiner'));
    bgsad.scrollFactor.set(0.9, 0.9);
    doubtGroupAssets.add(bgsad);

    var bghappy:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image(stageDirectory + 'trollostreetbeta'));
    bghappy.scrollFactor.set(0.9, 0.9);
    bghappy.ID = 1;
    doubtGroupAssets.add(bghappy);

    var fgsad:FlxSprite = new FlxSprite(83, 83).loadGraphic(Paths.image(stageDirectory + 'trollcloudyalley'));
    fgsad.scrollFactor.set(1, 1);
    doubtGroupAssets.add(fgsad);

    var fghappy:FlxSprite = new FlxSprite(83, 83).loadGraphic(Paths.image(stageDirectory + 'trolloalleybeta'));
    fghappy.scrollFactor.set(1, 1);
    fghappy.ID = 2;
    doubtGroupAssets.add(fghappy);

    var darkTrash = new FlxSprite(25, 1050).loadGraphic(Paths.image(stageDirectory + 'trashdark'));
    darkTrash.scrollFactor.set(1, 1);
    doubtGroupAssets.add(darkTrash);

    var trash = new FlxSprite(25, 1050).loadGraphic(Paths.image(stageDirectory + 'trashlight'));
    trash.scrollFactor.set(1, 1);
    trash.ID = 5;
    doubtGroupAssets.add(trash);

    rain = new FlxSprite(0, 0);
    rain.frames = Paths.getSparrowAtlas(stageDirectory + 'trollrain2');
    rain.animation.addByPrefix('rain', 'RainFallAAAAAAAAAA', 24, true);
    rain.flipX = true;
    rain.alpha = 0.2;
    rain.animation.play('rain');
    rain.scale.set(2, 2);
    rain.scrollFactor.set();
    rain.screenCenter();
    rain.visible = false;
    rain.zIndex = 999;
    add(rain);
}

function onBeatHit(){
    switch(game.curBeat){
        case 1:
            for(m in game.playHUD.members){ FlxTween.tween(m, {alpha: 0}, 2); }
            game.modManager.queueEase(game.curStep, game.curStep + 4, "alpha", 1);
        case 17:
            game.camHUD.flash(FlxColor.WHITE, 2);
            rain.visible = true;

            for (i in 0...doubtGroupAssets.members.length) {
                switch(doubtGroupAssets.members[i].ID)
                {
                    case 0:
                        FlxTween.tween(doubtGroupAssets.members[i], {alpha: 0}, 5);
                    case 1:
                        FlxTween.tween(doubtGroupAssets.members[i], {alpha: 0}, 5);
                    case 2:
                        FlxTween.tween(doubtGroupAssets.members[i], {alpha: 0}, 5);
                    case 3: //farcloud
                        FlxTween.tween(doubtGroupAssets.members[i], {x: 400}, 30, {ease: FlxEase.sineInOut});
                    case 4: // closecloud
                        FlxTween.tween(doubtGroupAssets.members[i], {x: 300}, 30, {ease: FlxEase.sineInOut});
                    case 5:
                        FlxTween.tween(doubtGroupAssets.members[i], {alpha: 0}, 5);
                }
            }
        case 31:
            for(m in game.playHUD.members){ FlxTween.tween(m, {alpha: 1}, 2); }
            game.modManager.queueEase(game.curStep, game.curStep + 4, "alpha", 0);
    }
}

function onStepHit(){
    switch(game.curStep){
    case 424:
        FlxTween.tween(FlxG.camera, {zoom: 1.1}, 2.6, {ease: FlxEase.quintOut, onComplete: function(twn:FlxTween){
            game.defaultCamZoom = 1.1;
        }});
    case 448:
        FlxTween.tween(FlxG.camera, {zoom: 0.95}, 2.6, {ease: FlxEase.quintOut, onComplete: function(twn:FlxTween){
            game.defaultCamZoom = 0.95;
        }});
    case 480:
        FlxTween.tween(FlxG.camera, {zoom: 1.2}, 3, {ease: FlxEase.quintIn, onComplete: function(twn:FlxTween){
            game.defaultCamZoom = 1.2;
        }});
    case 528:
        FlxTween.tween(FlxG.camera, {zoom: 0.95}, 1, {ease: FlxEase.quintOut, onComplete: function(twn:FlxTween){
            game.defaultCamZoom = 0.95;
        }});
    case 536:
        FlxTween.tween(FlxG.camera, {zoom: 1.2}, 1.25, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween){
            game.defaultCamZoom = 1.2;
        }});
    case 592:
        FlxTween.tween(FlxG.camera, {zoom: 0.95}, 1, {ease: FlxEase.quintOut, onComplete: function(twn:FlxTween){
            game.defaultCamZoom = 0.95;
        }});
    }
}