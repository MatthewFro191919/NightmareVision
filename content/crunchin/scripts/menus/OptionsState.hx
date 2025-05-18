import funkin.data.options.NotesSubState;
import funkin.data.options.ControlsSubState;
import funkin.data.options.GraphicsSettingsSubState;
import funkin.data.options.VisualsUISubState;
import funkin.data.options.GameplaySettingsSubState;
import funkin.data.options.NoteOffsetState;
import funkin.states.MainMenuState;

import funkin.backend.PlayerSettings;
var controls = PlayerSettings.player1.controls;

var custom = true;
function customMenu(){ return custom; }

var options:Array<String> = ['Note Colors', 'Controls', 'Adjust Delay and Combo', 'Graphics', 'Visuals and UI', 'Gameplay'];

var grpOptions:FlxTypedGroup;
var grpSprites:FlxTypedGroup;
var curSelected = 0;

var selectorLeft:Alphabet;
var selectorRight:Alphabet;

var backbutton:FlxSprite;
var transition:FlxSprite;

function onCreate(){
    FlxG.mouse.visible = true;

    var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('options/options_monitor'));
    bg.updateHitbox();
    bg.screenCenter();
    bg.antialiasing = ClientPrefs.globalAntialiasing;
    add(bg);

    grpSprites = new FlxTypedGroup();
    add(grpSprites);

    titleText2 = new Alphabet(0, 0, "MOUSE", true, false, 0, 0.7);
    titleText2.screenCenter(FlxAxes.X);
    titleText2.y += 70;
    titleText2.alpha = 1;
    add(titleText2);

    for (i in 0...options.length)
    {
        var optionSprite:FlxSprite = new FlxSprite().loadGraphic(Paths.image('options/options_' + options[i]));
        optionSprite.x = (i % 2 == 0) ? 200 : 900;
        var value = 125;
        optionSprite.y = (i % 2 == 0) ? 25 + (i * value) : 25 + (i * value) - value;
        optionSprite.ID = i;
        grpSprites.add(optionSprite);
    }

    selectorLeft = new Alphabet(0, 0, '>', true, false);
    add(selectorLeft);
    selectorRight = new Alphabet(0, 0, '<', true, false);
    add(selectorRight);

    var fg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('options/options_border'));
    fg.screenCenter();
    fg.antialiasing = ClientPrefs.globalAntialiasing;
    add(fg);
    ClientPrefs.saveSettings();

    backbutton = new FlxSprite(10, 10);
    backbutton.frames = Paths.getSparrowAtlas('backbutton');
    backbutton.animation.addByPrefix('idle', 'backbutton idle', 24, false);
    backbutton.animation.addByPrefix('hover', 'backbutton hover', 24, false);
    backbutton.animation.addByPrefix('confirm', 'backbutton confirm', 24, false);
    backbutton.animation.play('idle');
    backbutton.scrollFactor.set();
    backbutton.antialiasing = ClientPrefs.globalAntialiasing;
    //backbutton.scale.set(1, 1);
    backbutton.updateHitbox();
    //backbutton.setPosition(-300, -115);
    add(backbutton);

    transition = new FlxSprite();
    transition.frames = Paths.getSparrowAtlas('transition_out');
    transition.animation.addByPrefix('idle', 'transition_out idle', 60, false);
    transition.screenCenter();
    transition.scrollFactor.set();
    transition.scale.set(2.5, 2.5);

    add(transition);
    transition.animation.play('idle', false, true);
}

var movedBack = false;

function onUpdate(elapsed){
    // if(FlxG.keys.justPressed.R) FlxG.resetState();

    grpSprites.forEach(function(spr:FlxSprite)
    {
        if(FlxG.mouse.overlaps(spr) && !movedBack)
        {
            spr.scale.set(1.05, 1.05);

            if(FlxG.mouse.pressed)
            {
                openSelectedSubstate(options[spr.ID]);
            }
        }
        else
        {
            spr.scale.set(1, 1);
        }
    });

    var hover:Bool = FlxG.mouse.overlaps(backbutton);
    var backConfirm:Bool = (hover && FlxG.mouse.justPressed) || (controls.BACK);

    if(!backConfirm)
        backbutton.animation.play(hover ? 'hover' : 'idle');
    else
        backbutton.animation.play('confirm');
    

    if (!movedBack && backConfirm) {
        movedBack = true;

        FlxG.sound.play(Paths.sound('cancelMenu'));
        transition.animation.play('idle');
        
        FlxG.mouse.visible = false;

        new FlxTimer().start(1, function(tmr:FlxTimer)
        {
            FlxG.switchState(new MainMenuState());
        });
    }
}

function openSelectedSubstate(label:String) {
    if(label != 'Adjust Delay and Combo' && grpSprites != null)
    {
        titleText2.visible = false;
        grpSprites.visible = false;
    }

    titleText2.text = 'KEYBOARD';

    switch(label) {
        case 'Note Colors':
            openSubState(new NotesSubState());
        case 'Controls':
            openSubState(new ControlsSubState());
        case 'Graphics':
            openSubState(new GraphicsSettingsSubState());
        case 'Visuals and UI':
            openSubState(new VisualsUISubState());
        case 'Gameplay':
            openSubState(new GameplaySettingsSubState());
        case 'Adjust Delay and Combo':
            FlxG.switchState(new NoteOffsetState());
    }
}

function onCloseSubState(){
    FlxG.camera.zoom = 1;
    titleText2.text = 'MOUSE';
    titleText2.visible = true;
    grpSprites.visible = true;
}