#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 24;
healthpoints = healthpointsStart;
contactDamage = 2;

bulletLimitCost = 1;

pierces = 2;

isSolid = 0;
blockCollision = 0;
grav = 0;
doesTransition = false;

pushed = 0;
timer = 0;

forming = 1;
isFree = 0;

canHit = -1;

dir = 0;

attackDelay = 24;

// wow! a two in one combo
playSFX(sfxClamp);
playSFX(sfxIceWall);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    if(!isFree)
    {
        isFree = !checkSolid(0,0,1,1);
    }

    if (!isFree)
    {
        blockCollision = false;
        x = xprevious;
        y = yprevious;
        xspeed = 0;
        yspeed = 0;
        grav = 0;
    }

    if (!forming)
    {
        if (isFree)
        {
            if (collision_rectangle(bbox_left, y - 8 * sign(grav), bbox_right, bbox_top, objWater, false, false))
            {
                grav = 0;
                yspeed *= 1 - (1 / 8);
                shiftObject(0, -0.75, blockCollision);

                xspeed = 0;
            }
            else if (!place_meeting(x, y, objWater))
            {
                grav = 0.25 * image_yscale;
                inWater = 0;
            }

            if (xcoll != 0)
            {
                xspeed = -xcoll;
                dir = -dir;
            }

            if (ground)
            {
                if (pushed > 8)
                {
                    if (abs(xspeed) < 2 && !inWater)
                    {
                        xspeed += 0.04 * dir;
                    }

                }
                else
                {
                    var ispushed = pushed;

                    with (objMegaman)
                    {
                        if (xDir != 0 )
                        {
                            if (!place_meeting(x,y,other)&&place_meeting(x + sign(xDir), y, other))
                            {
                                other.pushed += 1;
                                other.dir = sign(xDir);

                            }
                        }
                    }

                    if (pushed == ispushed)
                    {
                        pushed = 0;
                    }
                }
            }
        }
        else
        {
            healthpoints = 0;
        }

        // gradually die
        healthpoints -= (healthpointsStart / 256) * (1 - (xspeed != 0) * 0.25);

        // update image index to be cracked and stuff
        image_index = max(4, 6 - floor((healthpoints / healthpointsStart) * 3));

        if (healthpoints <= 0)
        {
            event_user(EV_DEATH);
        }

        timer++;
    }
}
#define Other_17
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
healthpoints -= healthpointsStart / 64;

if (!audio_is_playing(sfxReflect) || !(timer mod 4))
{
    playSFX(sfxReflect);
}
#define Other_18
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
healthpoints -= other.contactDamage;
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
dead = 1;

with (instance_create(x, y, objSlideDust))
{
    sprite_index = sprIceWallBreak;
}
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
weaponSetup("ICE WALL", make_colour_rgb(60, 188, 252), make_color_rgb(164, 228, 252), sprWeaponIconsIceWall);
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
specialDamageValue("fire", 5);
specialDamageValue("flying", 4);
specialDamageValue("aquatic", 3);
specialDamageValue("nature", 3);
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT))
{
    fireWeapon(22, -3, objIceWall, 1, 3, 1, 0);
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (forming)
{
    var shardTime = 20;

    if (timer < shardTime)
    {
        shards = sprite_get_number(sprIceWallShard) - 1;
        shImg = shards - min(shards, floor(timer) / 3);

        for (var i = 0; i < 4; i += 1)
        {
            for (var z = shards; z >= shImg; z -= 1)
            {
                draw_sprite_ext(sprIceWallShard, z,
                    round(x + (min(8, shardTime - (timer - z)) * (3 * (1 - (i mod 2 == 0) * 2)))),
                    round(y + (min(8, shardTime - (timer - z)) * (3 * (1 - (i mod 3 == 0) * 2)))),
                    image_xscale, image_yscale, image_angle, image_blend, image_alpha);
            }
        }
    }
    else
    {
        image_index = floor((timer - shardTime) / 3);

        drawSelf();

        if (image_index >= 4)
        {
            forming = 0;
            if(isFree)
            {
                isSolid = 1;

                blockCollision = 1;
                grav = 0.25 * image_yscale;
            }
        }
    }

    timer+=2;
}
else
{
    drawSelf();
}
