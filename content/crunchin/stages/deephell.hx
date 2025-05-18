import flixel.text.FlxText;

var shack:FlxSprite;
var poopscare:FlxSprite;
var subtitles:FlxText;
var blackbartop:FlxSprite;
var blackbarbottom:FlxSprite;

var textTween:FlxTween;
var textTimer:FlxTimer;

var bbTween1:FlxTween;
var bbTween2:FlxTween;
var bbEnabled:Bool = false;
function onLoad(){
    var sky:FlxSprite = new FlxSprite().loadGraphic(Paths.image('stages/threat/deephell_hell', 'shared'));
    sky.setPosition(-700, -350);
    sky.scrollFactor.set(0, 0);

    add(sky);

    var darkpillar:FlxSprite = new FlxSprite().loadGraphic(Paths.image('stages/threat/poop_darkpillar'));
    darkpillar.setPosition(-300, -150);
    darkpillar.scrollFactor.set(0, 0);
    add(darkpillar);

    var farbindings:FlxSprite = new FlxSprite().loadGraphic(Paths.image('stages/threat/poop_farbinding'));
    farbindings.setPosition(-300, -150);
    farbindings.scrollFactor.set(0, 0);
    add(farbindings);

    var midbinding:FlxSprite = new FlxSprite().loadGraphic(Paths.image('stages/threat/poop_midbinding'));
    midbinding.setPosition(-300, -150);
    midbinding.scrollFactor.set(0.05, 0.05);
    add(midbinding);

    var perspective:FlxSprite = new FlxSprite().loadGraphic(Paths.image('stages/threat/poop_perspectivepillar'));
    perspective.setPosition(-299, -150);
    perspective.scale.set(1.5, 1.5);
    perspective.scrollFactor.set(0, 0);
    add(perspective);

    var poopclose:FlxSprite = new FlxSprite().loadGraphic(Paths.image('stages/threat/poop_poopclose'));
    poopclose.setPosition(-700, -150);
    poopclose.scrollFactor.set(0.2, 0.2);
    add(poopclose);

    shack = new FlxSprite().loadGraphic(Paths.image('stages/threat/deephell_shackv3'));
    shack.setPosition(0, 0);
    shack.scrollFactor.set(1, 1);
    add(shack);

    poopscare = new FlxSprite();
    poopscare.frames = Paths.getSparrowAtlas('poopscare', 'shared');
    poopscare.animation.addByPrefix('idle', 'poopscare idle', 24, true);
    poopscare.animation.play('idle');
    poopscare.scale.set(0.75, 0.75);
    poopscare.cameras = [game.camHUD];
    poopscare.scrollFactor.set();
    poopscare.screenCenter();
    poopscare.visible = false;
    add(poopscare);

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
}

var weirdlooking = true;

function onCreatePost(){
    game.gfGroup.zIndex = 2;
    game.dadGroup.zIndex = 0;
    shack.zIndex = 3;
    game.boyfriendGroup.zIndex = 4;
    game.refreshZ(game.stage);
    // game.addBehindBF(shack);

    // remove(game.gfGroup);
    // game.addBehindBF(game.gfGroup);

    game.dad.scrollFactor.set(0.3, 0.3);
    game.dad.x -= 300;
    game.dad.y -= 300;

    game.gf.scrollFactor.set(0.35, 0.35);
    game.gf.x -= 550;
    game.gf.y -= 400;

    game.gf.danceIdle = false;
    game.gf.idleSuffix = (PlayState.SONG.notes[0].mustHitSection) ? '' : '-alt';
    game.gf.dance();

    modManager.queueFuncOnce(512, (s,s2)->{
        weirdlooking = false;
        game.gf.specialAnim = true;
        game.gf.danceIdle = true;
        game.gf.idleSuffix = '';
        game.gf.animation.play('smile');
        game.gf.animation.finishCallback = function(name:String)
        {
            if(name == 'smile')
            {
                game.gf.specialAnim = false;
            }
        }
    });
}

var poopTimer:FlxTimer;
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
        case 'Poopscare':
            if(poopscare != null)
            {
                if(poopTimer != null)
                {
                    poopTimer.cancel();
                }

                poopscare.visible = true;
                poopTimer = new FlxTimer().start(0.175, function(tmr:FlxTimer) {
                    poopscare.visible = false;
                    poopTimer = null;
                });
            }
    }
}

var gfLooking:Bool = false;

function onUpdate(elapsed){
    if(game.curStep > 0){
        if(gf.curCharacter == 'deephell-ifu' && weirdlooking){
            if(PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection)
                {
                    if(!gfLooking)
                        {
                            gfLooking = true;
                
                            game.gf.danceIdle = false;
                
                            game.gf.specialAnim = true;
                            game.gf.animation.play('bflook');
                            game.gf.animation.finishCallback = function(name:String)
                            {
                                if(name == 'bflook')
                                {
                                    game.gf.specialAnim = false;
                                    game.gf.idleSuffix = '';
                                }
                            }
                        }
                }else{
                    if(gfLooking){
                        gfLooking = false;
        
                        game.gf.danceIdle = false;
            
                        game.gf.specialAnim = true;
                        game.gf.animation.play('pooplook');
                        game.gf.animation.finishCallback = function(name:String)
                        {
                            if(name == 'pooplook')
                            {
                                //gf.playAnim('idle-alt');
                                game.gf.specialAnim = false;
                                game.gf.idleSuffix = '-alt';
                            }
                        }
                    }
                }
        }
    }
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