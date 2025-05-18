import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.addons.display.FlxBackdrop;
import funkin.states.MainMenuState;
import funkin.states.LoadingState;
import flixel.addons.transition.FlxTransitionableState;
import funkin.states.editors.HScriptSubstate;

var bg:FlxBackdrop;
var trophies:FlxTypedGroup;

var curSelected:Int = 0;
var text:FlxText;

var transition:FlxSprite;

var leftArrow:FlxSprite;
var rightArrow:FlxSprite;

var backbutton:FlxSprite;

var defaultSongs:Array<String> = ['cerealweek', 'trollguy', 'epicweek', 'soundtest', 'legacy', 'threat', 'rumor', 'rattled', 'alert', 'crunchmix', 'ravegirl', 'yolo'];
var songs:Array<String> = [];

function create(){
    Paths.currentModDirectory = 'crunchin';

    songs = defaultSongs.copy();
    curSelected = (Std.int(songs.length / 2) % 2 == 0) ? Std.int(songs.length / 2) : Std.int(songs.length / 2) - 1;

    bg = new FlxBackdrop(Paths.image('awards/achievement-loop'), FlxAxes.X, 0, 0);
    bg.scale.set(1, 1);
    bg.screenCenter();
    bg.scrollFactor.set();
    bg.antialiasing = ClientPrefs.globalAntialiasing;
    add(bg);

    trophies = new FlxTypedGroup();
    add(trophies);

    for(i in 0...songs.length)
    {
        var name = (songs[i].toLowerCase() == 'trollguy') ? 'trollweek' : songs[i].toLowerCase();

        var trophy:FlxSprite = new FlxSprite().loadGraphic(Paths.image('awards/' + name + 'trophy'));
        trophy.screenCenter();
        trophy.x = ((FlxG.width / 2) - trophy.frameWidth / 2) + (500 * (i - curSelected));

        trophy.antialiasing = ClientPrefs.globalAntialiasing;
        trophy.scrollFactor.set();
        trophy.scale.set(1, 1);
        trophy.ID = i;
        trophies.add(trophy);

        var fatlittlepiggies = ['alert', 'ravegirl', 'crunchmix', 'yolo'];
        for(fat in fatlittlepiggies){
            if(name == fat){
                trophy.y -= 52;
            }
        }
        var tint = 0;
        tint = checkSONG(songs[i].toLowerCase());

        switch(tint)
        {
            case 2:
                trophy.loadGraphic(Paths.image('awards/' + name + 'FCtrophy'));
            case 1:
                trophy.loadGraphic(Paths.image('awards/' + name + 'trophy'));
            case 0:
                trophy.visible = false;
        }
    }

    
    var blackBar:FlxSprite = new FlxSprite(FlxG.width / 2, 0).makeGraphic(FlxG.width * 2, 100, FlxColor.BLACK);
    blackBar.screenCenter(FlxAxes.X);
    blackBar.y = -125;
    add(blackBar);

    text = new FlxText(0, -125, 0, songs[curSelected].toUpperCase(), 80);
    text.setFormat(Paths.font("candy.otf"), 80, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.TRANSPARENT);
    text.screenCenter(FlxAxes.X);
    text.scrollFactor.set();
    text.antialiasing = ClientPrefs.globalAntialiasing;
    text.text = 'fuck';
    add(text);

    changeSel(0);

    leftArrow = new FlxSprite();
    leftArrow.frames = Paths.getSparrowAtlas('storymode/storyleftarrow');
    leftArrow.animation.addByPrefix('idle', 'storyleftarrow idle', 24, false);
    leftArrow.animation.addByPrefix('hover', 'storyleftarrow hover', 24, false);
    leftArrow.animation.addByPrefix('confirm', 'storyleftarrow select', 24, false);
    leftArrow.animation.play('idle');
    leftArrow.scale.set(0.45, 0.45);
    leftArrow.antialiasing = ClientPrefs.globalAntialiasing;
    leftArrow.updateHitbox();
    leftArrow.screenCenter();
    leftArrow.x -= 800;

    rightArrow = new FlxSprite();
    rightArrow.frames = Paths.getSparrowAtlas('storymode/storyrightarrow');
    rightArrow.animation.addByPrefix('idle', 'storyrightarrow idle', 24, false);
    rightArrow.animation.addByPrefix('hover', 'storyrightarrow hover', 24, false);
    rightArrow.animation.addByPrefix('confirm', 'storyrightarrow select', 24, false);
    rightArrow.animation.play('idle');
    rightArrow.scale.set(0.45, 0.45);
    rightArrow.antialiasing = ClientPrefs.globalAntialiasing;
    rightArrow.updateHitbox();
    rightArrow.screenCenter();
    rightArrow.x += 800;

    add(rightArrow);
    add(leftArrow);

    backbutton = new FlxSprite();
    backbutton.frames = Paths.getSparrowAtlas('backbutton');
    backbutton.animation.addByPrefix('idle', 'backbutton idle', 24, false);
    backbutton.animation.addByPrefix('hover', 'backbutton hover', 24, false);
    backbutton.animation.addByPrefix('confirm', 'backbutton confirm', 24, false);
    backbutton.animation.play('idle');
    backbutton.scrollFactor.set();
    backbutton.antialiasing = ClientPrefs.globalAntialiasing;
    backbutton.scale.set(1.5, 1.5);
    backbutton.updateHitbox();
    backbutton.setPosition(-300, -115);
    add(backbutton);

    var thing:FlxText = new FlxText(0, 0, 0, "Press E to Erase Data", 46);
    thing.setFormat(Paths.font('candy.otf'), thing.size, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    thing.borderSize = 2;
    thing.screenCenter();
    thing.antialiasing = ClientPrefs.globalAntialiasing;
    thing.y += (FlxG.height * 0.65);
    add(thing);

    FlxG.camera.zoom = 0.675;

    transition = new FlxSprite();
    transition.frames = Paths.getSparrowAtlas('transition_out');
    transition.animation.addByPrefix('idle', 'transition_out idle', 60, false);
    transition.screenCenter();
    transition.scrollFactor.set();
    transition.scale.set(3.75, 3.75);

    add(transition);
    transition.animation.play('idle', false, true);
}

function changeSel(value)
{
    curSelected += value;

    if(curSelected < 0)
        curSelected = songs.length - 1;
    if(curSelected > songs.length - 1)
        curSelected = 0;

    
    text.text = songs[curSelected].toUpperCase();
    switch(text.text.toLowerCase())
    {
        case 'cerealweek':
            text.text = 'CEREAL GUY WEEK';
        case 'trollguy':
            text.text = 'TROLL GUY WEEK';
        case 'epicweek':
            text.text = 'EPIC FACE WEEK';
    }
    var check = checkSONG(songs[curSelected].toLowerCase());

    text.text += ((check == 2) ? ' (FC)' : '');

    if(check == 0)
        text.text = '???';

    text.screenCenter(FlxAxes.X);
}

function checkSONG(name:String)
{
    var int = 0;
    var data = FlxG.save.data.CrunchinSongData;

    switch(name)
    {
        case 'cerealweek':
            if(data.get('crunch').finished && data.get('milkyway').finished && data.get('choke-a-lot').finished)
            {
                if(data.get('crunch').fc && data.get('milkyway').fc && data.get('choke-a-lot').fc)
                {
                    int = 2;
                }
                else
                {
                    int = 1;
                }
            }
        case 'trollguy':
            if(data.get('doubt').finished && data.get('hope').finished && data.get('reunion').finished)
            {
                if(data.get('doubt').fc && data.get('hope').fc && data.get('reunion').fc)
                {
                    int = 2;
                }
                else
                {
                    int = 1;
                }
            }
        case 'epicweek':
            if(data.get('smile').finished && data.get('order-up').finished && data.get('last-course').finished)
            {
                if(data.get('smile').fc && data.get('order-up').fc && data.get('last-course').fc)
                {
                    int = 2;
                }
                else
                {
                    int = 1;
                }
            }
        default:
            if(data.get(name).finished)
            {
                if(data.get(name).fc)
                {
                    int = 2;
                }
                else
                {
                    int = 1;
                }
            }
            // int = 1;
            /*else
            {
                int = 0;
            }*/
    }

    return int;
}

var clicked = false;
var movedBack = false;
function update(elapsed){
    // if(FlxG.keys.justPressed.R) FlxG.resetState();

    trophies.forEach(function(spr:FlxSprite){
        var x:Float = ((FlxG.width / 2) - spr.frameWidth / 2) + (500 * (spr.ID - curSelected));

        spr.x = FlxMath.lerp(spr.x, x, FlxMath.bound(elapsed * 5, 0, 1));
    });

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

            changeSel(-1);
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

            changeSel(1);
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

    if(FlxG.keys.justPressed.E)
    {
        //Trophy.clearTrophies();
        // super.openSubState(new AreYouSureSubState());
        openSubState(new HScriptSubstate('AreYouSure'));
    }

    /*if (controls.BACK && !selectedSomethin)
    {
        selectedSomethin = true;
        FlxG.sound.play(Paths.sound('cancelMenu'));
        
        FlxTransitionableState.skipNextTransIn = true;

        transition.animation.play('idle');

        new FlxTimer().start(1, function(tmr:FlxTimer)
        {
            MusicBeatState.switchState(new MainMenuState());
        });
    }*/

    if(movedBack)
    {
        backbutton.animation.play('confirm');
    }
    else
    {
        if(FlxG.mouse.overlaps(backbutton))
        {
            backbutton.animation.play('hover');

            if(!movedBack && FlxG.mouse.pressed)
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