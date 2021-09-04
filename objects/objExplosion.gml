#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

image_speed = 1 / 3;

alarm[0] = ((1 / image_speed) * image_number) - 1;

myItem = -1;
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_user(0);

instance_destroy();
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// if "myItem" ==  0 --> regular drop
// if "myItem" == -1 --> drop nothing
// if "myItem" >   0 --> use value to determine new object

// Random drop rates (credit to Blyka)
// randomize();

if (myItem >= 0)
{
    var item = myItem;

    if (item == 0)
    {
        if (!irandom(4096)) // The shiniest shiny of all shinies
        {
            item = objYashichi;
        }
        else
        {
            var randItem = floor(random(600));
            randItem *= 1 - (global.dropUpgrade * 0.33) - (global.converter * 0.1);

            if (randItem < 4)
            {
                item = objLife;
            }
            else if (randItem < 45)
            {
                item = choose(objLifeEnergyBig, objWeaponEnergyBig);
            }
            else if (randItem < 120)
            {
                item = choose(objLifeEnergySmall, objWeaponEnergySmall, objBoltBig);
            }
            else if (randItem < 240)
            {
                item = objBoltSmall;
            }
        }
    }

    if (item)
    {
        i = instance_create(x, y, item);
        i.respawn = false;
        i.x += bboxGetXCenter() - bboxGetXCenterObject(i);
        i.y += bboxGetYCenter() - bboxGetYCenterObject(i);
        i.disappear = 105 * 2;
        if (i.grav != 0)
        {
            i.yspeed = -2;
        }
    }
}
