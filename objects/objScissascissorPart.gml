#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// See objScissascissor for more info.

event_inherited();

respawn = false;

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 3;

blockCollision = 0;
grav = 0;

facePlayerOnSpawn = true;

splitWithSpawn = false;

despawnRange = 64;

// Enemy specific code
contactStart = contactDamage;

actionTimer = 0;
parent = noone;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    actionTimer += 1;

    // stop quickly
    if (actionTimer == 10)
    {
        xspeed = 0;
    }

    // curl down
    if (actionTimer == 15)
    {
        image_index = 1;
    }
    if (actionTimer == 20)
    {
        image_index = 2;
    }

    // dash
    if (actionTimer == 30)
    {
        xspeed = 4 * image_xscale;
        yspeed = -3 * image_yscale;
    }

    // check for other parts to combine
    if (instance_exists(parent)&&instance_place(x, y, objScissascissorPart) && actionTimer >= 30)
    {
        playSFX(sfxBoltonAndNutton);
        parent.x = x;
        with (parent)
        {
            visible = true;
            contactDamage = 3;
            canHit = true;
            actionTimer = 0;
            image_index = 1;
        }
        with (instance_place(x, y, objScissascissorPart))
        {
            instance_destroy();
        }
        instance_destroy();
    }
}
else if (dead)
{
    calibrateDirection();
    splitWithSpawn = false;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Since if one of these guys dies, the other's not combining to form the full thing, kill the base
// object that split and is waiting to be reformed.
event_inherited();
with (parent)
{
    dead = true;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// spawn event
event_inherited();

if (spawned)
{
    xspeed = 4 * image_xscale;
}
