#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Octobulb
// Mandatory creation code: myFlag: the id of the switch handler, wich is activated by other
// objects, such as sheepman conveyors.
// You might need octobulb yoku blocks.
// The switch handler will be set to binary automatically
// You can optionally change maxEnergy.
event_inherited();

// Entity setup
canHit = false;
canDamage = false;
contactDamage = 4;
healthpointsStart = 20;
healthpoints = 20;
blockCollision = false;
grav = 0;
doesIntro = false;

category = "bulky, nature";

// Enemy specific code

//@cc flag of the switch handler
myFlag = 0;

//@cc weather its sparks use the rail system
useRails = false;

body = instance_create(x, y, prtAlwaysActive);
body.sprite_index = sprOctobulbBody;
body.image_index = 0;
body.depth = 3;

sprite_index = sprOctobulbHead;
x += 80;
xstart = x;

lockID = 0;



// AI
phase = 0; // Intro
timer = -1;
jellyfishTimer = 0;
activeTimer = 0;
energy = 0;
expectedEnergy = 0;

//@cc How much energy it needs to be fully charged? default: 120
maxEnergy = -1;

anim = 0;
animFrame = -1;
animSpeed = 0;
animTimer = -1;
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
global.flagParent[myFlag].flagOffLength = 1;
global.flagParent[myFlag].stayActive = 2;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    var prevAnim; prevAnim = anim;
    if (maxEnergy == -1)
    {
        maxEnergy = 120; // Default Value
    }
    var ph; ph = phase;
    var addEnergy; addEnergy = false;
    if (ph == 1 && place_meeting(x, y, objThunderBeam))
    {
        addEnergy = true;
        energy = maxEnergy;
    }
    with (body)
    {
        if (instance_exists(objOctobulbEnergy)) // Get energy
        {
            with (objOctobulbEnergy)
            {
                if (place_meeting(x, y, other))
                {
                    instance_destroy();
                    if (ph == 1)
                        addEnergy = true;
                }
            }
        }
        if (addEnergy)
        {
            other.energy = min(other.maxEnergy, other.energy + 12);
            if (other.energy > other.maxEnergy * 0.5)
            {
                other.anim = 2;
            }
            if (other.energy == other.maxEnergy)
            {
                other.anim = 3;
                other.phase = 2;
                other.timer = -1;
            }
        }
    }

    switch (phase)
    {
        case 0:
            if (timer == -1) // Intro, it finnishes once the animation is finnished
            {
                timer = 0;
                animSpeed = 0;
                global.lockTransition = true;
                lockID = playerLockMovement();
                canHit = false;
                canDamage = false;
                energy = 0;
                expectedEnergy = 0;
            }
            else if (timer >= 0)
            {
                timer += 1;
                if (timer > 20)
                {
                    timer = -2;
                    animSpeed = 0.2;
                    animTimer = -1;
                    animFrame = -1;
                }
            }
            break;
        case 1: // Inactive, shoots jellyfish and waits for energy
            if (timer == -1)
            {
                timer = 0;
                animSpeed = 0;
                canHit = false;
                canDamage = false;
                anim = 1;
                expectedEnergy = 0;
                jellyfishTimer = 0;
                energy = 0;
            }
            if (global.flag[myFlag] == 1) // Check if the switch's timer is changing
            {
                timer += 1;
                if (timer > 65)
                    timer = 0;
            }
            else
            {
                timer = 0;
                if (energy > 0 && expectedEnergy < maxEnergy)
                {
                    other.anim = 3;
                    other.phase = 2;
                    other.timer = -1;
                    if (other.energy < maxEnergy * 0.5)
                        other.energy = maxEnergy * 0.5;
                }
            }
            if (timer != -1)
            {
                // spawn Jellyfish


                if (!instance_exists(objOctobulbInk) && !instance_exists(objOctobulbJellyfish))
                {
                    jellyfishTimer += 1;
                    if (jellyfishTimer > 50)
                    {
                        instance_create(x + 31, y + 53, objOctobulbInk);
                        jellyfishTimer = 0;
                    }
                }



                var side; side = -1;
                var ox; ox = x - 80;
                var en; en = noone;
                if (instance_exists(objMegaman))
                {
                    with (objMegaman)
                    {
                        if (x > (other.x + (abs(other.bbox_right - other.bbox_left) / 2)))
                            side = 1;
                    }
                }
                var ordr; ordr = 0;

                if (expectedEnergy < maxEnergy)
                {
                    var i; i = 0;
                    repeat (2)
                    {
                        switch (timer)
                        {
                            case 5:
                                if (side == -1)
                                {
                                    en = instance_create(ox + 3, y + 159, objOctobulbEnergy);
                                }
                                else
                                {
                                    en = instance_create(ox + 214, y + 159, objOctobulbEnergy);
                                }
                                en.order = 0;
                                break;
                            case 25:
                                if (side == -1)
                                    en = instance_create(ox + 34, y + 159, objOctobulbEnergy);
                                else
                                    en = instance_create(ox + 182, y + 159, objOctobulbEnergy);
                                en.order = 1;
                                break;
                            case 45:
                                if (side == -1)
                                {
                                    en = instance_create(ox + 66, y + 159, objOctobulbEnergy);
                                }
                                else
                                {
                                    en = instance_create(ox + 150, y + 159, objOctobulbEnergy);
                                }
                                en.order = 2;
                                break;
                        }
                        if (en != noone)
                        {
                            en.dir = side * -1;
                            with (en)
                                event_user(0);
                            en.path_position = i;
                            en.visible = true;
                            en.dead = false;
                            expectedEnergy += maxEnergy / 10;
                        }
                        else
                        {
                            break;
                        }
                        i += 0.05;
                        playSFX(sfxOctobulbEnergy);
                    }
                }
            }

            break;
        case 2: // Activated
            if (timer == -1)
            {
                anim = 3;
                canHit = true;
                canDamage = true;
                timer = 0;
            }
            else if (timer >= 0)
            {
                energy -= 0.5;
                if (energy > 6 && energy < 20)
                {
                    anim = 4;
                }
                if (energy <= 6)
                {
                    anim = 2;
                }
                if (energy <= 0)
                {
                    anim = 1;
                    event_user(0);
                    timer = -2;
                    canHit = false;
                    canDamage = false;
                }
            }
            else if (timer <= -2)
            {
                timer -= 1;
                if (timer < 180)
                {
                    phase = 1;
                    expectedEnergy = 0;
                    energy = 0;
                }
            }
            break;
    }

    // Animate
    animTimer += animSpeed;
    if (anim != prevAnim)
    {
        animTimer = -1;
        animFrame = -1;
    }
    if (animTimer > 1 || animTimer == -1)
    {
        animFrame += 1;
        animTimer = 0;
        switch (anim)
        {
            case 0: // appear
                if (animFrame > 2) // Begin the fight
                {
                    animFrame = 2;
                    playerFreeMovement(lockID);
                    timer = -1;
                    anim = 1;
                    canHit = false;
                    canDamage = false;
                    phase = 1;
                }
                image_index = animFrame;
                break;
            case 1:
                image_index = 2;
            case 2:
            case 3:
                image_index = anim + 1;
                break;
            case 4: // Flashing
                animSpeed = 0.4;
                if (animFrame > 1)
                    animFrame = 0;
                if (animFrame == 0)
                {
                    image_index = 3;
                    body.image_index = 3;
                }
                else if (animFrame == 1)
                    image_index = 4;
                break;
        }
        body.image_index = image_index;
    }
}
else if (dead)
{
    if (killed)
        image_index = 5;
    else
        image_index = 0;
    phase = 0;
    timer = -1;
    anim = 0;
    animFrame = -1;
    animSpeed = 0;
    animTimer = -1;
    canHit = false;
    canDamage = false;
    jellyfishTimer = 0;
    body.image_index = 0;
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
alarm[0] = 1;
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Shooting

var sp1;
var sp2;

if (!useRails)
{
    sp1 = instance_create(x + 103 - 90, y + 70, objOctobulbBigSpark);
    sp2 = instance_create(x + 124 - 90, y + 70, objOctobulbBigSpark);
    with (sp1)
    {
        grav = 0;
        blockCollision = false;
        sprite_index = sprOctobulbBigSpark;
        image_speed = 0.45;
        path_start(pthOctobulbBigSpark1, 3, path_action_stop, false);
    }
    with (sp2)
    {
        grav = 0;
        blockCollision = false;
        sprite_index = sprOctobulbBigSpark;
        image_speed = 0.45;
        path_start(pthOctobulbBigSpark2, 3, path_action_stop, false);
    }
    sp1.parent = id;
    sp2.parent = id;
}
else
{
    sp1 = instance_create(x + 103 - 90, y + 70, objOctobulbRailSpark);
    sp2 = instance_create(x + 124 - 90, y + 70, objOctobulbRailSpark);
    sp1.parent = id;
    sp2.parent = id;
}

playSFX(sfxOctobulbShoot);
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
global.lockTransition = false;
body.image_index = 0;
if (instance_exists(objOctobulbJellyfish))
{
    with (objOctobulbJellyfish)
    {
        if (!dead)
        {
            event_user(10);
            instance_destroy();
        }
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
image_index = 0;
animFrame = -1;
image_speed = 0;
