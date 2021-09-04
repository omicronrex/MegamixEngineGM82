#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// A block that drops from the ceiling, landing on the ground. If it hits Mega Man while falling, it will damage him.
event_inherited();
healthpointsStart = 3;
isSolid = 1;

contactDamage = 3;
itemDrop = -1;
faction = 7;
bubbleTimer = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if ((!global.frozen) && (!dead) && (!global.timeStopped))
{
    with (objMegaman)
    {
        if (place_meeting(x, y - gravDir * 4 - (other.yspeed * (other.yspeed > 0)), other))
        {
            if ((canHit == true) && (iFrames == 0))
            {
                with (other)
                {
                    entityEntityCollision();
                }
            }
        }
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (other.object_index == objWaterShield)
{
    event_user(EV_DEATH);
}
