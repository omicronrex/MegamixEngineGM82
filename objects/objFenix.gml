#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Fenix initializer, set hight to false in the creation code to start on the ground
// place him in its highest position.

i = instance_create(x, y, objSuzakAndFenix);
i.introSprite = sprFenix;
i.sprite_index = sprFenix;
i.xstart = x;
i.ystart = y;
i.minY = y;
high = true;
lockTransition = true;
category = "bird, fire, flying";
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
i.xscaleStart = image_xscale;
i.image_xscale = image_xscale;
if (!lockTransition)
{
    i.lockTransition = false;
}
if (!high)
{
    i.high = false;
}
i.init = 1;
with (i)
    event_perform(ev_step_begin, 0);
instance_destroy();
