#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 0;

canHit = false;

// @cc the object_index of the item Eddie will send out. If not set, he will choose
// randomly from his pickup pool
myItem = 0;

// @cc if set to true, Eddie will never respawn once the item is given out
permanent = true;

// @cc if set to false, Eddie will stay still and not move towards MM when giving out items
moveTowardsPlayer = true;

phase = 0;
timer = 0;

stopOnFlash = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    /*if (ycoll * sign(image_yscale) > 0)
    {
        playSFX(sfxLand);
    }*/

    if (phase == 0)
    {
        if (ground && moveTowardsPlayer)
        {
            if (!(timer mod 6))
            {
                image_index = (image_index + 1) mod 3;
            }

            calibrateDirection();
            xspeed = image_xscale;
        }
        else
        {
            xspeed = 0;
            if !moveTowardsPlayer
            {
                calibrateDirection();
            }
        }

        if (instance_exists(target))
        {
            if (abs(x - target.x) <= 40)
            {
                timer = 0;
                phase = 1;
                image_index = 0;
                xspeed = 0;
            }
        }
    }
    else
    {
        switch (timer)
        {
            case 32:
                image_index = 3;
                break;
            case 40:
                image_index = 0;
                break;
            case 48:
                image_index = 4;
                break;
            case 56:
                image_index = 5;
                event_user(0);
                respawn = false;
                with (objGlobalControl)
                {
                    ds_list_add(pickups, string(room) + '/' + string(other.id));
                }
                break;
            case 72:
                image_index = 0;
                break;
            case 112:
                event_user(EV_DEATH);
                break;
        }
    }

    timer++;
}
else if (dead)
{
    image_index = 0;
    phase = 0;
    timer = 0;
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// randomize();

if (!myItem)
{
    var randitem = floor(random(90));

    if (randitem < 3)
    {
        myItem = objYashichi;
    }
    else if (randitem < 30)
    {
        myItem = choose(objLife, objETank);
    }
    else
    {
        myItem = choose(objLifeEnergyBig, objWeaponEnergyBig);
    }
}

event_perform_object(objExplosion, ev_other, ev_user0);

i.xspeed = image_xscale;
i.yspeed = -4;
i.y -= 8 * image_yscale;
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (myItem == 0)
{
    var randitem = floor(random(90));
    if (myItem == noone)
    {
        for (i = 0; i < 4; i += 1)
        {
            event_user(0);

            /*
            nitem.x = bboxGetXCenter() - 8;
            nitem.y += 2;
            nitem.xspeed -= 0.5 * i * sign(nitem.xspeed);
            nitem.yspeed -= 0.5 * i;
            nitem.yspeed += 1;
            nitem.disappear += irandom_range(-20, 20);
            */
        }
    }
    else
    {
        other.guardCancel = 2;
    }
}
else
{
    other.guardCancel = 2;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (healthpoints)
{
    dead = 1;

    // Teleport away
    i = instance_create(x, y, objRushTeleport);
    i.upordown = 'up';
    i.parent = -1;
}
else
{
    event_inherited();
}
