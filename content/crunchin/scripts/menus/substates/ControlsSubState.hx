function onCreatePost(){
    bg.loadGraphic(Paths.image('options/options_monitor'));
    bg.color = FlxColor.WHITE;

    var fg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('options/options_border'));
    fg.screenCenter();
    fg.antialiasing = ClientPrefs.globalAntialiasing;
    add(fg);
}