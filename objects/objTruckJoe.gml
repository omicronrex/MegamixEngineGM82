#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// image_xscale = 1 or -1 //(Use editor for this!!) // determines the direction Truck Joe is locked in.
event_inherited();
respawn = true;
introSprite = sprTruckJoeTeleport;
healthpointsStart = 18;
healthpoints = healthpointsStart;
contactDamage = 3;
blockCollision = 1;
grav = 0.325;
category = "bulky, joes";

penetrate = 3;

despawnRange = -1;
behaviourType = 4;

image_speed = 0;
image_index = 1;

faction = 5;

// Enemy specific code
spdF = 1.25;
spdB = 0.75;
phase = 0;
lockID = noone;

carFrame = 0;
joeFrame = 0;

strMMX = 0;
strMMY = 0;

overrideX = x;
overrideY = y;

animTimer = 0;

shotsFired = 0;
attackTimer = 0;

moveDir = image_xscale;

// creation code variables

//@cc The speed Truck Joe runs forwards
spdF = 1;

//@cc The speed Truck Joe runs backwards
spdB = 0.75;

//@cc If set to false, Truck Joe will not destroy terrain he collides with
destroyTerrain = true;

//@cc 0 = teleport in / 1 = move in
introType = 0;
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
dead = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep() && introTimer > 0 && introType)
{
    if (image_xscale == -1)
    {
        x = view_xview[0] + view_wview[0];
    }
    else
    {
        x = view_xview[0] - sprite_xoffset;
    }
    introTimer = 0;
    phase = -9999;
}

if (entityCanStep()
    && introTimer <= 0)
{
    if (instance_exists(target))
    {
        strMMX = target.x;
        strMMY = target.y;
    }

    if (destroyTerrain)
    {
        while (place_meeting(x + 4 * (sign(xspeed)), y, objSolid))
        {
            with (instance_place(x + 4 * (sign(xspeed)), y, objSolid))
            {
                if (image_xscale > 1 || image_yscale > 1)
                {
                    splitSolid();
                }
                else
                {
                    instance_create(bboxGetXCenter(), bboxGetYCenter(), objExplosion);
                    playSFX(sfxEnemyHit);
                    instance_create(x, y, objRollingDrillField);
                    instance_deactivate_object(id);
                }
            }
        }
    }

    switch (phase)
    {
        case -9999: // intro
            xspeed = image_xscale * 0.75;
            carFrame += 0.25;
            canHit = false;
            canDamage = false;
            if (carFrame >= 3)
            {
                carFrame = 0;
            }
            if ((x <= xstart && image_xscale == -1) || (x >= xstart && image_xscale == 1))
            {
                xspeed = 0;
                phase = 0;

                canHit = true;
                canDamage = true;
            }
            break;
        case 0: // run towards mega man
            var collider; collider = instance_place(x + 8 * image_xscale, y, objTruckJoeStop);
            if (abs(xspeed) < spdF && !collider || collider && x < collider.x)
            {
                xspeed += image_xscale * 0.05;
            }
            else if (!collider || collider && x < collider.x)
            {
                xspeed = image_xscale * spdF;
            }
            else
            {
                xspeed = 0;
            }
            animTimer+=1;
            if (animTimer == 64)
            {
                joeFrame = 1;
            }
            if (animTimer >= 72)
            {
                joeFrame = 0;
            }
            if (xspeed != 0)
            {
                carFrame += 0.25;
            }
            if (carFrame >= 3)
            {
                carFrame = 0;
            }
            if ((strMMX >= x && image_xscale == -1) || (strMMX <= x && image_xscale == 1))
            {
                phase = 1;
            }
            break;
        case 1:
        case 3: // change direction
            if (xspeed > 0.25) // slow down
            {
                xspeed -= 0.25;
            }
            else if (xspeed < -0.25)
            {
                xspeed += 0.25;
            }
            else
            {
                xspeed = 0;
            }
            if (joeFrame < 2)
            {
                joeFrame = 2;
            }
            attackTimer+=1;
            switch (attackTimer)
            {
                case 8:
                    if (phase == 1)
                        joeFrame = 2;
                    else
                        joeFrame = 5;
                    break;
                case 16:
                    if (phase == 1)
                        joeFrame = 3;
                    else
                        joeFrame = 4;
                    break;
                case 24:
                    if (phase == 1)
                        joeFrame = 4;
                    else
                        joeFrame = 3;
                    break;
                case 32:
                    if (phase == 1)
                    {
                        joeFrame = 5;
                    }
                    else
                    {
                        phase = 0;
                        joeFrame = 0;
                        attackTimer = 0;
                        animeTimer = 0;
                    }
                    break;
                case 48:
                    joeFrame = 6;
                    break;
                case 54:
                    joeFrame = 7;
                    break;
                case 60:
                    joeFrame = 8;
                    break;
                case 64:
                    joeFrame = 9;
                    phase = 2;
                    attackTimer = 0;
                    animeTimer = 0;
                    break;
            }
            break;
        case 2: // run backwards mega man
            if (abs(xspeed) < spdB && !place_meeting(x - 8 * image_xscale, y, objTruckJoeStop))
            {
                xspeed += -image_xscale * 0.05;
            }
            else if (!place_meeting(x - 8 * image_xscale, y, objTruckJoeStop))
            {
                xspeed = -image_xscale * spdB;
            }
            else
            {
                xspeed = 0;
            }
            if (xspeed != 0)
            {
                carFrame -= 0.25;
            }
            if (carFrame <= -1)
            {
                carFrame = 2;
            }
            if ((strMMX <= x && image_xscale == -1) || (strMMX >= x && image_xscale == 1))
            {
                phase = 3;
            }
            break;


    }
}
if (dead)
{
    x = overrideX;
    y = overrideY;
}
#define Other_12
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=605
invert=0
arg0=draw code
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index, 1 + ceil(clamp(carFrame, 0, 2)), round(x), round(y), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
if (floor(carFrame) == 1)
    draw_sprite_ext(sprite_index, 4 + joeFrame, round(x), round(y) + 1, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
else
    draw_sprite_ext(sprite_index, 4 + joeFrame, round(x), round(y), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
overrideX = x;
overrideY = y;

event_inherited();

alarm[0] = 2;
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (other.y > y - 9)
{
    other.guardCancel = 1;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// handles stuff differently than the Puny Regular Enemies....
if (introTimer > 0 && doesIntro)
{
    draw_sprite_ext(introSprite, 2 - (min(2, min(introTimer, 15) / 5)), x,
        y - max(introTimer - 10, 0) * image_yscale, image_xscale, image_yscale, 0, c_white, 1);
}
else
{
    // this debug message should be left in until
    // the spawn system stops breaking every week.

    if (spawned == -1)
    {
        show_debug_message(object_get_name(object_index) + " drawn without having ever spawned!");
    }
    if ((ceil(iFrames / 2) mod 4) || !iFrames)
    {
        if ((ceil(iFrames / 2) mod 2) || (iceTimer > 0))
        {
            var flashcol; flashcol = c_white;
            if (iceTimer > 0)
            {
                flashcol = make_color_rgb(0, 120, 255);
            }

            d3d_set_fog(true, flashcol, 0, 0);
            event_user(2);
            d3d_set_fog(false, 0, 0, 0);

            if (iceTimer > 0)
            {
                draw_set_blend_mode(bm_add);
                event_user(2);
                draw_set_blend_mode(bm_normal);
            }
        }
        else
        {
            event_user(2);
        }
    }
}
