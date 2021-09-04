#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Big robot snail that aims bombs and his own eyes at Megaman
event_inherited();
respawn = true;
facePlayerOnSpawn = false;

healthpointsStart = 16;
healthpoints = healthpointsStart;
contactDamage = 4;
category = "bulky, nature";

introSprite = sprEscarooIntro;

sprite_index = sprEscaroo;
mask_index = sprEscaroo;
x = xstart + image_xscale * (abs(sprite_get_xoffset(sprEscaroo) - sprite_get_xoffset(sprEscarooPreview)));
y -= image_yscale * (abs(sprite_get_yoffset(sprEscaroo) - sprite_get_yoffset(sprEscarooPreview)));
xstart = x;
ystart = y;

// Enemy specific code
dir = image_xscale;
init = 1;

shootTimer = 0;
image_speed = 0.15;
eye = noone;
introDone = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    shootTimer += 1;
    if (shootTimer == 160 + 90)
    {
        instance_create(x - 4 * image_xscale, y - 40, objEscarooBomb);
        shootTimer = 0;
    }
    if (!instance_exists(eye) && introDone)
    {
        eye = instance_create(x + 34 * image_xscale, y + 1, objEscarooEyes);
        eye.parent = id;
        eye.image_xscale = image_xscale;
        eye.dead = false;
    }
}
else if (!insideView())
{
    image_index = 0;
    shootTimer = 0;
}
if (introTimer == 1)
{
    introDone = true;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// make sure eyes aren't left over
if (instance_exists(eye))
{
    with (eye)
    {
        instance_destroy();
    }
    eye = noone;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.guardCancel = 1;
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (!spawned)
{
    if (instance_exists(eye))
    {
        with (eye)
            instance_destroy();
        eye = noone;
    }
}
