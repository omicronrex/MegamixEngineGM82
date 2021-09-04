#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = false;

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 3;

itemDrop = -1;

// enemy specific
killTimer = 0;

grav = 0.1;

animBack = false;
imgSpd = 0.2;
imgIndex = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // anim nation wow
    if (!animBack)
    {
        imgIndex += imgSpd;
        if (imgIndex >= 3)
        {
            imgIndex = 2 - imgIndex mod 3;
            animBack = true;
        }
    }
    else
    {
        imgIndex -= imgSpd;
        if (imgIndex < 0)
        {
            imgIndex = 1;
            animBack = false;
        }
    }

    // MAGIKARP, USE SPLASH!
    if (ground)
    {
        yspeed = -1.2;
        xspeed = random_range(-1.4, 1.4);
    }

    // ded temer
    killTimer += 1;
    if (killTimer >= 100)
    {
        instance_create(x, y, objExplosion);
        instance_destroy();
    }

    // bE FREE
    if (inWater)
    {
        instance_destroy();
    }
}

// do dem bettar dan game mekar staets (if you can't tell, I'm getting bored)
image_index = imgIndex div 1;
