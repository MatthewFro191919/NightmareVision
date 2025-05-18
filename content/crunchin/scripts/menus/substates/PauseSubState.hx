// import openfl.display.BlendMode;
import funkin.utils.CameraUtil;
import flixel.text.FlxText;
import funkin.backend.PlayerSettings;
import funkin.states.FreeplayState;
import funkin.states.StoryMenuState;
import flixel.addons.transition.FlxTransitionableState;

var controls = PlayerSettings.player1.controls;

var custom:Bool = true;
function customMenu(){ return custom; }

var cam = PlayState.instance.camOther;
var objects:FlxSpriteGroup;
var buttonMenu:FlxSpriteGroup;

var resumeButton:FlxSprite;
var restartButton:FlxSprite;
var exitButton:FlxSprite;
var songTitle:FlxSprite;
var levelInfo:FlxText;
var songName:String = '';
var transition:FlxSprite;

var bottom:Bool = false;
var right:Bool = false;

function addObject(path:String, scale:Float, id:Int = 0, flipSpr:Bool = false){
    var obj:FlxSprite = new FlxSprite().loadGraphic(Paths.image(path));
    obj.flipX = flipSpr;
    obj.scale.set(scale, scale);
    obj.updateHitbox();
    obj.screenCenter();
    obj.ID = id;
    objects.add(obj);
}

function onCreate(){
    if(!custom) return;
    WindowUtil.setTitle("Friday Night Crunchin' - Paused");

    bg = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
    bg.scrollFactor.set();
    bg.screenCenter();
    bg.alpha = 0.5;
    bg.camera = cam;
    add(bg);

    var path = 'pauseScreens/' + PlayState.SONG.song.toLowerCase() + '/';
    var suffix:String = "";
    var scale:Float = 0.68;
    var halfway:Bool = false;

    objects = new FlxSpriteGroup();
    objects.camera = cam;
    add(objects);

    switch(PlayState.SONG.song.toLowerCase()){
        case 'crunch':
            addObject(path + 'Cereal arrow Crunch', scale, 0, false);
            addObject(path + 'Crunch_Opponents_new', scale, 1, false);
        case 'milkyway':
            addObject(path + '/Milkway Pause screen Background', scale, -2, false);
            addObject(path + '/Cereal arrow Milkyway', scale, -1, false);
            addObject(path + '/cereal_droppings_behind', scale, 0, false);
            addObject(path + '/Milkyway Opponents', scale, 1, false);
            addObject(path + '/cereal_box_milyway', scale, 2, false);
        case 'choke-a-lot':
            if(PlayState.instance.curStep < 1367){
                addObject(path + '/Choke a Lot Opponents', scale, 1, false);
            }
            else{
                addObject(path + '/Choke a Lot Opponents Cereal guy dies lolololololol', scale, 0, false);
            }
            addObject(path + '/Cereal arrow Choke a Lot', scale, 0, false);
        case 'doubt':
            suffix = 'troll';
            addObject(path + '/doubtBG1', scale, 0, false);
            addObject(path + '/doubtBG2', scale, -1, false);
            addObject(path + '/doubtPLAYERS', scale, -1, false);
        case 'hope':
            suffix = 'troll';
            if(PlayState.instance.curStep < 272){
                addObject(path + '/doubtBG1', scale, 0, false);
                addObject(path + '/doubtBG2', scale, -1, false);
                addObject(path + '/doubtPLAYERS', scale, -1, false);
            }
            else if(PlayState.instance.curStep < 1040){
                addObject(path + '/Hope 2 Cloudes', scale, 1, false);
                addObject(path + '/Hope 2 magnet umbrella', scale, 0, false);
                addObject(path + '/Hope 2 Opponent player', scale, -1, false);
            }
            else if(PlayState.instance.curStep < 1216){
                addObject(path + '/Hope 3 ground', scale, -1, false);
                addObject(path + '/Hope 3 Clouds', scale, -2, false);
                addObject(path + '/Hope 3 Opponent player', scale, -1, false);
            }
            else{
                addObject(path + '/Hope 4 background', scale, -1, false);
                addObject(path + '/Hope 4 Clouds bottom', scale, -2, false);
                addObject(path + '/Hope 4 Clouds top', scale, -2, false);
                addObject(path + '/Hope 4 ground', scale, -1, false);
                addObject(path + '/Hope 4 Opponent player', scale, -1, false);
                addObject(path + '/Hope 4 Rain', scale, -2, false);
            }
        case 'reunion':
            suffix = 'troll';
            if(PlayState.instance.curStep < 1200){
                addObject(path + '/bg0', scale, 0, false);
                addObject(path + '/fg0', scale, 1, false);
            }
            else{
                addObject(path + '/bg1', scale, 0, false);
                addObject(path + '/Rest in peace Cereal guy', scale, 1, false);
            }
        case 'smile':
            suffix = 'epic';
            addObject(path + '/Smile Yellow for Panels Right Side', scale, 1, false);
            addObject(path + '/Shade white Right side', scale, 3, false);
            addObject(path + '/Smile Roach Panel Player', scale, 5, false);
            addObject(path + '/Smile Background Characters Panel', scale, 7, false);
            if(PlayState.instance.curStep < 400){
                addObject(path + '/Smile Awesome Faces Opponents', scale, 0, false);
            }
            else{
                addObject(path + '/Smile Awesome Faces 2 Opponents', scale, 0, false);
            }
        case 'order-up':
            suffix = 'epic';
            bottom = true;
            right = true;
            addObject(path + '/face light bottome', scale, -1, false);
            addObject(path + '/lone derp', scale, -1, false);
            addObject(path + '/Shine light top left', scale, 0, false);
            addObject(path + '/epic faces background', scale, 2, false);
            addObject(path + '/Awesome face opponent', scale, 4, false);
            addObject(path + '/Bf roach player new', scale, 5, false);
        case 'last-course':
            suffix = 'epic';
            if(PlayState.instance.curStep < 1744){
                bottom = true;
                addObject(path + '/stars and a reminiscent cereal bowl', scale, 0, false);
                addObject(path + '/4 star burger w an ifu', scale, 1, false);
                addObject(path + '/roach gronuf', scale, -1, false);
                addObject(path + '/opponent n player n distractions', scale, -1, false);
            }
            else if(PlayState.instance.curStep < 2128){
                bottom = true;
                addObject(path + '/air tight', scale, -1, false);
                addObject(path + '/dancin troupe', scale, -1, false);
                addObject(path + '/dancin smiley and roach', scale, 0, false);
            }
            else{
                addObject(path + '/secret end memory board', scale, 0, false);
                addObject(path + '/secret end cg w awesome face', scale, -1, false);
            }
        case 'crunchmix':
            bottom = true;
            addObject(path + '/wavy bg', scale, 0, false);
            addObject(path + '/side bar thing', scale, 0, false);
            addObject(path + '/cloud spill thing', scale, 1, false);
            addObject(path + '/tiny mic', scale, -1, false);
            addObject(path + '/cereal guy d', scale, -1, false);
            addObject(path + '/Roachh layin chillin', scale, 1, false);
        case 'ravegirl':
            suffix = 'rave';
            if(PlayState.instance.curStep < 464){
                addObject(path + '/RECORD SCr', scale, 0, false);
                addObject(path + '/bg character and development', scale, 1, false);
                addObject(path + '/piece of chucnk', scale, 0, false);
                addObject(path + '/couch', scale, -1, false);
                addObject(path + '/Cg and Epicface', scale, -1, false);    
            }else{
                bottom = true;
                addObject(path + '/2/dj epic face', scale, 0, false);
                addObject(path + '/2/cg and epicface', scale, 1, false);
            }
        case 'yolo':
            if(PlayState.instance.curStep < 384){
                //section 1
                addObject(path + 'Yolo 1/explode', scale, 1, false);
                addObject(path + 'Yolo 1/yea', scale, 0, false);
                addObject(path + 'Yolo 1/players', scale, 1, false);    
            }else if(PlayState.instance.curStep > 384 && PlayState.instance.curStep < 1280){
                // section 2
                bottom = true;
                addObject(path + '/Yolo 2/smoke', scale, 0, false);
                addObject(path + '/Yolo 2/smoke fire b', scale, 1, false);
                addObject(path + '/Yolo 2/target', scale, 2, false);
                addObject(path + '/Yolo 2/fuck yea car', scale, 1, false);
                addObject(path + '/Yolo 2/roach car', scale, 1, false);
            }else if(PlayState.instance.curStep > 1280 && PlayState.instance.curStep < 1500){
                bottom = true;
                suffix = 'weirdfuck';
                addObject(path + 'Yolo 3/blood ohh', scale, -2, false);
                addObject(path + 'Yolo 3/partern thing idk', scale, 0, false);
                addObject(path + 'Yolo 3/tunnel roach fuck yea', scale, 1, false);
            }else if(PlayState.instance.curStep > 1500){
                suffix = 'blast';
                addObject(path + 'Yolo 4/sides', scale, 0, false);
                addObject(path + 'Yolo 4/Shots', scale, 1, false);
            }
        case 'alert':
            suffix = 'alert';
            if(PlayState.instance.curStep < 1838){
                addObject(path + '/Background buildin', scale, -1, false);
                addObject(path + '/Alert_1_opponent_NEW', scale, 1, false);
                addObject(path + '/Alert 1 Player', scale, 2, false);
            }else{
                addObject(path + '/Background buildin', scale, -1, false);
                addObject(path + '/Building fire background', scale, -1, false);
                addObject(path + '/Alter 2 Opponent', scale, 0, false);
                addObject(path + '/Alert 2 Player', scale, 1, false);
                addObject(path + '/Dodge_24', scale, -1, false);
                addObject(path + '/fresh_light', scale, -2, false);
                objects.members[4].blend = BlendMode.DIFFERENCE;
            }
        case 'rattled':
            suffix = 'legacy';
            bottom = true;
            right = true;
            addObject(path + '/Pillar Up left corner', scale, 0, false);
            addObject(path + '/Rattled Helletons & Doot Opponents', scale, -1, false);
            addObject(path + '/Pillar Down right corner', scale, 1, false);
            addObject(path + '/Rattled Helletons 1 Opponents', scale, -1, false);
            addObject(path + '/Rattled Witch Ifu Player Side', scale, 2, false);
        case 'legacy':
            suffix = 'legacy';
            bottom = true;
            if(PlayState.instance.curStep < 1104){
                addObject(path + '/Ifunny Pillar Left side', scale, 0, false);
                addObject(path + '/Ifunny Pillar Right side', scale, 1, false);
                addObject(path + '/Legacy Trolljak Opponents NEW', scale, -1, false);
                addObject(path + '/Ifunny pillar up close', scale, 2, false);
                addObject(path + '/fire fire', scale, -1, false);
                objects.members[4].blend = BlendMode.MULTIPLY;
            }
            else
            {
                addObject(path + '/Ifunny Pillar (Ifu Part) Left side', scale, 0, false);
                addObject(path + '/Ifunny Pillar (Ifu Part) Right Side', scale, 1, false);
                addObject(path + '/Legacy Ifu Opponents New', scale, -1, false);
                addObject(path + '/Ifunny pillar up close', scale, 2, false);
                addObject(path + '/ifu blend', scale, -2, false);
                addObject(path + '/fire fire', scale, -1, false);
                objects.members[4].blend = BlendMode.MULTIPLY;
            }
        case 'threat':
            suffix = 'legacy';
            if(PlayState.instance.curStep < 512){
                addObject(path + '/Pillar Behind Opponents', scale, 0, false);
                addObject(path + '/THREAT PoopMad Opponents', scale, -1, false);
                addObject(path + '/Poop Pillar Madness', scale, 1, false);
                addObject(path + '/Wood', scale, 2, false);
            }
            else{
                right = true;
                addObject(path + '/Pillar Ifu Smile Left', scale, 0, false);
                addObject(path + '/Pillar Ifu Smile Right', scale, 1, false);
                addObject(path + '/THREAT PoopMad with Ifu Smile Opponents', scale, -1, false);
                addObject(path + '/Poopshit Up', scale, -2, false);
                addObject(path + '/Wood', scale, 3, true);
            }
        case 'rumor':
            suffix = 'rumor';
            if(PlayState.instance.curStep < 1952) // normal idi
            {
                addObject(path + '/rumorIDI', scale, 1, false);
                addObject(path + '/bf_rumor', scale, 0, false);
            }
            else if(PlayState.instance.curStep < 2208) // breakcore section
            {
                addObject(path + '/Rumor BREAKDOWN Opponents', scale, 0/*, BlendMode.ADD*/, false);
            }
            else if(PlayState.instance.curStep < 2720) // boyfriend lost control
            {
                addObject(path + '/static blue rumor bf part (Dodge)', scale, 0, false);
                addObject(path + '/Rumor Glitched BF Opponents', scale, 1, false);
                objects.members[0].blend = BlendMode.DIFFERENCE;
            }
            else
            {
                suffix = 'rumor2';
                addObject(path + '/Rumor IAMGOD Background Noise (27 Opacity)', scale, -1, false);
                addObject(path + '/Rumor GOD IDIS Background Characters', scale, 1, false);
                addObject(path + '/Rumor IAMGOD Opponents', scale, 2, false);
                addObject(path + '/Rumor IAMGOD Player', scale, 3, false);
            }
        case 'soundtest':
            halfway = true;
            addObject(path + '/Arrow point up', scale, -1, false);
            addObject(path + '/Soundtest REMIX Cereal guy Opponents', scale, -1, false);
            addObject(path + '/cereal pop up', scale, -1, false);
    }

    for(i in 0...objects.members.length) //-1 comes up from the y, -2 comes from alpha, anyhting else is just the order
    {
        var x:Float = objects.members[i].x;
        var y:Float = objects.members[i].y;
        var _id = objects.members[i].ID;

        if(_id == -1){
            objects.members[i].y += FlxG.height;
        }
        else if(_id == -2)
        {
            objects.members[i].alpha = 0;
        }
        else{
            objects.members[i].alpha = 1;
            objects.members[i].x += (FlxG.width) * ((objects.members[i].ID % 2 == 0) ? -1 : 1);
        }

        if(_id < 0){
            _id = 0;
        }

        FlxTween.tween(objects.members[i], {x: x, y: y, alpha: 1}, 0.75, {ease: FlxEase.quintOut, startDelay: 0.05 * _id});
    }

    buttonMenu = new FlxSpriteGroup();
    buttonMenu.camera = cam;
    add(buttonMenu);

    var path = 'pauseScreens/buttons';

    resumeButton = new FlxSprite();
    resumeButton.frames = Paths.getSparrowAtlas(path + '/resumeButton'+ suffix);
    resumeButton.animation.addByPrefix('normal', 'resumeButton' + suffix + ' normal', 0, false);
    resumeButton.animation.addByPrefix('hover', 'resumeButton' + suffix + ' hover', 0, false);
    resumeButton.animation.play('normal');
    resumeButton.ID = 0;
    buttonMenu.add(resumeButton);

    restartButton = new FlxSprite();
    restartButton.frames = Paths.getSparrowAtlas(path + '/restartButton'+ suffix);
    restartButton.animation.addByPrefix('normal', 'restartButton' + suffix + ' normal', 0, false);
    restartButton.animation.addByPrefix('hover', 'restartButton' + suffix + ' hover', 0, false);
    restartButton.animation.play('normal');
    restartButton.ID = 1;
    buttonMenu.add(restartButton);

    exitButton = new FlxSprite();
    exitButton.frames = Paths.getSparrowAtlas(path + '/exitButton'+ suffix);
    exitButton.animation.addByPrefix('normal', 'exitButton' + suffix + ' normal', 0, false);
    exitButton.animation.addByPrefix('hover', 'exitButton' + suffix + ' hover', 0, false);
    exitButton.animation.play('normal');
    exitButton.ID = 2;
    buttonMenu.add(exitButton);

    songTitle = new FlxSprite().loadGraphic(Paths.image('pauseScreens/SongTitle'));
    songTitle.x = -songTitle.width;
    songTitle.camera = cam;
    add(songTitle);

    if(PlayState.chartingMode){
        var disclaimer = new FlxText(5, FlxG.height, 0, "use keyboard for the buttons on the left there :D", 16);
        disclaimer.setFormat(Paths.font("candy.otf"), 16, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        disclaimer.screenCenter(FlxAxes.X);
        FlxTween.tween(disclaimer, {y: FlxG.height - disclaimer.height}, 1, {ease: FlxEase.quadOut});
        add(disclaimer);
    }

    levelInfo = new FlxText(35, 40, 0, "", 32);
    levelInfo.text += PlayState.SONG.song.toLowerCase();
    levelInfo.scrollFactor.set();
    levelInfo.setFormat(Paths.font("candy.otf"), 60, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    levelInfo.x = -levelInfo.width;
    FlxTween.tween(songTitle, {x: 0}, 0.4, {ease: FlxEase.quintOut});
    FlxTween.tween(levelInfo, {x: 35}, 0.4, {startDelay: 0.2, ease: FlxEase.quintOut});
    levelInfo.updateHitbox();
    levelInfo.camera = cam;
    add(levelInfo);

    var count:Int = 0;
    for(obj in buttonMenu.members){
        obj.scale.set(0.75, 0.75);
        obj.updateHitbox();

        obj.x = (!right) ? -obj.width : FlxG.width;
        var targetX = ((!right) ? 10 : FlxG.width - obj.width - 10);
        if(halfway){
            targetX = (FlxG.width - obj.width) / 2;
        }
        FlxTween.tween(obj, {x: targetX}, 0.4, {startDelay: 0.05 + (count * 0.1), ease: FlxEase.quadOut});
        //obj.x = 10;
        obj.y = 150 + ((obj.height + 5) * obj.ID);
        if(bottom){
            obj.y = 400 + ((obj.height + 5) * obj.ID);
        }
        count+=1;
    }
    transition = new FlxSprite();
    transition.frames = Paths.getSparrowAtlas('transition_out');
    transition.animation.addByPrefix('idle', 'transition_out idle', 60, false);
    transition.screenCenter();
    transition.scrollFactor.set();
    transition.scale.set(2.5, 2.5);
    transition.visible = false;
    transition.camera = cam;
    add(transition);
}

function isOverlapping(spr){
    var mousePos:FlxPoint = new FlxPoint(0, 0);
    FlxG.mouse.getPositionInCameraView(cam, mousePos);
    var sprPos:FlxPoint = spr.getPosition();

    var overlap = (mousePos.x > sprPos.x && mousePos.x < sprPos.x + spr.width && mousePos.y > sprPos.y && mousePos.y < sprPos.y + spr.height);
    return overlap;
}

var accepted2:Bool = false;
function onUpdate(elapsed){
    if(!custom) return;

    FlxG.mouse.visible = true;
    // if(FlxG.keys.justPressed.R) FlxG.resetState();
    if(FlxG.keys.justPressed.ENTER) coolerClose();

    var upP = controls.UI_UP_P;
    var downP = controls.UI_DOWN_P;
    var accepted = controls.ACCEPT;

    buttonMenu.forEach(function(spr:FlxSprite){
        if(isOverlapping(spr)){
            spr.animation.play('hover', true);

            if(!accepted2 && !accepted && FlxG.mouse.justPressed){
                accepted2 = true;

                FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
                FlxTransitionableState.skipNextTransIn = true;
                FlxTransitionableState.skipNextTransOut = true;

                switch(spr.ID){
                    default:
                        FlxG.mouse.visible = false;
                        coolerClose();
                    case 1:
                        transition.visible = true;
                        transition.animation.play('idle', false, false);
                        transition.animation.finishCallback = ()->{ new FlxTimer().start(1, this.restartSong); }
                    case 2:
                        PlayState.deathCounter = 0;
                        PlayState.seenCutscene = false;
                        FlxG.sound.playMusic(Paths.music('freakyMenu'));

                        transition.visible = true;
                        transition.animation.play('idle', false, false);
                        transition.animation.finishCallback = ()->{ new FlxTimer().start(1, ()->{
                            if(PlayState.isStoryMode) {
                                FlxG.switchState(new StoryMenuState());
                            } else {
                                FlxG.switchState(new FreeplayState());
                            }
                            PlayState.changedDifficulty = false;
                            PlayState.chartingMode = false;
    
                        }); }
                }
            }
        }
        else
        {
            spr.animation.play('normal', true);
        }
    });
}

var can = true;
function coolerClose(){
    // if(!can) close();

    if(can){
        can = false;
        for(i in 0...objects.members.length)
            FlxTween.tween(objects.members[i], {"scale.x": 2, "scale.y": 2, alpha: 0}, 0.75, {ease: FlxEase.quintIn});
    
        for(i in 0...buttonMenu.members.length)
            FlxTween.tween(buttonMenu.members[i], {x: right ? FlxG.width : -buttonMenu.members[i].width}, 0.75, {startDelay: 0.05 * (3 - i), ease: FlxEase.quintIn});
    
        // for(fuck in [songTitle, levelInfo])
        FlxTween.tween(songTitle, {x: -songTitle.width}, 0.75, {ease: FlxEase.quintIn, startDelay: 0.2});
        FlxTween.tween(levelInfo, {x: (-songTitle.width) + ((songTitle.width - levelInfo.width) / 2)}, 0.75, {startDelay: 0.2, ease: FlxEase.quintIn});
    
        FlxTween.tween(bg, {alpha: 0}, 0.9);
    
        new FlxTimer().start(1, ()->{
            var objs = [songTitle, levelInfo, bg];
            for(m in objects) objs.push(m);
            for(m in buttonMenu) objs.push(m);
    
            for(m in objs) m.destroy();
            
            WindowUtil.setTitle("Friday Night Crunchin' - Playing [ " + PlayState.SONG.song.toUpperCase() + " ]");
            close();
        });
    }
}