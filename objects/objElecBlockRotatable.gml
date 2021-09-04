#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Do not flip it, rotate the object instead or it won't face the right direction
event_inherited();

canHit = false;
grav = 0;
bubbleTimer = -1;

isSolid = 1;

//@cc Initial delay
delay = 0;

//@cc How long the zap lasts
zapLength = 60;

//@cc How much it waits between zaps
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
    sx = x;
    sy = y;
    // find the right of the block so we can spawn at it (basically remove the sprite x and y origin of the spawner)
    sx -= sprite_get_xoffset(sprite_index) * cos(degtorad(image_angle));
    sy += sprite_get_xoffset(sprite_index) * sin(degtorad(image_angle)); // -= cause the polar coordinate and cartesian coordinate systems of GMS are misaligned
    sx -= sprite_get_yoffset(sprite_index) * cos(degtorad(image_angle + 270));
    sy += sprite_get_yoffset(sprite_index) * sin(degtorad(image_angle + 270));
    sx += sprite_get_width(sprite_index) * cos(degtorad(image_angle));
    sy -= sprite_get_width(sprite_index) * sin(degtorad(image_angle));
    alarmAttack += 1;
    if (alarmAttack >= (waitLength + zapLength))
    {
        i = instance_create(sx, sy, objEnemyBullet);
        i.sprite_index = sprElecThunder;
        i.alarmDie = zapLength;
        i.image_angle = image_angle;
        i.imageSpeed = 0.25;
        i.contactDamage = 4;
        i.reflectable = 0;

        if (insideView())
        {
            playSFX(sfxBlockZap);
        }

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
