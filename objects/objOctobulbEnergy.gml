#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///
event_inherited();
canHit = false;
blockCollision = false;
grav = 0;
reflectable = false;
dead = false;

spd = 3;
dir = 1;
order = 0;
turnAfter[0] = -1;
turnAfter[1] = -1;
turnAfter[2] = -1;
turnAfter[3] = -1;
turnAfter[4] = -1;
image_speed = 0.35;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep)
{
    path_speed = spd;
}
else if (dead)
    path_speed = 0;
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
switch (order)
{
    case 0:
        if (dir == 1)
            path_start(pthOctobulbEnergy1, spd, path_action_stop, false);
        else
            path_start(pthOctobulbEnergy4, spd, path_action_stop, false);
        break;
    case 1:
        if (dir == 1)
            path_start(pthOctobulbEnergy2, spd, path_action_stop, false);
        else
            path_start(pthOctobulbEnergy5, spd, path_action_stop, false);
        break;
    case 2:
        if (dir == 1)
            path_start(pthOctobulbEnergy3, spd, path_action_stop, false);
        else
            path_start(pthOctobulbEnergy6, spd, path_action_stop, false);
        break;
}
