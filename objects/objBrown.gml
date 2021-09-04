#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "rocky";

grav = 0;

facePlayer = true;

// Enemy specific code
phase = 0;
timer = 0;
container = noone;

imgSpd = 0.3;
imgIndex = 0;

// set to real sprite
sprite_index = sprBrownHead;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// needs to be done even if this is frozen
if (container != noone && !global.frozen && !dead && instance_exists(target))
{
    if (!instance_exists(container))
    {
        dead = true;
    }
}

if (image_index == 0)
{
    canDamage = false;
    canHit = false;
}
else
{
    canDamage = true;
    canHit = true;
}

if (entityCanStep())
{
    switch (phase)
    {
        // start facing the player
        case 0:
            container = instance_create(x, y, objBrownContainer); // this is so the enemy can have seperate hitboxes
            phase = 1;
            break;

        // shooting
        case 1:
            timer -= 1;
            if (timer <= 0)
            {
                timer = 80; // <-=1 time between shots here

                if (instance_exists(target))
                {
                    bullet = instance_create(x, y - 14, objEnemyBullet);
                    bullet.contactDamage = 3;
                    bullet.grav = 0.11;
                    bullet.image_xscale = image_xscale;
                    bullet.yspeed = -3;
                    bullet.sprite_index = sprEnemyBulletMM6;

                    with (bullet)
                    {
                        xspeed = xSpeedAim(x, y, target.x, target.y, yspeed, grav);
                    }

                    playSFX(sfxEnemyDrop);
                }
            }
            if (container.wasHit || place_meeting(x, y, objMegaman))
            {
                phase = 2;
                timer = 0;
                container.animate = false;
            }
            break;

        // pop up
        case 2:
            if (imgIndex < 4)
            {
                imgIndex += imgSpd;
                if (imgIndex >= 5)
                {
                    imgIndex = 4;
                }
            }
            else
            {
                timer += 1;
                if (timer >= 60)
                {
                    // <-=1 time staying unhiden here
                    phase = 3;
                    timer = 0;
                }
            }
            break;

        // go back down
        case 3:
            imgIndex -= imgSpd;
            if (imgIndex div 1 == 0)
            {
                phase = 1;
                imgIndex = 0;
                container.animate = true;
            }
            break;
    }
}
else
{
    if (dead == true)
    {
        phase = 0;
        imgIndex = 0;
        timer = 0;

        if (instance_exists(container))
        {
            with (container)
            {
                instance_destroy();
            }
        }
        container = noone;
    }
}

image_index = imgIndex div 1;
