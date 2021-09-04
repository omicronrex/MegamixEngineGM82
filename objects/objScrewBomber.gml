#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// An enemy that acts as a turret. When you get close, they will rise up and shoot a spray of
// 5 shots and then rise back down again. It's harder to hit it when it's down. You can
// also flip its yscale in -1, so that it's placed on the ceiling.

// Creation code (all optional):
event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 1;

category = "cannons, grounded";

grav = 0;

// Enemy specific code

//@cc 0 = red (default); 1 = orange; 2 = blue
col = 0;

init = 1;

timer = 0;
phase = 1;
bullet = 0;
animTimer = 0;

radius = 100;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// switch colors when it spawns
if (init)
{
    init = 0;
    switch (col)
    {
        case 0:
            sprite_index = sprScrewBomberRed;
            break;
        case 1:
            sprite_index = sprScrewBomberOrange;
            break;
        case 2:
            sprite_index = sprScrewBomberBlue;
            break;
    }
}

event_inherited();

if (entityCanStep())
{
    timer += 1;

    switch (phase)
    {
        case 1: // wait / Look for target
            if (target)
            {
                if (distance_to_object(target) <= radius)
                {
                    if (timer >= 85)
                    {
                        image_index = 1; // start popping up
                        timer = 0;
                        phase = 2;
                    }
                }
            }
            break;
        case 2: // Open
            if (timer == 5)
            {
                image_index = 2;
                phase = 3;
                timer = 0;
                animTimer = 0;
            }
            break;
        case 3: // Shoot
            animTimer++;
            if (!(animTimer mod 4)) // Animation
            {
                image_index++;
                if (image_index > 4)
                {
                    image_index = 2;
                }
            }
            if (timer == 30) // shoot
            {
                if (bullet < 2)
                {
                    for (i = -2; i <= 2; i++)
                    {
                        var t = instance_create(x - (4 * i), y + (1.5 * (abs(i)) * image_yscale), objBeakBullet);
                        t.image_index = col; // set bullet color to that guys color
                        t.dir = 90 + (i * 45);
                        t.xscale = 1;
                        t.respawn = false;
                        if (image_yscale == -1)
                        {
                            t.dir -= 180 - ((90 - t.dir) * 2);
                        }
                    }

                    bullet += 1;
                    timer = 0;
                    playSFX(sfxEnemyShootClassic);
                }
            }
            else if (timer == 54) // stop animating
            {
                image_index = 1;
                timer = 0;
                phase = 4;
            }
            break;
        case 4: // Close
            if (timer == 5)
            {
                timer = 0;
                phase = 1;
                bullet = 0;
                image_index = 0;
            }
            break;
    }
}
else if (dead)
{
    timer = 0;
    phase = 1;
    bullet = 0;
    image_index = 0;
    animTimer = 0;
}
