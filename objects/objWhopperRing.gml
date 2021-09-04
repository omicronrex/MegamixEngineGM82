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
contactDamage = 4;
despawnRange = -1; // Do not despawn

isTargetable = false;

grav = 0;
blockCollision = 0;

// enemy specific
timer = 25;
dir = 1;
trueX = x;
trueY = y;

calibrateDirection();
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    trueX += xspeed * dir;
    trueY += yspeed * dir;
    if (timer > 0)
        timer -= 1;
    else
        dir = -1;
    if (dir == -1 && sign(xstart - trueX) == sign(xspeed) && sign(ystart - trueY) == sign(yspeed))
        instance_destroy();
    if (trueY < view_yview + view_hview && trueY > view_yview)
        y = trueY;
    if (trueX < view_xview + view_wview && trueX > view_xview)
        x = trueX;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.guardCancel = 3;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index, -1, round(trueX), round(trueY), image_xscale,
    image_yscale, image_angle, image_blend, image_alpha);
