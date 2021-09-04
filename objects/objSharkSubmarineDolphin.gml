#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = false;

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 4;
itemDrop = -1;
stopOnFlash = false;
canIce = false;

bouncyCalamity = true; // True = can bounce, False = can't bounce.
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (ground)
    {
        if (bouncyCalamity)
        {
            bouncyCalamity = false;
            if (ycoll != 0)
            {
                ground = false;
                yspeed = -ycoll * 0.5;
            }
        }
        else
        {
            image_speed = 1 / 6;
            if (xcoll != 0)
            {
                event_user(EV_DEATH);
            }
            xspeed = 2 * image_xscale;
        }
    }
}
#define Other_40
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy();
