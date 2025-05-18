function onCreatePost(){
    bg.loadGraphic(Paths.image('options/options_monitor'));
    bg.color = FlxColor.WHITE;
    titleText.screenCenter(FlxAxes.X);
    titleText.text = title + '\nKEYBOARD';

    var fg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('options/options_border'));
    fg.screenCenter();
    fg.antialiasing = ClientPrefs.globalAntialiasing;
    // add(fg);
    insert(members.indexOf(grpOptions) - 1, fg);
}