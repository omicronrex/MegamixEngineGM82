#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

/*
Bird enemy from Chill Man's stage, it flies to just past the middle of the screen
drops the jet egg, and then flees. If either egg or bird is destroyed, the other one
just flies forwards immediately
*/

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "flying, bird";

animTimer = 0;
flameFrame = 0;

hasEgg = true;
phase = 0;
stopX = 0;

spawnEgg = true;
spawnEggReset = spawnEgg;

blockCollision = 0;
grav = 0;
col = 0;
init = 1;

image_speed = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (init)
{
    init = 0;
    spawnEggReset = spawnEgg; // Make sure Swallowegg respawns with its egg
}

if (entityCanStep())
{
    switch (phase)
    {
        case 0: // Set Swallowegg's stopping point and make it fly towards you
            stopX = view_xview + view_wview / 2;
            calibrateDirection();
            xspeed = 3 * image_xscale;
            phase = 1;
            break;
        case 1: // Check to see if Swallowegg has reached the middle of the screen with its egg
            if ((image_xscale == 1 && x >= stopX && hasEgg == true) || (image_xscale == -1 && x <= stopX && hasEgg == true))
            {
                phase = 2;
            }
            break;
        case 2: // Slow down Swallowegg until it's almost two tiles past the middle of the screen
            if ((image_xscale == 1 && x >= (stopX + 28)) || (image_xscale == -1 && x <= (stopX - 28)))
            {
                xspeed = 0;
                phase = 3;
            }
            else
            {
                xspeed -= 0.1 * image_xscale;
            }
            break;
        case 3: // open Swallowegg's claw and drop the egg
            image_index += 2;
            hasEgg = false;
            phase = 4;
            break;
        case 4: // speed up Swallowegg until it reaches the original speed.
            if (xspeed != 3 || xspeed != -3)
            {
                xspeed += 0.1 * image_xscale;
            }
            break;
    }

    if (spawnEgg) // if it can spawn the jet egg, create the egg
    {
        var inst;
        var eggID;
        eggID = id;
        inst = instance_create(x, y + 11, objSwalloweggEgg);
        with (inst)
        {
            respawn = false;
            birdInstanceStore = eggID;
            target = other.target;
        }
        spawnEgg = false;
    }

    animTimer += 1;

    // animate Swallowegg's back flame.

    if (animTimer >= 4)
    {
        if (flameFrame == 0)
        {
            image_index += 1;
            flameFrame = 1;
        }
        else if (flameFrame == 1)
        {
            image_index -= 1;
            flameFrame = 0;
        }
        animTimer = 0;
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Spawn Event
event_inherited();
if (spawned)
{
    animTimer = 0;
    hasEgg = true;
    image_index = 0;
    spawnEgg = spawnEggReset;
    phase = 0;
    image_index = col * 4;
}
