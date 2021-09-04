#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

canHit = false;
grav = 0;
blockCollision = 0;
bubbleTimer = -1;
kamapot = noone;

kamapotSpeed = -2; // SET IN ROOM EDITOR - choose between 'slow', 'medium', and 'fast'.
kamapotDelay = 60;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (!instance_exists(kamapot))
    {
        var i = instance_create(x, y - 3 * image_yscale, objKamapot);
        i.kamapotSpeed = kamapotSpeed * image_yscale;
        i.image_yscale = image_yscale;

        // shift up player if theyre on top of the kamapot
        if place_meeting(x, y - 3 * image_yscale, objMegaman)
        {
            with instance_place(x, y - 3 * image_yscale, objMegaman)
            {
                shiftObject(0, -3 * image_yscale, true);
            }
        }

        i.moveTimer = kamapotDelay;
        kamapot = i.id;
    }
}
