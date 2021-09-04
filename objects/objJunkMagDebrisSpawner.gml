#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;

hasSwitch = false;

respawnRange = -1;
despawnRange = -1;

grav = 0;
blockCollision = 0;
bubbleTimer = -1;

timer = 180;

myFlag = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!hasSwitch)
{
    with (objSwitchHandler)
    {
        if (myFlag == other.myFlag)
        {
            other.hasSwitch = true;
        }
    }
}

event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    if (hasSwitch)
    {
        if (global.flagParent[myFlag].active)
        {
            timer += 1;
            if (timer >= 180)
            {
                var debris = instance_create(x, global.sectionBottom, objJunkMagDebris);
                debris.myFlag = myFlag;
                timer = 0;
            }
        }
    }
}
else if (dead)
{
    timer = 180;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// I don't think so.
