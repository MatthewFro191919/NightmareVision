import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.addons.display.FlxBackdrop;
import flixel.effects.FlxFlicker;
import funkin.data.WeekData;
import funkin.objects.MenuCharacter;
import funkin.objects.MenuItem;
import flixel.text.FlxText;
import funkin.utils.DifficultyUtil;
import funkin.backend.PlayerSettings;
import funkin.data.Highscore;
import funkin.states.MainMenuState;
import funkin.states.LoadingState;
import funkin.states.FreeplayState;

var controls = PlayerSettings.player1.controls;

var weekCompleted:StringMap = new StringMap();

var scoreText:FlxText;

var lastDifficultyName:String = '';
var curDifficulty:Int = 1;

var txtWeekTitle:FlxText;
var bgSprite:FlxSprite;

var curWeek:Int = 0;

var txtTracklist:FlxText;

var fileNames:Array<String> = ['StorymodeCG', 'StorymodeTrollface', 'StorymodeEpicFace'];
var fileNames2:Array<String> = ['StorymodeCGSongs', 'TrollSongs', 'EpicSongs'];

var characters:Array<String> = ['menu-cg', 'menu-depresstroll', 'menu-ef'];

var grpWeekText:FlxTypedGroup;
var grpWeekCharacters:FlxTypedGroup;

var grpLocks:FlxTypedGroup;

var difficultySelectors:FlxGroup;
var sprDifficulty:FlxSprite;
var leftArrow:FlxSprite;
var rightArrow:FlxSprite;

var loadedWeeks:Array<WeekData> = [];

var cg_bg:FlxBackdrop;
var cg_currentWeek:FlxSprite;
var cg_songs:FlxSprite;
var cg_playbutton:FlxSprite;
var cg_storyscore:FlxSprite;
var transition:FlxSprite;

var curCharacter:FlxSprite;
var backbutton:FlxSprite;

function create(){
    Paths.currentModDirectory = 'crunchin';

    if(curWeek >= WeekData.weeksList.length) curWeek = 0;
    persistentUpdate = persistentDraw = true;

    scoreText = new FlxText(10, 10, 0, "SCORE: 49324858", 36);
    scoreText.screenCenter(FlxAxes.X);
    scoreText.x += 450;
    scoreText.setFormat("VCR OSD Mono", 32);

    transition = new FlxSprite();
    transition.frames = Paths.getSparrowAtlas('transition_out');
    transition.animation.addByPrefix('idle', 'transition_out idle', 60, false);
    transition.screenCenter();
    transition.scrollFactor.set();
    transition.scale.set(2.5, 2.5);
    transition.animation.play('idle', false, true);

    var scale = 0.5;
    cg_bg = new FlxBackdrop(Paths.image('storymode/StorymodeBG'), FlxAxes.XY, 0, 0);
    cg_bg.screenCenter();
    // cg_bg.velocity.set(50,-50);
    cg_bg.scale.set(0.25,0.25);
    add(cg_bg);
    
    cg_currentWeek = new FlxSprite().loadGraphic(Paths.image('storymode/StorymodeCG'));
    cg_currentWeek.screenCenter();
    cg_currentWeek.scale.set(0.425, 0.425);
    cg_currentWeek.x -= 75;
    add(cg_currentWeek);

    cg_songs = new FlxSprite().loadGraphic(Paths.image('storymode/StorymodeCGSongs'));
    cg_songs.screenCenter();
    cg_songs.scale.set(scale, scale);
    add(cg_songs);

    cg_playbutton = new FlxSprite();
    cg_playbutton.frames = Paths.getSparrowAtlas('storymode/play');
    cg_playbutton.animation.addByPrefix('idle', 'play_idle', 24, false);
    cg_playbutton.animation.addByPrefix('select', 'play_select', 24, false);
    cg_playbutton.animation.play('idle');
    cg_playbutton.updateHitbox();
    cg_playbutton.screenCenter();
    cg_playbutton.scale.set(scale, scale);
    cg_playbutton.x += 375;
    cg_playbutton.y -= 15;
    add(cg_playbutton);

    cg_storyscore = new FlxSprite().loadGraphic(Paths.image('storymode/StorymodeScore'));
    cg_storyscore.screenCenter();
    cg_storyscore.scale.set(0.425, 0.425);
    cg_storyscore.x += 50;
    cg_storyscore.y -= 25;
    add(cg_storyscore);

    leftArrow = new FlxSprite();
    leftArrow.frames = Paths.getSparrowAtlas('storymode/storyleftarrow');
    leftArrow.animation.addByPrefix('idle', 'storyleftarrow idle', 24, false);
    leftArrow.animation.addByPrefix('hover', 'storyleftarrow hover', 24, false);
    leftArrow.animation.addByPrefix('confirm', 'storyleftarrow select', 24, false);
    leftArrow.animation.play('idle');
    leftArrow.scale.set(0.25, 0.25);
    leftArrow.updateHitbox();
    leftArrow.screenCenter();
    leftArrow.x -= 580;

    rightArrow = new FlxSprite();
    rightArrow.frames = Paths.getSparrowAtlas('storymode/storyrightarrow');
    rightArrow.animation.addByPrefix('idle', 'storyrightarrow idle', 24, false);
    rightArrow.animation.addByPrefix('hover', 'storyrightarrow hover', 24, false);
    rightArrow.animation.addByPrefix('confirm', 'storyrightarrow select', 24, false);
    rightArrow.animation.play('idle');
    rightArrow.scale.set(0.25, 0.25);
    rightArrow.updateHitbox();
    rightArrow.screenCenter();
    rightArrow.x -= 25;

    add(rightArrow);
    add(leftArrow);
    
    curCharacter = new FlxSprite();
    curCharacter.frames = Paths.getSparrowAtlas('storymode/' + characters[0]);
    curCharacter.animation.addByPrefix('idle', characters[0] + ' idle', 24, false);
    curCharacter.animation.play('idle');
    curCharacter.scale.set(0.4, 0.4);
    curCharacter.screenCenter();
    curCharacter.x -= 325;

    add(curCharacter);

    backbutton = new FlxSprite();
    backbutton.frames = Paths.getSparrowAtlas('backbutton');
    backbutton.animation.addByPrefix('idle', 'backbutton idle', 24, false);
    backbutton.animation.addByPrefix('hover', 'backbutton hover', 24, false);
    backbutton.animation.addByPrefix('confirm', 'backbutton confirm', 24, false);
    backbutton.animation.play('idle');
    backbutton.scrollFactor.set();
    backbutton.setPosition(10, 10);
    add(backbutton);
    add(scoreText);
    add(transition);


    WeekData.reloadWeekFiles();
    

    var num:Int = 0;
    for (i in 0...WeekData.weeksList.length)
    {
        var weekFile:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[i]);
        loadedWeeks.push(weekFile);
        num+=1;
    }

}

var fuckoff = false;
function beatHit(){
    if(curCharacter != null){
        if(curCharacter.animation.exists('idle'))
        {
            curCharacter.animation.play('idle');
        }else{
            fuckoff = !fuckoff;
            if(fuckoff)
                curCharacter.animation.play('danceLeft');
            else
                curCharacter.animation.play('danceRight');            
        }
        
    }

}
var lerpScore:Int = 0;
var intendedScore:Int = 0;
var movedBack:Bool = false;
var selectedWeek:Bool = false;
var stopspamming:Bool = false;
var clicked = false;

function update(elapsed){
    // if(FlxG.keys.justPressed.R) FlxG.resetState();

    if (FlxG.sound.music != null)
        Conductor.songPosition = FlxG.sound.music.time;

    FlxG.mouse.visible = true;

    if(cg_bg != null){
        cg_bg.x += 0.5;
        cg_bg.y -= 0.5;
    }
    lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, FlxMath(elapsed * 30, 0, 1)));
    if(Math.abs(intendedScore - lerpScore) < 10) lerpScore = intendedScore;

    scoreText.text = "WEEK SCORE:" + lerpScore;

    if (!movedBack && !selectedWeek)
    {
        var upP = controls.UI_UP_P;
        var downP = controls.UI_DOWN_P;

        if(FlxG.mouse.overlaps(leftArrow))
        {
            if(clicked)
            {
                leftArrow.animation.play('confirm');
            }
            else
            {
                leftArrow.animation.play('hover');
            }

            if(FlxG.mouse.pressed && !clicked)
            {
                clicked = true;

                leftArrow.animation.play('confirm');

                changeWeek(-1);
                FlxG.sound.play(Paths.sound('scrollMenu'));
            }
        }
        else
        {
            leftArrow.animation.play('idle');
        }

        if(FlxG.mouse.overlaps(rightArrow))
        {
            if(clicked)
            {
                rightArrow.animation.play('confirm');
            }
            else
            {
                rightArrow.animation.play('hover');
            }

            if(FlxG.mouse.pressed && !clicked)
            {
                clicked = true;

                rightArrow.animation.play('confirm');

                changeWeek(1);
                FlxG.sound.play(Paths.sound('scrollMenu'));
            }
        }
        else
        {
            rightArrow.animation.play('idle');
        }

        if(clicked && !FlxG.mouse.pressed)
        {
            clicked = false;
        }

        /*if (controls.UI_RIGHT)
            rightArrow.animation.play('press')
        else
            rightArrow.animation.play('idle');
        if (controls.UI_LEFT)
            leftArrow.animation.play('press');
        else
            leftArrow.animation.play('idle');
        
        if (controls.UI_RIGHT_P)
            changeDifficulty(1);
        else if (controls.UI_LEFT_P)
            changeDifficulty(-1);
        else if (upP || downP)
            changeDifficulty();
        */

        if(FlxG.mouse.overlaps(cg_playbutton) && FlxG.mouse.pressed)
        {
            selectWeek();
        }

        // if(FlxG.keys.justPressed.CONTROL)
        // {
        //     persistentUpdate = false;
        //     openSubState(new GameplayChangersSubstate());
        // }
        // else if(controls.RESET)
        // {
        //     persistentUpdate = false;
        //     openSubState(new ResetScoreSubState('', curDifficulty, '', curWeek));
        //     //FlxG.sound.play(Paths.sound('scrollMenu'));
        // }
    }

    if(movedBack)
    {
        backbutton.animation.play('confirm');
    }
    else
    {
        if(FlxG.mouse.overlaps(backbutton))
        {
            backbutton.animation.play('hover');

            if(!movedBack && !selectedWeek && FlxG.mouse.pressed)
            {
                movedBack = true;

                FlxTransitionableState.skipNextTransIn = true;
                
                FlxG.sound.play(Paths.sound('cancelMenu'));
                transition.animation.play('idle');

                new FlxTimer().start(1, function(tmr:FlxTimer)
                {
                    FlxG.switchState(new MainMenuState());
                });
            }
        }
        else
        {
            backbutton.animation.play('idle');
        }
    }
}

function changeWeek(change:Int = 0):Void
{
    curWeek += change;

    if (curWeek >= characters.length)
        curWeek = 0;
    if (curWeek < 0)
        curWeek = characters.length - 1;

    var leWeek:WeekData = loadedWeeks[curWeek];
    var leName:String = leWeek.storyName;

    var bullShit:Int = 0;

    PlayState.storyWeek = curWeek;

    DifficultyUtil.difficulties = DifficultyUtil.defaultDifficulties.copy();
    var diffStr:String = WeekData.getCurrentWeek().difficulties;

    if(diffStr != null && diffStr.length > 0)
    {
        var diffs:Array<String> = diffStr.split(',');
        var i:Int = diffs.length - 1;
        while (i > 0)
        {
            if(diffs[i] != null)
            {
                diffs[i] = diffs[i].trim();
                if(diffs[i].length < 1) diffs.remove(diffs[i]);
            }
            --i;
        }

        if(diffs.length > 0 && diffs[0].length > 0)
        {
            DifficultyUtil.difficulties = diffs;
        }
    }
    
    if(DifficultyUtil.difficulties.contains(DifficultyUtil.defaultDifficulty))
    {
        curDifficulty = Math.round(Math.max(0, DifficultyUtil.defaultDifficulties.indexOf(DifficultyUtil.defaultDifficulty)));
    }
    else
    {
        curDifficulty = 0;
    }

    var newPos:Int = DifficultyUtil.difficulties.indexOf(lastDifficultyName);

    if(newPos > -1)
    {
        curDifficulty = newPos;
    }

    var path = Paths.image('storymode/' + fileNames[curWeek]);
    var path2 = Paths.image('storymode/' + fileNames2[curWeek]);

    if(path != null)
    {
        cg_currentWeek.loadGraphic(path);
    }

    if(path2 != null)
    {
        cg_songs.loadGraphic(path2);
    }

    var path3 = Paths.getSparrowAtlas('storymode/' + characters[curWeek]);

    if(path3 != null)
    {
        curCharacter.frames = path3;
        if(curCharacter.animation.exists('idle') || curCharacter.animation.exists('danceLeft') || curCharacter.animation.exists('danceRight'))
            curCharacter.animation.remove('idle');
            curCharacter.animation.remove('danceLeft');
            curCharacter.animation.remove('danceRight');
            switch(characters[curWeek]){
                case 'menu-ef':
                    curCharacter.animation.addByPrefix('danceLeft', characters[curWeek] + ' danceLeft', 14, false);
                    curCharacter.animation.addByPrefix('danceRight', characters[curWeek] + ' danceRight', 14, false);

                    curCharacter.animation.play('danceRight');

                    curCharacter.screenCenter();
                    curCharacter.x -= 280;
                default:
                    curCharacter.animation.addByPrefix('idle', characters[curWeek] + ' idle', 24, false);

                    curCharacter.animation.play('idle');

                    curCharacter.screenCenter();
                    curCharacter.x -= 325;
            }
    }

    updateText();
}

function updateText()
{
    var weekArray:Array<String> = loadedWeeks[curWeek].weekCharacters;

    var leWeek:WeekData = loadedWeeks[curWeek];
    var stringThing:Array<String> = [];
    for (i in 0...leWeek.songs.length) {
        stringThing.push(leWeek.songs[i][0]);
    }

    intendedScore = Highscore.getWeekScore(loadedWeeks[curWeek].fileName, curDifficulty);
}

function selectWeek()
{
    if (stopspamming == false)
    {
        FlxG.sound.play(Paths.sound('confirmMenu'));
        cg_playbutton.animation.play('select'); 
        FlxFlicker.flicker(cg_playbutton, 1, 0.15, true);
        stopspamming = true;
    }

    FlxTransitionableState.skipNextTransIn = true;
    FlxTransitionableState.skipNextTransOut = true;
    
    // We can't use Dynamic Array .copy() because that crashes HTML5, here's a workaround.
    var songArray:Array<String> = [];
    var leWeek:Array<Dynamic> = loadedWeeks[curWeek].songs;
    for (i in 0...leWeek.length)
    {
        songArray.push(leWeek[i][0]);
    }

    // Nevermind that's stupid lmao
    PlayState.storyPlaylist = songArray;
    PlayState.isStoryMode = true;
    selectedWeek = true;

    DifficultyUtil.reset();
    var diffic = DifficultyUtil.getDifficultyFilePath(2);
    if (diffic == null) diffic = '';

    PlayState.storyDifficulty = 2;

    var songLowercase = Paths.formatToSongPath(PlayState.storyPlaylist[0].toLowerCase());

    PlayState.SONG = Song.loadFromJson(songLowercase + '-hard', songLowercase);
    PlayState.campaignScore = 0;
    PlayState.campaignMisses = 0;

    new FlxTimer().start(0.25, ()->{
        transition.animation.play('idle', false, false);
        transition.animation.finishCallback = ()->{
            new FlxTimer().start(1, function(tmr:FlxTimer) {
                LoadingState.loadAndSwitchState(new PlayState(), true);
                // FreeplayState.destroyFreeplayVocals();
            });
        }
    });
}