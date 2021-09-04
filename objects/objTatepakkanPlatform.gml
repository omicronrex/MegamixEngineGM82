#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

contactDamage = 0;
canHit = false;

isSolid = 2;
doesTransition = false;
respawn = false;

respawnRange = -1;
despawnRange = -1;
canIce = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead)
{ }
else if (dead)
{
    instance_destroy();
}
