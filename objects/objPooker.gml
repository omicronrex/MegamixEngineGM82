#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

contactDamage = 3;
contactStart = contactDamage;

grav = 0.15;

facePlayer = true;

phase = 0;
timer = 0;

dir = 1;
getY = y;
yOffset = 0;
lock = false;
platTarget = noone;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    switch (phase)
    {
        // normal attacking behavior
        case 0: // shoot projectiles
            facePlayer = 1;
            timer += 1;
            if (timer == 120)
            {
                instance_create(x, y - 8, objPookerProjectile);
                playSFX(sfxEnemyDrop);
                image_index = 1;
            }
            if (timer >= 150)
            {
                timer = 0;
                image_index = 0;
            }
            break;

        // flip over after being hit by a charge shot
        case 1:
            facePlayer=0;
            timer = 0;

            // animation
            if (image_index < 3)
            {
                image_index += 1 / 5;
            }
            if (image_index < 2)
            {
                image_index = 2;
            }

            // land in liquidmovingPlat
            if ((place_meeting(x, y, objOil) || place_meeting(x, y, objWater)) && !checkSolid(0, 0, 1, 1))
            {
                phase = 2
                platTarget = noone;
                lock = false;


                xspeed = 0;
                yspeed = 0;
                lock=0;
                if (place_meeting(x, y, objWater))
                    y -= 1;

                break;
            }

            // hitting solid ground
            if (xcoll != 0 || ycoll != 0)
            {
                yspeed = 0;

                instance_create(x, y, objBigExplosion);
                audio_stop_sound(sfxMM3Explode);
                playSFX(sfxExplosion);

                dead = true;

                phase = 0;
                image_index = 0;
            }
            break;

        // rideable platform
        case 2:
            contactDamage = 0;
            if (instance_place(x, y + 4, objOil))
            {
                ID = instance_place(x, y + 4, objOil);
            }
            else if (instance_place(x, y + 4, objWater))
            {
                ID = instance_place(x, y + 4, objWater);
            }
            else
            {
                phase = 1;

                break;
            }
            if (ID != noone)
                getY = ID.y - 8;
            if (image_index < 7.4)
            {
                image_index += 1 / 5;
                yOffset = (7 - round(image_index)) * 2;
                xspeed = 0;
            }
            else
            {
                isSolid = 2;

                if (floor(image_index) == 7)
                {
                    timer += 1;
                    if (timer == floor(timer / 30) * 30)
                    {
                        if (yOffset == 1)
                        {
                            yOffset = 0;
                        }
                        else
                        {
                            yOffset = 1;
                        }
                    }
                }

                var _hasWeight = false;
                var _overlappingEntity = false;
                if (!lock)
                {
                    with (objMegaman)
                    {
                        if (bbox_bottom < other.bbox_top + 5 && place_meeting(x, y + 2, other))
                        {
                            _overlappingEntity = true;
                            if (ground)
                            {
                                _hasWeight = true;
                                other.platTarget = id;

                                break;
                            }
                        }
                    }
                    if (!_hasWeight)
                    {
                        with (prtEntity)
                        {
                            if ((faction == 3) && blockCollision && place_meeting(x, y + 2, other))
                            {
                                _overlappingEntity = true;
                                if (ground)
                                {
                                    _hasWeight = true;
                                    other.platTarget = id;
                                    break;
                                }
                            }
                        }
                    }
                }
                if (!lock && _hasWeight)
                {
                    image_index = 8;
                    timer = 32;
                    lock = true;
                    yOffset = 2;
                    var direc = sign(image_xscale);
                    if (instance_exists(platTarget))
                        direc = sign(platTarget.image_xscale);
                    dir = direc;
                    image_xscale = dir;
                }
                else if (!instance_exists(platTarget) || (((instance_exists(platTarget) && !(place_meeting(x, y - 2, platTarget) && platTarget.bbox_bottom < bbox_top + 5)) || !instance_exists(platTarget)) && (image_index != 8 || timer == 0)))
                {
                    lock = false;
                    platTarget = noone;
                }

                if (floor(image_index) == 8)
                {
                    if (!checkSolid(xspeed, 0, 1, 1))
                    {
                        xspeed = dir;
                    }
                    else
                    {
                        xspeed = 0;
                    }

                    if (timer == 30)
                    {
                        yOffset = 3;
                    }

                    if (timer == 25)
                    {
                        yOffset = 2;
                    }

                    if (timer > 0)
                    {
                        timer -= 1;
                    }
                    else
                    {
                        image_index = 7.4;
                        xspeed = 0;
                        yOffset = 0;
                        timer = 0;
                    }
                }
            }
            yspeed = ((getY + yOffset) - y);
            break;
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (phase == 0)
{
    if (other.object_index == objBusterShotCharged || other.object_index == objBreakDash)
    {
        phase = 1;
        yspeed = -3;
        y += yspeed; // so it doesn't immediately detect the ground and try to explode
        ground = false;
        xspeed = sign(other.image_xscale);
        dir = sign(other.image_xscale);
        if (dir == 0)
        {
            var otherX = 0;
            with (other)
                otherX = bboxGetXCenter();
            if (otherX > bboxGetXCenter())
            {
                dir = 1;
                xspeed = 1;
            }
            else
            {
                dir = -1;
                xspeed = -1;
            }
        }
        image_xscale = dir;
    }

    if (other.penetrate >= 2 || other.object_index == objChillSpikeLanded)
    {
        other.guardCancel = 2;
    }
    else
    {
        other.guardCancel = 1;
    }
}
else
{
    other.guardCancel = 2;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// On spawn
event_inherited();
phase = 0;
image_index = 0;
isSolid = 0;
if (instance_exists(target))
{
    if (target.x < x)
    {
        dir = -1;
    }
    else
    {
        dir = 1;
    }
}

contactDamage = contactStart;
