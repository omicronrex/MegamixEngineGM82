#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// The master control object for any boss.

// Creation code:
// healthpoints: The Boss health. Default is 28. This can be used for enemies, too, but I'm restating it here because why not.
// hitInvun: the length of the hit invulnerablilty of the boss, in frames. If this is 1 or lower, they don't have any.
// healthParent: Whatever instance ID this is set to, if the boss takes damage its parent(healthParent) and its brothers will also take damage, if this value is different from -1 the healthbar wont be drawn, so leave this untouched in the healthParent
// syncIFrames : if using a healthParent and this is true, iFrames will be applied to the parent(healthParent) and its brothers
// shareMode : Mode 0: for bosses that share the same healthbar, so if one dies all of them die;
///             Mode 1: for bosses with individual healthbars that are drawn as one
// dieToPits : if true the boss will die if it falls into a pit

// music: just the file name of the music you're using for the boss. MUST BE A STRING
// musicType: Type of file to load. "OGG" loads OGGs, "VGM" loads NSFs/SPCs/VGMs/GBSs
// musicTrackNumber: If musicType is "VGM", it'll use this as the track for the NSF/SPC/VGM/GBS
// musicVolume: 0-1 (the volume of the music; optional)
// musicLoopSecondsStart: 0-song point in seconds (the starting loop point of the music in seconds; optional)
// musicLoopSecondsEnd: 0-song length in seconds (the ending of the loop of the music in seconds; if musicLoopSecondsStart is used, this one is required)

// introType: Type of intro animation.
// // 0 = none (healthbar only fills up when you manually set that the intro is over),
// // 1 = drop in (default), 2 = pop in, 3 = dramatic MM6 animation, 4 = Tier Boss cutscene
// // More info for introType 4 can be found in event user 6.
// cutsceneScript: If set, introType 4 will call this code rather than event user 6.
// lockTransitions: Default true, if it's true, all boss gates and screen transitons lock when the boss is onscreen.
// useEndStageBehavior: Default true, if it's true, ALL music will stop and transitons stay locked on defeat. Otherwise, stage music and transitions resume.
// itemDrop: Can be used for enemies, but important here. The thing the boss drops, as an object. Default objEnergyElement.
// elementName: If itemDrop is objEnergyElement, this is the name of the EE they drop.
// elementScript: If itemDrop is objEnergyElement, this is the script of the EE they drop.
// elementCode: If itemDrop is objEnergyElement, this is the code string of the EE they drop.
// stopOnFlash: If set to true, the enemy will be affected by timestopping weapons. Default false.


// healthBarPrimaryColor[1]: Primary color of the boss' first healthbar. THE [1] IS IMPORTANT. Use the number of the color you want that's on the NES palette reference.
// healthBarSecondaryColor[1]: Secondary color of the boss' first healthbar. THE [1] IS IMPORTANT. Use the number of the color you want that's on the NES palette reference.
// healthBarColorSkip: The number that the healthbar color increments by when a new healthbar is reached, referring to the color numbers in global.nesPalette. Only applies if using automatic coloring.

// manualColors: If set to true, you can define the colors of each healthbar of the boss manually. Instead of
// it relying on the global.nesPalette array, you use make_color_rgb.
// // Example: healthBarPrimaryColor[2] = make_color_rgb(0,0,0). The second healthbar will use that color for primary. Etc.

event_inherited();

//Default weaknesses
var i; for(i =0; i<global.totalWeapons ; i+=1)
{
    enemyDamageValue(global.weaponObject[i], 1);
}

// used for some prtEntity control stuff
boss = 1;
behaviourType = 2;

despawnRange = -1;
respawnRange = -1;
killOverride = false;
blockCollisionStart = noone;
gravStart = 0;


// intro stuff
active = false;
startIntro = false;
isIntro = false;
startFight = 0;
isFight = false;
wasKilled = false;

// BOSS SETTINGS !
music = "Mega_Man_2.nsf";
musicType = "VGM";
musicTrackNumber = 17;
musicVolume = 0.8;
musicLoop = true;
musicLoopSecondsStart = 8.825;
musicLoopSecondsEnd = 61.575;

itemDrop = noone;
elementName = "";
elementScript = scrNoEffect;
elementCode = "";

introType = 1;
introFade = 0;
cutsceneTimer = 0;
cutsceneScript = "";
quickSpawn = false; // If true, it will spawn as a regular enemy
destroyOnDeath = true;
doPlayerExplosion = true; // If true it will use the same death effect as the player
dieToPits = true;
useEndStageBehavior = true;
lockTransitions = true;

stopOnFlash = false;
hitInvun = 45;

forceSpreadSettings = false;

// Generic stuff
facePlayerOnSpawn = true;

healthpoints = 28;
_init = 1;

drawBoss = false; // Should we be visible? (Can't use the 'visible' variable as this prevents the Draw event from executing)
rememberDepth = depth; // for the MM6 intro fade to go under the health bar.
maxFanOutDistance = 80;

// healthbar bs
drawHealthBar = false;
canFillHealthBar = true;
fillingHealthBar = false;

healthBarTimer = 0; // timer for fillup
healthBarTimerMax = 30; // how long will the boss wait between finishing intro and filling healthbar?

healthBarTimerSpeed = 1; // basically health per frame
healthBarTimerSpeedExtra = 0.25;

healthBarPrimaryColor[1] = 34;
healthBarSecondaryColor[1] = 40;
healthBarColorSkip = 1;
manualColors = false;

healthBarHealth = 0;
healthIndex = -1; // If a boss shares a healthbar with another boss set it manually from the create event to the same value(check gemini man or rounder v2 for more details on how to share healthbars)

healthParent = -1;
syncIFrames = false;
shareMode = 0;

dead = false;

// Music storage for restarting it after death
musicStore = "";
musicTypeStore = "";
musicLoopStartStore = 0;
musicLoopEndStore = 1;
musicLoopStore = 0;
musicVolumeStore = 0.8;
musicTrackNumberStore = 0;

// if this is true, boss performs own pre-fight posing animation.
customPose = false;

introLock = false;

canIce = false; // by default, should not be able to freeze bosses
visible = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// HANDLE ACTUAL VISIBLE BOSS
if (entityCanStep())
{
    setTargetStep();

    // Starting the intro pose (and falling down)
    if (startIntro == true)
    {
        if (introType > 0)
        {
            // Intro animations
            visible = true;

            // pop in
            if (introType == 2)
            {
                y = ystart;
                startIntro = false;
            } // Drop or MM6
            else if (introType == 1 || introType == 3)
            {
                y = view_yview[0] - sprite_get_yoffset(sprite_index);
                startIntro = false;
            }
            else if (introType == 4)
            {
                event_user(EV_BOSS_CUTSCENE);
                exit;
            }

            // move on to the actual intro
            isIntro = true;
            if (facePlayerOnSpawn || facePlayer)
                calibrateDirection(); // face player
        }
        grav = 0;
        blockCollision = 0;
        yspeed = 0;
    }

    // Intro animation
    if (isIntro)
    {
        if (introType == 2) // no intro
        {
            isIntro = false;
        }
        else
        {
            // Handle intro if the boss hasn't reached its Y yet
            if (y < ystart)
            {
                if (introType == 1 || introType == 2 || introType == 4)
                {
                    ground = 0;
                    grav = gravAccel;
                }
                else if (introType == 3)
                {
                    if (introFade < 0.4)
                    {
                        introFade += 0.4 / 10;
                    }
                    else
                    {
                        yspeed = 1;
                    }
                }
            }
            else
            {
                if (introFade > 0)
                {
                    introFade -= 0.4 / 10;
                }

                // force up
                if (introType != 0)
                {
                    y = ystart;

                    if yspeed > 0
                    {
                        yspeed = 0;
                    }

                    if (!customPose)
                    {
                        sprite_index = pose; // pose

                        // Start animation
                        if (image_speed == 0)
                        {
                            image_index = 0;
                        }
                        image_speed = poseImgSpeed;

                        if (image_index >= image_number - 1)
                        {
                            image_index = image_number - 1;
                            image_speed = 0;
                            isIntro = false;
                        }
                    }
                }
            }
        }
        if (!isIntro)
        {
            blockCollision = blockCollisionStart;
            grav = gravStart;
        }
    }

    // Starting the actual fight, checking if all other onscreen bosses are done w/ animations
    // in the process.
    if (!wasKilled && (startFight == global.aliveBosses) && (global.aliveBosses > 0))
    {
        lockPoolRelease(introLock);
        startFight = 0;
        isFight = true;
    }

}
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (_init)
{
    healthpointsStart = healthpoints;
    _init = 0;
    if (quickSpawn)
    {
        respawnRange = 0;
        isFight = true;
        drawBoss = true;
        canFillHealthBar = false;
        healthpoints = healthpointsStart;
        isIntro = false;
        introTimer = 0;
    }
    else
    {
        if (itemDrop == noone)
        {
            if (useEndStageBehavior)
                itemDrop = objEnergyElement;
        }
    }
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
// Prevent bosses from healing past their max HP - this means you, Heat Man and Mercury!
if (isFight == true)
{
    if (healthpoints > healthpointsStart)
    {
        healthpoints = healthpointsStart;
    }

    if(dieToPits)
    {
        if( (sign(grav)>0 && bbox_top>global.sectionBottom)
        || sign(grav)<0 && bbox_bottom<global.sectionTop )
            event_user(EV_DEATH);
    }

}
// STARTING THE BOSS SETUP (Triggering it, healthbar fillup)
if (instance_exists(objMegaman) && !global.frozen && !isFight && !wasKilled)
{
    if (!objMegaman.teleporting && !objMegaman.showReady)
    {
        if (insideSection(x, y))
        {
            // s the player and activates the boss (but won't make the boss move yet, it just performs its starting pose)
            // Also plays the boss music
            if (!(active))
            {
                active = true;
                startIntro = true;
                drawBoss = true;
                blockCollisionStart = blockCollision;
                gravStart = grav;
                // Lock player movement, spread out co-op players, make megaman face the boss
                introLock = lockPoolLock(global.playerLock[PL_LOCK_MOVE],
                    global.playerLock[PL_LOCK_SLIDE],
                    global.playerLock[PL_LOCK_SHOOT],
                    global.playerLock[PL_LOCK_TURN],
                    global.playerLock[PL_LOCK_CHARGE],
                    global.playerLock[PL_LOCK_CLIMB],
                    global.playerLock[PL_LOCK_JUMP],
                    global.playerLock[PL_LOCK_PAUSE],
                    global.playerFrozen);

                with (objMegaman)
                {
                    isSlide = false;
                    slideLock = lockPoolRelease(slideLock);
                    slideChargeLock = lockPoolRelease(slideChargeLock);
                    mask_index = mskMegaman;
                    xspeed = 0;
                    yspeed = 0;

                    if (x < other.x)
                    {
                        image_xscale = 1;
                    }
                    else
                    {
                        image_xscale = -1;
                    }
                    if (abs(other.maxFanOutDistance) > 0)
                    {
                        playerFanOut(20 * image_xscale, other.maxFanOutDistance);
                    }
                }

                // Lock the transitions of the room
                if (other.lockTransitions)
                {
                    global.lockTransition = true;
                }

                global.aliveBosses += 1; // Used for multiple bosses being around.

                /*with (prtBoss)
                {
                    if (!quickSpawn&&id != other.id && active && !dead)
                    {
                        global.aliveBosses += 1;
                    }
                }

                if (healthIndex == -1)
                {
                    healthIndex = global.aliveBosses;
                }
                */

                // start music
                if (music != "" && global.aliveBosses == 1)
                {
                    with (prtBoss)
                    {
                        musicStore = global.levelSong;
                        musicTypeStore = global.levelSongType;
                        musicLoopStartStore = global.levelLoopStart;
                        musicLoopEndStore = global.levelLoopEnd;
                        musicLoopStore = global.levelLoop;
                        musicVolumeStore = global.levelVolume;
                        musicTrackNumberStore = global.levelTrackNumber;
                    }

                    stopMusic();
                    playMusic(music, musicType, musicTrackNumber, musicLoopSecondsStart, musicLoopSecondsEnd, musicLoop, musicVolume);

                }
            }

            // Preparing to fill the health bar
            if (canFillHealthBar)
            {
                // If the intro is done check
                if (isIntro == false && startIntro == false)
                {
                    healthBarTimer += 1;

                    if (healthBarTimer >= healthBarTimerMax)
                    {
                        healthBarTimer = 0;
                        canFillHealthBar = false;
                        fillingHealthBar = true;
                        loopSFX(sfxEnergyRestore);
                        drawHealthBar = true;
                    }
                }
            }

            // Filling the health bar
            if (fillingHealthBar)
            {
                // make sure sfx is playing if the healthbar is filling
                if (healthParent==-1&&!audio_is_playing(sfxEnergyRestore))
                {
                    loopSFX(sfxEnergyRestore);
                }

                healthBarTimerSpeed = (healthBarHealth div 28)
                    * healthBarTimerSpeedExtra + 1;

                healthBarTimer += healthBarTimerSpeed;

                if (healthBarTimer >= 3)
                {
                    healthBarHealth += healthBarTimer div 3;
                    healthBarTimer = 0;
                }
                var maxHealth; maxHealth =healthpoints;
                if(shareMode==1)
                {
                    with(prtBoss)
                    {
                        if(id!=other.id&&active&&(healthParent==other.id||(healthParent!=-1&& healthParent==other.healthParent)))
                        {
                            maxHealth+=healthpoints;
                        }
                    }
                }

                if (healthBarHealth >= maxHealth)
                {
                    healthBarHealth = maxHealth;
                    if(shareMode==1)
                    {
                        with (prtBoss)
                        {
                            if (id!=other.id && !dead && (healthParent == other.id || (healthParent != -1 && healthParent == other.healthParent)))
                            {
                                healthBarHealth = other.healthBarHealth;
                            }
                        }
                    }
                    with (prtBoss)
                    {
                        startFight += 1;
                    }
                    fillingHealthBar = false;
                    if (healthParent == -1)
                    {
                        stopSFX(sfxEnergyRestore);
                    }
                }
            }
        }
    }
}
#define Other_16
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// This is used for "tier boss"-esque cutscenes. Until you specifically set startIntro to false,
// the boss will continue to run this code and wait for you to specify it's the end.
// Here is an example cutscene.

// Check if cutsceneScript is set
if (cutsceneScript != "")
{
    script_execute(cutsceneScript);
    exit;
}

// DON'T REMOVE THIS LINE UNLESS YOU KNOW WHAT YOU'RE DOING
if (!instance_exists(objDialogueBox))
{
    cutsceneTimer += 1;
} // Checks for objTextbox so that the cutscene pauses until you advance the textboxes.

// Now, for the actual cutscene.
if (cutsceneTimer == 5) // 5 frames have passed
{
    spawnTextBox(0, -1, "My Boss's Name",c_white,"Mwahaha! I am a boss! Placeholder message!");

    // Make sure to put a -1 in se seconf parameter of each spawnTextBox call like so, as it'll tell the
    // game you're done with that textbox and that it can close it after that message.
    cutsceneTimer += 1; // MAKE SURE YOU DO THIS EVERY TIME YOU SPAWN A TEXTBOX
}
else if (cutsceneTimer == 10) // 5 frame later, MM responds
{
    spawnTextBox(0, -1, "Player Character",c_white,
        "[WITTY COMMENT]");
    cutsceneTimer += 1;
}
else if (cutsceneTimer == 15)
{
    spawnTextBox(0, -1, "My Boss's Name",c_white,
        "To be fair, you have to have a very high IQ to understand Rick and Morty. The humour is extremely subtle, and without a solid grasp of theoretical physics most of the jokes will go over a typical viewer’s head. There’s also Rick’s nihilistic outlook, which is deftly woven into his characterisation- his personal philosophy draws heavily from Narodnaya Volya literature, for instance. The fans understand this stuff; they have the intellectual capacity to truly appreciate the depths of these jokes, to realise that they’re not just funny- they say something deep about LIFE. As a consequence people who dislike Rick & Morty truly ARE idiots- of course they wouldn’t appreciate, for instance, the humour in Rick’s existential catchphrase “Wubba Lubba Dub Dub,” which itself is a cryptic reference to Turgenev’s Russian epic Fathers and Sons. I’m smirking right now just imagining one of those addlepated simpletons scratching their heads in confusion as Dan Harmon’s genius wit unfolds itself on their television screens. What fools.. how I pity them.");
    cutsceneTimer += 1;
}
else if (cutsceneTimer == 20)
{
    startIntro = false; // now start the boss.
    isIntro = true;
}
#define Other_19
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Code for getting hit

iFrames = max(1, hitInvun); // Being able to get hit again

playSFX(sfxEnemyHit);
with(prtBoss)
{
    if(id!=other&&!dead &&((id==other.healthParent || healthParent==other.id)||(healthParent!=-1&&healthParent==other.healthParent)))
    {
        if(shareMode==0)
        {
            healthpoints-=global.damage;

            if(healthpoints<=0)
            {
                event_user(EV_DEATH);
            }
        }
        if(other.syncIFrames&&syncIFrames)
        {
            iFrames += other.iFrames;
        }
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
global.bossTextShown = false;
if (!quickSpawn)
{
    global.aliveBosses = max(0,global.aliveBosses- 1);
}
wasKilled = true;

if (!quickSpawn && global.aliveBosses <= 0)
{
    if (useEndStageBehavior)
    {
        stopMusic();
        audio_stop_all();
    }
    else
    {
        global.lockTransition = false;
        playMusic(musicStore, musicTypeStore, musicTrackNumberStore, musicLoopStartStore, musicLoopEndStore, musicLoopStore, musicVolumeStore);
    }
}
else if(!quickSpawn)
{
    if (healthParent==-1)
    {
        var newParent; newParent = noone;
        with (prtBoss)
        {
            if (id!=other.id && !dead && healthParent == other.id)
            {
                newParent = id;
                healthParent = -1;
                break;
            }
        }
        with (prtBoss)
        {
            if (id != newParent && id != other.id && !dead && healthParent == other.id)
            {
                healthParent = newParent;
            }
        }
    }
}
active = false;

if (doPlayerExplosion)
{
    playSFX(sfxDeath);

    // Classic boss explosion
    var i, explosionID;
    for (i = 0; i < 8; i += 1)
    {
        explosionID = instance_create(bboxGetXCenter(), bboxGetYCenter(),
            objMegamanExplosion);
        explosionID.dir = i * 45;
        explosionID.spd = 0.75;
    }
    for (i = 0; i < 8; i += 1)
    {
        explosionID = instance_create(bboxGetXCenter(), bboxGetYCenter(),
            objMegamanExplosion);
        explosionID.dir = i * 45;
        explosionID.spd = 1.5;
    }
}

// HANDLING ITEM DROPS
if (quickSpawn || global.aliveBosses <= 0)
{
    if (itemDrop == objKey)
    {
        i = instance_create(bboxGetXCenter() - 8, bboxGetYCenter() - 8,
            objKey);
        with (i)
        {
            yspeed = -4;
            homingTimer = 90;
            playSFX(sfxKeySpawn);
        }
    }
    else if (itemDrop == objEnergyElement)
    {
        var a; a = instance_create(bboxGetXCenter() - 8, bboxGetYCenter() - 8, objEnergyElement);
        with (a)
        {
            name = other.elementName;
            script = other.elementScript;
            code = other.elementCode;
        }
    }
    else
    {
        // do item drop like a normal enemy (set itemDrop to 0 for normal random drops like enemies too)
        i = instance_create(bboxGetXCenter(), bboxGetYCenter(), objExplosion);
        i.alarm[0] = 1;
        i.visible = false;
        i.myItem = itemDrop;
    }
}

if (destroyOnDeath)
{
    instance_destroy();
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (spawned)
{
    if (!isFight && !quickSpawn)
    {
        visible = false;
    }
    else
    {
        visible = 1;
        wasKilled=false;
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!dead)
{
    if (drawBoss) // actually draw itself
    {
        if ((iFrames mod 4) < 2 || !iFrames)
        {
            drawSelf();
        }
        else // Hitspark
        {
            draw_sprite_ext(sprHitspark, 0, spriteGetXCenter(), spriteGetYCenter(), 1, 1, 0, c_white, 1);
        }
    }
}
