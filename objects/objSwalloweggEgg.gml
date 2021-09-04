#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

/*
The egg that comes with Swallowegg, when it's released, it locks onto your
position, and flies at you once it's lined up.
*/

healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "flying, bird";

blockCollision = 0;
grav = 0;
despawnRange = -1;

animTimer = -1;
phase = 0;

release = 0;
targetLeft = 0;
launchY = 0;
soundPlay = 0;

drawFlame = 0;
flameTimer = 0;
flameIndex = 0;

birdInstanceStore = noone;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (instance_exists(birdInstanceStore))
    {
        // if the egg is being carried, set it's position to just under that Swallowegg
        if (!birdInstanceStore.dead && !release)
        {
            var inst;
            inst = birdInstanceStore;
            x = ceil(inst.x + (1 * inst.image_xscale));
            xspeed = 0;
            image_xscale = inst.image_xscale;
        }

        // if Swallowegg is dead, start flying towards the target immediately.
        if (xspeed == 0 && birdInstanceStore.dead)
        {
            if (instance_exists(target))
            {
                if (target.x > x)
                {
                    targetLeft = 0;
                    xspeed = 4;
                }
                else
                {
                    targetLeft = 1;
                    xspeed = -4;
                }
                release = 1;
                despawnRange = 4;
                drawFlame = 1;
                soundPlay = 1;
            }
        }

        // if Swallowegg has dropped the egg, set a target point, start falling, and ignore the bird
        if (xspeed == 0 && birdInstanceStore.hasEgg == false)
        {
            yspeed = 4;
            despawnRange = 4;
            release = 1;
            if (instance_exists(target))
            {
                launchY = target.y;
            }
            birdInstanceStore = noone;
        }
    }
    else
    {
        // if there is no bird at all, start flying
        if (release == 0 && xspeed == 0)
        {
            if (instance_exists(target) && target.x > x)
            {
                targetLeft = 0;
                xspeed = 4;
            }
            else
            {
                targetLeft = 1;
                xspeed = -4;
            }
            release = 1;
            despawnRange = 4;
            drawFlame = 1;
            soundPlay = 1;
        }
    }

    // If the egg is almost lined up with the target, slow down and activate boosters
    if (release == 1 && y < launchY - 14 && y > launchY - 48)
    {
        if (instance_exists(target) && target.x > x)
        {
            targetLeft = 0;
        }
        else
        {
            targetLeft = 1;
        }
        yspeed = 2;
        drawFlame = 1;
    }

    // more slow down
    if (release == 1 && y < launchY && y > launchY - 14)
    {
        yspeed = 1;
        drawFlame = 1;
    }

    // if the egg has reached/is below the target point, start flying
    if (release == 1 && y >= launchY)
    {
        if (targetLeft == 0)
        {
            xspeed += 0.5;
            if (xspeed > 4)
            {
                xspeed = 4;
            }
        }
        else
        {
            xspeed -= 0.5;
            if (xspeed < -4)
            {
                xspeed = -4;
            }
        }
        yspeed = 0;
        drawFlame = 1;
        if (soundPlay == 0)
        {
            playSFX(sfxJetEggLaunch);
            soundPlay = 1;
        }
    }

    // animation timer for the flame effect
    if (drawFlame == 1)
    {
        animTimer += 1;

        if (animTimer >= 4)
        {
            if (flameIndex == 0)
            {
                flameIndex = 1;
            }
            else if (flameIndex == 1)
            {
                flameIndex = 0;
            }
            animTimer = 0;
        }
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (instance_exists(birdInstanceStore))
{
    birdInstanceStore.hasEgg = false;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite(sprJetEgg, 0, x, y);

// this code controls the drawing of its jet flame

if (drawFlame == 1)
{
    if (targetLeft == 0)
    {
        draw_sprite_ext(sprEggFlame, flameIndex, x - 12, y, 1, 1, 0, c_white, 1);
    }
    else
    {
        draw_sprite_ext(sprEggFlame, flameIndex, x + 13, y, -1, 1, 0, c_white, 1);
    }
}
