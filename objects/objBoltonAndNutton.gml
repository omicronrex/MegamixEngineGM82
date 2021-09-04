#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// They appear out of nowhere. Once fully assembled, they will track down Mega Man and attempt to collide
// with him. They can only be damaged after they have fully come together.
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 0; // contact damage is 2, but it isn't set right off the bat

category = "cluster";

grav = 0;
blockCollision = 0;

// Enemy specific code
first = true;

stopOnFlash = false;

realContactDamage = 2;

radius = 5 * 16;
spd = 0.6;
phase = 0;

blinkTimer = 0;

nutton = noone;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (phase == 0)
{
    visible = 0;
}

if (entityCanStep())
{
    if (phase == 1)
    {
        if (!instance_exists(nutton))
        {
            dead = true;
        }
    }

    if (!global.timeStopped)
    {
        switch (phase)
        {
            case 0: // waiting for player
            // deliberately undoing things the parent object does. man, this engine really is built on breadsticks... and run on potatoes (I mean GM8.1 is quite the old potato)
                canHit = false;
                visible = 0;

                // delete nutton if it happens to exist already (usually as a result of flash stopper shenanigans)
                if (instance_exists(nutton))
                {
                    event_user(0);
                }
                if (instance_exists(target))
                {
                    if (abs(target.x - x) < radius)
                    {
                        calibrateDirection();
                        if (image_xscale < 0)
                        {
                            nutton = instance_create(view_xview + 4, y, objNutton);
                        }
                        else
                        {
                            nutton = instance_create(view_xview + view_wview - 4, y, objNutton);
                        }
                        nutton.image_xscale = -image_xscale;

                        canHit = true;
                        contactDamage = realContactDamage;
                        phase = 1;
                        visible = 1;
                    }
                }
                break;
            case 1: // waiting for nutton
                if (blinkTimer < 3)
                {
                    blinkTimer += 1;
                }
                else
                {
                    blinkTimer = 0;
                    if (visible == 0)
                    {
                        visible = 1;
                    }
                    else
                    {
                        visible = 0;
                    }
                }
                if (place_meeting(x, y, objNutton))
                {
                    event_user(0); // delete nutton

                    // start screwing animation
                    blinkTimer = 0;
                    visible = 1;
                    sprite_index = sprBoltonAndNutton;
                    image_index = 0;
                    phase = 2;

                    playSFX(sfxBoltonAndNutton);
                }
                break;
            case 2: // screwing animation
                image_index += 15 / 60;
                if (image_index > image_number - 1)
                {
                    phase = 3;
                }
                break;
            case 3: // chasing the player
                if (instance_exists(target))
                {
                    mp_linear_step(target.x, target.y, spd, false);
                }
                break;
        }
    }
    else
    {
        // so it doesn't freeze with its sprite being completely invisible
        if (phase == 0)
        {
            // the engine keeps setting it to visible no matter what and it's making me mad
            if (visible == 1)
            {
                visible = 0;
            }
        }
        if (phase == 1)
        {
            visible = 1;
        }
    }
}
else if (dead)
{
    phase = 0;
    sprite_index = sprBolton;
    image_index = 0;
    contactDamage = 0;
    event_user(0); // Delete Nutton
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Deletes Nutton
if (nutton != noone && instance_exists(nutton))
{
    with (nutton)
    {
        instance_destroy();
    }

    nutton = noone;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Reflect Projectiles
if (phase != 3)
{
    other.guardCancel = 1;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (spawned)
{
    visible = false;
}

event_inherited();
