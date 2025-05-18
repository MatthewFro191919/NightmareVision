function setupNote(note){
    note.reloadNote('notes/Sad-');
    note.colorSwap.hue = 0;
    note.colorSwap.saturation = 0;
    note.colorSwap.brightness = 0;
    note.hitCausesMiss = false;
    note.offsetX = 15;
    // note.noAnimation = true;
    // note.botplaySkin = false;
}

var game = PlayState.instance;
function noteMiss(note){
    game.camHUD.flash(FlxColor.fromRGB(100, 100, 255, 255), 0.5, null, true);

    var curSpeed = game.songSpeed;
    if(curSpeed - 1 <= 1)
    {
        game.songSpeed = 1;
    }
    else
    {
        FlxTween.tween(game, {songSpeed: curSpeed - 1}, 1, {ease: FlxEase.linear});
    }
}