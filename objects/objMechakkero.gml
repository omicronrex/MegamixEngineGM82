#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "grounded";

facePlayerOnSpawn = true;

// Enemy specific code
contactStart = contactDamage;
jumpTimer = 40;

col = 0; // 0 = red; 1 = yellow;
init = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (init)
{
    init = 0;
    switch (col)
    {
        case 0:
            sprite_index = sprMechakkeroRed;
            break;
        case 1:
            sprite_index = sprMechakkeroYellow;
            break;
    }
}

event_inherited();
if(xcoll!=0)
{
    xspeed=xcoll;
}


if (entityCanStep())
{
    if (ground)
    {
        xspeed = 0;
        jumpTimer += 1;
        if (jumpTimer < 10)
        {
            image_index = 1;
        }
        else
        {
            image_index = 0;
        }
        if (jumpTimer == 60)
        {
            calibrateDirection();
            jumpTimer = 0;
            y -= 4;
            yspeed = choose(-3, -4.5);
        }
    }
    else
    {
        image_index = 2;
        xspeed = image_xscale * 2;
    }
}
else if (dead)
{
    jumpTimer = 0;
    image_index = 0;
}
