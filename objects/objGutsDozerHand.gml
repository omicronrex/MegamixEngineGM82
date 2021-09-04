#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 9999;
healthpoints = healthpointsStart;
contactDamage = 4;

isTargetable = false;

parent = noone;
yOffset = 0;
despawnRange = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (instance_exists(parent))
    {
        image_xscale = parent.image_xscale;
        x = parent.x - 58 * image_xscale;
        y = parent.y - 16 - yOffset;
    }
    else
        instance_destroy();
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
//
