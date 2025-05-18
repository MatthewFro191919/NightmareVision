var stageDirectory = 'stages/graveyard/';
// reunionStuff 
var reunionGroupObjects:FlxTypedGroup<FlxSprite>;
var theComic:FlxSprite;

function onLoad(){
    GameOverSubstate.characterName = 'player-troll';
    GameOverSubstate.deathSoundName = 'nothing';
    GameOverSubstate.endSoundName = 'nothing';

    reunionGroupObjects = new FlxTypedGroup();
    add(reunionGroupObjects);

    var bg:FlxSprite = new FlxSprite(-350, -500).loadGraphic(Paths.image(stageDirectory + 'reunion_sky'));
    bg.scrollFactor.set(0.1, 0.0);
    reunionGroupObjects.add(bg);

    var mountain:FlxSprite = new FlxSprite(-250, -500).loadGraphic(Paths.image(stageDirectory + 'reunion_mountains'));
    mountain.scrollFactor.set(0.2, 0.0);
    reunionGroupObjects.add(mountain);

    var far:FlxSprite = new FlxSprite(50, -1100).loadGraphic(Paths.image(stageDirectory + 'reunion_background'));
    far.scrollFactor.set(0.5, 0.5);
    reunionGroupObjects.add(far);

    var fg:FlxSprite = new FlxSprite(500, -1780).loadGraphic(Paths.image(stageDirectory + 'reunion_foreground'));
    fg.scrollFactor.set(1, 1);
    reunionGroupObjects.add(fg);
}
function onCreatePost(){
    for(m in game.playHUD.members){m.alpha = 0;}
    theComic = new FlxSprite(-1000,-2180).loadGraphic(Paths.image('dialogue/DTE-panel3'));
    theComic.scrollFactor.set(1, 1);
    theComic.scale.set(3, 3);
    add(theComic);

    game.isCameraOnForcedPos = true;
    // game.snapCamFollowToPos(theComic.getGraphicMidpoint().x - 250, theComic.getGraphicMidpoint().y);
    game.snapCamFollowToPos(-250, -1600);

    // game.camFollow.x = (theComic.getGraphicMidpoint().x - 250);
    // game.camFollow.y = (theComic.getGraphicMidpoint().y);

    for(i in 0...reunionGroupObjects.members.length)
    {
        switch(i)
        {
            case 0:
                reunionGroupObjects.members[i].x += 1200;
                reunionGroupObjects.members[i].y += 500;
            case 1:
                reunionGroupObjects.members[i].x += 1000;
                reunionGroupObjects.members[i].y += 500;
            case 2:
                reunionGroupObjects.members[i].x += 500;
                reunionGroupObjects.members[i].y += 100;
        }
    }
}

function onSongStart(){
    for(m in game.playHUD.members){m.alpha = 1;}
    game.isCameraOnForcedPos = false;
    for(i in 0...reunionGroupObjects.members.length)
    {
        var posX = reunionGroupObjects.members[i].x;
        var posY = reunionGroupObjects.members[i].y;

        switch(i)
        {
            case 0:
                FlxTween.tween(reunionGroupObjects.members[i], {x: posX - 1200, y: posY - 500}, 2, {ease: FlxEase.quadOut});
            case 1:
                FlxTween.tween(reunionGroupObjects.members[i], {x: posX - 1000, y: posY - 500}, 2, {ease: FlxEase.quadOut});
            case 2:
                FlxTween.tween(reunionGroupObjects.members[i], {x: posX - 500, y: posY - 100}, 2, {ease: FlxEase.quadOut});
        }
    }

    FlxTween.tween(theComic, {alpha: 0}, 4, {ease: FlxEase.linear});

    FlxTween.tween(FlxG.camera, {zoom: 0.7}, 2, {ease:FlxEase.quadOut, onComplete: function(twn:FlxTween){
        game.defaultCamZoom = 0.7;
    }});
}

function onGameOverStart(){
    FlxG.sound.music.stop();
}

function onUpdate(elapsed){
    if(inGameOver){
        if(FlxG.sound.music != null) FlxG.sound.music.stop();
    }
}