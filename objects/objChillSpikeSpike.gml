#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// This enemy has a few behaviours depending on you want to ultilize him. In Mega Man 5, he appears stationary, but actually moves to the left to replicate the water bike speeding by.
// The default behaviour for this enemy is how it "appears" in Mega Man 5, but not how he is actually programmed. The below variables can be disabled to get any sort of effect you want with this enemy.

// Creation code (all optional):
// hasGravity=false; - use this to turn off this enemies' gravity effect.)
// isStationary=false; - use this to make the enemy move towards Mega Man ala Mega Man 5.)

event_inherited();

respawn = true;

stopOnFlash = false;

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;

// Enemy specific code
calibrateDirection();

cooldownTimer = 60;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!respawn && !instance_exists(objChillMan))
{
    instance_destroy();
    exit;
}

if (entityCanStep())
{
    if (image_index < 1)
    {
        image_index += 0.25;
    }
    if (cooldownTimer > 0)
    {
        cooldownTimer -= 1;
    }
    else
    {
        event_user(EV_DEATH);
    }

    if (instance_exists(target))
    {
        if (place_meeting(x, y, target))
        {
            event_user(EV_DEATH);
        }
    }
}
else if (dead)
{
    image_index = 0;
    cooldownTimer = 60;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
dead = 1;

playSFX(sfxChillSpikeShatter);
for (i = 0; i < 2; i += 1)
{
    MET = instance_create(bboxGetXCenter(), bboxGetYCenter(),
        objChillDebry);
    MET.xspeed = -choose(0.25, 0.5);
    if (i == 1)
    {
        MET.xspeed *= -1;
    }
    MET.image_index = irandom(2);
    MET.image_xscale = choose(-1, 1);
    MET.yspeed = -0.25 * irandom(12);
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.difficulty == DIFF_HARD)
{
    other.guardCancel = 1;
}
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
specialDamageValue(objHornetChaser, 0);
specialDamageValue(objJewelSatellite, 1);
