import flixel.FlxObject;
import flixel.text.FlxText;
import funkin.states.MainMenuState;
import flixel.util.FlxSort;
import funkin.backend.PlayerSettings;

var controls = PlayerSettings.player1.controls;

var bg:FlxSprite;
var fade:FlxSprite;
var backbutton:FlxSprite;
var transition:FlxSprite;
var buttons:FlxTypedGroup;

var comicSections = ['CG', 'Trl', 'Epc', 'TJak', 'Ifu', 'Poop', 'Idi', 'Prov'];
var comicButtonPositions:Array<FlxPoint> = [];
var comicsButtons:FlxTypedGroup;

var actualComics:StringMap = new StringMap();
var comicGroups:Array<FlxTypedGroup> = [];
var indicator:FlxSprite;

typedef MiscStuff = {
    title:String,
    file:String,
    video:Bool
}

var miscGroup:Array<FlxTypedGroup> = [];
// var miscOrder = ['comic', 'redBLASTER.mp4'];
var miscOrder:Array<MiscStuff> = [
    // { title: "", file: "", video: false},
    
    { title: 'Roach\'s original concept art', file: 'roachconcept', video: false},
    { title: 'Roster', file: 'Comic', video: false },
    { title: 'Original V2 Poster Art', file: 'crunchinv2ogimage', video: false},
    { title: "Hope BG original concept", file: "hopeog", video: false},
    { title: 'Scrapped To Be Continued.. screen', file: 'tbc', video: false},
    { title: "Why the long face?", file: 'loong', video: true},
    { title: "The very first concept of Alert's visuals", file: 'originalalert', video: false},
    { title: "Grimjak's original design plan", file: 'grimjak_conceptoids', video: false},
    { title: "Originally planned visuals for Alert", file: 'alertreallyold', video: false},
    { title: "ScorchVX's concepts for Grimjak's poses", file: "scorchtrolljak", video: false},
    { title: "Scrapped iFunnyhell asset", file: "giygas", video: false},
    { title: "Very first concept for Legacy BG", file: "legacybgold", video: false},
    { title: 'Threat concept', file: 'poopconcept', video: false},
    { title: "Scrapped idea for Poopmadness's appearance in threat", file: "threatgiygas", video: false},
    { title: 'Poopmadness\' original design', file: 'original poop', video: false},
    { title: 'STOP STARING AT ME .....', file: 'stop starin at me with them big old eyes', video: true}
    { title: 'tumr : )', file: 'Tumor', video: false},
    { title: 'Idi concept design', file: 'idiconcept', video: false},
    { title: 'Original concept for Main Menu', file: 'menuconcept', video: false},
    { title: 'Original logo for V1', file: 'logo1', video: false},
    // { title: 'erm actually', file: 'erm', video: false},
    { title: 'Scrapped concept for Yolo\'s UI', file: 'yoloUI', video: false},
    { title: 'Concept art for Roach in Yolo', file: 'roachyoloconcept', video: false},
    { title: 'One of the first Gameplay WIPs of Yolo', file: 'firstyoloWIP', video: true},
    { title: 'WRONG!', file: 'redBLASTER', video: true},
    // { title: "Crunchin development", file: 'crunchindev', video: false}
];

var currentState = 'main';

var canSelect = false;
var updateX = true;
var curSelected = 0;
var curGroup = 0;

var camFollow:FlxObject;
var camFollowPos:FlxObject;
var resetPoint = (FlxG.width / 4) + 39;
var limits = [350, resetPoint];

var leftArrow:FlxSprite;
var rightArrow:FlxSprite;

function create(){

    camFollow = new FlxObject(FlxG.width / 2, resetPoint, 1, 1);
    camFollowPos = new FlxObject(FlxG.width / 2, resetPoint, 1, 1);
    FlxG.camera.follow(camFollowPos, FlxCameraFollowStyle.LOCKON, 1);

    leftArrow = new FlxSprite();
    leftArrow.frames = Paths.getSparrowAtlas('storymode/storyleftarrow');
    leftArrow.animation.addByPrefix('idle', 'storyleftarrow idle', 24, false);
    leftArrow.animation.addByPrefix('hover', 'storyleftarrow hover', 24, false);
    leftArrow.animation.addByPrefix('confirm', 'storyleftarrow select', 24, false);
    leftArrow.animation.play('idle');
    leftArrow.scale.set(0.5, 0.5);
    leftArrow.updateHitbox();
    leftArrow.screenCenter();
    leftArrow.x = (20);

    rightArrow = new FlxSprite();
    rightArrow.frames = Paths.getSparrowAtlas('storymode/storyrightarrow');
    rightArrow.animation.addByPrefix('idle', 'storyrightarrow idle', 24, false);
    rightArrow.animation.addByPrefix('hover', 'storyrightarrow hover', 24, false);
    rightArrow.animation.addByPrefix('confirm', 'storyrightarrow select', 24, false);
    rightArrow.animation.play('idle');
    rightArrow.scale.set(0.5, 0.5);
    rightArrow.updateHitbox();
    rightArrow.screenCenter();
    rightArrow.x = FlxG.width - rightArrow.width - 20;


    bg = new FlxSprite().loadGraphic(Paths.image('gallery/bg'));
    bg.scale.set(0.7, 0.7);
    bg.updateHitbox();
    bg.screenCenter();
    bg.scrollFactor.set();
    bg.antialiasing = ClientPrefs.globalAntialiasing;
    add(bg);

    fade = new FlxSprite().makeGraphic(1280, 720, FlxColor.BLACK);
    fade.scrollFactor.set();
    fade.screenCenter();
    fade.alpha = 0;
    add(fade);

    indicator = new FlxSprite().loadGraphic(Paths.image('gallery/comics/zoomguide'));
    indicator.scale.set(0.8, 0.8);
    indicator.updateHitbox();
    indicator.alpha = 0;
    indicator.x = FlxG.width - indicator.width - 40;
    indicator.antialiasing = ClientPrefs.globalAntialiasing;
    add(indicator);

    buttons = new FlxTypedGroup();
    add(buttons);

    var fuck2 = ['gComics', 'gMisc'];
    for(i in 0...fuck2.length){
        var fuck = new FlxSprite();
        fuck.frames = Paths.getSparrowAtlas('gallery/' + fuck2[i]);
        fuck.animation.addByPrefix('idle', fuck2[i] + ' unselect', 24, false);
        fuck.animation.addByPrefix('hover', fuck2[i] + ' select', 24, false);
        fuck.animation.play('idle');
        fuck.ID = i;
        fuck.alpha = 0;
        fuck.scale.set(0.95, 0.95);
        fuck.updateHitbox();
        fuck.antialiasing = ClientPrefs.globalAntialiasing;
        buttons.add(fuck);

        fuck.x = ((FlxG.width / 4) * (fuck.ID > 0 ? fuck.ID * 3 : 1)) - (fuck.width / 2);
        fuck.screenCenter(FlxAxes.Y);
    }

    comicsButtons = new FlxTypedGroup();
    add(comicsButtons);

    actualComics.set('CG', ['cgcomic1', 'cgcomic2', 'cgcomic3']);
    actualComics.set('Trl', ['trollcomic1', 'trollcomic2', 'trollcomic3']);
    actualComics.set('Epc', ['epiccomic1', 'epiccomic2', 'epiccomic3']);
    actualComics.set('TJak', ['trolljakcomic1']);
    actualComics.set('Ifu', ['ifucomic1', 'ifucomic2', 'ifucomic3']);
    actualComics.set('Poop', ['poopcomic1', 'poopcomic2', 'poopcomic3']);
    actualComics.set('Idi', ['idicomic1', 'idicomic2', 'idicomic3']);
    actualComics.set('Prov', ['provicomicuhm']);

    var rowNum = -1;
    var laneNum = -1;
    var perLane = 4;
    for(i in 0...comicSections.length){
        rowNum += 1;
        laneNum = Math.floor(i/perLane);
        if(rowNum >= perLane) rowNum = 0;

        var button = new FlxSprite(((FlxG.width / 8)) - 32.5, (FlxG.height / 8) - 25);
        button.frames = Paths.getSparrowAtlas('gallery/comics/GalComSel-' + comicSections[i]);
        button.animation.addByPrefix('locked', 'GalComSel-' + comicSections[i] + ' locked', 24, false);
        button.animation.addByPrefix('idle', 'GalComSel-' + comicSections[i] + ' unlock', 24, false);
        button.animation.play('idle');
        button.scale.set(0.5, 0.5);
        button.updateHitbox();
        button.ID = i;
        button.zIndex = i;
        button.antialiasing = ClientPrefs.globalAntialiasing;
        comicsButtons.add(button);

        button.visible = false;
        button.x += (300 * rowNum);
        button.y += (400 * laneNum) + 35;

        comicButtonPositions.push(FlxPoint.get(button.x, button.y));

        var comicGroup = new FlxTypedGroup();
        comicGroup.visible = false;
        add(comicGroup);
        comicGroups.push(comicGroup);

        // trace(actualComics.get)
        var counter = -1;
        for(fuckoff in actualComics.get(comicSections[i])){
            counter += 1;
            var sprite = new FlxSprite().loadGraphic(Paths.image('gallery/comics/actualcomics/'+ fuckoff));
            sprite.setGraphicSize(0, 720);
            sprite.updateHitbox();
            sprite.setPosition((FlxG.width - sprite.width) / 2, 0);
            sprite.ID = counter;
            sprite.alpha = 0;
            sprite.visible = false;
            sprite.antialiasing = ClientPrefs.globalAntialiasing;
            comicGroup.add(sprite);

            // if(counter != 0)
            //     sprite.setPosition(0, comicGroup.members[counter - 1].y + comicGroup.members[counter-1].height);
            // else
            //     sprite.setPosition(0, 0);

            sprite.y += 720;
        }
    }

    if(FlxG.random.bool(1)) 
        miscOrder.push({ title: 'RAAHHHHH', file: 'shrek', video: false});
    if(FlxG.random.bool(50)){
        miscOrder.push({ title: "Crunchin development", file: 'crunchindev', video: false});
    }

    for(i in 0...miscOrder.length){
        var parent = miscOrder[i];
        var group:FlxTypedGroup;
        if(i == 0 || i % 2 == 0) left = true;

        var sprite:FlxSprite;
        var video:FunkinVideoSprite;
        var title:FlxText;
        
        group = new FlxTypedGroup();
        add(group);
        miscGroup.push(group);
        
        if(!parent.video){
            sprite = new FlxSprite().loadGraphic(Paths.image('gallery/misc/' + parent.file));
            sprite.setGraphicSize(0, 500);
            sprite.updateHitbox();
            if(sprite.width > 1280){
                sprite.setGraphicSize(0, 300);
                // sprite.updateHitbox();
            }
            sprite.screenCenter();
            sprite.visible = false;
            sprite.ID = i;
            sprite.y += 50;
            sprite.antialiasing = ClientPrefs.globalAntialiasing;
            group.add(sprite);    

        }else{
            video = new FunkinVideoSprite();
            video.load(Paths.video('gallery/' + parent.file), [FunkinVideoSprite.looping]);
            video.addCallback('onFormat', ()->{
                video.setGraphicSize(0, 500);
                video.screenCenter();
                video.alpha = 1;
                video.ID = i;
                video.y += 50;
                video.antialiasing = ClientPrefs.globalAntialiasing;
            });
            video.addCallback('onStart', ()->{
                video.visible = true;
            });
            video.addCallback('onEnd', ()->{
                video.visible = false;
            });
            // video.play();
            // video.pause();
            group.add(video);
        }

        title = new FlxText(35, 40, 0, parent.title, 32);
        title.scrollFactor.set();
        title.setFormat(Paths.font("candy.otf"), 60, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        if(title.width > 1280)
            title.setFormat(Paths.font("candy.otf"), 48, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        title.screenCenter();
        title.y = 20;
        // title.updateHitbox();
        group.add(title);
        
        for(m in group.members) m.y += 720;
    }
        
    backbutton = new FlxSprite();
    backbutton.frames = Paths.getSparrowAtlas('backbutton', 'preload');
    backbutton.animation.addByPrefix('idle', 'backbutton idle', 24, false);
    backbutton.animation.addByPrefix('hover', 'backbutton hover', 24, false);
    backbutton.animation.addByPrefix('confirm', 'backbutton confirm', 24, false);
    backbutton.animation.play('idle');
    backbutton.scrollFactor.set();
    backbutton.setPosition(10, 10);
    backbutton.antialiasing = ClientPrefs.globalAntialiasing;
    add(backbutton);

    for(fuck in [rightArrow, leftArrow]){
        fuck.antialiasing = ClientPrefs.globalAntialiasing;
        fuck.alpha = 0;
        add(fuck);
    }


    transition = new FlxSprite();
    transition.frames = Paths.getSparrowAtlas('transition_out');
    transition.animation.addByPrefix('idle', 'transition_out idle', 60, false);
    transition.screenCenter();
    transition.scrollFactor.set();
    transition.scale.set(2.5, 2.5);
    transition.antialiasing = ClientPrefs.globalAntialiasing;

    add(transition);
    transition.animation.play('idle', false, true);



    setUpNewMenu('main', 0);
    // setUpNewMenu('comicsmain', 0);
}


var scale = 0.95;
var selectedSomethin:Bool = false;
var selectedSomething2:Bool = false;

function update(elapsed){

    // if(FlxG.keys.justPressed.R) FlxG.resetState();

    if(camFollowPos != null && camFollow != null){
        camFollowPos.x = FlxMath.lerp(camFollowPos.x, camFollow.x, elapsed * 3);
        camFollowPos.y = FlxMath.lerp(camFollowPos.y, camFollow.y, elapsed * 3);    
    }

    if(canSelect){
        switch(currentState){
            case 'main':
    
                if(buttons != null){
                    buttons.forEach((s)->{
            
                        if(s != null){                        
                            if(canSelect){
                                s.scale.x = FlxMath.lerp(s.scale.x, scale, elapsed * 12);
                                s.scale.y = FlxMath.lerp(s.scale.y, scale, elapsed * 12);            
                                s.screenCenter(FlxAxes.Y);
                                s.x = ((FlxG.width / 4) * (s.ID > 0 ? s.ID * 3 : 1)) - (s.width / 2);
                
                                if(FlxG.mouse.overlaps(s)){
                                    scale = 0.95;
                                    s.animation.play('hover');
                                    if(FlxG.mouse.justPressed && canSelect){
                                        // selectedSomethin = true;
                                        switch(s.ID){
                                            case 0:
                                                selectMenu('comicsmain', s.ID);
                                            case 1:
                                                selectMenu('misc', s.ID);
                                        }
                                    }
                                }else{
                                    scale = 1;
                                    s.animation.play('idle');    
                                }
                            }
                            // }else{
                            //     s.screenCenter(FlxAxes.Y);
                            //     if(updateX) s.x = ((FlxG.width / 4) * (s.ID > 0 ? s.ID * 3 : 1)) - (s.width / 2);
                            // }
                        }
                    });
                }
                    
            case 'comicsmain':
                if(canSelect){
                    comicsButtons.forEach((s)->{
                        if(FlxG.mouse.overlaps(s)){
                            s.scale.set(0.55, 0.55);
                            if(FlxG.mouse.justPressed)
                                selectMenu('comics', s.ID);
                        }
                        else
                            s.scale.set(0.5, 0.5);
                    });
                }
            case 'comics':
                if(canSelect){
                    if(FlxG.keys.pressed.CONTROL){
                        if(FlxG.mouse.wheel != 0){
                            FlxG.camera.zoom += (FlxG.mouse.wheel * 0.1);
    
                            if(controls.UI_UP_P)
                                FlxG.camera.zoom += 0.1;
                            if(controls.UI_DOWN_P)
                                FlxG.camera.zoom -= 0.1;
    
                            if(FlxG.camera.zoom < 1) FlxG.camera.zoom = 1;
                            if(FlxG.camera.zoom > 3) FlxG.camera.zoom = 3;
                        }
                        
                    }else{
                        if(FlxG.mouse.wheel != 0/* && FlxG.camera.zoom > 1*/)
                            camFollow.y += -(FlxG.mouse.wheel * 50);
    
                        if(controls.UI_UP)
                            camFollow.y -= 5;
                        if(controls.UI_DOWN)
                            camFollow.y += 5;
                    }    
    
    
                    if(FlxG.mouse.overlaps(leftArrow))
                    {
                        if(FlxG.mouse.justPressed){
                            leftArrow.animation.play('confirm', true);
                            changeComic(-1);
                        }else
                            leftArrow.animation.play('hover');   
    
                    }else leftArrow.animation.play('idle');
    
                    if(FlxG.mouse.overlaps(rightArrow)){
                        if(FlxG.mouse.justPressed){
                            rightArrow.animation.play('confirm', true);
                            changeComic(1);
                        }else
                            rightArrow.animation.play('hover');   
                    } else rightArrow.animation.play('idle');
                }
    
            case 'misc':
                if(FlxG.mouse.overlaps(leftArrow))
                {
                    if(FlxG.mouse.justPressed){
                        leftArrow.animation.play('confirm', true);
                        changeMisc(-1);
                    }else
                        leftArrow.animation.play('hover');   
    
                }else leftArrow.animation.play('idle');
    
                if(FlxG.mouse.overlaps(rightArrow)){
                    if(FlxG.mouse.justPressed){
                        rightArrow.animation.play('confirm', true);
                        changeMisc(1);
                    }else
                        rightArrow.animation.play('hover');   
                } else rightArrow.animation.play('idle');
    
        }
    
        if(FlxG.mouse.overlaps(backbutton) && canSelect)
            {
                backbutton.animation.play('hover');
        
                if(!selectedSomething2 && FlxG.mouse.pressed)
                {
                    selectedSomething2 = true;
        
                    FlxG.sound.play(Paths.sound('cancelMenu'));
                    switch(currentState){
                        case 'main':
                            transition.animation.play('idle', false, false);
                            transition.animation.finishCallback = ()->{FlxG.switchState(new MainMenuState());}
                        case 'comicsmain':
                            returnToMenu('comicsmain', 'main');
                        case 'comics':
                            returnToMenu('comics', 'comicsmain');
                        case 'misc':
                            returnToMenu('misc', 'main');
                    }
    
                    new FlxTimer().start(0.3, ()->{ selectedSomething2 = false; });
                }
            }
            else
            {
                backbutton.animation.play('idle');
            }    
    }
    
    if(camFollow.y > (limits[0] * (FlxG.camera.zoom)))
        camFollow.y = (limits[0] * (FlxG.camera.zoom));

    if(camFollow.y < (limits[1] / FlxG.camera.zoom))
        camFollow.y = (limits[1] / FlxG.camera.zoom);
}

var select2 = true;
function selectMenu(name, id){
    if(select2){
        FlxG.sound.play(Paths.sound('confirmMenu'));
        select2 = false;
        canSelect = false;

        switch(currentState){
            case 'main':
                buttons.forEach((s)->{
                    if(s.ID == id){
                        updateX = false;
                        FlxTween.tween(s, {x: (FlxG.width - s.width) / 2, "scale.x": 1.1, "scale.y": 1.1}, 0.5, {ease: FlxEase.quintOut, onComplete: ()->{
                            FlxTween.tween(s, {"scale.x": 0.75, "scale.y": 0.75, alpha: 0}, 0.5, {startDelay: 0.25, ease: FlxEase.quintIn});

                            new FlxTimer().start(0.8, setUpNewMenu(name, id));
                        }});
                    }
                    else
                        FlxTween.tween(s, {"scale.x": 0.6, "scale.y": 0.6, alpha: 0}, 0.25, {ease: FlxEase.quintIn});                
                });
            case 'comicsmain':
                var s = comicsButtons.members[id];
    
                FlxTween.tween(s, {x: (FlxG.width - s.width) / 2, y: (FlxG.height - s.height) / 2, "scale.x": 1, "scale.y": 1}, 0.5, {ease: FlxEase.quartOut, onComplete: ()->{
                    FlxTween.tween(s, {"scale.x": 0.25, "scale.y": 0.25, alpha: 0}, 0.5, {startDelay: 0.25, ease: FlxEase.quartIn, onComplete: setUpNewMenu(name, id) });
                }});
                comicsButtons.forEach((s)->{
                   if(s.ID != id) FlxTween.tween(s, {alpha: 0}, 0.25, {ease: FlxEase.quadOut});
                });
        }
    }
}

function setUpNewMenu(name, id){
    switch(name){
        case 'main':
            for(m in [leftArrow, rightArrow]){
                FlxTween.cancelTweensOf(m);
                m.alpha = 0;
            }
            buttons.forEach((fuck)->{
                fuck.alpha = 0;
                fuck.scale.set(0.6, 0.6);
                new FlxTimer().start(1, ()->{
                    FlxTween.tween(fuck.scale, {x: 0.95, y: 0.95}, 1, {startDelay: 0.06125 * fuck.ID, ease: FlxEase.quintOut, onUpdate: (t)->{
                        fuck.x = ((FlxG.width / 4) * (fuck.ID > 0 ? fuck.ID * 3 : 1)) - (fuck.width / 2);
                    }});
                    FlxTween.tween(fuck, {alpha: 1}, 1, {startDelay: 0.06125 * fuck.ID});
                    new FlxTimer().start(1.25, ()->{ 
                        canSelect = true;
                        select2 = true;
                    });
                });
            });
        case 'misc':
            curSelected = 0;
            miscGroup[0].visible = true;
            for(i in 0...miscGroup.length){
                var group = miscGroup[i];
                for(m in group.members){
                    if(i == 0) m.visible = true;
                    else m.visible = false;

                    var pos = 0;
                    if(Std.isOfType(m, FlxSprite) || Std.isOfType(m, FunkinVideoSprite))
                        pos = 150;
                    else if(Std.isOfType(m, FlxText))
                        pos = 20;

                    FlxTween.tween(m, {y: pos}, 1, {ease: FlxEase.quartOut});
                }
            }
            FlxTween.tween(fade, {alpha: 0.5}, 1);

            new FlxTimer().start(1.125, ()->{
                for(button in [leftArrow, rightArrow]) FlxTween.tween(button, {alpha: 1}, 1);

                canSelect = true;
                select2 = true;
            });

        case 'comicsmain':
            for(m in [leftArrow, rightArrow]){
                FlxTween.cancelTweensOf(m);
                m.alpha = 0;
            }
            // buttons.forEach((s)->{
            //     FlxTween.cancelTweensOf(s);
            //     s.alpha = 0;
            // });
            scale = 0.5;
            comicsButtons.forEach((s)->{

                new FlxTimer().start(0.25 + (0.125 * s.ID), ()->{
                    s.setPosition(comicButtonPositions[s.ID].x, comicButtonPositions[s.ID].y);

                    s.visible = true;
                    s.alpha = 1;
                    s.scale.set(0.325, 0.325);
                    s.updateHitbox();

                    FlxTween.tween(s.scale, {x: 0.5, y: 0.5}, 0.5, {ease: FlxEase.backOut});

                });
                new FlxTimer().start(1 + (0.125 * 8), ()->{ 
                    canSelect = true;
                    select2 = true;
                });
            });
        case 'comics':
            buttons.forEach((s)->{
                FlxTween.cancelTweensOf(s);
                s.alpha = 0;
            });
            curSelected = 0;
            curGroup = id;
            comicGroups[id].visible = true;
            for(fuck in comicGroups[id]){
                if(fuck.ID == 0) fuck.visible = true;
                else fuck.visible = false;
                FlxTween.tween(fuck, {y: fuck.y - 720, alpha: 1}, 1, {startDelay: 0.25, ease: FlxEase.quartOut});
            }
            new FlxTimer().start(0.26, ()->{ 
                canSelect = true;
                select2 = true;
            });

            FlxTween.tween(fade, {alpha: 0.5}, 1);
            FlxTween.tween(indicator, {alpha: 1}, 1);

            for(fuck in [leftArrow, rightArrow])
                FlxTween.tween(fuck, {alpha: 1}, 1);

    }

    currentState = name;
}

function returnToMenu(curName, newName){
    canSelect = false;

    switch(curName){
        case 'comicsmain':
            comicsButtons.forEach((s)->{
                // s.setPosition(comicButtonPositions[s.ID].x, comicButtonPositions[s.ID].y);

                FlxTween.tween(s, {"scale.x": 0.325, "scale.y": 0.325, alpha: 0}, 0.5, {startDelay: (0.125 * s.ID), ease: FlxEase.backIn});
                new FlxTimer().start((0.125 * 9), ()->{ setUpNewMenu(newName, 0); });
            });
        case 'comics':
            curSelected = 0;
            for(fuck in comicGroups){
                for(fucker in fuck.members){
                    if(fucker.ID == 0) fucker.visible = true;
                    FlxTween.tween(fucker, {y: 720, alpha: 0}, 0.5, {ease: FlxEase.quartIn, onComplete: setUpNewMenu(newName, 0)});
                }
            }
            FlxTween.tween(fade, {alpha: 0}, 0.5);
            FlxTween.tween(indicator, {alpha: 0}, 0.5);

            for(fuck in [leftArrow, rightArrow])
                FlxTween.tween(fuck, {alpha: 0}, 0.5, {ease: FlxEase.quartIn});
            FlxTween.num(camFollow.y, resetPoint, 0.5, {ease: FlxEase.quartIn, onUpdate: (t)->{ camFollow.y = t.value; }});
            FlxTween.num(FlxG.camera.zoom, 1, 0.5, {ease: FlxEase.quartIn, onUpdate: (t)->{ FlxG.camera.zoom = t.value; }});
        case 'misc':
            FlxTween.tween(fade, {alpha: 0}, 0.5);
            for(fuck in [leftArrow, rightArrow])
                FlxTween.tween(fuck, {alpha: 0}, 0.5, {ease: FlxEase.quartIn});

            for(i in 0...miscGroup.length){
                var group = miscGroup[i];
                for(m in group.members){
                    if(Std.isOfType(m, FunkinVideoSprite)) stopVideo(m);
                    FlxTween.tween(m, {y: m.y + 720}, 1, {ease: FlxEase.quartOut, onComplete: ()->{
                        m.visible = false;
                    }});
                }
            }

            // canSelect = true;
            new FlxTimer().start(1.06125, setUpNewMenu(newName, 0));
    }
}

var stopspamming = false;
function changeComic(change){
    if(comicGroups[curGroup].length > 1 && !stopspamming){
        stopspamming = true;
        FlxG.sound.play(Paths.sound('scrollMenu'));
        var prev = comicGroups[curGroup].members[curSelected];
        FlxTween.tween(prev, {y: (-prev.height * change), alpha: 0}, 0.325, {onComplete: ()->{prev.visible = false;}});
    
        curSelected += change;
        if(curSelected > (comicGroups[curGroup].length - 1)) curSelected = 0;
        if(curSelected < 0) curSelected = curSelected = (comicGroups[curGroup].length - 1);
    
    
        var cur = comicGroups[curGroup].members[curSelected];
        cur.y = (FlxG.height * change);
        cur.visible = true;
        cur.alpha = 0;
        FlxTween.tween(cur, {y: (FlxG.height - cur.height) / 2, alpha: 1}, 0.325, {onComplete: ()->{ stopspamming = false; }});
    }

}

var stopspamming2 = false;
var alreadyplaying = false;
function changeMisc(change){
    FlxG.sound.play(Paths.sound('scrollMenu'));
    if(miscGroup.length > 1 && !stopspamming2){
        stopspamming2 = true;

        var prev = miscGroup[curSelected];
        for(m in prev.members){
            m.visible = false;
            if(Std.isOfType(m, FunkinVideoSprite)) stopVideo(m);
        }

        curSelected += change;
        // if(curSelected > miscGroup.length) curSelected = 0;
        // trace(curSelected);
        if(curSelected > (miscGroup.length - 1)) curSelected = 0;
        if(curSelected < 0) curSelected = (miscGroup.length - 1);
        // trace(curSelected);

        var cur = miscGroup[curSelected];
        for(m in cur.members) {
            m.visible = true;
            m.alpha = 1;
            if(Std.isOfType(m, FunkinVideoSprite)) playVideo(m);
        }

        new FlxTimer().start(0.265, ()->{stopspamming2 = false;});
    }
}

function playVideo(video){
    if(video != null) {
        video.play();
        // video.visible = true;
    }

    FlxTween.cancelTweensOf(FlxG.sound.music);
    FlxTween.tween(FlxG.sound.music, {volume: 0}, 1);
}

function stopVideo(video){
    if(video!=null){
        video.pause();
        // video.visible = false;
    }

    // FlxTween.tween(video, {alpha: 0}, 0.25);

    FlxTween.cancelTweensOf(FlxG.sound.music);
    FlxTween.tween(FlxG.sound.music, {volume: 1}, 1);
}