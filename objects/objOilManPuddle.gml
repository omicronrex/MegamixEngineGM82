#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
blockCollision = 0;
grav = 0;
stopOnFlash = false;
reflectable = false;
contactDamage = 0;
playSFX(sfxOil);
delay = 128;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (!global.frozen)
{
    if (image_index < image_number - 1)
        image_index += 0.25;
    with (instance_place(x, y, objMegaman))
    {
        if (ground && xspeed != 0)
        {
            playerGetShocked(0, 35, true, 30); // fine-tune if necessary
            xspeed = 0;
        }
    }
    if (delay > 0)
        delay -= 1;
    else
        instance_destroy();
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (delay > 32 || delay <= 32 && delay mod 2 == 0)
    event_inherited();
