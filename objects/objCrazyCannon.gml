#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A gun with a face, will switch between high and low shots
event_inherited();

healthpointsStart = 5;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "cannons";

// Enemy specific code
state = 0;
timer = 1;
bulletTimes = 0;
init = 1;

//@cc 0 = red (default); 1 = red
col = 0;

// facePlayerOnSpawn = true;
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
        case 1:
            sprite_index = sprCrazyCannonRed;
            break;
        default:
            sprite_index = sprCrazyCannon;
            break;
    }
}


if (entityCanStep())
{
    timer -= 1;
    switch (state)
    {
        case 0:
            if (timer == 0)
            {
                if (bulletTimes == 6)
                {
                    state = 1;
                    timer = 15;
                }
                else
                {
                    timer = 35;
                    playSFX(sfxEnemyShootClassic);
                    a = instance_create(x + (6 * image_xscale), y - 12,
                        objCrazyCannonBullet);
                    a.xspeed = 3.5 * image_xscale;
                    a.yspeed = -2.75;
                    a.inWater = inWater;
                    bulletTimes += 1;
                }
            }
            break;
        case 1:
            if (timer == 0)
            {
                if (image_index == 5)
                {
                    bulletTimes = 0;
                    state = 2;
                    timer = 15;
                }
                else
                {
                    image_index += 1;
                    timer = 8;
                }
            }
            break;
        case 2:
            if (timer == 0)
            {
                if (bulletTimes == 6)
                {
                    state = 3;
                    timer = 15;
                }
                else
                {
                    timer = 35;
                    playSFX(sfxEnemyShootClassic);
                    a = instance_create(x + (6 * image_xscale), y - 12,
                        objCrazyCannonBullet);
                    a.xspeed = choose(.75, 1.25) * image_xscale;
                    a.yspeed = -4.5;
                    a.inWater = inWater;
                    bulletTimes += 1;
                }
            }
            break;
        case 3:
            if (timer == 0)
            {
                if (image_index == 0)
                {
                    bulletTimes = 0;
                    state = 0;
                    timer = 15;
                }
                else
                {
                    image_index -= 1;
                    timer = 8;
                }
            }
            break;
    }
}
else if (dead)
{
    image_index = 0;
    state = 0;
    timer = 1;
}
