import flixel.addons.transition.FlxTransitionableState;
import funkin.states.MainMenuState;

var transition:FlxSprite;
var img:FlxSprite;

function create(){
    img = new FlxSprite().loadGraphic(Paths.image('warning'));
    img.screenCenter();
    img.antialiasing = ClientPrefs.globalAntialiasing;
    add(img);

    transition = new FlxSprite();
    transition.frames = Paths.getSparrowAtlas('transition_out');
    transition.animation.addByPrefix('idle', 'transition_out idle', 60, false);
    transition.screenCenter();
    transition.scrollFactor.set();
    transition.scale.set(2.5, 2.5);
    transition.antialiasing = ClientPrefs.globalAntialiasing;

    add(transition);
    transition.animation.play('idle', false, true);
}

function onUpdate(elapsed){
    if(FlxG.mouse.justPressed)
        die();
}

var can = true;
function die(){
    if(can){
        can = false;
        FlxG.camera.flash(FlxColor.WHITE, 0.5);
        FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
        FlxTransitionableState.skipNextTransIn = true;
        FlxTransitionableState.skipNextTransOut = true;
        transition.animation.play('idle', true, false);
        transition.animation.finishCallback = ()->{
            FlxG.switchState(new MainMenuState());
        }
    }

}