#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 5;
healthpoints = healthpointsStart;
contactDamage = 5;

itemDrop = -1;

isSolid = true;

spd = 3;
canHit = true;
image_speed = 1 / 4;

begunMove = false;

// when positive, runs slow death animation explosion
slowdeath_timer = 0;

has_honked = false;

damageOffset = 1; // I megaman collides with this truck and his bbox_bottom is > bbox_top+damageOffset megaman would get hit
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (!begunMove)
    {
        image_xscale = 1;
        if (x > view_xview[0] + view_wview[0] / 2)
        {
            image_xscale = -1;
        }
        begunMove = true;
        visible = true;
    }

    xspeed = image_xscale * spd;

    // honk
    if (!has_honked && canHit && insideView())
    {
        has_honked = true;
        playSFX(sfxHonk);
    }

    // colliding with things:
    if (slowdeath_timer == 0)
    {
        var do_collision; do_collision = false;

        with (objMegaman)
        {
            if (!((bbox_bottom > other.bbox_top + other.damageOffset)))
            {
                continue;
            }
            if (place_meeting(x - other.xspeed, y - min(0, other.yspeed), other))
            {
                // manual damage to player
                if (iFrames == 0 && canHit)
                {
                    with (other)
                    {
                        entityEntityCollision();
                    }
                }

                if (global.playerHealth[playerID] > 0)
                    do_collision = true;
            }
        }

        if (xcoll != 0)
        {
            do_collision = true;
        }

        with (prtEntity)
        {
            if (id != other.id && object_index != objMegaman)
            {
                if (!((bbox_bottom > other.bbox_top + other.damageOffset)))
                {
                    continue;
                }
                if (place_meeting(x - other.xspeed * 2, y - min(0, other.yspeed), other))
                {
                    if (!dead && canHit)
                    {
                        if (object_index == objNitroTruck)
                        {
                            slowdeath_timer = 1;
                            yspeed = 0;
                            do_collision = true;
                        }
                        else
                        {
                            healthpoints -= other.contactDamage;
                            event_user(EV_HURT);
                            if (healthpoints <= 0)
                            {
                                event_user(EV_DEATH);
                                playSFX(sfxEnemyHit);
                            }
                            else
                                do_collision = true;
                        }
                    }
                }
            }
        }

        if (do_collision)
        {
            slowdeath_timer = 1;
            instance_create(x+25*image_xscale,choose(y+5,y+40),objBigExplosion);
            playSFX(sfxMM9Explosion);//(sfxExplosion2);
            yspeed = 0;
        }
    }
    else
    {
        // exploding animation
        canHit = false;
        visible = (slowdeath_timer div 3) mod 2;
        xspeed = -image_xscale;

        if (slowdeath_timer == 10)
        {
            instance_create(x-30*image_xscale,choose(y+5,y+30),objBigExplosion);
            playSFX(sfxMM9Explosion);
        }

        if (slowdeath_timer > 10)
        {
            xspeed = 0;
        }

        if (slowdeath_timer > 20)
        {
            with (instance_create(bboxGetXCenter(), bboxGetYCenter(), objHarmfulExplosion))
            {
                contactDamage = 0;
                playSFX(sfxMM9Explosion);
            }
            dead = true;
            visible = true;
        }

        slowdeath_timer += 1;
    }
}
else if (dead)
{
    begunMove = false;
    slowdeath_timer = 0;
    canHit = true;
    has_honked = false;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (other.object_index != objSparkShock && other.object_index != objChillShot
    && other.object_index != objChillSpikeLanded)
{
    other.guardCancel = 3;
    global.damage = 0;
}
else if (other.object_index == objChillSpikeLanded)
{
    slowdeath_timer = 1;
    instance_create(x+25*image_xscale,choose(y+5,y+40),objBigExplosion);
    playSFX(sfxMM9Explosion);
    yspeed = 0;
    global.damage = 4;
}
