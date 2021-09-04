#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = false;

blockCollision = 0;

isTargetable = false;
grav = 0;

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;

// Enemy specific code
phase = 0;
playSFX(sfxWanaan);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (phase == 1)
    {
        y += 4;
        if (y >= ystart)
        {
            instance_destroy();
        }
    }
    if (place_meeting(x, y, objWanaan))
    {
        if (phase == 0)
        {
            y -= 4;
        }
    }
    else
    {
        image_index = 1;
        phase = 1;
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.guardCancel = 3;
