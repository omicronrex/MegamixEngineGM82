#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;
contactStart = contactDamage;

category = "floating";

blockCollision = 0;
grav = 0;

facePlayer = true;

// Enemy specific code

//@cc how long it is until the watcher pops up.
popDelay = 32;

//@cc -1 is up, 1 is down
dir = 1;

timer = 0;
phase = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    timer += 1;
    switch (phase)
    {
        case 1: // pop up
            if (timer >= popDelay)
            {
                if (y > global.sectionTop - (dir * 16)
                    && y < global.sectionBottom - (dir * 16))
                {
                    yspeed = 0.75 * dir;
                    phase = 2;
                }
            }
            break;
        case 2: // Look for target
            if (target)
            {
                if (collision_rectangle(view_xview, y - 12, view_xview + view_wview, y + 12, target, false, true))
                {
                    image_index = 1;
                    timer = 0;
                    phase = 3;
                }
            }
            break;
        case 3: // Shoot
            if (timer == 12)
            {
                image_index = 2;
            }
            else if (timer == 24)
            {
                playSFX(sfxBlockZap);
                repeat (2)
                {
                    image_yscale *= -1;
                    i = instance_create(x + (8 * image_xscale), y + (22 * image_yscale), objEnemyBullet);
                    i.xspeed = 3 * image_xscale;
                    i.sprite_index = sprWatcherBullet;
                    i.imageSpeed = 0.3;
                }
            }
            else if (timer == 32)
            {
                image_index = 1;
                yspeed *= -2;
            }
            else if (timer == 40)
            {
                image_index = 0;
            }
            break;
    }
}
else if (dead)
{
    timer = 0;
    phase = 1;
    image_index = 0;
}

visible = (phase > 1);
canHit = visible;
contactDamage = contactStart * visible;
