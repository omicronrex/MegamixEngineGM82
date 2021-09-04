#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;

myItem = 0;

isSolid = 1;
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
dead = 1;

var ex = instance_create(x + 8, y + 8, objExplosion);
ex.myItem = myItem;

if (myItem == 0)
{
    var randitem = floor(random(90));

    if (randitem < 3)
    {
        ex.myItem = objYashichi;
    }
    else if (randitem < 30)
    {
        ex.myItem = choose(objLife, objETank);
    }
    else
    {
        ex.myItem = choose(objLifeEnergyBig, objWeaponEnergyBig);
    }
}

instance_destroy(); // don't respawn
