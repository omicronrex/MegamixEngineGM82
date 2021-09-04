#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

contactDamage = 2;

image_speed = 0.3;
calibrateDirection();

yspeed = -4;

// aim at oil
megaman = false;

rightBound = 0;
if (image_xscale < 0)
{
    rightBound = view_xview;
}
else
{
    rightBound = view_xview + view_wview;
}

oil = collision_rectangle(x + sprite_width / 2, view_yview, rightBound,
    view_yview + view_hview, objOil, false, false);

if (instance_exists(oil))
{
    if (!oil.fire)
    {
        xspeed = xSpeedAim(x, y, oil.x, oil.y, yspeed, grav);

        // so it can clear any blocks if the oil being aimed at is right at the start of the oil pit
        if (abs(xspeed) < 1.5)
        {
            xspeed += image_xscale * 0.2;
        }
    }
    else
    {
        megaman = true;
    }
}
else
{
    megaman = true;
}

noSpeedException = false;
setTargetStep();
if (megaman && instance_exists(target))
{
    xspeed = xSpeedAim(x, y, target.x, target.y, yspeed, grav);

    if (xspeed == 0 && target.y > y - 32)
    {
        noSpeedException = true;
    }
}

// if there was nothing to really aim at, then just throw it
if (!noSpeedException && xspeed == 0)
{
    xspeed = 4 * image_xscale;
}

reflectable = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if ((!noSpeedException && xspeed == 0) || ground)
    {
        instance_create(x, y, objExplosion);
        playSFX(sfxEnemyHit);
        instance_destroy();
    }

    image_speed = 0.3;
}
else
{
    image_speed = 0;
}
