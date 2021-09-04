#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
i = 0;
delay = 0;
hitFloor = false;
shuntedIntoRoof = false;
event_perform_object(prtEntity, ev_create, 0);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (delay > 0 && !global.frozen)
    delay -= 1;
if (delay == 0)
{
    shuntedIntoRoof = false;
    if (instance_exists(objCentaurMan))
    {
        if (instance_exists(objMegaman) && objCentaurMan.randomSpawn == false)
        {
            image_xscale = objMegaman.image_xscale;
            x = objMegaman.x - image_xscale;
        }
        else
            x = view_xview + (irandom_range(2 * 16, 14 * 16));
        y = view_yview + view_hview - 32;
        hitFloor = false;
        for (i = 0; i < 256; i += 1)
        {
            if (((y <= view_yview + 16) && objCentaurMan.randomSpawn == false)
                || ((y <= view_yview + 16)
                && objCentaurMan.randomSpawn == true && place_meeting(x, y,
                objCentaurMan)))
            {
                i = 0;
                delay = 0;
                shuntedIntoRoof = true;
                break;
            }

            if (checkSolid(0, 0, 1, 1) && hitFloor == false)
                y -= 1;
            else if (!checkSolid(0, 0, 1, 1) && hitFloor == false)
                hitFloor = true;
            else
                break;
        }
        if (shuntedIntoRoof == false)
        {
            i = 0;
            delay = 4;
        }
    }
}
if (!instance_exists(objCentaurMan))
    instance_destroy();
