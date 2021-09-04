#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
i = 0;
hitWall = false;
event_perform_object(prtEntity, ev_create, 0);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!checkSolid((8 * image_xscale), 0, 1, 1))
{
    for (i = 0; i < 256; i += 1)
    {
        x += (1 * image_xscale);
        if (checkSolid(8 * image_xscale, 0, 1, 1))
        {
            hitWall = true;
            break;
        }
    }
}
if (checkSolid((8 * image_xscale), 0, 1, 1))
{
    hitWall = true;
}
if (!instance_exists(objSplashWoman))
    instance_destroy();
