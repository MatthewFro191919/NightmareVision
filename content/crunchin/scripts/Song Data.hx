import haxe.ds.StringMap;
import flixel.text.FlxText;
import funkin.data.Conductor;
import funkin.states.substates.GameOverSubstate;

// save data
var songName = StringTools.replace(PlayState.SONG.song.toLowerCase(), ' ', '-');
function onEndSong(){
    if(FlxG.save.data.CrunchinSongData == null){
        FlxG.save.data.CrunchinSongData = new StringMap();
        FlxG.save.data.CrunchinSongData.set(songName, {fc: game.songMisses == 0, finished: true});
    } 
    
    FlxG.save.data.CrunchinSongData.get(songName).finished = true;
    if(!FlxG.save.data.CrunchinSongData.get(songName).fc)
        FlxG.save.data.CrunchinSongData.get(songName).fc = game.songMisses == 0;
    
    // trace(songName + ': ' + FlxG.save.data.CrunchinSongData.get(songName));
    FlxG.save.flush();
    return Function_Continue;
}

typedef CreditsData = {
    musician:String,
    special:Bool
}

var creditcard:FlxSpriteGroup;
var card:FlxSprite;
var name:FlxText;
var artist:FlxText;
var icon:HealthIcon;

var isSpecial:Bool = false;
var isException:Bool = false;
var exceptions = ['yolo'];
var songCredits = new StringMap();

function onCreatePost(){

    // songCredits.set('', {musician: special: });
    WindowUtil.setTitle("Friday Night Crunchin' - Playing [ " + PlayState.SONG.song.toUpperCase() + " ]");

    var neutroaSongs = ['doubt', 'choke-a-lot', 'milkyway', 'crunch', 'soundtest', 'smile'];
    for(n in neutroaSongs){ songCredits.set(n, {musician: 'neutroa', special: false}); }

    songCredits.set('hope', {musician: 'Wrathstetic & Sturm', special: false});
    songCredits.set('reunion', {musician: 'Wrathstetic & Sturm', special: false});
    songCredits.set('order-up', {musician: 'RedTV53 & Tapwater', special: false});
    songCredits.set('last-course', {musician: 'RedTV53', special: false});

    songCredits.set('alert', {musician: 'Luna, STURMVIDEO, RedTV53', special: false});
    songCredits.set('legacy', {musician: 'Sturm', special: true});
    songCredits.set('rattled', {musician: 'Joey Animations & Sturm', special: false});
    songCredits.set('threat', {musician: 'Tapwater', special: true});
    songCredits.set('rumor', {musician: 'lol', special: true});

    songCredits.set('crunchmix', {musician: 'PolarVortex', special: false});
    songCredits.set('harness', {musician: 'RedTV53 & Wrathstetic', special: false});
    songCredits.set('ravegirl', {musician: 'Lydian', special: false});

    for(s in exceptions){ if(songName == s) isException = true; }

    if(!isException){
        creditcard = new FlxSpriteGroup();
        creditcard.camera = game.camOther;
        add(creditcard);
    
        var songName = StringTools.replace(PlayState.SONG.song.toLowerCase(), ' ', '-');
        var songData = songCredits.get(songName);
        var musician = songData.musician;
        var special = songData.special;

        card = new FlxSprite().loadGraphic(Paths.image('nowplaying/' + (special ? songName : 'blank')));
        card.scale.set(0.67, 0.67);
        card.updateHitbox();
        card.screenCenter();
        card.scrollFactor.set();
        creditcard.add(card);
    
        if(!special){
            name = new FlxText(0, 0, 0, songName);
            name.setFormat(Paths.font("candy.otf"), 55, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
            name.setPosition(card.getGraphicMidpoint().x - 530, card.getGraphicMidpoint().y + 280);
            creditcard.add(name);
        
            artist = new FlxText(0, 0, 0, musician);
            artist.setFormat(Paths.font("candy.otf"), 24, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
            artist.setPosition(card.getGraphicMidpoint().x + 220, card.getGraphicMidpoint().y + 323);
            creditcard.add(artist);
    
            icon = new HealthIcon(game.dad.healthIcon, false, true);
            icon.scale.set(0.75, 0.75);
            icon.setPosition(card.getGraphicMidpoint().x + 495, card.getGraphicMidpoint().y + 245);
            creditcard.add(icon);
        }
    
        for(i in creditcard.members){ i.y += 125; }
    
    }

    var allofthem = [];
    for(m in members) allofthem.push(m);
    if(game.stage != null) for(m in game.stage.members) allofthem.push(m);

    for (sprite in allofthem)
    {
        var sprite:Dynamic = sprite; // Make it check for FlxSprite instead of FlxBasic
        var sprite:FlxSprite = sprite; // Don't judge me ok
        if (sprite != null && (Std.isOfType(sprite, FlxSprite)) && !(Std.isOfType(sprite, FlxText)))
        {
            sprite.antialiasing = ClientPrefs.globalAntialiasing;
        }
    }
}

function onSongStart(){
    if(!isException){
        for(m in creditcard.members){
            FlxTween.tween(m, {y: m.y - 125}, 2, {ease: FlxEase.quartOut});
        }
    
        new FlxTimer().start((Conductor.stepCrotchet / 1000) * 32, (t)->{
            for(m in creditcard.members){
                FlxTween.tween(m, {y: m.y + 125}, 2, {ease: FlxEase.quartIn, onComplete: ()->{
                    creditcard.remove(m);
                    // destroy(m);
                }});
            }
        });    
    }
}

function onUpdate(elapsed){
    if(FlxG.keys.justPressed.ONE){
        PlayState.chartingMode = false;
        game.KillNotes();
        if (FlxG.sound.music.onComplete != null) FlxG.sound.music.onComplete();
    } 

    if(game.songScore > 0 && game.songMisses == 0)
        game.playHUD.scoreTxt.color = 0xFFFFD700;
    else
        game.playHUD.scoreTxt.color = FlxColor.WHITE;
}

var noteTypes = ['CerealNote', 'EpicNote'];
function onSpawnNote(note){
    if(!ClientPrefs.mechanics){
        if(note.noteType == 'Sad-Note') {
            note.noteType = '';
            note.reloadNote();
        }

        for(m in noteTypes) if(note.noteType == m) return Function_Stop;

        if(PlayState.SONG.song.toLowerCase() == 'yolo' && note.noteData == 4) return Function_Stop;
    }   
}