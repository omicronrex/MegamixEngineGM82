#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A rabbit that shoots a bunch of harmful carrots towards megaman
event_inherited();

healthpointsStart = 10;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "semi bulky, nature";

facePlayerOnSpawn = true;

// Enemy specific code
jumpTimer = 0;
landtimer = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if(xcoll!=0)
{
    xspeed=xcoll;
}


if (entityCanStep())
{
    if (ground)
    {
        image_index = 0;
        if (landtimer)
        {
            landtimer -= 1;
            image_index = 1;
        }
    }
    else
    {
        image_index = 2;
    }

    if (!ground && xspeed == 0)
    {
        xspeed = image_xscale;
    }

    if (ground)
    {
        xspeed = 0;
        jumpTimer += 1;
        if (jumpTimer == 60 || jumpTimer == 105 || jumpTimer == 150)
        {
            i = instance_create(x, y - 14, objCarrot);
            i.image_xscale = image_xscale;
        }
        if (jumpTimer == 190)
        {
            landtimer = 16;
            image_index = 1;
        }
        if (jumpTimer == 200)
        {
            jumpTimer = 0;
            calibrateDirection();
            yspeed = -4;
            xspeed = image_xscale;
        }
    }
}
else if (dead)
{
    jumpTimer = 0;
    yspeed = -4;
    landtimer = 8;
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
    xspeed = image_xscale;
}
