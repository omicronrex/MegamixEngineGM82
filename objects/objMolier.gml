#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=other
*/
event_inherited();

healthpointsStart = 5;
healthpoints = healthpointsStart;
contactDamage = 5;

category = "grounded, semi bulky";

facePlayerOnSpawn = true;

// Enemy specific code
timer = 60;
knocked = 0;

imgIndex = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // Landing sfx
    if (ycoll > 0)
    {
        playSFX(sfxBikkyLand);
    }

    // Explode when a wall is hit
    if (xcoll != 0)
    {
        instance_create(x, y, objBigExplosion);
        playSFX(sfxExplosion2);
        healthpoints = 0;
        itemDrop = -1;

        dead = true; //event_user(EV_DEATH);
    }

    // moving towards the player
    if (!knocked)
    {
        if (timer)
        {
            if (ground) // If it fell off a ledge, then face the player after landing after a bit
            {
                timer -= 1;
                if (timer == 8)
                {
                    imgIndex = 2;
                }
                if (!timer)
                {
                    calibrateDirection();
                    imgIndex = 0;
                }
            }
        }
        else
        {
            if (ground) // Drive forward
            {
                xspeed = 1.7 * image_xscale;
            }
            else
            {
                xspeed = 0;
                imgIndex = 0;
                timer = 32;
            }
        }
    }

    // Animate
    if (xspeed != 0)
    {
        imgIndex += 0.25;
        if (imgIndex >= 2)
        {
            imgIndex = imgIndex mod 2;
        }
    }
}
else if (dead)
{
    timer = 60;
    knocked = 0;
    itemDrop = -1;
    xspeed = 0;
    yspeed = 0;
}

image_index = imgIndex div 1;
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
instance_create(bboxGetXCenter(),bboxGetYCenter(),objBigExplosion);
playSFX(sfxExplosion2);
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!knocked && other.object_index == objSlashClaw || other.object_index == objBreakDash)
{
    knocked = 1;
    xspeed = 4.2 * other.image_xscale;

    playSFX(sfxEnemyHit);
    iFrames = 4;
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
    timer = 16;
}
