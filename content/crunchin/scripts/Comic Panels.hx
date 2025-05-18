var seenCutscene:Bool = PlayState.chartingMode;
function onStartCountdown(){
    FlxG.mouse.visible = true;
    
    if(!seenCutscene){
        if(PlayState.isStoryMode){
            switch(PlayState.SONG.song.toLowerCase()){
                case 'crunch':
                    setIntro('CGuyPanel1', 'breakfast', '');
                case 'crunch':
                    setIntro('CGuyPanel1', 'breakfast', '');
    
                case 'milkyway':
                    setIntro('CGuyPanel2', 'breakfast', '');
                    
                case 'choke-a-lot':
                    setIntro('CGuyPanel3', 'breakfast', '');
    
                case 'doubt':
                    setIntro('DTE-panel1', 'sadge', '');
    
                case 'hope':
                    setIntro('DTE-panel2', 'happi', '');
    
                case 'reunion':
                    setIntro('DTE-panel3', 'happi', '');
    
                case 'smile':
                    setIntro('epic-panel1', 'breakfast', 'epic-panel2');
                
                case 'order-up':
                    setIntro('epic-panel3', 'breakfast', '');
                    
                case 'last-course':
                    setIntro('epic-panel4', 'breakfast', '');
                    
                default:
                    return Function_Continue;
            }
            return Function_Stop;
        }else{
            switch(PlayState.SONG.song.toLowerCase()){
                case 'alert':
                    setIntro('ALERTCOMIC', 'breakfast', '');
                default:
                    return Function_Continue;
            }
            return Function_Stop;
        }
    }

}
function onCountdownTick(tick){ if(tick == 0) game.playHUD.visible = true; }

//CUTSCENE THINGS U KNOW HOW IT IS
var button:FlxSprite;
var imageCutscene:FlxSprite;
var twoPanel:Bool = false;
var secondPanName:String = "";
var curPanel = 0;
var alreadyClicked = false;

function setIntro(name, songName = 'sadge', secondpanelName = ''){
    FlxG.mouse.visible = true;
    twoPanel = secondpanelName.length > 0;
    if(twoPanel){
        secondPanName = secondpanelName;
    }

    Paths.currentModDirectory = 'crunchin';

    FlxG.sound.playMusic(Paths.music(songName), 0);
    FlxG.sound.music.fadeIn(2, 0, 1);

    button = new FlxSprite();
    button.cameras = [game.camHUD];
    button.scrollFactor.set();
    if(twoPanel){
        button.frames = Paths.getSparrowAtlas('dialogue/nextbutton');
    }
    else{
        button.frames = Paths.getSparrowAtlas('dialogue/BeginSong');
    }
    button.animation.addByPrefix('idle', 'BeginSong unselect', 0, false);
    button.animation.addByPrefix('select', 'BeginSong select', 0, false);
    button.animation.play('idle');
    button.scale.set(0.5, 0.5);
    button.screenCenter();
    button.alpha = 0;
    button.setPosition((FlxG.width - button.frameWidth) + 250, (FlxG.height - button.frameHeight) + 150);
    button.updateHitbox();

    imageCutscene = new FlxSprite().loadGraphic(Paths.image('dialogue/' + name));
    imageCutscene.antialiasing = true;
    imageCutscene.cameras = [game.camHUD];
    imageCutscene.scale.set(0.67, 0.67);
    imageCutscene.updateHitbox();
    imageCutscene.scrollFactor.set();

    if(name == 'DTE-panel3')
    {
        imageCutscene.visible = false;
    }

    setup_panel();

    add(imageCutscene);
    add(button);
    game.playHUD.visible = false;
    playPanelAnimation(name == 'ALERTCOMIC');
}

var panelX:Float = 0;
var panelY:Float = 0;
function setup_panel(?screenC:Bool = true){
    if(imageCutscene != null){
        if(screenC){
            imageCutscene.screenCenter();

            panelX = imageCutscene.x;
            panelY = imageCutscene.y;
        }
        else{
            imageCutscene.x = panelX;
            imageCutscene.y = panelY;
        }
        imageCutscene.x -= imageCutscene.width + 200;
        imageCutscene.y += 100;
        imageCutscene.angle = -4;
    }
}

// var point:FlxPoint = new FlxPoint();
function onUpdate(elapsed){
    if(FlxG.keys.justPressed.R && FlxG.keys.pressed.SHIFT) FlxG.resetState();

    if(game.inCutscene && button != null && !alreadyClicked)
    {
        var point = FlxG.mouse.getPositionInCameraView(game.camHUD);
        var fuck = (point.x >= button.x && point.x <= button.x + button.frameWidth) && (point.y >= button.y && point.y <= button.y + button.frameHeight);

        if(fuck && button.alpha > 0.1)
        {
            if(FlxG.mouse.pressed)
            {
                alreadyClicked = true;
                FlxG.sound.play(Paths.sound('dialogueClose'));
                if(twoPanel && curPanel == 1){
                    game.inCutscene = false;
                    FlxG.sound.music.fadeOut(1, 0);
                }
                else if(!twoPanel)
                {
                    game.inCutscene = false;
                    FlxG.sound.music.fadeOut(1, 0);
                }

                var centerX = imageCutscene.x;
                var centerY = imageCutscene.y;

                if(!game.inCutscene){
                    game.modchartTweens.set("buttonTween", FlxTween.tween(button, {alpha: 0}, 1, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween){
                        game.modchartTweens.remove("buttonTween");
                    }}));
                }

                //FlxTween.tween(button, {alpha: 0}, 1, {ease: FlxEase.quadOut});
                FlxTween.tween(imageCutscene, {x: centerX + imageCutscene.width + 200, angle: 4, y: centerY + 100}, 0.5, {ease: FlxEase.quintIn, onComplete: function(twn:FlxTween){
                    if(!twoPanel){
                        seenCutscene = true;
                        game.startCountdown();
                        FlxG.mouse.visible = false;
                        remove(imageCutscene);
                    }else{
                        if(curPanel == 1){
                            seenCutscene = true;
                            game.startCountdown();
                            FlxG.mouse.visible = false;
                            remove(imageCutscene);
                        }
                        else{
                            button.frames = Paths.getSparrowAtlas('dialogue/BeginSong');
                            button.animation.addByPrefix('idle', 'BeginSong unselect', 0, false);
                            button.animation.addByPrefix('select', 'BeginSong select', 0, false);
                            button.alpha = 0;
                            imageCutscene.loadGraphic(Paths.image('dialogue/' + secondPanName));
                            setup_panel(false);
                            playPanelAnimation();
                        }
                    }
                    curPanel+=1;
                }});
            }

            button.animation.play('select');
        }
        else
        {
            button.animation.play('idle');
        }
    }
}

function playPanelAnimation(?skipTimer = false){
    FlxTween.tween(imageCutscene, {x: panelX + 100, angle: 2, y: panelY}, 0.5, {ease: FlxEase.quintIn, onComplete: function(twn:FlxTween){
        FlxTween.tween(imageCutscene, {x: panelX, angle: 0}, 1, {ease: FlxEase.elasticOut});
        FlxG.sound.play(Paths.sound('dialogueClose'));
    }});

    alreadyClicked = false;

    new FlxTimer().start((!skipTimer) ? 4 : 0, function(deadTime:FlxTimer)
    {
        game.inCutscene = true;
        var buttonTween = game.modchartTweens.get("buttonTween");
        if(buttonTween != null){
            buttonTween.cancel();
        }
        game.modchartTweens.set("buttonTween", FlxTween.tween(button, {alpha: 1}, 0.25, {ease: FlxEase.quintOut, onComplete: function(twn:FlxTween){
            game.modchartTweens.remove("buttonTween");
        }}));
    });
}

var transition:FlxSprite;

function onCreatePost(){
    transition = new FlxSprite();
    transition.frames = Paths.getSparrowAtlas('transition_out');
    transition.animation.addByPrefix('idle', 'transition_out idle', 60, false);
    transition.screenCenter();
    transition.scrollFactor.set();
    transition.scale.set(2.5, 2.5);
    transition.animation.play('idle', false, true);
    transition.camera = game.camOther;
    add(transition);
}

var done = false;
function onEndSong(){
    if(!done){
        done = true;
        if(transition != null){
            transition.animation.play('idle', false, false);
            transition.animation.finishCallback = ()->{ PlayState.instance.endSong(); }
        }else{
            transition = new FlxSprite();
            transition.frames = Paths.getSparrowAtlas('transition_out');
            transition.animation.addByPrefix('idle', 'transition_out idle', 60, false);
            transition.screenCenter();
            transition.scrollFactor.set();
            transition.scale.set(2.5, 2.5);
            transition.animation.play('idle', false, false);
            transition.camera = game.camOther;
            add(transition);

            transiiton.animation.finishCallback = ()->{ PlayState.instance.endSong(); }
        }
        return Function_Stop;    
    }
    return Function_Continue;
}