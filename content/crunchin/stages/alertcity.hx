import openfl.filters.ShaderFilter;
import funkin.utils.CameraUtil;
import funkin.data.Conductor;

var AlertScraperB:BGSprite;
var AlertScraperC:BGSprite;
var AlertScraperD:BGSprite;
var AlertScraperE:BGSprite;
var AlertScraperF:BGSprite;
var AlertScraperG:BGSprite;
var AlertScraperH:BGSprite;
var AlertScraperI:BGSprite;
var AlertScraperJ:BGSprite;

var AlertScraperFireB:BGSprite;
var AlertScraperFireF:BGSprite;
var AlertScraperFireG:BGSprite;
var AlertScraperFireI:BGSprite;
var AlertScraperFireJ:BGSprite;

var AlertPillar1:BGSprite;
var AlertPillar2:BGSprite;
var AlertPillar3:BGSprite;

var alertComic:FlxSprite;
var ifuAlertEnding:FlxSprite;
var ifuAlertEnding2:FlxSprite;

var PillarTween1:FlxTween;
var PillarTween2:FlxTween;
var PillarTween3:FlxTween;

var alertIfu:Bool = false;
var imageShake_Amt:Float = 0;

var stepSize = (Conductor.stepCrotchet / 1000);
// trace(stepSize);

function onLoad(){
    GameOverSubstate.characterName = 'RoachDIE';

    var alertSky:BGSprite = new BGSprite('stages/alert/AlertSky', -900, -480, 0, 0);
    alertSky.setGraphicSize(Std.int(alertSky.width * 0.9));
    alertSky.antialiasing = ClientPrefs.globalAntialiasing;
    add(alertSky); 

    AlertPillar3 = new BGSprite('stages/alert/AlertFarPillars', 570, 760, 0.015, 0.015);
    AlertPillar3.setGraphicSize(Std.int(AlertPillar3.width * 0.8));
    AlertPillar3.antialiasing = ClientPrefs.globalAntialiasing;
    add(AlertPillar3); 

    AlertPillar2 = new BGSprite('stages/alert/AlertMidPillars', 350, 650, 0.03, 0.03);
    AlertPillar2.setGraphicSize(Std.int(AlertPillar2.width * 0.8));
    AlertPillar2.antialiasing = ClientPrefs.globalAntialiasing;
    add(AlertPillar2); 

    ILOVEIFU = new BGSprite('stages/alert/Alert-Ifu', 595, 300, 1, 1, ['Alert-Ifu idle', 'Alert-Ifu ascend'], false, 24);
    ILOVEIFU.scrollFactor.x = 0.04;
    ILOVEIFU.scrollFactor.y = 0.04;
    ILOVEIFU.antialiasing = ClientPrefs.globalAntialiasing;
    ILOVEIFU.visible = false;
    add(ILOVEIFU);

    AlertPillar1 = new BGSprite('stages/alert/AlertClosePillars', -250, 675, 0.06, 0.06);
    AlertPillar1.setGraphicSize(Std.int(AlertPillar1.width * 0.8));
    AlertPillar1.antialiasing = ClientPrefs.globalAntialiasing;
    add(AlertPillar1); 

    var alertFog6:BGSprite = new BGSprite('stages/alert/AlertFog6', -1000, -100, 0.1, 0.1);
    alertFog6.setGraphicSize(Std.int(alertFog6.width * 0.9));
    alertFog6.antialiasing = ClientPrefs.globalAntialiasing;
    add(alertFog6); 

    AlertScraperH = new BGSprite('stages/alert/AlertScraperH', 900, 425, 1, 1, ['AlertScraperH int', 'AlertScraperH dest'], true);
    AlertScraperH.scrollFactor.x = 0.15;
    AlertScraperH.scrollFactor.y = 0.15;
    AlertScraperH.antialiasing = ClientPrefs.globalAntialiasing;
    AlertScraperH.animation.play('AlertScraperH int');
    add(AlertScraperH);

    AlertScraperI = new BGSprite('stages/alert/AlertScraperI', 700, 500, 1, 1, ['AlertScraperI int', 'AlertScraperI dest'], true);
    AlertScraperI.scrollFactor.x = 0.123;
    AlertScraperI.scrollFactor.y = 0.123;
    AlertScraperI.antialiasing = ClientPrefs.globalAntialiasing;
    AlertScraperI.animation.play('AlertScraperI int');
    add(AlertScraperI);

    AlertScraperFireI = new BGSprite('stages/alert/AlertScraperI-fire', 700, 500, 1, 1, ['AlertScraperI-fire int', 'AlertScraperI-fire dest'], true);
    AlertScraperFireI.blend = BlendMode.ADD;
    AlertScraperFireI.scrollFactor.x = 0.123;
    AlertScraperFireI.scrollFactor.y = 0.123;
    AlertScraperFireI.antialiasing = ClientPrefs.globalAntialiasing;
    AlertScraperFireI.animation.play('AlertScraperI-fire int');
    add(AlertScraperFireI);

    AlertScraperJ = new BGSprite('stages/alert/AlertScraperJ', 200, 695, 1, 1, ['AlertScraperJ int', 'AlertScraperJ dest'], true);
    AlertScraperJ.scrollFactor.x = 0.11;
    AlertScraperJ.scrollFactor.y = 0.11;
    AlertScraperJ.antialiasing = ClientPrefs.globalAntialiasing;
    AlertScraperJ.animation.play('AlertScraperJ int');
    add(AlertScraperJ);

    AlertScraperFireJ = new BGSprite('stages/alert/AlertScraperJ-fire', 200, 695, 1, 1, ['AlertScraperJ-fire int', 'AlertScraperJ-fire dest'], true);
    AlertScraperFireJ.blend = BlendMode.ADD;
    AlertScraperFireJ.scrollFactor.x = 0.11;
    AlertScraperFireJ.scrollFactor.y = 0.11;
    AlertScraperFireJ.antialiasing = ClientPrefs.globalAntialiasing;
    AlertScraperFireJ.animation.play('AlertScraperJ-fire int');
    add(AlertScraperFireJ);

    var alertFog5:BGSprite = new BGSprite('stages/alert/AlertFog5', -900, -30, 0.2, 0.2);
    alertFog5.setGraphicSize(Std.int(alertFog5.width * 0.9));
    alertFog5.antialiasing = ClientPrefs.globalAntialiasing;
    add(alertFog5); 

    AlertScraperG = new BGSprite('stages/alert/AlertScraperG', -450, 95, 1, 1, ['AlertScraperG int', 'AlertScraperG dest'], true);
    AlertScraperG.scrollFactor.x = 0.35;
    AlertScraperG.scrollFactor.y = 0.35;
    AlertScraperG.antialiasing = ClientPrefs.globalAntialiasing;
    AlertScraperG.animation.play('AlertScraperG int');
    add(AlertScraperG);

    AlertScraperFireG = new BGSprite('stages/alert/AlertScraperG-fire', -450, 75, 1, 1, ['AlertScraperG-fire int', 'AlertScraperG-fire dest'], true);
    AlertScraperFireG.blend = BlendMode.ADD;
    AlertScraperFireG.scrollFactor.x = 0.35;
    AlertScraperFireG.scrollFactor.y = 0.35;
    AlertScraperFireG.antialiasing = ClientPrefs.globalAntialiasing;
    AlertScraperFireG.animation.play('AlertScraperG-fire int');
    add(AlertScraperFireG);

    AlertScraperF = new BGSprite('stages/alert/AlertScraperF', 1150, -50, 1, 1, ['AlertScraperF int', 'AlertScraperF dest'], true);
    AlertScraperF.scrollFactor.x = 0.45;
    AlertScraperF.scrollFactor.y = 0.45;
    AlertScraperF.antialiasing = ClientPrefs.globalAntialiasing;
    AlertScraperF.animation.play('AlertScraperF int');
    add(AlertScraperF);

    AlertScraperFireF = new BGSprite('stages/alert/AlertScraperF-fire', 1150, -50, 1, 1, ['AlertScraperF-fire int', 'AlertScraperF-fire dest'], true);
    AlertScraperFireF.blend = BlendMode.ADD;
    AlertScraperFireF.scrollFactor.x = 0.45;
    AlertScraperFireF.scrollFactor.y = 0.45;
    AlertScraperFireF.antialiasing = ClientPrefs.globalAntialiasing;
    AlertScraperFireF.animation.play('AlertScraperF-fire int');
    add(AlertScraperFireF);

    var alertFog4:BGSprite = new BGSprite('stages/alert/AlertFog4', -875, 530, 0.5, 0.5);
    alertFog4.setGraphicSize(Std.int(alertFog4.width * 0.9));
    alertFog4.antialiasing = ClientPrefs.globalAntialiasing;
    add(alertFog4); 

    var alertFog3:BGSprite = new BGSprite('stages/alert/AlertFog3', -825, 875, 0.7, 0.7);
    alertFog3.setGraphicSize(Std.int(alertFog3.width * 0.9));
    alertFog3.antialiasing = ClientPrefs.globalAntialiasing;
    add(alertFog3); 

    AlertScraperE = new BGSprite('stages/alert/AlertScraperE', -300, 600, 1, 1, ['AlertScraperE int', 'AlertScraperE dest'], true);
    AlertScraperE.scrollFactor.x = 0.75;
    AlertScraperE.scrollFactor.y = 0.75;
    AlertScraperE.antialiasing = ClientPrefs.globalAntialiasing;
    AlertScraperE.animation.play('AlertScraperE int');
    add(AlertScraperE);

    var alertFog2:BGSprite = new BGSprite('stages/alert/AlertFog2', -790, 1025, 0.8, 0.8);
    alertFog2.setGraphicSize(Std.int(alertFog2.width * 0.9));
    alertFog2.antialiasing = ClientPrefs.globalAntialiasing;
    add(alertFog2); 

    var alertFog1:BGSprite = new BGSprite('stages/alert/AlertFog1', -790, 1200, 0.9, 0.9);
    alertFog1.setGraphicSize(Std.int(alertFog1.width * 0.9));
    alertFog1.antialiasing = ClientPrefs.globalAntialiasing;
    add(alertFog1); 

    var alertBuildingA:BGSprite = new BGSprite('stages/alert/AlertBuildingA', -600, 1300, 1, 1);
    alertBuildingA.setGraphicSize(Std.int(alertBuildingA.width * 1));
    alertBuildingA.antialiasing = ClientPrefs.globalAntialiasing;
    add(alertBuildingA); 

    AlertScraperD = new BGSprite('stages/alert/AlertScraperD', 3100, -300, 1, 1, ['AlertScraperD int', 'AlertScraperD dest'], true);
    AlertScraperD.antialiasing = ClientPrefs.globalAntialiasing;
    AlertScraperD.animation.play('AlertScraperD int');
    add(AlertScraperD);

    AlertScraperC = new BGSprite('stages/alert/AlertScraperC', 2050, -600, 1, 1, ['AlertScraperC int', 'AlertScraperC int'], true);
    AlertScraperC.antialiasing = ClientPrefs.globalAntialiasing;
    AlertScraperC.animation.play('AlertScraperC int');
    add(AlertScraperC);

    AlertScraperB = new BGSprite('stages/alert/AlertScraperB', 600, 200, 1, 1, ['AlertScraperB int', 'AlertScraperB dest'], true);
    AlertScraperB.antialiasing = ClientPrefs.globalAntialiasing;
    AlertScraperB.animation.play('AlertScraperB int');
    add(AlertScraperB);

    alertComic = new FlxSprite();
    alertComic.scrollFactor.set();
    alertComic.frames = Paths.getSparrowAtlas('stages/alert/alert-schmending');
    for(i in 0...7){
        alertComic.animation.addByPrefix('panel' + i, 'alert-schmending ' + (i + 1), 0, false);
    }
    alertComic.animation.play('panel0');
    alertComic.setGraphicSize(Std.int(alertComic.width * 0.6666666667));
    alertComic.cameras = [game.camHUD];
    alertComic.screenCenter();
    alertComic.alpha = 0.000001;

    blackScreen = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
    blackScreen.cameras = [game.camHUD];
    blackScreen.screenCenter();
    blackScreen.scrollFactor.set();
    blackScreen.alpha = 0.000001;

    ifuAlertEnding2 = new FlxSprite().loadGraphic(Paths.image('stages/alert/alert-ending'));
    ifuAlertEnding2.scrollFactor.set();
    ifuAlertEnding2.setGraphicSize(Std.int(ifuAlertEnding2.width * 0.6666666667));
    ifuAlertEnding2.screenCenter();
    ifuAlertEnding2.alpha = 0.0000001;
    ifuAlertEnding2.cameras = [game.camHUD];

    ifuAlertEnding = new FlxSprite();
    ifuAlertEnding.scrollFactor.set();
    ifuAlertEnding.alpha = 0.0000001;
    ifuAlertEnding.cameras = [game.camHUD];
    ifuAlertEnding.setGraphicSize(Std.int(ifuAlertEnding.width * 0.7));
    ifuAlertEnding.frames = Paths.getSparrowAtlas('stages/alert/Alert-EndIfu');
    ifuAlertEnding.animation.addByPrefix('idle', 'Alert-EndIfu idle', 24, true);
    ifuAlertEnding.animation.play('idle');
    ifuAlertEnding.screenCenter();
}

var heatwaveShader = null; 

function onCreatePost(){
    if(ClientPrefs.shaders)
        heatwaveShader = newShader('heatwave');

    add(alertComic);
    add(blackScreen);
    add(ifuAlertEnding2);
    add(ifuAlertEnding);

    alertComic.cameras = [game.camHUD];
    blackScreen.cameras = [game.camHUD];
    ifuAlertEnding2.cameras = [game.camHUD];
    ifuAlertEnding.cameras = [game.camHUD];

    // game.camGame.setFilters(new ShaderFilter(heatwaveShader));
    // game.camHUD.setFilters(new ShaderFilter(heatwaveShader));
    if(ClientPrefs.shaders){
        CameraUtil.addShader(heatwaveShader, game.camGame);
        CameraUtil.addShader(heatwaveShader, game.camHUD);
    }
    
    alertWHITE = new FlxSprite().makeGraphic(Std.int(FlxG.width * 4), Std.int(FlxG.height * 4), FlxColor.WHITE);
    alertWHITE.cameras = [game.camHUD];
}
function onBeatHit(){
    if(game.curBeat % 2 == 0 && alertIfu) ILOVEIFU.dance(true);
}

var heatTime_Amt:Float = 0.0;
var heatwave_Amt:Float = 0.0;
function onUpdate(elapsed){
    if(ILOVEIFU.animation.curAnim.finished && ILOVEIFU.animation.curAnim.name == 'Alert-Ifu ascend') alertIfu = true;

    if(heatwaveShader != null){
        heatTime_Amt += elapsed;
        heatwaveShader.data.uTime.value = [heatTime_Amt];
        heatwaveShader.data.threshold.value = [heatwave_Amt];    
    }
    if(alertComic != null){
        alertComic.offset.set(FlxG.random.float(-imageShake_Amt, imageShake_Amt), FlxG.random.float(-imageShake_Amt, imageShake_Amt));
    }
}

function onEvent(eventName, value1, value2){
    switch(eventName){
        case 'Cam Events':
			{
				switch(value1)
				{
					case 'bump':
						switch(value2)
						{
							case '1':
								FlxG.camera.zoom += 0.02;
								game.camHUD.zoom += 0.01;
							case '2':
								FlxG.camera.zoom += 0.035;
								game.camHUD.zoom += 0.02;
							case '3':
								FlxG.camera.zoom += 0.045;
								game.camHUD.zoom += 0.03;
						}
					case 'turn left':
						switch(value2)
						{
							case '1':
								FlxG.camera.angle += 0.2;
								game.camHUD.angle += 0.2;
					
								FlxTween.tween(FlxG.camera, {angle: 0}, stepSize, {ease: FlxEase.quadOut});
								FlxTween.tween(game.camHUD, {angle: 0}, stepSize, {ease: FlxEase.quadOut});
							case '2':
								FlxG.camera.angle += 4;
								game.camHUD.angle += 3;
					
								FlxTween.tween(FlxG.camera, {angle: 0}, stepSize, {ease: FlxEase.quadOut});
								FlxTween.tween(game.camHUD, {angle: 0}, stepSize, {ease: FlxEase.quadOut});
							case '3':
								FlxG.camera.angle += 10;
								game.camHUD.angle += 5;
					
								FlxTween.tween(FlxG.camera, {angle: 0}, stepSize, {ease: FlxEase.quadOut});
								FlxTween.tween(game.camHUD, {angle: 0}, stepSize, {ease: FlxEase.quadOut});
						}
					case 'turn right':
						switch(value2)
						{
							case '1':
								FlxG.camera.angle -= 0.2;
								game.camHUD.angle -= 0.2;
					
								FlxTween.tween(FlxG.camera, {angle: 0}, stepSize, {ease: FlxEase.quadOut});
								FlxTween.tween(game.camHUD, {angle: 0}, stepSize, {ease: FlxEase.quadOut});
							case '2':
								FlxG.camera.angle -= 10;
								game.camHUD.angle -= 3;
					
								FlxTween.tween(FlxG.camera, {angle: 0}, stepSize, {ease: FlxEase.quadOut});
								FlxTween.tween(game.camHUD, {angle: 0}, stepSize, {ease: FlxEase.quadOut});
							case '3':
								FlxG.camera.angle -= 20;
								game.camHUD.angle -= 5;
					
								FlxTween.tween(FlxG.camera, {angle: 0}, stepSize, {ease: FlxEase.quadOut});
								FlxTween.tween(game.camHUD, {angle: 0}, stepSize, {ease: FlxEase.quadOut});
						}
					case 'add 1 zoom':
						game.defaultCamZoom += 0.1;
					case 'remove 1 zoom':
						game.defaultCamZoom -= 0.1;
					// case 'bump left':
					// 	switch(value2)
					// 	{
					// 		case '1':
					// 		case '2':
					// 		case '3':
					// 	}
					// case 'bump right':
					// 	switch(value2)
					// 	{
					// 		case '1':
					// 		case '2':
					// 		case '3':
					// 	}
				}
			}
        case 'Alert Nuke':
            // game.camHUD.flash(FlxColor.WHITE, 9);
            game.defaultCamZoom = 0.9;

            AlertScraperB.animation.play('AlertScraperB dest');
            AlertScraperD.animation.play('AlertScraperD dest');
            AlertScraperE.animation.play('AlertScraperE dest');
            AlertScraperF.animation.play('AlertScraperF dest');
            AlertScraperFireF.animation.play('AlertScraperF-fire dest');
            AlertScraperG.animation.play('AlertScraperG dest');
            AlertScraperFireG.animation.play('AlertScraperG-fire dest');
            AlertScraperH.animation.play('AlertScraperH dest');
            AlertScraperI.animation.play('AlertScraperI dest');
            AlertScraperFireI.animation.play('AlertScraperI-fire dest');
            AlertScraperJ.animation.play('AlertScraperJ dest');
            AlertScraperFireJ.animation.play('AlertScraperJ-fire dest');
            heatwave_Amt = 0.3; 
            game.boyfriend.playAnim('turning');

        case 'Alert Pillar Far': //this code is fucking messy just roll with it
            PillarTween3 = FlxTween.tween(AlertPillar3, {y: -190}, 10, {ease: FlxEase.sineOut});
            game.camGame.shake(0.001, 24);
            game.camHUD.shake(0.0002, 24);

            new FlxTimer().start(1, function(tmr:FlxTimer) {
                //ScraperJ here :)

                //tower shake
                ShakeTween1 = FlxTween.tween(AlertScraperJ.offset, {y: 2}, 0.1, {ease: FlxEase.linear, type: 4});
                ShakeTween2 = FlxTween.tween(AlertScraperJ.offset, {x: 3}, 0.04, {ease: FlxEase.linear, type: 4});

                //fire shake
                ShakeTween3 = FlxTween.tween(AlertScraperFireJ.offset, {y: 2}, 0.1, {ease: FlxEase.linear, type: 4});
                ShakeTween4 = FlxTween.tween(AlertScraperFireJ.offset, {x: 3}, 0.04, {ease: FlxEase.linear, type: 4});

                //tower fall
                TowerFallTween1 = FlxTween.tween(AlertScraperJ, {y: AlertScraperJ.y + 450}, 11, {ease: FlxEase.sineInOut});
                TowerFallTween2 = FlxTween.tween(AlertScraperJ, {x: AlertScraperJ.x - 300}, 13, {ease: FlxEase.sineInOut});
                TowerFallTween3 = FlxTween.tween(AlertScraperJ, {angle: AlertScraperJ.angle - 90}, 9, {ease: FlxEase.sineInOut});

                //fire fall
                TowerFallTween4 = FlxTween.tween(AlertScraperFireJ, {y: AlertScraperFireJ.y + 450}, 11, {ease: FlxEase.sineInOut});
                TowerFallTween5 = FlxTween.tween(AlertScraperFireJ, {x: AlertScraperFireJ.x - 300}, 13, {ease: FlxEase.sineInOut, onComplete:
                    function (twn:FlxTween)
                    {
                        remove(AlertScraperJ);
                        remove(AlertScraperFireJ);
                    }
                });
                TowerFallTween6 = FlxTween.tween(AlertScraperFireJ, {angle: AlertScraperFireJ.angle - 90}, 9, {ease: FlxEase.sineInOut});
            });

            new FlxTimer().start(4.1, function(tmr:FlxTimer) {
                //ScraperI here

                //tower shake
                ShakeTween5 = FlxTween.tween(AlertScraperI.offset, {y: 3}, 0.1, {ease: FlxEase.linear, type: 4});
                ShakeTween6 = FlxTween.tween(AlertScraperI.offset, {x: 4}, 0.04, {ease: FlxEase.linear, type: 4});

                //fire shake
                ShakeTween7 = FlxTween.tween(AlertScraperFireI.offset, {y: 3}, 0.1, {ease: FlxEase.linear, type: 4});
                ShakeTween8 = FlxTween.tween(AlertScraperFireI.offset, {x: 4}, 0.04, {ease: FlxEase.linear, type: 4});

                //tower fall
                TowerFallTween7 = FlxTween.tween(AlertScraperI, {y: AlertScraperI.y + 500}, 11, {ease: FlxEase.sineInOut});
                TowerFallTween8 = FlxTween.tween(AlertScraperI, {x: AlertScraperI.x + 100}, 13, {ease: FlxEase.sineInOut});
                TowerFallTween9 = FlxTween.tween(AlertScraperI, {angle: AlertScraperI.angle + 60}, 9, {ease: FlxEase.sineInOut});

                //fire fall
                TowerFallTween10 = FlxTween.tween(AlertScraperFireI, {y: AlertScraperFireI.y + 500}, 11, {ease: FlxEase.sineInOut});
                TowerFallTween11 = FlxTween.tween(AlertScraperFireI, {x: AlertScraperFireI.x + 100}, 13, {ease: FlxEase.sineInOut, onComplete:
                    function (twn:FlxTween)
                    {
                        remove(AlertScraperI);
                        remove(AlertScraperFireI);
                    }
                });
                TowerFallTween12 = FlxTween.tween(AlertScraperFireI, {angle: AlertScraperFireI.angle + 60}, 9, {ease: FlxEase.sineInOut});
            });
        case 'Alert Pillar Mid':
            PillarTween2 = FlxTween.tween(AlertPillar2, {y: -300}, 10, {ease: FlxEase.sineOut});
            PillarTween2.startDelay = 1;
            shakeTimer = new FlxTimer().start(1, function(tmr:FlxTimer) {
                game.camGame.shake(0.0015, 24);
                game.camHUD.shake(0.0025, 24);
            
                new FlxTimer().start(3.5, function(tmr:FlxTimer) {
                    //ScraperH here

                    //tower shake
                    ShakeTween1 = FlxTween.tween(AlertScraperH.offset, {y: 5}, 0.1, {ease: FlxEase.linear, type: 4});
                    ShakeTween2 = FlxTween.tween(AlertScraperH.offset, {x: 6}, 0.04, {ease: FlxEase.linear, type: 4});

                    //tower fall
                    TowerFallTween1 = FlxTween.tween(AlertScraperH, {y: AlertScraperH.y + 800}, 13, {ease: FlxEase.sineInOut, onComplete:
                        function (twn:FlxTween)
                        {
                            remove(AlertScraperH);
                        }
                    });
                    TowerFallTween2 = FlxTween.tween(AlertScraperH, {x: AlertScraperH.x + 375}, 13, {ease: FlxEase.sineInOut});
                    TowerFallTween3 = FlxTween.tween(AlertScraperH, {angle: AlertScraperH.angle + 60}, 9, {ease: FlxEase.sineInOut});
                });

                new FlxTimer().start(4, function(tmr:FlxTimer) {
                    //ScraperG here

                    //tower shake
                    ShakeTween5 = FlxTween.tween(AlertScraperG.offset, {y: 6}, 0.1, {ease: FlxEase.linear, type: 4});
                    ShakeTween6 = FlxTween.tween(AlertScraperG.offset, {x: 7}, 0.04, {ease: FlxEase.linear, type: 4});

                    //fire shake
                    ShakeTween7 = FlxTween.tween(AlertScraperFireG.offset, {y: 6}, 0.1, {ease: FlxEase.linear, type: 4});
                    ShakeTween8 = FlxTween.tween(AlertScraperFireG.offset, {x: 7}, 0.04, {ease: FlxEase.linear, type: 4});

                    //tower fall
                    TowerFallTween7 = FlxTween.tween(AlertScraperG, {y: AlertScraperG.y + 1050}, 13, {ease: FlxEase.sineInOut});
                    TowerFallTween8 = FlxTween.tween(AlertScraperG, {x: AlertScraperG.x - 700}, 13, {ease: FlxEase.sineInOut});
                    TowerFallTween9 = FlxTween.tween(AlertScraperG, {angle: AlertScraperG.angle - 90}, 9, {ease: FlxEase.sineInOut});

                    //fire fall
                    TowerFallTween10 = FlxTween.tween(AlertScraperFireG, {y: AlertScraperFireG.y + 1050}, 13, {ease: FlxEase.sineInOut, onComplete:
                        function (twn:FlxTween)
                        {
                            remove(AlertScraperG);
                            remove(AlertScraperFireG);
                        }
                    });
                    TowerFallTween11 = FlxTween.tween(AlertScraperFireG, {x: AlertScraperFireG.x - 700}, 13, {ease: FlxEase.sineInOut});
                    TowerFallTween12 = FlxTween.tween(AlertScraperFireG, {angle: AlertScraperFireG.angle - 90}, 9, {ease: FlxEase.sineInOut});
                });
            });
        case 'Alert Pillar Close':
            PillarTween1 = FlxTween.tween(AlertPillar1, {y: -525}, 10, {ease: FlxEase.sineOut});
            PillarTween1.startDelay = 1;
            shakeTimer2 = new FlxTimer().start(1, function(tmr:FlxTimer) {
                game.camGame.shake(0.002, 14);
                game.camHUD.shake(0.003, 14);

                new FlxTimer().start(1, function(tmr:FlxTimer) {
                    //ScraperF here

                    //tower shake
                    ShakeTween1 = FlxTween.tween(AlertScraperF.offset, {y: 7}, 0.1, {ease: FlxEase.linear, type: 4});
                    ShakeTween2 = FlxTween.tween(AlertScraperF.offset, {x: 7}, 0.04, {ease: FlxEase.linear, type: 4});

                    //fire shake
                    ShakeTween3 = FlxTween.tween(AlertScraperFireF.offset, {y: 7}, 0.1, {ease: FlxEase.linear, type: 4});
                    ShakeTween4 = FlxTween.tween(AlertScraperFireF.offset, {x: 7}, 0.04, {ease: FlxEase.linear, type: 4});

                    //tower fall
                    TowerFallTween1 = FlxTween.tween(AlertScraperF, {y: AlertScraperF.y + 1000}, 13, {ease: FlxEase.sineInOut});
                    TowerFallTween2 = FlxTween.tween(AlertScraperF, {x: AlertScraperF.x + 485}, 13, {ease: FlxEase.sineInOut});
                    TowerFallTween3 = FlxTween.tween(AlertScraperF, {angle: AlertScraperF.angle + 80}, 10, {ease: FlxEase.sineInOut});

                    //fire fall
                    TowerFallTween4 = FlxTween.tween(AlertScraperFireF, {y: AlertScraperFireF.y + 1000}, 13, {ease: FlxEase.sineInOut, onComplete:
                        function (twn:FlxTween)
                        {
                            remove(AlertScraperF);
                            remove(AlertScraperFireF);
                        }
                    });
                    TowerFallTween5 = FlxTween.tween(AlertScraperFireF, {x: AlertScraperFireF.x + 485}, 13, {ease: FlxEase.sineInOut});
                    TowerFallTween6 = FlxTween.tween(AlertScraperFireF, {angle: AlertScraperFireF.angle + 80}, 10, {ease: FlxEase.sineInOut});
                });

                new FlxTimer().start(3, function(tmr:FlxTimer) {
                    //ScraperE here

                    //tower shake
                    ShakeTween5 = FlxTween.tween(AlertScraperE.offset, {y: 7}, 0.1, {ease: FlxEase.linear, type: 4});
                    ShakeTween6 = FlxTween.tween(AlertScraperE.offset, {x: 7}, 0.04, {ease: FlxEase.linear, type: 4});

                    //tower fall
                    TowerFallTween7 = FlxTween.tween(AlertScraperE, {y: AlertScraperE.y + 900}, 13, {ease: FlxEase.sineInOut, onComplete:
                        function (twn:FlxTween)
                        {
                            remove(AlertScraperE);
                        }
                    });
                    TowerFallTween8 = FlxTween.tween(AlertScraperE, {x: AlertScraperE.x - 485}, 13, {ease: FlxEase.sineInOut});
                    TowerFallTween9 = FlxTween.tween(AlertScraperE, {angle: AlertScraperE.angle - 80}, 10, {ease: FlxEase.sineInOut});
                });
            });


        case 'Alert Ifu':
            ILOVEIFU.visible = true;
            ILOVEIFU.animation.play('Alert-Ifu ascend');
        case 'Zoom into Roach':
            game.isCameraOnForcedPos = true;
            
            game.defaultCamZoom = 0.7;
            game.camFollow.x = game.boyfriend.getGraphicMidpoint().x - 100;
            game.camFollow.y = game.boyfriend.getGraphicMidpoint().y - 225;
            // game.snapCamFollowToPos(game.boyfriend.getGraphicMidpoint().x - 100, game.boyfriend.getGraphicMidpoint().y - 225);
            game.modchartTweens.set("alertZoom5", FlxTween.tween(FlxG.camera, {zoom: 0.7}, stepSize * 36, {onComplete: function(twn:FlxTween){
                game.modchartTweens.remove("alertZoom5");
            }}));
        case 'Alert Cutscene 1':
            FlxG.sound.play(Paths.sound('le_alert_cutscene_smiley_face'));
            game.modchartTweens.set("alertZoom4", FlxTween.tween(FlxG.camera, {zoom: 0.7}, stepSize * 14, {onComplete: function(twn:FlxTween){
                game.modchartTweens.remove("alertZoom4");
            }}));

            game.modchartTweens.set("alertFadeOut", FlxTween.tween(blackScreen, {alpha: 1}, stepSize * 14, {onComplete: function(twn){

                
                if(alertComic != null){
                    alertComic.animation.play('panel0');
                }

                game.modchartTweens.remove("alertFadeOut");
            }}));
        case 'Alert Cutscene 2':
            blackScreen.alpha = 0.0000001;

            FlxG.camera.alpha = 0.00000001;
            //camHUD.bgColor.alpha = 1;

            if(alertComic != null){
                alertComic.alpha = 1;
            }
            game.camHUD.flash(FlxColor.WHITE, 1);
            game.playHUD.visible = false;
            heatwave_Amt = 0;
            game.modManager.setValue("alpha", 1);
            game.camZooming = false;
        case 'BlackScreen Event':
            var val1:Float = Std.parseFloat(value1); //duration in steps
            var val2:Float = Std.parseFloat(value2); //target alpha
            if(Math.isNaN(val1)) val1 = 0;
            if(Math.isNaN(val2)) val2 = 1;

            if(val1 < 0) val1 = 0;

            if(val2 < 0) val2 = 0;
            if(val2 > 1) val2 = 1;



            // if(game.modchartTweens.exists("blackScreenFade")){
            //     game.modchartTweens.get("blackScreenFade").cancel();
            //     game.modchartTweens.remove("blackScreenFade");
            // }

            // game.modchartTweens.set("blackScreenFade", FlxTween.tween(blackScreen, {alpha: val2}, Conductor.stepCrotchet * val1 / 1000, {onComplete: function(twn){
            //     game.modchartTweens.remove("blackScreenFade");
            // }}));
        case 'Alert Cutscene 6':
            if(game.modchartTweens.exists("ifuZoomAlert")){
                game.modchartTweens.get("ifuZoomAlert").cancel();
                game.modchartTweens.remove("ifuZoomAlert");

            }
            ifuAlertEnding.alpha = 0;
            ifuAlertEnding2.alpha = 0;
        case 'Alert Cutscene 4':
            game.modchartTweens.set("alertZoom10", FlxTween.tween(game.camHUD, {zoom: 1.3}, 10, {onComplete: function(twn:FlxTween){
                game.modchartTweens.remove("alertZoom10");
            }}));

            game.modchartTweens.set("ifuZoomAlert", FlxTween.tween(ifuAlertEnding2, {alpha: 1}, 10, {onComplete: function(twn:FlxTween){
                game.modchartTweens.remove("ifuZoomAlert");
            }}));
        case 'Alert Cutscene 5':
            ifuAlertEnding2.setGraphicSize(Std.int(ifuAlertEnding2.width * 3));
            ifuAlertEnding.alpha = 1;
        case 'Alert Cutscene 3':
            FlxTween.tween(blackScreen, {alpha: 1}, 3.5);

            game.camZooming = false;
            FlxTween.tween(game.camHUD, {zoom: game.camHUD.zoom + 0.25}, 3.5, {ease: FlxEase.quartIn, onComplete: ()->{ game.camHUD.zoom = 1; }});
            // game.modchartTweens.set("alert CamZoom", FlxTween.tween(game.camHUD, {zoom: 1.2}, 3.5, {onComplete: function(twn){
            //     game.camHUD.zoom = 1;

            //     game.modchartTweens.remove("alert CamZoom");
            // }}));

        case 'Change Comic Panel':
            var val1:Float = Std.parseInt(value1);
            var listThing:String = value2;
            if(Math.isNaN(val1)) val1 = 0;
            
            if(alertComic != null){
                alertComic.visible = true;
                alertComic.animation.play('panel' + val1);
            }

            game.camHUD.zoom += 0.03;
            // game.camZooming = false;

            if(StringTools.contains(listThing, 'flash')){
                var color = StringTools.contains(listThing, 'redflash') ? FlxColor.RED : FlxColor.WHITE;
                game.camHUD.flash(color, 1);
                // game.camHUD.flash(StringTools.contains(listThing, 'redflash') ? FlxColor.RED : FlxColor.WHITE, 1);
            }

            if(StringTools.contains(listThing, 'shake')){
                //camHUD.shake(0.01, Conductor.stepCrotchet * ((listThing.contains('longshake')) ? 32 : 16) / 1000);
                var length = StringTools.contains(listThing, 'longshake') ? 32 : 16;
                // trace(stepSize * length);

                if(StringTools.contains(listThing, 'shakeFadeIn'))
                {
                    // new FlxTimer().start(stepSize * 16, (t)->{
                        FlxTween.num(imageShake_Amt, 15, stepSize * 16, {ease: FlxEase.quadIn, onUpdate: (t)->{ imageShake_Amt=t.value; }, onComplete: ()->{
                            new FlxTimer().start(stepSize * length, (t)->{
                                FlxTween.num(imageShake_Amt, 0, stepSize * 16, {ease: FlxEase.quadIn, onUpdate: (t)->{ imageShake_Amt=t.value; }});
                            });
                        }});
                    // });
                }else{
                    imageShake_Amt = 15;
                    new FlxTimer().start(stepSize * length, (t2)->{
                        FlxTween.num(imageShake_Amt, 0, stepSize, {ease: FlxEase.quadIn, onUpdate: (t)->{ imageShake_Amt=t.value; }});
                    });
                }
                // if(listThing.contains('shakeFadeIn')){
                //     modchartTimers.set("comicShakeFadeIn", new FlxTimer().start((Conductor.stepCrotchet / 1000) * 16, function(tmr:FlxTimer){
                //         modchartTweens.set("comicShakeFade2", FlxTween.tween(this, {imageShake_Amt: 15}, (Conductor.stepCrotchet / 1000) * 16, {ease: FlxEase.quadIn, onComplete: function(twn){
                //             modchartTimers.set("comicShake", new FlxTimer().start((Conductor.stepCrotchet * / 1000) * ((listThing.contains('longshake')) ? 32 : 16), function(tmr:FlxTimer){
                //                 modchartTweens.set("comicShakeFade", FlxTween.tween(this, {imageShake_Amt: 0}, (Conductor.stepCrotchet / 1000) * 16, {ease: FlxEase.quadOut, onComplete: function(twn){
                //                     modchartTweens.remove("comicShakeFade");
                //                 }}));
                                
                //                 modchartTweens.remove("comicShake");
                //             }));
                            
                //             modchartTweens.remove("comicShakeFade2");
                //         }}));
                        
                //         modchartTweens.remove("comicShakeFadeIn");
                //     }));
                // }
                // else
                // {
                //     imageShake_Amt = 15;
                //     modchartTimers.set("comicShake", new FlxTimer().start(Conductor.stepCrotchet * ((listThing.contains('longshake')) ? 32 : 16) / 1000, function(tmr:FlxTimer){
                //         modchartTweens.set("comicShakeFade", FlxTween.tween(this, {imageShake_Amt: 0}, Conductor.stepCrotchet * 16 / 1000, {ease: FlxEase.quadOut, onComplete: function(twn){
                //             modchartTweens.remove("comicShakeFade");
                //         }}));
                        
                //         modchartTweens.remove("comicShake");
                //     }));
                // }
            }
    }
}

function onStepHit(){
    switch(game.curStep){
        case 1792:
            game.modchartTweens.set("alertZoom", FlxTween.tween(FlxG.camera, {zoom: 0.8}, Conductor.stepCrotchet * 36 / 1000, {onComplete: function(twn:FlxTween){
                defaultCamZoom = 0.6;
                
                game.modchartTweens.remove("alertZoom");
            }}));
        case 1840:
            game.modchartTweens.set("alertZoom2", FlxTween.tween(FlxG.camera, {zoom: 0.7}, Conductor.stepCrotchet * 20 / 1000, {ease: FlxEase.quadIn, onComplete: function(twn:FlxTween){
                defaultCamZoom = 0.8;
                
                game.modchartTweens.remove("alertZoom2");
            }}));
    }
}

function onBeatHit(){
    switch(game.curBeat){
        case 465:
            add(alertWHITE);
            game.camGame.shake(0.01, 5);
            game.camHUD.shake(0.01, 5);
        case 472:
            // remove(alertWHITE);
            alertWHITE.visible = false;
            game.defaultCamZoom = 0.9;
            game.camGame.flash(FlxColor.WHITE, 4);
            game.camGame.shake(0.01, 1);
            game.camHUD.shake(0.01, 1);// :)
        case 484:
            game.defaultCamZoom = 0.7;
    }
}