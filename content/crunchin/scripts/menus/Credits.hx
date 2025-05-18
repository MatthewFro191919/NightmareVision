import funkin.objects.TextTracker;
import flixel.addons.transition.FlxTransitionableState;
import funkin.states.MainMenuState;
import Sys;

typedef CreditInfo = {
    fileName:String,
    socials:Array<String>,
    message:String
}

var fileNames:Array<Array<String>> = [
    ['newgrounds', 'promo_ground'], 
    ['twitter', 'promo_twitr'],
    ['youtube', 'promo_yotob']
];

var newInfo:Array<CreditInfo> = [
    {
        fileName: 'grossa', 
        socials: ['https://twitter.com/grossalicious', 'https://grossalicious.newgrounds.com/'], 
        message: "Hi, i am Grossa, the director of this mod\n\nHOLY SHIT, I DIDN'T EXPECT THIS TO ACTUALLY COME TO FRUITION\n\nthe development process has been very turbulent, with a fair chunk of internal struggles. it's been a bit of a mess but it's here and alive now!\n\nthank you to everyone on the team for making this project possible in the first place, and thank you to the people who've held out for this project for as long as it's been cooking\n\nhere's to hoping we can bring the rest of this to fruition!!\n\n\n\n\n\n\n\n\n\n\n\noh, and - lounge."
    },
    {
        fileName: 'duskie',
        socials: ['https://twitter.com/duskiewhy', 'https://www.youtube.com/@DuskieWhy'],
        message: "WHERE AM I\n\nI'm DuskieWhy, you may know me from a few notable projects like  Hit Single, Sonic Legacy, Mario's Madness, and even the dreaded Vs Sonic.EXE. Ever since around late 2021 when the first update of this mod released, I was absolutely obsessed with this mod. It was my #1 hyperfixation for a LONG period of time, I made so many modcharts and cool coding visuals.. I listened to legacy over 4000 times in 2022....\n\nNeedless to say, it was an absolute shocker to be invited to this mod. I am eternally grateful to be able to put my name into a project that means this much to me, I'm extremely proud of all the work I put into this. \n\nI've put serious time into this and I've been on the mod for less than 6 months.. I ported the entire mod over to my personal engine, made EVERYTHING (yes literally everything) softcoded, reworked a TON of backend systems to be easier to manage, and coded all the new songs from scratch! Everything you are seeing or playing in this executable has been coded by me.\n\nA deep and genuine thanks to Grossalicious for allowing me to help with this project. I really cannot put into words how thankful I am for being able to work on this, it's a genuine dream come true.\n\nAlso srife ash decoy dom clover fredrick dan and scrumbo YOU'RE ALL FAT AS FUCK OK?"
    },
    {
        fileName: 'polar',
        socials: ['https://twitter.com/_Polar_Vortex', 'https://www.youtube.com/@polarvortex506'],
        message: "hi!\n\nI am Polar Vortex, the lead programmer for Crunchin' v2.\n\nI programmed almost everything you see in within the mod for version 2 and worked alongside with PHO on version 3!\n\nThis mod has been an absolute joy to work on, from the programming of it to the other people on the team made this journey possible and absolutely awesome.\n\nWe have a lot of awesome things planned and hope that you enjoy what we produced for the mod! :D"
    },
    {
        fileName: 'pho',
        socials: ['https://twitter.com/Phomow1', 'https://www.youtube.com/channel/UCjmtYOy-SiZrAqCAT4aHw9Q'],
        message: "Duskie did most of the programming for this update\n\ncheck out Better Material on music streaming services, I got another album coming soon\n\nDON'T MAKE ME REPEAT MYSELF..."
    },
    {
        fileName: 'dk',
        socials: ['https://twitter.com/Not_Dk_At_All'],
        message: "Had lots of fun on this team, it’s full of really great people that I am happy I got to work with. Even though I am no longer a part of this community I am looking forward to seeing what they make in the future!!"
    },
    {
        fileName: 'neutroa',
        socials: ['https://www.youtube.com/c/Neutroa'],
        message: "i wish-\n\nHi, Grossa here. for the sake of real, totally unfake laws, we can't put neutroa's message here. he either wanted it blank or totally never wrote one. just pretend there's an image of shrek here.\n\ntee hee, shrek is funny. tee. teehee."
    },
    {
        fileName: 'sturm',
        socials: ['https://twitter.com/gurgney', 'https://youtube.com/@churgneygurgney9895?si=4Z1vCnJYA0zvWNfH'],
        message: "Welcome, and thank you for your participation in playing this mods. I think that you will enjoy what is offered Here, and what will be in the future.\n\nI have to give a titanic thank you to LunaISuppose for their graciousness in allowing me the opportunity to bring a small snippet of music they made to fruition, and their patience in not getting on my ass for taking over a fucking year to do so. My thanks extend to Redtv53 of Watery Grave Fame for providing his aid with the vocals near the very end of the song, and I apologize if I neglected to turn some elements of the song down.\n\nWrath Stetic, in fact, did Not create twitter, he is a lying son of a bitch and usurped my place as twitter creator, count your fucking days\n\nhaha, I'm just kidding, that's my joke's powers\n\n\nI hold a deep envy for Franklin's Singular Flake\n\nThere is Always something you can do\n\n- Sturm Video"
    },
    {
        fileName: 'tapwater',
        socials: ['https://twitter.com/Funny_Mechanism'],
        message: "I am Tapwater. Knower of truth. Spreader of truth. They will know the truth. That aside I am the producer Threat and producer of evils yet to come. Stay fucking tuned. This team is pretty cool except for Sturm...lame ass fat ass fuck....",
    },
    {
        fileName: 'luna',
        socials: ['https://youtube.com/channel/UCGO8Xoil8o0-KI7Q3jhukfQ'],
        message: "hello my name is luna (i suppose) (funny)\n\ni originally made alert as a fan concept when i was 13 (i am now 16) but then the team seemed to really enjoy it so they let me on and i got to work on the full thing with sturm :]\n\nfunnily enough crunchin was smth i wanted to work on for a very long time so i am extremely grateful that they liked my work n let me on the team\n\nwould write more but i am not the best at paragraphs so i will just end it here bye bye and thank u for playing :]",
    },
    {
        fileName: 'wrathstetic',
        socials: ['https://twitter.com/wrathstetic'],
        message: "hello people of da world.\n\ni am the man known only as wrath stetic. i didn't really do much for this update but i'm sure as shit here to party\n\ni created the website known as twitter. you might have erm. freaking heard of it? yeah. don't believe sturm's lies\n\ni worked on music for the mod mainly (hope, reunion, rumor), and did sound design and writing here or there maybe\n\nit has been nothing but a pleasure to work with my dearest friends on this mod, even if my work has been somewhat ancillary up to this point\n\nmy heart especially goes out to Sturm, Ironik, Tapwater, Goofee, Sevvy, Scrumbo and RedTV53, for being a constant source of kinship in a life that tends to have its ups and downs\n\ni as well hope i have been a good enough friend to you all\n\nenclosed in this cereal box you will find my headshots and catchphrase\n\nhype yourself up or die\n\nsigned, the Rock's Trick Masta, wrathstetic",
    },
    {
        fileName: 'joey',
        socials: ['https://www.youtube.com/@Joey_Animations', 'https://twitter.com/joey_animations'],
        message: "Hey guys I'm Joey and I'm a little bit musical, I'm a bit like Bach, sort of similar to the one known as Beethoven fire emoji fire emoji sticking out tounge emoji",
    },
    {
        fileName: 'j4k3',
        socials: ['https://twitter.com/J4K3Tweet'],
        message: "Heya, name's Jake how are ya?\n\nIt is I, the fork of the molduga that designed most of the menus, cover arts and a lot of  concept artisticals.\n\nI would like to say that this is an amazing mod to work on with everyone being fantastic people to work along side with. I thank the opportunity to the spectacular grossalicious to developing this project, and hopefully to the future as we go... if we don't all get burnt out to this man behind the slaughter.\n\nAnyhow signing off.\n\nRegards,\n\nJ4K3\n\nP.S, wrath you don't own twitter stop spreading propaganda",
    },
    {
        fileName: 'tani',
        socials: ['https://www.youtube.com/watch?v=pQDCNgGwhhM&list=PLedrfL-Rad12s_PgHoGPachcbJMTIla2R'],
        message: "S'up, name's Tani\n\nI am the certified voice of Ifu, as well as the creator of several visual assets (namely roach's various sprites). Very excited for some of the stuff I got planned for both this mod and others, keep your eyes peeled.\n\nThe team, man, I don't even know where to begin with this. This group of people has helped me through so many bumps without even knowing, I'm not sure I'll ever be able to adequately thank everyone. Though everyone has helped me in some way, there are still some I feel inclined to point out specifically.\n\nTo Polar; If I was told to list every positive thing about you it would end up being a college length thesis, you just radiate light every time I've spoken to you, even during low points you manage to keep the energy high, never change.\n\nTo Frank; We may not have had the smoothest path all the time, but as one of the first people I spoke to in this group, your interactions helped me tear down the walls I had built around myself, and allowed me to be more outspoken with the rest of that initial team, thank you.\n\nTo Sevvy; Ever since we crossed paths you've just been fun to hang around, even in vcs where there isn't really much going on, it's just a comfortable place to be in, BUT PLEASE FOR THE LOVE OF GOD EAT SOMETHING OTHER THAN MCDONALD'S YOU EAT THERE LIKE EVERY DAY FUCKER!!!!\n\nTo Grossa; I can't even begin to describe how much you mean to me, I wish I'd say it more often, but you are by far the most important person in my life. So above all, thank you for just being here, I don't know where I'd be at right now without you.\n\nAnd to everyone else; thank you for being such cool people, despite any disagreements we may have had, you all mean a lot to me.",
    },
    {
        fileName: 'ten',
        socials: ['https://twitter.com/trin96'],
        message: "RAAH WOR RAHH ROWR.... WAH HUFF.\nbear-roar.wav\n\n\n(translation)\nHI 10Tenn here, id like to say i am very honored to have been invited, helped and worked half to death by the team (you guys are awesome). I always wanted to do something as cool as Crunchin but i never thought id be part of the team, and i very big part too.\n\nits was super cool to have done such huge work visually for this update. Animations, backgrounds, etc. It was all very very fun, though........ i will probably ask to revamp things and try and one up myself like always....\nits a bad habit.\n\nokay bye for now\n\nXIAOHONGSHU!!!"
    }
    {
        fileName: 'mac',
        socials: ['https://twitter.com/Macheesecheese'],
        message: "My cereal tastes funny (give it a try why don't you)\nOh yea I do funny pause screen art (some new additional pause screen for this update! I liked the Ravegirl one)n\nI happen to work on Step Right Up (Idk if you know that mod but ehehe)\n\nShoutouts to Penkaru, Danimates, CraftingPony, Niffirg, StanleyMOV, Matt Does VODS, Losttael, SEDAX, Hunterman9924, ThatGuySly,  an\nJoni Denta for playin the previous Crunchin build (awesome people!)\n\nDrink water everyday guys! (thank you for playing horrayy)",
    },
    {
        fileName: 'itcby',
        socials: ['https://twitter.com/itCBY_itCBM'],
        message: "Being on this mod means so much to me, watching people grow and develop they’re own ideas and concepts, into a work of art displayed for thousands of people to enjoy. I didn’t do much to be fair on this project but the concepts and art I did include were things I’ll forever be grateful for…\n\nBeing included in this project once again means the world to me, especially knowing some of my art was shown to have an impact on people who enjoy it. Who knows what the future to this project holds, but whatever it may be, it’ll blow your expectations out of the water like it always have seemed.\n\nLoved this project and team, and we hope you enjoy it,\n\nMany thanks, EJ (ItCBY_ItCBM)",
    },
    {
        fileName: 'frankspole',
        socials: ['https://twitter.com/FranksPole'],
        message: "hi im frank\n\ni dont chart as much as I did anymore, but I do soind design for this le mod !\n\npeed.",
    },
    {
        fileName: 'goofee',
        socials: ['https://twitter.com/goofeesquared'],
        message: "Hi! Goofee here, charter extraordinaire!! I thank you so much for spending your time playing, enjoying our mod, we put so much effort into it.\n\nI know what I did for the mod isn't exactly mind blowing, but man the feeling of working on a team where everyone really meshes well changes your mindset. I love you guys so much!\n\nAnd to the person reading this, whether it be on a video or you actually going through each credit and reading them individually (which I love you if you did), I hope you have a wonderful day. Stay safe, stay blessed. Your favorite clown, goofee :o]",
    },
    {
        fileName: 'tooth',
        socials: ['https://twitter.com/ToothLeft'],
        message: "Heljo, G'day, Yo yo, I'm Tooth, an artist n va doin fun stuff.\n\nI'm le voice actor for ol' trollface n forever alone, and they were real fun to do. The troll voice stuck with me so much that sometimes ill just say shit in that voice, completely unprovoked.\n\nI have loved, and will continue to love workin on this project with everyone involved, it's genuinely been an experience like none other, the love put into the project here is unreal.\n\nSeeing everything develop and come together is a truly magical feeling, especially given the talent and hard work of everyone involved.\n\nI hope whoever's reading has a baller day, and I sincerely hope you enjoy this mod!\n\nOr else i'll have to get you.",
    },
    {
        fileName: 'sevvy',
        socials: ['https://twitter.com/SEVVY077'],
        message: "(THEY TRAPPED ME IN THIS CEREAL BOX-- PLEASE SEND HELP. I CAN'T BREATHE IN HERE)\n\nI created the menu sounds you hear when you select things (AKA I destroyed 2 bowls and got milk all over my kitchen)\n\nI still remember the day the first concept was made for this mod, and it's really heartwarming to know we've made it this far. Everyone involved with this mod has a special place in my heart, and I'm so glad to have been there with them, even if my work was minimal. Thank you for giving me a chance and for sticking around. You've made so many people proud, including me, and I'm excited to see what the future holds.\n\n-sevvy",
    },
    {
        fileName: 'scorch',
        socials: ['https://twitter.com/ScorchVx'],
        message: "Heya, the name’s ScorchVx or Scronch or Spoink or Spoon, however you wanna screw it up.\n\nIt’s been a blast ever since I joined in the crunchin’ team and I couldn’t be more grateful to be given the opportunity to be part of the amazing talent shown here in this mod. I’ve worked on quite a few things here like the concepts and animated sprites for Grimjak’s second phase. It’s been really fun being part of this banger of a mod and I can’t wait for you guys to see what else is in store. Thanks again to Grossa and the rest of the Crunchin’ team for having me be part of the mod and I hope you all have a great day :D",
    },
    {
        fileName: 'redbox',
        socials: ['https://twitter.com/RedTV53', 'https://www.youtube.com/@RedTv53'],
        message: "They call me redtv (they is everyone loler\n\nI did 2 epic face songs and i will do a LOT MORE later down the line,.,. heje hehe\nI also helped out with the end of alert when sturm ran outta ideas (polar cut this bit out if alert isnt in the update\nive had friends in this team for quite a while but getting to work on it and see all the stuff my pals have made has ben an experience to be sure\nthe future of crunchin is bright, stay tuned.,\nalso check out this cool video: https://youtu.be/BoGeRRN5AIc",
    },
    {
        fileName: 'lydian',
        socials: ['https://twitter.com/lydian__music', 'https://www.youtube.com/channel/UCxQTnLmv0OAS63yzk9pVfaw'],
        message: "im lydian\n\nI got brought on to do some stuff for a later update, but I saw that Ravegirl (unnamed at the time) was an idea that was being floated around and decided to make that too. I'm really proud with how it turned out in the end, since happy hardcore is a genre that I had never done before that point, and it gave me an excuse to listen to a ton of S3RL for inspiration (even though I only really used the most popular songs................).\n\nCrunchin' was always one of those mods that I'd never thought I'd get to work on, and honestly I'm glad I was brought on in the end. This releasing is reminding me that FNF can be fun when it wants to be. I've been working on FAF for so long that I forgot what it was like to release something, y'know? It became this sort of, \"Oh, right, that's why I started making stuff!\" moment. \n\nSo, erm, yeah... thats all I got... @lydian.bsky.official if you wanna find me somewhere... Stay Jammin'!"
    },
    {
        fileName: 'scrumbo',
        socials: ['https://twitter.com/scrumbo_', 'https://www.youtube.com/@scrumbo_2096'],
        message: 'hello Gang. im scrumbo_. you may know me from... MDMA ! and . Abuse Jon Mix ! i made YOLO ! shoutout LIL T !'
    }
];

var currentLinks:StringMap = new StringMap();

var startX:Float = 300;
var startY:Float = 0;
var objects:FlxTypedGroup;
var rowAmount = 10;
var positions:Array<FlxPoint> = [];
var offsetX:Float = 0;

var shelf:FlxSprite;
var shelf2:FlxSprite;

var int_selectedBox:Int = -1;
var animationDone:Bool = false;
var offsetNow:Bool = false;
var elapsedMult:Float = 1;
var tween:FlxTween;
var bgBS:FlxSprite;
var descriptionBox:FlxSprite;
var descText:TextTracker;
var vignette:FlxSprite;
var scrollWheel:FlxSprite;

var colorTween:FlxTween;
var tempObj:FlxSprite;
var backbutton:FlxSprite;
var movedBack:Bool = false;

var socialButtons:FlxTypedGroup;
var transition:FlxSprite;
var shrek:FlxSprite; //LOL
var shrekTween:FlxTween;

function create(){
    bgBS = new FlxSprite().makeGraphic(Std.int(FlxG.width * 1.25), Std.int(FlxG.height * 1.25), 0xFFACACBE);
    add(bgBS);

    tempObj = new FlxSprite().makeGraphic(0, 0, 0xFFFFFFFF);

    vignette = new FlxSprite().loadGraphic(Paths.image('newCredits/creditVignette'));
    vignette.scrollFactor.set();
    vignette.screenCenter();
    vignette.alpha = 0;
    add(vignette);
    
    shelf = new FlxSprite().loadGraphic(Paths.image('newCredits/shelf'));
    shelf.scrollFactor.set();
    shelf.screenCenter();
    add(shelf);

    objects = new FlxTypedGroup();
    add(objects);

    shelf2 = new FlxSprite().loadGraphic(Paths.image('newCredits/shelf2'));
    shelf2.scrollFactor.set();
    shelf2.screenCenter();
    add(shelf2);
    
    var yCounter:Int = 0;
    var scale:Float = 0.5;
    var counter = 0;
    for(i in 0...newInfo.length){
        var credit = newInfo[i];

        yCounter = Math.floor(i / rowAmount);
        var sprite = new FlxSprite().loadGraphic(Paths.image('newCredits/' + credit.fileName));
        sprite.setGraphicSize(Std.int(sprite.width * scale));
        sprite.setPosition(startX + ((i - rowAmount * yCounter) * 90), startY + (yCounter * 250));
        sprite.updateHitbox();
        positions[i] = new FlxPoint(sprite.x, sprite.y);
        sprite.ID = i;
        objects.add(sprite);
    }

    descriptionBox = new FlxSprite().makeGraphic(600, FlxG.height, FlxColor.WHITE);
    descriptionBox.alpha = 0.8;
    descriptionBox.setPosition((FlxG.width / 2) - (descriptionBox.width / 2) + 300, (FlxG.height / 2) - (descriptionBox.height / 2) + FlxG.height);
    add(descriptionBox);

    descText = new TextTracker("", 15, 15, 24, descriptionBox.width - 30);
    descText.sprTracker = descriptionBox;
    add(descText);

    scrollWheel = new FlxSprite(FlxG.width - 50).loadGraphic(Paths.image('newCredits/scrollweel'));
    scrollWheel.scale.x = 0.75;
    add(scrollWheel);

    socialButtons = new FlxTypedGroup();
    add(socialButtons);

    shrek = new FlxSprite().loadGraphic(Paths.image('shrek'));
    shrek.screenCenter();
    shrek.alpha = 0.0000001;
    shrek.y += 200;
    add(shrek);

    backbutton = new FlxSprite();
    backbutton.frames = Paths.getSparrowAtlas('backbutton');
    backbutton.animation.addByPrefix('idle', 'backbutton idle', 24, false);
    backbutton.animation.addByPrefix('hover', 'backbutton hover', 24, false);
    backbutton.animation.addByPrefix('confirm', 'backbutton confirm', 24, false);
    backbutton.animation.play('idle');
    backbutton.scrollFactor.set();
    backbutton.setPosition(10, 10);
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

var mouseWheelOffset:Float = 0;
var calculation:Float = 0;

function clamp(val:Float, min:Float, max:Float)
{
    var va:Float = val;
    if(va < min) va = min;
    if(va > max) va = max;
    return va;
}

var scrollActive = false;
var curMouseOffset:Float = -1;
function update(elapsed){
    // if(FlxG.keys.justPressed.R) FlxG.resetState();

    var hovering:Bool = false;

    if (FlxG.mouse.wheel != 0 && !movedBack && offsetNow && animationDone && tween == null && !scrollActive)
    {
        mouseWheelOffset += (FlxG.mouse.wheel * 25);
    }

    var textHeight = descText.frameHeight - FlxG.height;
    calculation = clamp(textHeight, 0, descText.frameHeight);

    var normalValue = (mouseWheelOffset / -calculation);
    var calcHeight = (FlxG.height - scrollWheel.frameHeight);

    scrollActive = false;
    if(!movedBack && offsetNow && animationDone && tween == null){
        if(FlxG.mouse.overlaps(scrollWheel)){
            if(FlxG.mouse.pressed){
                scrollActive = true;

                if(curMouseOffset < 0){
                    curMouseOffset = FlxG.mouse.y - scrollWheel.y;
                }
            }
        }
    }

    if(scrollActive){
        scrollWheel.y = clamp(FlxG.mouse.y - curMouseOffset, 0, calcHeight);
        mouseWheelOffset = textHeight * (scrollWheel.y / -calcHeight);
    }else{
        scrollWheel.y = calcHeight * normalValue;
        curMouseOffset = -1;
    }

    var targetAlpha = (offsetNow && animationDone && tween == null) ? 1 : 0;
    scrollWheel.alpha = FlxMath.lerp(scrollWheel.alpha, targetAlpha, FlxMath.bound(elapsed * 5, 0, 1)); 

    mouseWheelOffset = clamp(mouseWheelOffset, -calculation, 0);

    descText.offset_y = mouseWheelOffset;

    socialButtons.forEach(function(spr:SocialButton){
        if(FlxG.mouse.overlaps(spr)){
            spr.alpha = 1;

            if(FlxG.mouse.justPressed)
                CoolUtil.browserLoad(currentLinks.get(spr.ID));
        }
        else{
            spr.alpha = 0.7;
        }
    });

    if(!offsetNow && tempObj.color != 0xFFFFFFFF && colorTween == null)
    {
        colorTween = FlxTween.color(tempObj, 0.5, tempObj.color, 0xFFFFFFFF, {onComplete: function(twn:FlxTween){
            colorTween = null;
        }});
    }

    if(offsetNow && tempObj.color != 0xFF8A8A8A && colorTween == null)
    {
        colorTween = FlxTween.color(tempObj, 0.5, tempObj.color, 0xFF8A8A8A, {onComplete: function(twn:FlxTween){
            colorTween = null;
        }});
    }

    /*if(int_selectedBox != -1 && animationDone && tween == null && FlxG.keys.justPressed.ESCAPE){
        offsetNow = false;
        tween = FlxTween.tween(objects.members[int_selectedBox], {"scale.x": 0.5, "scale.y": 0.5, x: positions[int_selectedBox].x, y: positions[int_selectedBox].y}, 0.5, {ease: FlxEase.quintInOut, onComplete: function(twn:FlxTween){
            animationDone = false;
            int_selectedBox = -1;
            tween = null;
        }});
    }*/

    var targetPos:FlxPoint = new FlxPoint((FlxG.width / 2) - (descriptionBox.width / 2) + 300, (FlxG.height / 2) - (descriptionBox.height / 2));
    targetPos.y += (!offsetNow) ? FlxG.height : 0;
    descriptionBox.setPosition(FlxMath.lerp(descriptionBox.x, targetPos.x, FlxMath.bound(elapsed * 9, 0, 1)), FlxMath.lerp(descriptionBox.y, targetPos.y, FlxMath.bound(elapsed * 9, 0, 1)));
    
    vignette.alpha = FlxMath.lerp(vignette.alpha, (!offsetNow) ? 0 : 0.5, FlxMath.bound(elapsed * 6, 0, 1));
    offsetX = ((!offsetNow) ? 0 : 225);
    elapsedMult = ((!offsetNow) ? 1 : 0.6);

    shelf.offset.x = FlxMath.lerp(shelf.offset.x, -offsetX, FlxMath.bound(elapsed * 9 * elapsedMult, 0, 1));
    shelf2.offset.x = shelf.offset.x;

    for(i in 0...objects.length){
        var spr = objects.members[(objects.length - 1) - i];
        var point:FlxPoint = new FlxPoint(positions[spr.ID].x, positions[spr.ID].y);
        if(FlxG.mouse.overlaps(spr) && !hovering && int_selectedBox == -1){
            hovering = true;
            point.x -= 25;

            if(FlxG.mouse.justPressed){
                int_selectedBox = spr.ID;
            }
        }

        if(spr.ID != int_selectedBox){
            spr.setPosition(FlxMath.lerp(spr.x, point.x + offsetX, FlxMath.bound(elapsed * 9 * elapsedMult, 0, 1)), FlxMath.lerp(spr.y, point.y, FlxMath.bound(elapsed * 9 * elapsedMult, 0, 1)));
            spr.color = tempObj.color;
        }
        else{
            if(!animationDone && tween == null){
                var curX = positions[spr.ID].x;
                descText.text = newInfo[spr.ID].message;

                currentLinks.clear();
                var _soc = newInfo[spr.ID].socials;
                for(i in 0..._soc.length){
                    var creditButton = new FlxSprite(0,0);
                    var link = _soc[i];
                    if(link.length > 0){
                        for(i in 0...fileNames.length){
                            if(StringTools.contains(link, (fileNames[i][0]))){

                                // trace('newCredits/buttons/' + fileNames[i][1]);
                                creditButton.loadGraphic(Paths.image('newCredits/buttons/' + fileNames[i][1]));
                                creditButton.ID = i;
                                // trace(creditButton.ID);

                                currentLinks.set(i, link);
                            }
                        }
                    }
                    var creditY:Float = FlxG.height - creditButton.height - 15;
                    creditButton.setPosition(15 + (i * (creditButton.width + 15)), FlxG.height + 10);
                    FlxTween.tween(creditButton, {y: creditY}, 0.2, {ease: FlxEase.quadOut, startDelay: 0.05 * i});
                    socialButtons.add(creditButton);
                }

                if(StringTools.contains(newInfo[spr.ID].fileName, "neutroa") && shrek != null){
                    // trace('Errrr what the FUCK?');
                    FlxTween.tween(shrek, {alpha: 0.6}, 22, {startDelay: 2, onComplete: function(twn:FlxTween){
                        FlxG.sound.play(Paths.sound('shrek_roar'));

                        new FlxTimer().start(1, function(tmr){
                            Sys.exit(0);
                        });
                    }});
                }

                tween = FlxTween.tween(spr, {x: curX - 135}, 0.5, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween){
                    new FlxTimer().start(0.235, function(tmr:FlxTimer){
                        offsetNow = true;
                    });
                    tween = FlxTween.tween(spr, {"scale.x": 1, "scale.y": 1, x: 35, y: -18}, 0.75, {ease: FlxEase.quintIn, onComplete: function(twn:FlxTween){
                        tween = FlxTween.tween(spr, {x: 45, y: -18}, 0.5, {ease: FlxEase.elasticOut, onComplete: function(twn:FlxTween){
                            animationDone = true;
                            tween = null;
                        }});
                    }});
                }});
            }
        }
        spr.updateHitbox();
    }

    if(movedBack)
    {
        backbutton.animation.play('confirm');
    }
    else
    {
        if(FlxG.mouse.overlaps(backbutton) && tween == null)
        {
            backbutton.animation.play('hover');

            if(!movedBack && FlxG.mouse.justPressed)
            {
                if(int_selectedBox != -1 && animationDone){
                    mouseWheelOffset = 0;

                    for(button in socialButtons){
                        button.destroy();
                    }

                    if(shrek != null){
                        shrek.alpha = 0.0000001;
                    }

                    socialButtons.clear();

                    FlxG.sound.play(Paths.sound('cancelMenu'));
                    offsetNow = false;
                    tween = FlxTween.tween(objects.members[int_selectedBox], {"scale.x": 0.5, "scale.y": 0.5, x: positions[int_selectedBox].x, y: positions[int_selectedBox].y}, 0.5, {ease: FlxEase.quintInOut, onComplete: function(twn:FlxTween){
                        animationDone = false;
                        int_selectedBox = -1;
                        tween = null;
                    }});
                }else{
                    movedBack = true;
                    
                    FlxTransitionableState.skipNextTransIn = true;
                
                    FlxG.sound.play(Paths.sound('cancelMenu'));
                    transition.animation.play('idle');

                    new FlxTimer().start(1, function(tmr:FlxTimer)
                    {
                        FlxG.switchState(new MainMenuState());
                    });
                }
            }
        }
        else
        {
            backbutton.animation.play('idle');
        }
    }
}
