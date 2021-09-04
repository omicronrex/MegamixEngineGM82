#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_perform_object(prtEntity,ev_create,0);
i = 0;
hitRoof = false;
offRoof = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!checkSolid(0,0,1,1))
{
    for (i = 0; i < 256; i += 1)
    {
        y -= 1;
        if (checkSolid(0, 0,1,1))
        {
            hitRoof = true;
            break;
        }
    }
}
if (checkSolid(0,0,1,1))
{
    hitRoof = true;
    y += 8;
}
if (!checkSolid(0, 0,1,1) && hitRoof == true)
    offRoof = true;
if (!instance_exists(objVoltMan))
    instance_destroy();
