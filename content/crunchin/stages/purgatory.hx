import flixel.FlxCamera;
import flixel.math.FlxMath;
import funkin.utils.CameraUtil;
import openfl.filters.ShaderFilter;

var stageDirectory = 'stages/rumor/';

var phase1GROUP:FlxSpriteGroup;

var bfSpotlight:FlxSprite;
var dadSpotlight:FlxSprite;
var bfSpotlight2:FlxSprite;
var dadSpotlight2:FlxSprite;

var focusShadow:FlxSprite;
var activation:FlxSprite;
var jackCORD:FlxSprite;
var newBF:FlxSprite;
var backroom:FlxSprite;
var thingy:FlxSprite;
var table:FlxSprite;
var _9mFRAME:FlxSprite;
var idi_intro:FlxSprite;
var rumorWHITE:FlxSprite;
var alertWHITE:FlxSprite;
var mon_static:FlxSprite;
var whiteSCREENpartTWO:FlxSprite;

var randomIMAGES:FlxSprite;
var imagenames:Array<String> = ['bsod', 'FUUUUU', 'ifu', 'ifunny', 'WhoopDa', 'nightmare', 'providence', 'real', 'worktomorrow', 'trilogy', 'smile', 'restinpeace'];

var godSTEPS:Array<Int> = [2960, 3024, 3072, 3088, 3168, 3184, 3200, 3216, 3248, 3280, 3312, 3328, 3392, 3408, 3440, 3456, 3472, 3616, 3632, 3680, 3696, 3744, 3760, 3808, 3824, 3840, 3856, 3872, 3888, 3904, 3920, 3936, 3952, 3968, 3984, 4000, 4080];

var tv:FlxCamera;

var the_man_in_the_tv:FlxSound;

function onLoad(){
    tv = CameraUtil.quickCreateCam(false);

    var scrollFactor = 0.95;

    phase1GROUP = new FlxSpriteGroup();
    add(phase1GROUP);

    activation = new FlxSprite().loadGraphic(Paths.image(stageDirectory + 'Idi/activation'));
    activation.screenCenter();
    activation.scrollFactor.set(scrollFactor, scrollFactor);
    activation.scale.set(1.5, 1.5);
    activation.blend = BlendMode.ADD;
    activation.alpha = 0;
    add(activation);

    add(phase1GROUP);

    backroom = new FlxSprite().loadGraphic(Paths.image(stageDirectory + 'Idi/room'));
    backroom.screenCenter();
    backroom.scrollFactor.set(scrollFactor, scrollFactor);
    backroom.scale.set(1.5, 1.5);
    phase1GROUP.add(backroom);

    thingy = new FlxSprite().loadGraphic(Paths.image(stageDirectory + 'Idi/thingy'));
    thingy.screenCenter();
    thingy.scrollFactor.set(scrollFactor, scrollFactor);
    thingy.scale.set(1.5, 1.5);
    phase1GROUP.add(thingy);

    table = new FlxSprite().loadGraphic(Paths.image(stageDirectory + 'Idi/table'));
    table.screenCenter();
    table.scrollFactor.set(1, 1);
    table.scale.set(1.5, 1.5);
    phase1GROUP.add(table);

    bfSpotlight = new FlxSprite().loadGraphic(Paths.image(stageDirectory + 'Idi/bfturn'));
    bfSpotlight.screenCenter();
    bfSpotlight.scrollFactor.set(1, 1);
    bfSpotlight.scale.set(1.5, 1.5);
    bfSpotlight.alpha = 0;
    bfSpotlight.blend = BlendMode.ADD;
    bfSpotlight.cameras = [tv];

    bfSpotlight2 = new FlxSprite().loadGraphic(Paths.image(stageDirectory + 'Idi/bfturn_nolight'));
    bfSpotlight2.screenCenter();
    bfSpotlight2.scrollFactor.set(1, 1);
    bfSpotlight2.scale.set(1.5, 1.5);
    bfSpotlight2.alpha = 0;
    bfSpotlight2.cameras = [tv];

    dadSpotlight = new FlxSprite().loadGraphic(Paths.image(stageDirectory + 'Idi/iditurn'));
    dadSpotlight.screenCenter();
    //dadSpotlight.x += 50;
    dadSpotlight.scrollFactor.set(1, 1);
    dadSpotlight.scale.set(1.5, 1.5);
    dadSpotlight.alpha = 1;
    dadSpotlight.blend = BlendMode.ADD;
    dadSpotlight.cameras = [tv];

    dadSpotlight2 = new FlxSprite().loadGraphic(Paths.image(stageDirectory + 'Idi/iditurn_nolight'));
    dadSpotlight2.screenCenter();
    dadSpotlight2.scrollFactor.set(1, 1);
    dadSpotlight2.scale.set(1.5, 1.5);
    dadSpotlight2.alpha = 1;
    dadSpotlight2.cameras = [tv];

    jackCORD = new FlxSprite();
    jackCORD.frames = Paths.getSparrowAtlas(stageDirectory + 'jack', 'shared');
    jackCORD.animation.addByPrefix('entrance', 'jack stabtime', 24, false);
    jackCORD.antialiasing = ClientPrefs.globalAntialiasing;
    jackCORD.visible = false;
    phase1GROUP.add(jackCORD);

    focusShadow = new FlxSprite().loadGraphic(Paths.image(stageDirectory + 'Idi/focusshadow', 'shared'));
    focusShadow.cameras = [tv];
    focusShadow.screenCenter();
    focusShadow.antialiasing = ClientPrefs.globalAntialiasing;
    focusShadow.scale.set(1.35, 1.35);
    //focusShadow.x += 295;
    //focusShadow.y += 25; // -= 25;
    focusShadow.visible = false;
    //phase1GROUP.add(focusShadow);

    newBF = new FlxSprite();
    newBF.frames = Paths.getSparrowAtlas(stageDirectory + 'londonbf', 'shared');
    newBF.antialiasing = ClientPrefs.globalAntialiasing;
    newBF.animation.addByPrefix('stab', 'londonbf stab', 24, false);
    newBF.animation.addByPrefix('idle', 'londonbf idle', 24, true);
    newBF.alpha = 0.0001;
    phase1GROUP.add(newBF);

    idi_intro = new FlxSprite();
    idi_intro.frames = Paths.getSparrowAtlas(stageDirectory + 'Idi/IDI_Intro_Anim', 'shared');
    idi_intro.antialiasing = ClientPrefs.globalAntialiasing;
    idi_intro.animation.addByPrefix('idle', 'Intro_Anim', 24, false);
    idi_intro.visible = false;
    idi_intro.y -= 215;
    idi_intro.scale.set(1.5, 1.5);

    mon_static = new FlxSprite();
    mon_static.frames = Paths.getSparrowAtlas(stageDirectory + 'Idi/MonitorStatic', 'shared');
    mon_static.antialiasing = ClientPrefs.globalAntialiasing;
    mon_static.animation.addByPrefix('idle', 'StaticMonitors', 24, true);
    mon_static.animation.play('idle');
    mon_static.alpha = 0.00001;
    mon_static.scale.set(2.15, 2.15);
    add(mon_static);

    rumorWHITE = new FlxSprite().makeGraphic(Std.int(FlxG.width * 4), Std.int(FlxG.height * 4), FlxColor.WHITE);
    rumorWHITE.alpha = 0;
    rumorWHITE.visible = false;
    add(rumorWHITE);

    add(idi_intro);

    _9mFRAME = new FlxSprite().loadGraphic(Paths.image(stageDirectory + 'Idi/monitors'));
    _9mFRAME.antialiasing = ClientPrefs.globalAntialiasing;
    _9mFRAME.scale.set(1.5, 1.5);
    _9mFRAME.y -= 215;
    _9mFRAME.alpha = 0;

    randomIMAGES = new FlxSprite();
    randomIMAGES.screenCenter();
    randomIMAGES.scrollFactor.set();
    randomIMAGES.visible = false;
    randomIMAGES.scale.set(1.5, 1.5);
    randomIMAGES.x -= 950;
    randomIMAGES.y -= 550;
    for(i in 0...imagenames.length)
    {
        randomIMAGES.loadGraphic(Paths.image(stageDirectory + 'thepast/' + imagenames[i], 'shared'));
    }

    phase1GROUP.cameras = [tv];
    _9mFRAME.cameras = [tv];
    
    add(randomIMAGES);
    add(dadSpotlight);
    add(dadSpotlight2);
    add(bfSpotlight);
    add(bfSpotlight2);
    add(focusShadow);
    add(_9mFRAME);
}

var crt = null;
// var crt = newShader('CRT');
// crt.data.red.value = [false];

function onCreatePost(){
    if(ClientPrefs.shaders){
        crt = newShader('CRT');
        crt.data.red.value = [false];
    }
    CameraUtil.insertFlxCamera(1, tv);
    tv.follow(game.camFollowPos, FlxCameraFollowStyle.LOCKON, 1);
    tv.focusOn(game.camFollow);

    game.gfGroup.alpha = 0;
    
    setupIdiPopups();
    setupGodIdi();

    game.addCharacterToList('pov-bf', 0);
    game.addCharacterToList('iamgod', 1);
    game.addCharacterToList('hijacked-bf', 2);

    game.boyfriendGroup.cameras = [tv];
    game.dadGroup.cameras = [tv];
    game.gfGroup.cameras = [tv];

    for(fuck in [randomIMAGES, dadSpotlight, dadSpotlight2, bfSpotlight, bfSpotlight2, _9mFRAME]){fuck.zIndex = 1; }
    game.refreshZ(game.stage);

    whiteSCREENpartTWO = new FlxSprite().makeGraphic(Std.int(FlxG.width * 4), Std.int(FlxG.height * 4), FlxColor.WHITE);
    whiteSCREENpartTWO.alpha = 0;
    whiteSCREENpartTWO.screenCenter();
    whiteSCREENpartTWO.scrollFactor.set();
    add(whiteSCREENpartTWO);

    if(ClientPrefs.shaders){
        game.camGame.setFilters([new ShaderFilter(crt)]);
        game.camGame.filtersEnabled = false;    
    }

    // trace('GOD DAMNIT FUCK FUCK FUCK');

    game.modManager.queueFuncOnce(1852, (s,s2)->{ debugTextShit(217, 'HE WANTS TO MEET YOU', FlxColor.WHITE); });
    game.modManager.queueFuncOnce(1872, (s,s2)->{ debugTextShit(218, 'I WANNA PLAY WITH THE MAN', FlxColor.WHITE); });
    game.modManager.queueFuncOnce(1892, (s,s2)->{ debugTextShit(219, 'IN THE TV!', FlxColor.RED); });
}

function debugTextShit(line, text, color){
    game.addTextToDebug('[content/crunchin/stages/purgatory.hx]: MESSAGE ON LINE ' + line + ' - > ' + text, color);
}

function onCountdownTick(tick){
    switch(tick){
        case 1: countdownReady.cameras = [tv];
        case 2: countdownSet.cameras = [tv];
        case 3: countdownGo.cameras = [tv];
    }
}

var rumorPHASE2INIT:Bool = false;
function onUpdate(elapsed){
    tv.zoom = FlxG.camera.zoom;

    if(!game.startingSong){
        if(!rumorPHASE2INIT)
        {
            if(PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection)
            {
                bfSpotlight.alpha = FlxMath.lerp(bfSpotlight.alpha, 1, FlxMath.bound(elapsed * 9, 0, 0.5));
                dadSpotlight.alpha = FlxMath.lerp(dadSpotlight.alpha, 0, FlxMath.bound(elapsed * 9, 0, 1.5));
            }
            else
            {
                bfSpotlight.alpha = FlxMath.lerp(bfSpotlight.alpha, 0, FlxMath.bound(elapsed * 9, 0, 1.5));
                dadSpotlight.alpha = FlxMath.lerp(dadSpotlight.alpha, 1, FlxMath.bound(elapsed * 9, 0, 0.5));
            }
        }
        else
        {
            bfSpotlight.alpha = FlxMath.lerp(bfSpotlight.alpha, 0, FlxMath.bound(elapsed * 9, 0, 1));
            dadSpotlight.alpha = FlxMath.lerp(dadSpotlight.alpha, 0, FlxMath.bound(elapsed * 9, 0, 1));
        }
        if(bfSpotlight2 != null) bfSpotlight2.alpha = bfSpotlight.alpha;
        if(dadSpotlight2 != null) dadSpotlight2.alpha = dadSpotlight.alpha;        

        if(game.curStep >= 2720)
        {
            if(PlayState.SONG.notes[Std.int(game.curStep / 16)].mustHitSection)
            {
                game.camFollow.y = 375;
                game.boyfriend.alpha = FlxMath.lerp(game.boyfriend.alpha, 1, FlxMath.bound(elapsed * 9, 0, 1.5));
            }
            else
            {
                game.camFollow.y = 300;
                game.boyfriend.alpha = FlxMath.lerp(game.boyfriend.alpha, 0.1, FlxMath.bound(elapsed * 9, 0, 1.5));
            }
        }
    }
}

var idiPOPUPS:Bool = false;
function onStepHit(){
    if(idiPOPUPS){ if(FlxG.random.bool(25)) idiPOP(); }
    for(i in 0...godSTEPS.length)
    {
        if(curStep == godSTEPS[i])
        {
            godIDI();
        }
    }
}

var popups:Array<FlxSprite> = [];
var names:Array<String> = ['Grossa', 'Idiot', 'Poop', 'Providence', 'Purgatory'];
function setupIdiPopups(){
    for(i in names){
        var pop:FlxSprite = new FlxSprite();
        pop.frames = Paths.getSparrowAtlas(stageDirectory + 'Idi/popups/' + i);
        pop.animation.addByPrefix('open', 'Symbol 3 instance 1', 24, false);
        pop.screenCenter();
        popups.push(pop);
    }
}
function idiPOP()
{
    var int = FlxG.random.int(0, names.length - 1);
    var pop = popups[int];

    if(pop.animation.exists('open'))
        pop.animation.play('open');
    else
        remove(pop);

    pop.animation.finishCallback = function(s:String)
    {
        remove(pop);
    };

    pop.x = (FlxG.random.float(-FlxG.width * 0.75, FlxG.width * 0.75)) + 100;
    pop.y = (FlxG.random.float(-FlxG.height * 0.75, FlxG.width * 0.75));

    add(pop);
}

var godpopups:Array<FlxSprite> = [];
function setupGodIdi(){
    for(i in 0...9){
        var idi1:FlxSprite = new FlxSprite();    
        idi1.frames = Paths.getSparrowAtlas(stageDirectory + 'Idi/popups/idigodlaugh');
        idi1.animation.addByPrefix('laugh', 'idigodlaugh mockery', 24, false);
        idi1.visible = false;
        idi1.scale.set(1, 1);
        add(idi1);
        godpopups.push(idi1);
    }
}

var inUse:Bool = false;
var inUse2:Bool = false;
var counter = -1;
function godIDI()
{
    for(i in 0...3){
        var idi:FlxSprite = new FlxSprite();    
        idi.frames = Paths.getSparrowAtlas(stageDirectory + 'Idi/popups/idigodlaugh');
        idi.animation.addByPrefix('laugh', 'idigodlaugh mockery', 24, false);
        idi.visible = false;
        idi.scale.set(1, 1);
        add(idi);
    
        idi.visible = true;
        idi.animation.play('laugh');        
        idi.screenCenter();
        idi.x += FlxG.random.float(-FlxG.width * 1, FlxG.width * 1) + 250;
        idi.y += FlxG.random.float(-FlxG.height * 0.75, FlxG.height * 0.75);
        idi.animation.finishCallback = function(s:String)
        {
            idi.visible = false;
            remove(idi);
        }; 
    }

    var messages = [
        'YOU ARE AN IDIOT', 
        'I AM GOD', 
        'YOU ARE AN IDIOT AND I AM GOD', 
        'FOOL', 
        'HAHAHAHAHA', 
        'GIVE IN', 
        'HOW DOES IT FEEL TO BE STABBED?', 
        'DEATH IS TOO SOFT OF A PUNISHMENT FOR YOU',
        'ENJOY YOUR NEW HOME!',
        'JOIN THE HIVE',
        'HAVE YOU MET MY FRIEND IFU?',
        'PROVIDENCE IS WAITING FOR YOU!',
        'HAVE YOU MET MY FRIEND TUMOR?',
        'actually i hate tumor.',
        'HE SEES ALL',
        'SMILEFORME',
        'YOU\'RE NOT FROM HERE, ARE YOU?',
        'YOU\'RE MORE... BLUE.. THAN THE OTHER ONE.'
    ];

    debugTextShit(FlxG.random.int(134, 692), messages[FlxG.random.int(0, messages.length - 1)], FlxColor.RED);
}

var funny = false;
function onEvent(eventName, value1, value2){
    if(eventName == 'Song Events'){
        switch(value1){
            case 'prep':
                jackCORD.x = game.boyfriend.getGraphicMidpoint().x - 235;
                jackCORD.y = game.boyfriend.getGraphicMidpoint().y - 430;
                jackCORD.animation.play('entrance');
                jackCORD.visible = true;
            case 'stab':
                jackCORD.visible = false;
                game.boyfriend.visible = false;
                newBF.alpha = 1;
                newBF.x = game.boyfriend.getGraphicMidpoint().x - 240;
                newBF.y = game.boyfriend.getGraphicMidpoint().y - 470;
                newBF.alpha = 1;
                newBF.animation.play('stab', true);
                newBF.animation.callback = function(name:String, frameNumber:Int, frameIndex:Int)
                {
                    if(name == 'stab')
                    {
                        switch(frameNumber)
                        {
                            case 1:
                                FlxG.sound.play(Paths.sound('bf_plug'));
                            case 2:
                                camGame.shake(0.005, 0.1);
                            case 3:
                                focusShadow.alpha = 0;
                                focusShadow.visible = true;
                                FlxTween.tween(focusShadow, {alpha: 1}, 1, {ease: FlxEase.quintOut});

                                game.camGame.filtersEnabled = ClientPrefs.shaders;

                                FlxTween.tween(activation, {alpha: 1}, 2, {ease: FlxEase.quintOut});
                                rumorPHASE2INIT = true;
    
                        }
                    }
                }
                newBF.animation.finishCallback = function(s:String)
                {
                    newBF.animation.play('idle');
                }
            case 'the other one':
                game.isCameraOnForcedPos = true;
                game.camFollow.x = 900;
                game.camFollow.y = 285;

                FlxTween.tween(phase1GROUP, {alpha: 0}, 4, {ease: FlxEase.quintInOut});

                FlxTween.tween(FlxG.camera, {zoom: 10}, 4, {ease: FlxEase.quintInOut, onComplete: function(twn:FlxTween){
                    FlxTween.tween(_9mFRAME, {alpha: 1}, 2, {ease: FlxEase.quintInOut});
                    
                    game.camFollow.x = 950;
                    game.camFollow.y = 285;
                    game.defaultCamZoom = 0.485;

                    focusShadow.alpha = 0;

                    mon_static.screenCenter();
                    mon_static.y -= 100;
                    mon_static.x += 325;
                    mon_static.alpha = 0.00001;
                    
                    FlxTween.tween(mon_static, {alpha: 1}, 1, {ease: FlxEase.quadInOut});
                    game.dad.visible = false;

                    FlxTween.tween(FlxG.camera, {zoom: game.defaultCamZoom}, 2, {ease: FlxEase.quintInOut, onComplete: function(twn:FlxTween){
                        activation.alpha = 0;
                    }});
                }});
            case 'image':
                funny = !funny;
                showImage(funny, game.curStep);

            case 'weird shit':
                switch(value2){
                    case '0':
                        game.boyfriend.visible = false;
                        game.boyfriend.zIndex = 999;
                        game.boyfriendGroup.zIndex = 999;
                        game.refreshZ(game.stage);
                    case '1':
                        rumorWHITE.visible = true;
						rumorWHITE.screenCenter();
						FlxTween.tween(rumorWHITE, {alpha: 1}, 2.25, {ease: FlxEase.quintIn});
						FlxTween.tween(game.camHUD, {alpha: 0}, 3, {ease: FlxEase.quintOut});
                    case '2':
                        FlxTween.tween(game.camHUD, {alpha: 1}, 0.5, {ease: FlxEase.quintOut});
                    case '3':
						the_man_in_the_tv = new FlxSound().loadEmbedded(Paths.sound('the_man_in_the_tv'), false, true);
                        the_man_in_the_tv.play();

                    case '4':
                        rumorWHITE.visible = false;
						game.gf.cameras = [game.camGame];
						idi_intro.visible = true;
						idi_intro.animation.play('idle');
						idi_intro.animation.finishCallback = function(s:String){
							game.boyfriend.visible = true;
							game.boyfriend.alpha = 0;
							game.boyfriend.x -= 500;
							game.boyfriend.y += 50;
							
							FlxTween.tween(game.boyfriend, {alpha: 1}, 0.5, {ease: FlxEase.quadInOut});
							FlxTween.tween(FlxG.camera, {zoom: 1.125}, 0.1, {ease: FlxEase.quintIn});

                            game.opponentStrums.owner = game.gf;

							game.gfGroup.visible = true;
							game.gf.visible = true;
							game.gf.alpha = 1;

							idi_intro.visible = false;
							game.defaultCamZoom = 0.475;
							game.camFollow.x = 950;
                            game.camFollow.y = 310;

							idiPOPUPS = true;
						};
                    case '5':
                        game.camHUD.shake(0.005, 1);
						FlxG.sound.play(Paths.sound('da_middle_scroll'));
                        
                        modManager.queueEase(game.curStep, game.curStep + 4, 'opponentSwap', 0.5, 'quadOut');
                        modManager.queueEase(game.curStep, game.curStep + 4, 'alpha', 1, 'quadOut', 1);
                    case '6':
                        idiPOPUPS = false;
						FlxTween.color(mon_static, 4, 0xFFFFFFFF, 0xFF00008b, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween){
							FlxTween.tween(mon_static, {alpha: 0.2}, 4, {ease: FlxEase.quadOut});
						}});
						FlxTween.tween(game.gf, {alpha: 0}, 0.25, {ease: FlxEase.quadInOut, onComplete: function(twn:FlxTween){
							game.triggerEventNote('Change Character', 'gf', 'hijacked-bf');
							game.playHUD.iconP2.changeIcon('hijacked-bf');
							game.gf.cameras = [game.camGame];
							game.gf.alpha = 0;
							game.gf.setPosition(400, -200);
							game.gf.scale.set(0.25, 0.25);

							FlxTween.tween(game.gf, {alpha: 1, "scale.x": 1.9, "scale.y": 1.9}, 1, {ease: FlxEase.quintOut, onComplete: function(twn2:FlxTween){
								game.camFollow.x = 950;
                                game.camFollow.y = 285;
							}});

							FlxTween.tween(boyfriend, {alpha: 0.15, y: 425}, 1, {ease: FlxEase.quintOut});
						}});
                    case '7':
                        FlxTween.tween(game.boyfriend, {alpha: 0.5}, 0.6, {ease: FlxEase.quintOut});
						FlxTween.tween(FlxG.camera, {zoom: 0.5}, 0.6, {ease: FlxEase.quintOut, onComplete: function(twn:FlxTween){
							FlxTween.tween(game.boyfriend, {alpha: 1}, 0.5, {ease: FlxEase.quintOut});
							FlxTween.tween(FlxG.camera, {zoom: 0.575}, 0.5, {ease: FlxEase.quintOut, onComplete:function(twn2:FlxTween){
								FlxTween.tween(game.boyfriend, {alpha: 0.15}, 1, {ease: FlxEase.quintOut});
							}});
						}});
                    case '8':
                        FlxTween.tween(game.boyfriend, {alpha: 1, y: 350}, 1, {ease: FlxEase.cubeOut});
						game.camFollow.x = (950);
                        game.camFollow.y = (365);
                    case '9':
                        FlxTween.tween(game.gf, {alpha: 0, "scale.x": 0.25, "scale.y": 0.25}, 2, {ease: FlxEase.quadIn});
						game.boyfriend.playAnim('freedom', true);
						game.boyfriend.animation.finishCallback = function(name:String)
						{
							game.triggerEventNote('Change Character', 'bf', 'pov-bf');
							game.triggerEventNote('Change Character', 'dad', 'iamgod');
							game.playHUD.iconP2.alpha = 0;

							FlxTween.color(mon_static, 5, 0xFF00008b, 0xFF990000, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween){
								FlxTween.tween(mon_static, {alpha: 0.3}, 10, {ease: FlxEase.quadOut});
							}});
							game.dad.cameras = [game.camGame];
							game.dad.visible = false;
							game.dad.x += 850;
							game.dad.y -= 300 + 175;

							game.boyfriendGroup.x -= 600;
							game.boyfriendGroup.y += 110;
							whiteSCREENpartTWO.screenCenter();
							whiteSCREENpartTWO.cameras = [tv];
							whiteSCREENpartTWO.alpha = 1;

							 FlxTween.tween(whiteSCREENpartTWO, {alpha: 0}, 5, {ease: FlxEase.quintOut, onComplete: function(twn:FlxTween){
								remove(whiteSCREENpartTWO);
							}});
						}
						game.boyfriend.specialAnim = true;
                    case '10':
						FlxTween.tween(boyfriend, {alpha: 0.1}, 1, {ease: FlxEase.quadInOut});
                        if(ClientPrefs.shaders) crt.data.red.value = [true];
                    case '11':
                        // game.isCameraOnForcedPos = false;
                        game.opponentStrums.owner = game.dad;

                        game.dad.cameras = [game.camGame];
						game.dad.visible = true;
						game.dad.playAnim('appear');
						FlxTween.tween(iconP2, {alpha: 1}, 5, {ease: FlxEase.quintOut});
						
						game.dad.animation.callback = function(name:String, frameNumber:Int, frameIndex:Int)
						{
							if(name == 'appear')
							{
								switch(frameNumber)
								{
									case 1:
										FlxG.sound.play(Paths.sound('glitch_lol'));
								}
							}
						}

						game.dad.animation.finishCallback = function(name:String)
						{
							game.dad.specialAnim = false;
						}
						game.dad.specialAnim = true;
                }
        }
    }
}

var donecam:Bool = false;
var checkSTEP:Int = 0;
var chance:Array<Int> = [-1, -1, -1, -1, -1];

function showImage(show:Bool, curSte:Int) //this is probably really tedious but that is okay
{
    if(checkSTEP != curSte)
    {
        if(show)
        {	
            var notFinished:Bool = true;
            var newInt:Int = 0;
            while(notFinished)
            {
                var temp:Int = FlxG.random.int(0, imagenames.length);
                var check:Bool = false;

                for(i in 0...chance.length)
                {
                    if(temp == chance[i])
                    {
                        check = true;
                    }
                }
                
                if(!check)
                    notFinished = false;
                    newInt = temp;

                    chance.insert(0, temp);
            }
            checkSTEP = curSte;
            randomIMAGES.loadGraphic(Paths.image(stageDirectory + 'thepast/' + imagenames[newInt]));
            randomIMAGES.visible = true;
            chance.push(newInt);
        }
        else
        {
            randomIMAGES.visible = false;
        }
    }

}

function onPause(){
    if(the_man_in_the_tv != null){
        if(the_man_in_the_tv.playing){
            the_man_in_the_tv.pause();
        }
    }
}

function onResume(){
    if(the_man_in_the_tv != null){
        the_man_in_the_tv.play();
    }
}

var singAnimations = ['singLEFT', 'singDOWN', 'singUP', 'singRIGHT'];
function noteMiss(note){
    if(game.curStep >= 2208 && game.curStep <= 2655){
        var animToPlay:String = singAnimations[Std.int(Math.abs(note.noteData))] + 'miss';
        gf.playAnim(animToPlay, true);
    }  
}