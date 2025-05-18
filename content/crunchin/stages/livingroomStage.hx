var stageDirectory:String = 'stages/cerealguy/';

function onLoad(){
    GameOverSubstate.characterName = 'RoachDIE';

	var bg = new FlxSprite(-550, -600).loadGraphic(Paths.image(stageDirectory + 'cgbackground'));
	bg.scrollFactor.set(0.8, 0.8);
	add(bg);

	var couch = new FlxSprite(500, 250).loadGraphic(Paths.image(stageDirectory + 'cgcouch'));
	couch.scrollFactor.set(0.8, 0.8);
	add(couch);

	var camera = new FlxSprite(-200, 500).loadGraphic(Paths.image(stageDirectory + "cgcamera"));
	camera.scrollFactor.set(0.5, 0.5);
	camera.zIndex = 999;
	add(camera);
}

function onStepHit(){
	switch(PlayState.SONG.song.toLowerCase()){
		case 'milkyway':
			switch(game.curStep)
			{
				case 505:
					FlxTween.num(game.defaultCamZoom, 0.8, 0.5, {ease: FlxEase.quintOut, onUpdate: (t)->{ game.defaultCamZoom = t.value; }});
				case 520:
					FlxTween.num(game.defaultCamZoom, 0.7, 0.45, {ease: FlxEase.quintOut, onUpdate: (t)->{ game.defaultCamZoom = t.value; }, onComplete: ()->{
						FlxTween.num(game.defaultCamZoom, 0.9, 0.5, {ease: FlxEase.quintOut, onUpdate: (t)->{ game.defaultCamZoom = t.value; }});
					}});
				case 640:
					FlxTween.num(game.defaultCamZoom, 0.8, 0.5, {ease: FlxEase.quintOut, onUpdate: (t)->{ game.defaultCamZoom = t.value; }, onComplete: ()->{ game.defaultCamZoom = 0.85; }});
				case 892:
					FlxTween.num(game.defaultCamZoom, 0.6, 0.5, {ease: FlxEase.quintOut, onUpdate: (t)->{ game.defaultCamZoom = t.value; }});
			}
		case 'soundtest':
			var fuckoff = [256, 264, 272, 274, 276, 280, 284, 288, 296, 304, 306, 308, 312, 316];
			for(fuck in fuckoff){
				if(fuck == game.curStep)
					FlxG.camera.zoom = 0.675;
			}
			switch(curStep)
			{
				case 352:
					FlxTween.tween(FlxG.camera, {zoom: 0.8}, 2, {ease: FlxEase.quadIn, onComplete: function(twn:FlxTween){
						game.defaultCamZoom = 0.8;
					}});
				case 384:
					FlxTween.tween(FlxG.camera, {zoom: 0.6}, 0.75, {ease: FlxEase.quintOut, onComplete: function(twn:FlxTween){
						game.defaultCamZoom = 0.6;
					}});
				case 476 | 508:
					FlxTween.tween(FlxG.camera, {zoom: 0.8}, 0.6, {ease: FlxEase.quintOut});
				case 640:
					FlxTween.tween(FlxG.camera, {zoom: 0.9}, 1.5, {ease: FlxEase.quadIn, onComplete: function(twn:FlxTween){
						FlxTween.tween(FlxG.camera, {zoom: 0.8}, 0.5, {ease: FlxEase.bounceOut});
						game.defaultCamZoom = 0.8;
					}});
				case 762:
					FlxTween.tween(FlxG.camera, {zoom: 0.6}, 2, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween){
						game.defaultCamZoom = 0.6;
					}});
			}
	}
}

function goodNoteHit(note){
	if(note.noteType == 'CerealNote'){
		game.dad.playAnim('spit');
		cerealHit();
		// trace('FUCK');
	}
}

function cerealHit()
{
	var chanceCN = FlxG.random.int(1,3);
	var cerealThing:FlxSprite = new FlxSprite().loadGraphic(Paths.image('Cereal' + chanceCN));
	cerealThing.cameras = [game.camHUD];
	cerealThing.screenCenter();
	cerealThing.x = FlxG.random.float(playerStrums.members[0].getGraphicMidpoint().x - 50 - 450, playerStrums.members[3].getGraphicMidpoint().x + 50 - 450);
	var posY = cerealThing.y;
	cerealThing.scale.set(0, 0);
	cerealThing.angle = FlxG.random.int(-25, 25);
	cerealThing.y -= 150;
	add(cerealThing);

	FlxTween.tween(cerealThing, {"scale.x": 0.75, "scale.y": 0.75, angle: 0}, 0.5, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween){
		FlxTween.tween(cerealThing, {"scale.y": 1, y: posY + 400, angle: -5}, 5, {ease: FlxEase.quadOut, onComplete: function(twn2:FlxTween){
			FlxTween.tween(cerealThing, {y: posY + 600, alpha: 0}, 2, {ease: FlxEase.quintOut, onComplete: function(twn3:FlxTween){
				remove(cerealThing);
			}});
		}});
	}});
}