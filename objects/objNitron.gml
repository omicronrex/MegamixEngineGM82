#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// When Mega Man is close, it swoops down and drops three fireballs that spout into small flame geysers
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "fire, floating";

grav = 0;
blockCollision = 0;

// Enemy specific code
phase = 0;
radius = 4.5 * 16;
dipTimer = 0;

image_speed = 0.1;

//@cc 0 = blue; 1 = orange;
col = 0;
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
            sprite_index = sprNitronBlue;
            break;
        case 1:
            sprite_index = sprNitronOrange;
            break;
    }
}

event_inherited();

if (entityCanStep())
{
    switch (phase)
    {
        // start movement towards mega man
        case 0:
            if (instance_exists(target))
            {
                calibrateDirection();
                xspeed = 1 * image_xscale;
                phase = 1;
            }
            break;
        // flying towards megaman
        case 1:
            if (instance_exists(target))
            {
                if (abs(target.x - x) <= radius)
                {
                    phase = 2;
                    xspeed = 1.5 * image_xscale;
                    yspeed = 2;
                }
            }
            break;
        // dip down & shoot
        case 2:
            if (dipTimer == 0 || dipTimer == 25 || dipTimer == 50)
            {
                fire = instance_create(x, y + sprite_height / 2,
                    objNitronFire);
                fire.col = col;
            }
            if (dipTimer == 75)
            {
                phase = 3;
                xspeed = 0;
                yspeed = -3;
            }
            yspeed -= 0.05;
            dipTimer += 1;
            break;
        // fly away
        case 3: // don't need to do anything here  :P
    }
}
else if (dead)
{
    phase = 0;
    dipTimer = 0;
}
