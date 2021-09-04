#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
respawn = false;
healthpointsStart = 10;
healthpoints = healthpointsStart;
contactDamage = 0;
facePlayerOnSpawn = true;
image_speed = 0;
image_index = 0;
image_xscale = 1;

// Enemy specific code
capture = noone;
animTimer = 5;
calibrateDirection();
playSFX(sfxLECBubble);
pop = false;
setMega = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (!pop)
{
    if (place_meeting(x, y + 2, objLadder))
        setMega = false;
    else
        setMega = true;
    with (target)
    {
        if (place_meeting(x, y, other) && other.capture == noone && !other.dead)
        {
            with (other)
            {
                if (place_meeting(x, y, objLECBubble))
                {
                    capture = noone;
                    pop = true;
                }
            }
            other.capture = id;
            if (other.setMega)
            {
                /* other.x = x;
                other.y = y-2 ;*/
                xspeed = 0;
                yspeed = 0;
            }
        }
        if (other.capture == id)
        {
            if (climbing)
            {
                climbing = false;
                climbLock = lockPoolRelease(climbLock);
            }
            x = other.x;
            y = other.y - 2;
            xspeed = 0;
            yspeed = 0;
            animNameID = 3;
        }
    }
}
if ((entityCanStep()) && !pop)
{
    if (place_meeting(x, y + 1, objSolid) || place_meeting(x, y + 1, objTopSolid) && !place_meeting(x, y + 2, objLadder))
    {
        xspeed = 0.5 * image_xscale;
        yspeed = 0;
        blockCollision = 1;
    }
    else if (place_meeting(x, y + 1, objTopSolid) && place_meeting(x, y + 2, objLadder))
    {
        blockCollision = 0;
        yspeed = 0.5;
        xspeed = 0;
    }
    else if (ground)
    {
        blockCollision = 1;
        yspeed = 0;
        xspeed = 0.5 * image_xscale;
    }
    else
    {
        blockCollision = 1;
        yspeed = 0.5;
        xspeed = 0;
    }
    if ((x <= view_xview + 16 || x >= view_xview + view_wview - 16) && capture != noone)
        pop = true;
}
else if (pop)
{
    capture = noone;
    image_index = 1;
    animTimer -= 1;
    if (animTimer <= 0)
        instance_destroy();
}
if (dead)
{
    capture = noone;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
pop = true;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index, image_index, round(x), floor(y), 1, image_yscale, image_angle, image_blend, image_alpha);
if ((iFrames == 1 || iFrames == 3) || (iceTimer > 0))
{
    var flashcol; flashcol = c_white;
    if (iceTimer > 0)
        flashcol = make_color_rgb(0, 120, 255);
    d3d_set_fog(true, flashcol, 0, 0);
    draw_sprite_ext(sprite_index, image_index, round(x), floor(y), 1, image_yscale, image_angle, image_blend, image_alpha);
    d3d_set_fog(false, 0, 0, 0);
    if (iceTimer > 0)
    {
        draw_set_blend_mode(bm_add);
        draw_sprite_ext(sprite_index, image_index, round(x), floor(y), 1, image_yscale, image_angle, image_blend, image_alpha);
        draw_set_blend_mode(bm_normal);
    }
}
