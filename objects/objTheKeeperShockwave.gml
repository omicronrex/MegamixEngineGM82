#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
grav = 0;
blockCollision = false;
reflectable = false;
contactDamage = 3;
playSFX(sfxTheKeeperShockwave);
timer = 0;
image_speed = 0.4;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
image_xscale = sign(xspeed);
if (entityCanStep())
{
    timer += 1;
    if (timer > 10)
    {
        if (timer mod 4 == 0)
        {
            visible = false;
        }
        else
        {
            visible = true;
        }
        if (timer > 17)
        {
            image_index = 0;
        }
        if (timer > 20)
        {
            instance_destroy();
        }
    }
}
#define Other_7
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_index = image_number - 1;
image_speed = 0;
