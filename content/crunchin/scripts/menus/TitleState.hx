import funkin.states.MainMenuState;
import flixel.addons.transition.FlxTransitionableState;
import funkin.states.editors.HScriptState;
import funkin.states.TitleState;
import lime.graphics.Image;

var whyareyouback:Bool = false;
var closedState:Bool = false;
var normalScale:Float = 0.7;

var playbutton:FlxSprite;
var logo:FlxSprite;
var transition:FlxSprite;

function onCreatePost(){
    WindowUtil.setTitle("Friday Night Crunchin' - Browsing the menus");
}

typedef SongData =
{
    finished:Bool,
    fc:Bool
}

var songMap:StringMap = new StringMap();
var songs = ['crunch', 'milkyway', 'choke-a-lot', 'doubt', 'hope', 'reunion', 'smile', 'order-up', 'last-course', 'soundtest', 'alert', 'legacy', 'rumor', 'threat', 'rattled', 'crunchmix', 'yolo', 'harness', 'ravegirl'];

// porting old save stuff over to modern save format
var songsFC:StringMap;
var songsComplete:StringMap;

function onStartIntro(){
    if(FlxG.save.data.songsCompleteFNC != null)
        songsComplete = FlxG.save.data.songsCompleteFNC;
    else
        songsComplete = new StringMap();

    if(FlxG.save.data.songsFCFNC != null)
        songsFC = FlxG.save.data.songsFCFNC;
    else
        songsFC = new StringMap();

    for(song in songs){ 
        var FC = songsFC.get(song) == null ? false : songsFC.get(song);
        var FINISHED = songsComplete.get(song) == null ? false : songsComplete.get(song);

        songMap.set(song, {finished: FINISHED, fc: FC});
    }    
    
    if(FlxG.save.data.CrunchinSongData == null)
        FlxG.save.data.CrunchinSongData = songMap;

    trace(FlxG.save.data.CrunchinSongData);
    FlxG.save.flush();

    WindowUtil.setTitle("Friday Night Crunchin'");

    // var icon:Image = Image.fromFile(Paths.file('images/crunchinicon.ico'));
    // FlxG.stage.window.setIcon(icon);

    FlxG.mouse.visible = true;
    Paths.currentModDirectory = 'crunchin';
    FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
    FlxG.sound.music.fadeIn(4, 0, 0.7);
    Conductor.bpm = 110;

    TitleState.title = ['FRIDAY', 'NIGHT', "CRUNCHIN'"];
}

var logoTween:FlxTween;
function onBeatHit(){
    if(logo != null && curBeat % 2 == 0){
        if(logoTween != null)
        {
            logoTween.cancel();
        }
        logo.scale.set(normalScale - 0.025, normalScale - 0.025);

        logoTween = FlxTween.tween(logo, {"scale.x": normalScale, "scale.y": normalScale}, 1.25, {ease: FlxEase.quintOut, onComplete: function(twn:FlxTween){
            logoTween = null;
        }});
    }
}

function onSkipIntro(){ 
    Paths.currentModDirectory = 'crunchin';

    var randomBG = FlxG.random.int(1, 7);

    bg = new FlxSprite(0, 0).loadGraphic(Paths.image('titleBGs/' + randomBG));
    bg.antialiasing = ClientPrefs.globalAntialiasing;
    //bg.scale.set(FlxG.width, FlxG.height);
    //bg.updateHitbox();

    add(bg);

    logo = new FlxSprite().loadGraphic(Paths.image('logo'));
    logo.scale.set(normalScale, normalScale);
    logo.updateHitbox();
    logo.screenCenter();
    logo.y -= 75;
    logo.antialiasing = ClientPrefs.globalAntialiasing;
    add(logo);

    playbutton = new FlxSprite();
    playbutton.scrollFactor.set();
    playbutton.frames = Paths.getSparrowAtlas('playbutton');
    playbutton.animation.addByPrefix('idle', 'playbutton idle', 24, false);
    playbutton.animation.addByPrefix('hover', 'playbutton hover', 24, false);
    playbutton.animation.addByPrefix('confirm', 'playbutton confirm', 24, false);
    playbutton.animation.play('idle');
    playbutton.screenCenter();
    playbutton.y += 250;
    playbutton.antialiasing = ClientPrefs.globalAntialiasing;
    add(playbutton);

    transition = new FlxSprite();
    transition.frames = Paths.getSparrowAtlas('transition_out');
    transition.animation.addByPrefix('idle', 'transition_out idle', 60, false);
    transition.screenCenter();
    transition.scrollFactor.set();
    transition.scale.set(2.5, 2.5);
    transition.antialiasing = ClientPrefs.globalAntialiasing;
    add(transition);
    transition.visible = false;

}

var transitioning:Bool = false;

function onUpdate(elapsed){
    // if(FlxG.keys.justPressed.R) FlxG.resetState();    

    if(FlxG.sound.music != null)
        Conductor.songPosition = FlxG.sound.music.time;

    if(playbutton != null && playbutton.visible)
    {
        if(transitioning)
        {
            playbutton.animation.play('confirm');
        }
        else
        {
            if(FlxG.mouse.overlaps(playbutton))
            {
                playbutton.animation.play('hover');
                if(!transitioning && FlxG.mouse.pressed)
                {
                    FlxG.camera.flash(FlxColor.WHITE, 1);
                    FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
    
                    transitioning = true;
                    // FlxG.sound.music.stop();
    
                    FlxTransitionableState.skipNextTransIn = true;
                    FlxTransitionableState.skipNextTransOut = true;
    
                    transition.visible = true;
                    transition.animation.play('idle');
                    transition.animation.finishCallback  = ()->{
                        FlxG.switchState(new HScriptState('OiCunt'));
                        closedState = true;
                    }
                }
            }
            else
            {
                playbutton.animation.play('idle');
            }
        }
    }
}

function onEnter(){ return Function_Stop; }