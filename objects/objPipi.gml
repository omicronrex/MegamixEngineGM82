#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A flying robot that drops eggs full of baby pipies that will fly towards Meagaman
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "flying, bird";

animTimer = 0;
hasEgg = true;

blockCollision = 0;
grav = 0;

//@cc 0 = red, 1 = orange, 2 = yellow
col = 0;

init = 1;
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
    switch (col)
    {
        default:
            sprite_index = sprPipi;
            break;
        case 1:
            sprite_index = sprPipiOrange;
            break;
        case 2:
            sprite_index = sprPipiYellow;
            break;
    }
}


if (entityCanStep())
{
    if (xspeed == 0)
    {
        calibrateDirection();
        xspeed = 2 * image_xscale;
    }

    animTimer += 1;

    if (animTimer >= 8 && hasEgg)
    {
        if (image_index == 0)
        {
            image_index = 1;
        }
        else if (image_index == 1)
        {
            image_index = 0;
        }
        animTimer = 0;
    }

    if (collision_rectangle(x - 48, y - 512, x + 48, y + 512, target, false, true) && hasEgg)
    {
        image_index = 2;
        hasEgg = false;
        var ID = instance_create(x, y + 3, objPipiEgg);
        ID.col = col;
        ID.image_xscale = image_xscale;
    }
}
else if (dead)
{
    animTimer = 0;
    hasEgg = true;
    image_index = 0;
}
