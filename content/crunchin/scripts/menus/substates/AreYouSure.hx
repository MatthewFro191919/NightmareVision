import funkin.utils.WindowUtil;
import lime.app.Application;

var image1:FlxSprite;
var image2:FlxSprite;
var ohyeah:FunkinVideoSprite;
var state:Int = 0;
var ready = true;
var cantDoNothing = false;

function create(){
    image1 = new FlxSprite().loadGraphic(Paths.image('awards/areyousure/areyousure', 'preload'));
    image1.scrollFactor.set();
    image1.screenCenter();
    image1.antialiasing = ClientPrefs.globalAntialiasing;
    image1.alpha = 0;
    add(image1);

    image2 = new FlxSprite().loadGraphic(Paths.image('awards/areyousure/areyousuresure', 'preload'));
    image2.scrollFactor.set();
    image2.screenCenter();
    image2.antialiasing = ClientPrefs.globalAntialiasing;
    image2.alpha = 0;
    add(image2);

    ohyeah = new FunkinVideoSprite();
    ohyeah.addCallback('onFormat', ()->{
        ohyeah.setGraphicSize(0, FlxG.height * 1.5);
        ohyeah.updateHitbox();
        ohyeah.screenCenter();
    });
    ohyeah.addCallback('onEnd', die);
    ohyeah.load(Paths.video('bozo'));
    add(ohyeah);

    nextState(state);
}

function die(){

    if(FlxG.save.data.CrunchinSongData != null){
        FlxG.save.data.CrunchinSongData = null;
        Application.current.window.alert('Dumb stupid bitch', 'oopsies!');
    }else
        Application.current.window.alert('dude what are you doing. you dont even have save data. how did you manage to get here if you dont even have save data ??????? ITS CREATED ON THE TITLE SCREEN.', 'oopsies!');
    
    FlxG.save.flush();
    WindowUtil.crashTheFuckingGame();
}

function nextState(stateNumber)
{
    if(ready)
    {
        ready = false;

        switch(stateNumber)
        {
            case 0:
                FlxTween.tween(image1, {alpha: 1}, 0.5, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween){
                    state = 1;
                    ready = true;
                }});
            case 1:
                FlxG.sound.music.volume = 0.5;
                FlxTween.tween(image2, {alpha: 1}, 0.5, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween){
                    FlxG.sound.music.volume = 0;
                    state = 2;
                    ready = true;
                }});
            case 2:
                FlxG.sound.music.stop();
                cantDoNothing = true;
                ohyeah.play();
        }
    }
}

function backState(stateNumber)
{
    switch(stateNumber)
    {
        case 1:
            FlxG.sound.music.volume = 1;
            FlxTween.tween(image1, {alpha: 0}, 0.5, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween){
                close();
            }});
        case 2:
            image1.alpha = 0;
            FlxG.sound.music.volume = 1;
            FlxTween.tween(image2, {alpha: 0}, 0.5, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween){
                close();
            }});
    }
}

function update(elapsed:Float)
{
    if(!cantDoNothing)
    {
        var spacebar = FlxG.keys.justPressed.SPACE;
        var escape = FlxG.keys.justPressed.ESCAPE;
        if(spacebar)
        {
            nextState(state);
        }

        if(escape)
        {
            backState(state);
        }
    }
}