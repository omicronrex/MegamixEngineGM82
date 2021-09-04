#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Big cctopus enemy that sinks into the ground

event_inherited();

respawn = true;
doesIntro = false;

healthpointsStart = 20;
healthpoints = healthpointsStart;
contactDamage = 6;
category = "aquatic, bulky";

yspeed = -0.5;
yOffset = 36;
yOffsetMax = 36;

detectorXOffset = 40;
detectorYOffset = 32;
detectorMOffset = 24;
detectorMXOffset = 24
spdY = 0.5;
detectorMXScale = 3;
detectorMYScale = 3.5;
turnRoundLong = 80;
turnRoundShort = 24;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
#define Collision_objMegaman
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (other.y <= y + 32 - yOffset)
{
    event_inherited();
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
b = bboxGetYCenterObject(other.id);

if (!collision_rectangle(x, y - 4,
    x + ((bbox_right - bbox_left) / 2) * image_xscale, y + 4, other.id,
    false, false))
{
    other.guardCancel = 1;
}

if (b >= bbox_bottom - yOffset)
{
    guardCancel = 2;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if(spawned)
{
    xscaleStorage = 0;
    image_index = 0;
    xspeed = 0;
    yspeed = -0.5;
    yOffset = yOffsetMax;
    imageTimer = 1;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if(!spawned)
    exit;
if (iFrames == 1 || iFrames == 3)
{
    d3d_set_fog(true, c_white, 0, 0);
}

// makes octoboss face its spawned direction, regardless of other scripts.


if (xscaleStorage <= 0)
{
    image_xscale = 1;
    draw_sprite_part_ext(sprite_index, image_index, 0, 0, sprite_width,
        sprite_height - yOffset, round(x - 24) + sprite_width, round(y - 24),
        -image_xscale, image_yscale, image_blend, image_alpha);
    image_xscale = -1;
}
else
{
    image_xscale = 1;
    draw_sprite_part_ext(sprite_index, image_index, 0, 0, sprite_width,
        ceil(sprite_height - yOffset), round(x - 24), round(y - 24),
        image_xscale, image_yscale, image_blend, image_alpha);
}



if (imageTimer == 1)
{
    y = ystart + yOffset;
    imageTimer = 0;
}

if (iFrames == 1 || iFrames == 3)
{
    d3d_set_fog(false, 0, 0, 0);
}
