#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Same as objElecBlockRotatable. Do not flip it, rotate the object instead or it won't face the right direction
event_inherited();

isSolid = 1;

grav = 0;
canHit = false;
bubbleTimer = -1;

delay = 0;
zapLength = 60;
waitLength = 60;

alarmAttack = 0;
sx = 0;
sy = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    image_xscale = 1;
    image_yscale = 1;
    sx = x;
    sy = y;
    // find the right of the block so we can spawn at it (basically remove the sprite x and y origin of the spawner)
    sx -= sprite_get_xoffset(sprite_index) * cos(degtorad(image_angle));
    sy += sprite_get_xoffset(sprite_index) * sin(degtorad(image_angle)); // -= cause the polar coordinate and cartesian coordinate systems of GMS are misaligned
    sx -= sprite_get_yoffset(sprite_index) * cos(degtorad(image_angle + 270));
    sy += sprite_get_yoffset(sprite_index) * sin(degtorad(image_angle + 270));
    sx += sprite_get_width(sprite_index) * cos(degtorad(image_angle));
    sy -= sprite_get_width(sprite_index) * sin(degtorad(image_angle));

    // do not function if it's raining
    if (global.telTelWeather == 1)
    {
        exit;
    }

    // create the actual fire
    if (!place_meeting(sx, sy, objFireBlockFire))
    {
        i = instance_create(sx, sy, objFireBlockFire);
        i.image_angle = image_angle;
    }

    alarmAttack += 1;
    if (alarmAttack >= (waitLength + zapLength))
    {
        i.sprite_index = sprFireBeam;
        i.alarmCalm = zapLength;
        alarmAttack = 0;
    }
}
else if (dead)
{
    alarmAttack = -delay;
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/* if we have a custom sprite with a different sprite origin, shift our position so
we are in the same place we appeared in in the editor */
if (sprite_get_xoffset(sprite_index) != 0 || sprite_get_yoffset(sprite_index) != 0)
{
    // find the top left position of the laser spawner so we can spawn at it (basically remove the sprite x and y origin of the spawner)
    xstart += sprite_get_xoffset(sprite_index) * cos(degtorad(image_angle));
    ystart -= sprite_get_xoffset(sprite_index) * sin(degtorad(image_angle)); // -= cause the polar coordinate and cartesian coordinate systems of GMS are misaligned
    xstart += sprite_get_yoffset(sprite_index) * cos(degtorad(image_angle + 270));
    ystart -= sprite_get_yoffset(sprite_index) * sin(degtorad(image_angle + 270));

    x = xstart;
    y = ystart;
}
