import flixel.FlxSprite;

var stageDirectory:String = 'stages/rave/';

var them:FlxSprite;
var phase1 = [];

var dj:FlxSprite;
var crowd:FlxSprite;
var phase2 = [];

var curPhase = 1;

var epicFaceMeter:Bool = false;
var epicMeter:FlxSprite;
var epicY:Float;
var epicHits:Int = 0;

function onLoad(){
    GameOverSubstate.characterName = 'whatthefuckBOOM';
    GameOverSubstate.deathSoundName = 'efexplode';

    var lol = new FlxSprite().loadGraphic(Paths.image(stageDirectory + '1/bg1'));
    addShit(lol, [0.625, 0.625], 1, false);

    them = new FlxSprite(700, 300);
    them.frames = Paths.getSparrowAtlas(stageDirectory + '1/them');
    them.animation.addByPrefix('idle', 'THEM', 24, false);
    them.animation.play('idle', true);
    them.scale.set(0.625, 0.625);
    them.updateHitbox();
    add(them);
    phase1.push(them);

    var lol = new FlxSprite().loadGraphic(Paths.image(stageDirectory + '1/table'));
    addShit(lol, [0.625, 0.625], 1, false);

    var lol = new FlxSprite().loadGraphic(Paths.image(stageDirectory + '1/bushes'));
    addShit(lol, [0.625, 0.625], 1, true);

    var lol = new FlxSprite().loadGraphic(Paths.image(stageDirectory + '2/djbg'));
    addShit(lol, [0.625, 0.625], 2, false);

    dj = new FlxSprite(650, 330);
    dj.frames = Paths.getSparrowAtlas(stageDirectory + '2/djepic');
    dj.animation.addByPrefix('danceLeft', 'djdanceleft', 24, false);
    dj.animation.addByPrefix('danceRight', 'djdanceright', 24, false);
    addShit(dj, [0.625, 0.625], 2, false);

    crowd = new FlxSprite(-80, 450);
    crowd.frames = Paths.getSparrowAtlas(stageDirectory + '2/crowd');
    crowd.animation.addByPrefix('bounce', 'crowd', 24, false);
    crowd.animation.play('bounce', true);
    addShit(crowd, [0.625, 0.625], 2, true);

}

function onGameOverStart(){
    bg = new FlxSprite().makeGraphic(1280, 720, 0xFF251C33);
    bg.scrollFactor.set();
    GameOverSubstate.instance.insert(GameOverSubstate.instance.members.indexOf(GameOverSubstate.instance.boyfriend), bg);

    new FlxTimer().start(2.25, ()->{
        FlxG.camera.flash(FlxColor.WHITE, 1);
        bg.alpha = 0;
    });

    FlxG.camera.zoom = 1;
    GameOverSubstate.instance.updateCamera = false;
    GameOverSubstate.instance.camFollowPos.setPosition(GameOverSubstate.instance.boyfriend.getGraphicMidpoint().x - 25, GameOverSubstate.instance.boyfriend.getGraphicMidpoint().y);
}

function addShit(spr:FlxSprite, scale:Array<Int>, group:String, fg:Bool){
    spr.scale.set(scale[0], scale[1]);

    // if(fg) foreground.add(spr);
    // else add(spr);
    add(spr);
    if(fg) spr.zIndex = 1;
    
    switch(group){
        case 1:
            phase1.push(spr);
        case 2:
            spr.visible = false;
            phase2.push(spr);
    }
}

function onCreatePost(){
    game.camZooming = true;
    game.dad.ghostsEnabled = false;
    game.dad.baseCameraDisplacement = 10;
    game.boyfriend.ghostsEnabled = false;

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

    // changeSection(2);
    modManager.queueFuncOnce(464, (s,s2)->{ changeSection(2); });
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
            epicTimer = new FlxTimer().start(5, (tmr)->{
                epicHits-= 1;
                epicTimer = null;
            });
        }
    }
}

var dir:Int = 1;
function onBeatHit(){
    switch(curPhase){
        case 1:
            if((game.curBeat) % 2 == 0) them.animation.play('idle', true);
        case 2:
            dir *= -1;
            if(dir == 1) dj.animation.play('danceLeft', true);
            else dj.animation.play('danceRight', true);

            crowd.animation.play('bounce', true);
    }
    // trace(them);
}

function onMoveCamera(isDad){
    if(curPhase == 1){
        if(isDad == 'dad') game.defaultCamZoom = 1.45;
        else game.defaultCamZoom = 1.2;    
    }else{
        game.defaultCamZoom = 1.6;
    }
}

function changeSection(section){
    FlxG.camera.flash(FlxColor.WHITE, 1);
    switch(section){
        case 1:
            for(s in phase1){ if(s != null) s.visible = true; }
            for(s in phase2){ if(s != null) s.visible = false; }
        case 2:
            for(s in phase1){ if(s != null) s.visible = false; }
            for(s in phase2){ if(s != null) s.visible = true; }
    }
    curPhase = section;
    // trace(curPhase);

    game.dad.baseCameraDisplacement = 20;
    game.dad.ghostsEnabled = false;
    game.boyfriend.ghostsEnabled = false;
}

function goodNoteHit(note){
	if(note.noteType == 'CerealNote')
		cerealHit();
    if(note.noteType == 'EpicNote')
        epicNoteHit(1);
}

function cerealHit()
{
    var chanceCN = FlxG.random.int(1,3);
    var cerealThing:FlxSprite = new FlxSprite().loadGraphic(Paths.image('Cereal' + chanceCN));
    cerealThing.cameras = [game.camOther];
    cerealThing.screenCenter();
    cerealThing.x = FlxG.random.float(playerStrums.members[0].getGraphicMidpoint().x - 50 - 450, playerStrums.members[3].getGraphicMidpoint().x + 50 - 450);
    var posY = cerealThing.y;
    cerealThing.scale.set(0, 0);
    cerealThing.angle = FlxG.random.int(-25, 25);
    cerealThing.y -= 150;
    add(cerealThing);

    FlxTween.tween(cerealThing, {"scale.x": 0.75, "scale.y": 0.75, angle: 0}, 0.5, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween){
        FlxTween.tween(cerealThing, {"scale.y": 1, y: posY + 400, angle: -5}, 5, {ease: FlxEase.quadOut, onComplete: function(twn2:FlxTween){
            FlxTween.tween(cerealThing, {y: posY + 600, alpha: 0}, 2, {ease: FlxEase.quintOut, onComplete: function(twn3:FlxTween){
                remove(cerealThing);
            }});
        }});
    }});
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

        epicTimer = new FlxTimer().start(5, function(tmr){
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