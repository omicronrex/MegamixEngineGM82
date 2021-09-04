#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
    Pico bricks.
    Simply place any number of these in a room and they will become a boss fight.
    Set the "priority" variable in creation code to determine the order they will
    spawn.
    negative priority means the brick will never be used.
    If more than two bricks share a priority, they will appear in
    a random order.
*/
event_inherited();

enemyDamageValue(objBusterShotCharged, 3);

respawnRange = -1; // set to -1 to make infinite
despawnRange = -1; // set to -1 to make infinite

canHit = false;
grav = 0;
blockCollision = false;
isSolid = true;
contactDamage = 5;

hpmax = 0;
hp = 0;

// @cc the number in order that the pico bricks go. Since they come in twos, there
// should be two bricks each that have the same priority number.
priority = 0;

// @cc if set to true, this will be the pico brick that settings such as music,
// item drops, etc will be read off of.
settingTransplant = false;

phase = 0;
phaseTimer = 0;

moveSpeed = .9 + (global.difficulty == DIFF_HARD * .75);

shiftVisible = 2;

// Ignore this. This is used for setting transplant
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

useEndStageBehavior = true;
lockTransitions = true;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

xspeed = 0;
yspeed = 0;

if (entityCanStep())
{
    if (phase == 1)
    {
        if (isSolid)
        {
            // setup
            isSolid = false;

            var ax; ax = x;
            if (image_xscale < 0)
                ax -= 16;

            // place brick beneath
            instance_create(ax, y, objSolid);
            tile_add(tstMM2Wily2, 48, 48, 16, 16, ax, y, depth);
            visible = true;
            depth -= 1;
            exit;
        }

        // make sure partner exists:
        if (!instance_exists(partner))
        {
            with (objPicoControl)
                puyoBrickIndex += 2;
            instance_destroy();
            exit;
        }

        if (partner.y != y)
        {
            // unusual circumstance: nearby x and y; move apart
            if (((partner.x - x < 0 && image_xscale == -1)
                || (partner.x - x > 0 && image_xscale == 1))
                && abs(partner.y - y) < 48)
                x += image_xscale * moveSpeed;
            else
            {
                // move up/down to partner
                var yDir; yDir = sign(partner.y - y)
                    ;
                if (abs(partner.y - y) < spd)
                    y = partner.y;
                else
                {
                    y += yDir * moveSpeed;
                }
            }
        }
        else
        {
            // move left/right to partner
            if (abs(partner.x - x) > 1.5 * moveSpeed)
            {
                var xDir; xDir = sign(partner.x - x);
                x += xDir * moveSpeed;
            }
            else
            {
                // merge into Puyo Kun
                if (!instance_exists(objPicoKun))
                {
                    with (instance_create(x / 2 + partner.x / 2, y + 12, objPicoKun))
                    {
                        spd = other.spd;
                        respawn = false;
                        contactDamage = other.contactDamage;
                    }
                }

                // If on hard mode, create a bullet spread
                if (global.difficulty == DIFF_HARD)
                {
                    playSFX(sfxEnemyShootClassic);

                    // I use a for loop here to avoid copypasting code.
                    for (i = -1; i <= 1; i += 2)
                    {
                        with (instance_create(x, y, objEnemyBullet))
                        {
                            xspeed = other.i;
                            yspeed = -6;
                            grav = gravAccel;
                        }
                    }
                }

                // destroy the actual bricks
                with (partner)
                {
                    instance_destroy();
                }
                instance_destroy();
            }
        }
    }
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// determine if this section already has a control object
var controllerExists; controllerExists = false;

setSection(x, y, false);

with (objPicoControl)
{
    if (sectionLeft == other.sectionLeft && sectionTop == other.sectionTop)
        controllerExists = true;
}

// create control object
if (!controllerExists)
{
    with (instance_create(x + 8, y + 8, objPicoControl))
    {
        sectionLeft = other.sectionLeft;
        sectionTop = other.sectionTop;

        // construct list of puyo bricks, sorted by appearance order.
        puyoBrickN = 0;
        puyoBrickIndex = 0;

        // construct sorted list of priorities:
        var puyoBrickPriorities;
        with (objPicoBrick)
        {
            setSection(x, y, false);
            if (other.sectionLeft == sectionLeft && other.sectionTop == sectionTop)
            {
                if (priority >= 0)
                {
                    puyoBrickPriorities[other.puyoBrickN] = priority;
                    other.puyoBrickList[other.puyoBrickN] = id;
                    other.puyoBrickN+=1;
                }
            }

            // If set to true, this pico brick will transfer all settings
            if (settingTransplant)
            {
                other.music = music;
                other.musicType = musicType;
                other.musicTrackNumber = musicTrackNumber;
                other.musicVolume = musicVolume;
                other.musicLoop = musicLoop;
                other.musicLoopSecondsStart = musicLoopSecondsStart;
                other.musicLoopSecondsEnd = musicLoopSecondsEnd;

                other.itemDrop = itemDrop;
                other.elementName = elementName;
                other.elementScript = elementScript;
                other.elementCode = elementCode;

                other.useEndStageBehavior = useEndStageBehavior;
                other.lockTransitions = lockTransitions;
            }
        }
        if (puyoBrickN > 0)
            quickSortBy(puyoBrickList, puyoBrickPriorities);

        /// guarantees even set of puyo bricks
        puyoBrickN = floorTo(puyoBrickN, 2);
        if (puyoBrickN == 0)
            instance_destroy();
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// should destroy in case player comes back to room.
instance_destroy();
