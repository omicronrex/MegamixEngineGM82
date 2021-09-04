#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// This enemy has a few behaviours depending on you want to ultilize him. In Mega Man 5, he appears stationary, but actually moves to the left to replicate the water bike speeding by.
// The default behaviour for this enemy is how it "appears" in Mega Man 5, but not how he is actually programmed. The below variables can be disabled to get any sort of effect you want with this enemy.

// Creation code (all optional):
// isStationary=false; - use this to make the enemy move towards Mega Man ala Mega Man 5.)

event_inherited();

respawn = true;

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 4;
category = "aquatic, grounded";

blockCollision = 1;
grav = 0;

facePlayerOnSpawn = true;

// Enemy specific code
image_speed = 0.3;

isStationary = true;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (grav)
    {
        // turn around on wall
        xSpeedTurnaround();

        // super fast v go
        if (!isStationary && xspeed == 0 && ground)
        {
            xspeed = 1 * image_xscale;
        }

        // float up in water
        if (place_meeting(x, y + yspeed, objWater))
        {
            yspeed -= 0.5;
            if (yspeed < 0 && yspeed >= -0.25)
            {
                yspeed = 0;
            }
        }
    }
}
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
specialDamageValue(objHornetChaser, 3);
specialDamageValue(objJewelSatellite, 3);
