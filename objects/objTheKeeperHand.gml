#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
reflectable = 0;
animSpeed = 0.065;
image_speed = animSpeed;
phase = 0;
isTargetable = false;
dir = 1;
subPhase = 0;
grav = 0;
isSolid = 1;
contactDamage = 0;
timer = 0;
fallOnPlayer = true;
canHit = true;
faction = 7;
parent = noone;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    target = instance_nearest(x, y, objMegaman);
    image_xscale = dir;
    switch (phase)
    {
        case 0: // First pattern move near the center and smack the ground
            if (subPhase == 0 && image_speed == 0) // Start moving after it's animation is done
            {
                if (((dir > 0 && x < xstart + dir * 80) || (dir < 0 && x > xstart + dir * 80)) && (!fallOnPlayer || (fallOnPlayer && instance_exists(target) && !((dir == 1 && x - 24 > target.x) || (dir == -1 && x + 24 < target.x)))))
                {
                    xspeed = dir * 3;
                }
                else
                {
                    subPhase = 1;

                    xspeed = 0;
                    timer = 0;
                }
            }
            else if (subPhase == 1) // Smack the ground
            {
                if (timer >= 0)
                {
                    timer += 1;
                    if (timer > 10)
                    {
                        grav = 0.25;
                        yspeed = -2.5; // do a little jump before going down
                        timer = -1;
                    }
                }
                if (ground)
                {
                    subPhase = 2;
                    timer = 0;
                    event_user(0); // Create shockwaves
                }
            }
            else if (subPhase == 2) // Going back to its starting y position, will move back until it collides
            {
                if (timer >= 0)
                    timer += 1;
                if (timer > 30)
                {
                    timer = -1;
                    grav = 0;
                }
                if (timer == -1)
                {
                    if (y > ystart)
                        yspeed = -2.5;
                    else
                    {
                        xspeed = -dir * 1.5;
                        yspeed = 0;
                    }
                    if ((sign(xstart - x) == -sign(xspeed)) || xcoll != 0)
                    {
                        image_speed = -animSpeed;
                        xspeed = 0;
                        timer = -2;
                    }
                }
            }
            break;
        case 2: // phase 2 and 1 makes it move a bit forward and then smacks the ground, after that in phase 2 it will come back;
        case 1: // but in phase 1 it will move forward untill it collides with a wall, then it will come back;
            if (subPhase == 0 && image_speed == 0)
            {
                if ((dir > 0 && x < xstart + dir * 42) || (dir < 0 && x > xstart + dir * 42)) // advance
                {
                    xspeed = dir * 3;
                }
                else
                {
                    subPhase = 1;
                    grav = 0;
                    yspeed = 0;
                    xspeed = 0;
                }
            }
            else if (subPhase == 1)
            {
                if (timer >= 0)
                {
                    timer += 1;
                    if (timer > 10) // fall
                    {
                        grav = 0.25;
                        yspeed = -1.5;
                        timer = -1;
                    }
                }
                else if (timer <= -2) // I was too lazy to make new variables, so I used the timer for everything
                {
                    timer -= 1;
                }
                if (ground)
                {
                    if (timer == -1)
                    {
                        event_user(0); // Create shockwaves
                        timer = -2;
                    }
                    if (xcoll != 0)
                    {
                        if ((dir == 1 && x > xstart + 160) || (dir == -1 && x < xstart - 160)) // if it advanced enough it means it collided with the wall
                        {
                            timer = -100;
                        }
                    }
                    if (xcoll == 0 && timer > -100 && timer < -30)
                    {
                        if (phase == 1)
                        {
                            if (timer == -31)
                                xspeed = -2.5 * dir;
                            if (abs(xspeed) < abs(dir * 3))
                                xspeed += dir * 0.2;
                            else
                                xspeed = dir * 3;
                        }
                    }
                    else if (timer > -100 && timer < -30 || phase == 2)
                    {
                        if (phase == 2) // if phase 2 come back immediately
                        {
                            phase = 0;
                            subPhase = 2;
                            timer = 0;
                            grav = 0;
                        }
                        else
                        {
                            with (objTheKeeperHand) // make sure it's synchroined with the other when in phase 1
                            {
                                if (phase == 1)
                                {
                                    phase = 0;
                                    subPhase = 2;
                                    timer = 0;
                                    grav = 0;
                                }
                            }
                            playSFX(sfxTheKeeperFistClash);
                        }
                    }
                    if (timer < -130) // if it advanced enough and collided with a wall it moves back for a bit and then goes up
                    {
                        xspeed = -dir * 1.5;
                        if (timer < -150)
                        {
                            phase = 0;
                            subPhase = 2;
                            timer = -1;
                            grav = 0;
                            xspeed = 0;
                        }
                    }
                }
            }

            break;
    }

    // Prevent crushing the player

    var crushedPlayer = false;

    if (!instance_exists(target) && instance_exists(objMegaman))
    {
        with (objMegaman)
            other.target = self;
    }
    if (instance_exists(target) && yspeed > 0)
    {
        var ysp = 3;


        ysp += abs(target.yspeed);
        var targetHasGround = false;
        with (target)
        {
            if (checkSolid(0, 3 + abs(yspeed)))
            {
                targetHasGround = true;
            }
        }
        if (place_meeting(x, y + abs(yspeed) + ysp, target) && targetHasGround)
        {
            crushedPlayer = true;
            contactDamage = 4;
            with (target)
            {
                if (canHit && iFrames == 0)
                {
                    with (other)
                    {
                        entityEntityCollision();
                    }
                }
                yspeed = 0;
            }
            yspeed = 0;
        }
    }

    if (xspeed != 0 && !crushedPlayer)
    {
        if (instance_exists(target))
        {
            var xsp = sign(xspeed);
            if (target.xspeed != 0 && sign(target.xspeed) * xsp == 1)
                xsp += target.xspeed;
            var nearSolid = false;

            with (target)
            {
                var lhand = collision_rectangle(bbox_left - 8, bbox_top, x - 4, bbox_bottom, objTheKeeperHand, false, false);
                var rhand = collision_rectangle(x + 8, bbox_top, bbox_right + 4, bbox_bottom, objTheKeeperHand, false, false);
                if (collision_rectangle(bbox_left - 4 - abs(xsp), bbox_top, bbox_right + 4 + abs(xsp), bbox_bottom, objSolid, false, false) || ((lhand != noone && lhand != other) || (rhand != noone && rhand != other)))
                {
                    nearSolid = true;
                }
            }
            if (nearSolid && place_meeting(x + ceil(xspeed) + 4 * sign(xspeed), y, target))
            {
                crushedPlayer = true;
                contactDamage = 4;
                with (target)
                {
                    if (canHit && iFrames == 0)
                    {
                        with (other)
                            entityEntityCollision();
                    }
                }
            }
        }
    }
    if (crushedPlayer)
    {
        image_speed = -animSpeed;
        yspeed = 0;
        grav = 0;
        xspeed = 0;
        contactDamage = 0;
        phase = -1;
    }
}
#define Other_7
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (image_speed > 0)
{
    image_speed = 0;
    image_index = image_number - 1;
}
else
{
    instance_destroy();
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Make Shockwaves
var sw = instance_create(x + (abs(bbox_left - bbox_right) * 0.5), bbox_bottom, objTheKeeperShockwave);
sw.xspeed = 2;
var sw = instance_create(x - (abs(bbox_left - bbox_right) * 0.5), bbox_bottom, objTheKeeperShockwave);
sw.xspeed = -2;
screenShake(40, 1, 1);
with (objMegaman)
    playerGetShocked(false, 0, true, 40);
#define Other_19
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// nothing
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
global.damage = 0;
other.guardCancel = 3;
if (other.object_index == objWaterShield)
    other.guardCancel = 2;
