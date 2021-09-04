#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):

event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "aquatic, nature";

blockCollision = 0;
grav = 0;

facePlayerOnSpawn = true;

// Enemy specific code
animTimer = 0;
started = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (!ground)
    {
        grav = gravAccel;
    }

    if (ground || image_index == 1)
    {
        grav = 0;

        animTimer += 1;
        if (animTimer == 8)
        {
            animTimer = 0;
            if (image_index == 1)
            {
                image_index = 2;
            }
            if (image_index == 2)
            {
                y -= 12;
                yspeed = -5;
                xspeed = 2.5 * image_xscale;
                playSFX(sfxSplash);
                ground = false;
            }
        }
    }
    else
    {
        image_index = 0;
        animTimer = 0;
    }

    // Check water:
    var myWater;
    myWater = instance_place(x, y + yspeed, objWater);
    if (myWater >= 0 && yspeed)
    {
        y = myWater.y - (sprite_get_height(mask_index)
            - sprite_get_yoffset(mask_index) - (sprite_height / 2)
            * (min(0, image_yscale))) * image_yscale;

        while (place_meeting(x, y, myWater))
        {
            y -= yspeed;
        }
        yspeed = 0;
        xspeed = 0;
        if (image_index == 0)
        {
            playSFX(sfxSplash);
            image_index = 1;
            y += 8;
        }
    }
}
else if (dead)
{
    xspeed = 0;
    yspeed = 0;
    image_index = 0;
    animTimer = 0;
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
    yspeed = -5;
    xspeed = 2.5 * image_xscale;
}
