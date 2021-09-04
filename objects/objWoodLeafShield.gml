#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
stopOnFlash = true;
range = 24;
canHit = true;
reflectable = 0;
followWood = true;

isTargetable = false;

xs = x;
ys = y;

contactDamage = 4;
blockCollision = 0;
rotationTimer = 0;
grav = 0;

x = round(xs + 22 * cos(direction / 57));
y = round(ys + 22 * sin((direction + 180) / 57));
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // sticks to wood man
    if (instance_exists(objWoodMan))
    {
        if (followWood)
        {
            xs = bboxGetXCenterObject(objWoodMan);
            ys = bboxGetYCenterObject(objWoodMan);
            image_xscale = other.image_xscale;
        }
    }
    else
    {
        instance_destroy();
    }

    xs += xspeed;
    if (followWood)
        ys += yspeed;
    x = round(xs + 22 * cos(direction / 57));
    y = round(ys + 22 * sin((direction + 180) / 57));
    if rotationTimer >= 3
    {
        direction += 22.5;
        rotationTimer = 0;
    }
    else
    {
        rotationTimer+=1
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (other.object_index != objFlameMixer) && (other.object_index != objTornadoBlow)
&& (other.object_index != objSolarBlaze)
{
    other.guardCancel = 3;
}
else
{
    if (other.object_index != objTornadoBlow)
    {
        instance_create(x,y,objExplosion);
    }
    event_user(EV_DEATH);
}
#define Other_40
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy();
