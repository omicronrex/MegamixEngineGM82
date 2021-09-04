#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpoints = 2;
healthpointsStart = healthpoints;

isSolid = 1;
grav = 0;
blockCollision = 0;

contactDamage = 0;

respawn = false;
itemDrop = -1;

// dont use
canHit = true;
offset = 0;
spd = 0.5;

despawnRange = 48;
respawnRange = 48;

if (instance_exists(objKabatoncuePlatform))
{
    parent = instance_nearest(x, y, objKabatoncuePlatform);
}
else
{
    parent = noone;
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // check for Buddy
    if (!instance_exists(parent))
    {
        instance_destroy();
    }

    // :aesthetics:
    if (place_meeting(x, y - 5, objKabatoncuePlatform))
    {
        image_index = 0;
    }
    else
    {
        image_index = 1;
    }

    if (!place_meeting(x, y - 1, objKabatoncuePlatform)
        && !place_meeting(x, y - 1, objKabatoncuePlatformPiece))
    {
        if (offset > 0)
            offset -= spd;
        yspeed = -spd;
    }
    else
    {
        yspeed = 0;
    }

    if (!place_meeting(x, y + 4, objSolid)
        && !place_meeting(x, y + 4, objKabatoncuePlatformPiece))
    {
        y += 16;
        while (place_meeting(x, y, objSolid)
            || place_meeting(x, y, objKabatoncuePlatformPiece))
            y -= 1;
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (other.penetrate < 2 && other.pierces < 2 && other.object_index != objBusterShotCharged)
{
    other.penetrate = 0;
    other.pierces = 0;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!dead)
{
    draw_sprite_part(sprite_index, -1, 0, 0, sprite_width,
        round(sprite_height - offset), round(x - sprite_xoffset),
        round(y - sprite_yoffset));
}
