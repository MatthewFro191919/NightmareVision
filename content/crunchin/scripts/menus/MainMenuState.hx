import flixel.FlxObject;
import flixel.text.FlxText;
import flixel.addons.transition.FlxTransitionableState;
import funkin.states.TitleState;
import funkin.states.FreeplayState;
import funkin.states.StoryMenuState;
import funkin.states.LoadingState;
import funkin.data.options.OptionsState;
import funkin.states.editors.HScriptState;

var custom:Bool = true;
function customMenu() { return custom; }


var menuItems:FlxTypedGroup;
var optionShit:Array<String> = [
    'achievement',
    'gallery',
    'freeplay',
    'options',
    'credits',
    'storymode'
];
var offsets:Array<Array<Float>> = [
    [940, -10], // achievement offset
    [-368, 72], // gallery offset
    [-115,142], // freeplay offset
    [650,143], // options offset
    [300,190], // credits offset
    [750,435], // storymode offset
];
var backbutton:FlxSprite;
var transition:FlxSprite;
var notice:FlxSprite;
var actualnotice:FlxSprite;

function onCreatePost(){
    if(custom){
        Paths.currentModDirectory = 'crunchin';
        WindowUtil.setTitle("Friday Night Crunchin' - Browsing the menus");

        camFollowPos = new FlxObject(0, 0, 1, 1);
        add(camFollowPos);
    
        var scale:Float = 0.475;
        camGame.zoom = 0.98;
    
        menuItems = new FlxTypedGroup();
        add(menuItems);
    
        var COOLCEREAL:FlxSprite = new FlxSprite().loadGraphic(Paths.image('mainmenu/CGTable'));
        COOLCEREAL.ID = -2;
        COOLCEREAL.screenCenter();
        COOLCEREAL.scrollFactor.set(0.05, 0.05);
        COOLCEREAL.scale.set(scale, scale);
        COOLCEREAL.antialiasing = ClientPrefs.globalAntialiasing;
        menuItems.insert(0, COOLCEREAL);
    
        var actualTable:FlxSprite = new FlxSprite().loadGraphic(Paths.image('mainmenu/actualTABLE'));
        actualTable.ID = -1;
        actualTable.screenCenter();
        actualTable.scrollFactor.set(0.05, 0.05);
        actualTable.scale.set(scale, scale);
        actualTable.antialiasing = ClientPrefs.globalAntialiasing;
        menuItems.insert(2, actualTable);
    

        notice = new FlxSprite();
        notice.frames = Paths.getSparrowAtlas('mainmenu/notice-note');
        notice.animation.addByPrefix('idle', 'loop', 24, false);
        notice.animation.addByPrefix('clear', 'clear', 24, false);
        notice.animation.play('idle');        
        notice.scrollFactor.set(0.05, 0.05);
        notice.setPosition(500, 10);
        add(notice);

        // Trophy.loadTrophies();
        
        freeplayAvailable = true;
        // trace(freeplayAvailable);
    
        var lockedsprite:FlxSprite = new FlxSprite(0, 0);
        if(!freeplayAvailable)
        {
            lockedsprite.loadGraphic(Paths.image('mainmenu/freeplayLocked'));
            lockedsprite.scale.set(scale, scale);
            //lockedsprite.setPosition(lockedsprite.x - 87, lockedsprite.y - 200);
            lockedsprite.screenCenter();
            lockedsprite.ID = 2;
            lockedsprite.y += 5;
            lockedsprite.scrollFactor.set(0.051, 0.051);
            lockedsprite.antialiasing = ClientPrefs.globalAntialiasing;
        }
        //FlxG.plugins.add(new FlxMouseEventManager());
    
        // var galSprite = new FlxSprite();
        // // galSprite.loadGraphic(Paths.image('mainmenu/galleryLocked'));
        // galSprite.frames = Paths.getSparrowAtlas('mainmenu/gallery');
        // galSprite.scale.set(scale, scale);
        // galSprite.screenCenter();
        // galSprite.ID = -1;
        // //galSprite.y += 5;
        // galSprite.scrollFactor.set(0.05, 0.05);
        // galSprite.antialiasing = ClientPrefs.globalAntialiasing;
    
        for (i in 0...optionShit.length)
        {
            var menuItem:FlxSprite = new FlxSprite(0, 0);
            menuItem.scale.x = scale;
            menuItem.scale.y = scale;
            menuItem.frames = Paths.getSparrowAtlas('mainmenu/' + optionShit[i]);
            menuItem.animation.addByPrefix('idle', optionShit[i] + " normal", 24);
            menuItem.animation.addByPrefix('select', optionShit[i] + " select", 24);
            menuItem.animation.play('idle');
            menuItem.ID = i;
            menuItem.antialiasing = ClientPrefs.globalAntialiasing;
            menuItem.screenCenter();

            if(optionShit[i] != 'gallery')
                menuItems.insert(3 + i, menuItem);
            else
                menuItems.insert(1, menuItem);

            switch(optionShit[i])
            {
                case 'storymode':
                    menuItem.scrollFactor.set(0.125, 0.125);
                case 'achievement' | 'gallery':
                    menuItem.scrollFactor.set(0.05, 0.05);
                default:
                    menuItem.scrollFactor.set(0.051, 0.051);
            }

            if(optionShit[i] == 'gallery'){
                menuItem.setSize(menuItem.width - 100, menuItem.height);
            }
    
            menuItem.x += offsets[i][0];
            menuItem.y += offsets[i][1];
            
            menuItem.antialiasing = ClientPrefs.globalAntialiasing;
            menuItem.updateHitbox();
    
        }
        FlxG.camera.follow(camFollowPos, null, 1);

        ClientPrefs.saveSettings();
    
        actualnotice = new FlxSprite().loadGraphic(Paths.image('mainmenu/notice'));
        actualnotice.scale.set(0.7, 0.7);
        actualnotice.updateHitbox();
        actualnotice.screenCenter();
        actualnotice.scrollFactor.set();
        add(actualnotice);
        actualnotice.visible = false;

        backbutton = new FlxSprite();
        backbutton.frames = Paths.getSparrowAtlas('backbutton');
        backbutton.animation.addByPrefix('idle', 'backbutton idle', 24, false);
        backbutton.animation.addByPrefix('hover', 'backbutton hover', 24, false);
        backbutton.animation.addByPrefix('confirm', 'backbutton confirm', 24, false);
        backbutton.animation.play('idle');
        backbutton.scrollFactor.set();
        backbutton.setPosition(10, 10);
        backbutton.antialiasing = ClientPrefs.globalAntialiasing;
        add(backbutton);
        // actualnotice.setGraphicSize(1,1);
        
        transition = new FlxSprite();
        transition.frames = Paths.getSparrowAtlas('transition_out');
        transition.animation.addByPrefix('idle', 'transition_out idle', 60, false);
        transition.screenCenter();
        transition.scrollFactor.set();
        transition.scale.set(2.5, 2.5);
        transition.antialiasing = ClientPrefs.globalAntialiasing;
    
        add(transition);
        transition.animation.play('idle', false, true);
    
        FlxG.mouse.visible = true;
    }else{
        FlxG.mouse.visible = false;
    }
}


var selectedSomethin:Bool = false;
var selectedSomething2:Bool = false;
var fattyfatfat = false;
function onUpdate(elapsed){
    // if(FlxG.keys.justPressed.R) FlxG.resetState();

    if(custom){
        var percent = FlxG.width * 0.21;
        var percent2 = FlxG.width * 0.15;
        var s_offset = 0;
        if(FlxG.mouse.screenX >= 0 && FlxG.mouse.screenX <= percent) { s_offset = -4700; }
        if(FlxG.mouse.screenX >= FlxG.width - percent2 && FlxG.mouse.screenX <= FlxG.width) { s_offset = 4200; }
    
        // var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
        camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, elapsed * 7.5), FlxMath.lerp(camFollowPos.y, camFollow.y, elapsed * 7.5));
        camFollow.setPosition(FlxG.mouse.screenX + s_offset, FlxG.mouse.screenY);
    
        // /*if(FlxG.keys.justPressed.E){
        //     openSubState(new RewardsSubstate(''));
        // }*/
    
        if(selectedSomething2)
        {
            backbutton.animation.play('confirm');
        }
        else
        {
            if(FlxG.mouse.overlaps(backbutton) && !selectedSomethin)
            {
                backbutton.animation.play('hover');
    
                if(!fattyfatfat){
                    if(!selectedSomething2 && FlxG.mouse.pressed)
                    {
                        selectedSomething2 = true;
        
                        FlxG.sound.play(Paths.sound('cancelMenu'));
                        FlxG.switchState(new TitleState());
                    }                    
                }else{
                    if(FlxG.mouse.pressed && !selectedSomethin){
                        selectedSomethin = true;
                        FlxTween.tween(actualnotice, {alpha: 0}, 1, {ease: FlxEase.quartOut, onComplete: ()->{ 
                            new FlxTimer().start(0.125, ()->{
                                fattyfatfat = false;
                                selectedSomethin = false;
                            });
                         }});    
                    }
                }

            }
            else
            {
                backbutton.animation.play('idle');
            }

            if(FlxG.mouse.overlaps(notice) && FlxG.mouse.justPressed && !selectedSomethin && !fattyfatfat){
                notice.animation.play('clear');
                selectedSomethin = true;
                actualnotice.visible = true;
                actualnotice.alpha = 0;
                FlxTween.tween(actualnotice, {alpha: 1}, 1, {ease: FlxEase.quartOut});

                FlxTween.num(2, 1280 * 1.025, 1, {ease: FlxEase.quartOut, onUpdate: (t)->{
                    actualnotice.setGraphicSize(t.value);
                }, onComplete: ()->{ 
                    selectedSomethin = false;
                    fattyfatfat = true;
                }});

            }
        }
    
        if(!selectedSomethin && !selectedSomething2)
        {
            var overlapping = false;
            var currentlySelected:Int = -1;
            menuItems.forEach(function(spr:FlxSprite)
            {
                if(spr.ID >= 0){
                    if(FlxG.mouse.overlaps(spr) && !overlapping)
                    {
                        if(!freeplayAvailable)
                        {
                            if(spr.ID != 2)
                            {
                                overlapping = true;
                                currentlySelected = spr.ID;
                                spr.animation.play('select');
            
                                if(spr.ID == 5)
                                {
                                    FlxTween.tween(spr, {y: 435 - 50}, 0.1, {ease: FlxEase.quadOut});
                                }
                            }
                        }
                        else
                        {
                            overlapping = true;
                            currentlySelected = spr.ID;
                            spr.animation.play('select');
        
                            if(spr.ID == 5)
                            {
                                FlxTween.tween(spr, {y: 435 - 50}, 0.1, {ease: FlxEase.quadOut});
                            }
                        }
                    }
                    else
                    {
                        spr.animation.play('idle');
                        if(spr.ID == 5)
                        {
                            FlxTween.tween(spr, {y: 435}, 0.1, {ease: FlxEase.quadOut});
                        }
                    }
                }
            });
    
            if(currentlySelected > -1)
            {
                if(FlxG.mouse.pressed && !fattyfatfat)
                {
                    selectedSomethin = true;
                    FlxG.sound.play(Paths.sound('confirmMenu'));
                    FlxTransitionableState.skipNextTransIn = true;
                    FlxTransitionableState.skipNextTransOut = true;
                    new FlxTimer().start(1, function(tmr:FlxTimer) {
                        var daChoice:String = optionShit[currentlySelected];
    
                        switch (daChoice)
                        {
                            case 'storymode':
                                FlxG.switchState(new HScriptState('StoryMode'));
                            case 'freeplay':
                                FlxG.switchState(new funkin.states.FreeplayState());
                            case 'gallery':
                                FlxG.switchState(new HScriptState('Gallery'));
                            case 'achievement':
                                FlxG.switchState(new HScriptState('TrophyRoom'));
                            case 'credits':
                                FlxG.switchState(new HScriptState('Credits'));
                            case 'options':
                                LoadingState.loadAndSwitchState(new OptionsState());
                            default:
                                LoadingState.loadAndSwitchState(new OptionsState());
                        }
                    });
    
    
                    transition.frames = Paths.getSparrowAtlas('transition_out');
                    transition.animation.addByPrefix('idle', 'transition_out idle', 60, false);
                    transition.screenCenter();
                    transition.scrollFactor.set();
                    transition.scale.set(2.5, 2.5);
                    
                    add(transition);
                    transition.animation.play('idle');
    
                }
            }
        }
    
        // if (!selectedSomethin)
        // {
        //     /*if(FlxG.keys.justPressed.E){
        //         selectedSomethin = true;
        //         FlxG.switchState(new editors.FrameByFrameState());
        //     }*/
        //     #if desktop
        //     if (FlxG.keys.anyJustPressed(debugKeys))
        //     {
        //         selectedSomethin = true;
        //         FlxG.switchState(new MasterEditorMenu());
        //     }
        //     #end
        // }
    }
}