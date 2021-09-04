#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

canHit = false;

grav = 0;
isSolid = true;
bubbleTimer = -1;

respawnRange = -1;
despawnRange = -1;

timer = 0;

shiftVisible = 1;

// edit these with creation code
timerInitial = x;
timerMax = 4 * 60; // length of pattern
timerShoot = timerMax - 2 * 60; // at what point in pattern to shoot
timerWarning = timerShoot - 60; // at what point in pattern warning starts to flash
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    timer = (timer + 1) mod timerMax;
    image_index = 0;

    if (timer >= timerWarning)
    {
        image_index = (timer div 4) mod 2;
    }
    if (timer >= timerShoot)
    {
        image_index = 1;
    }
    if (timer == timerShoot)
    {
        if (insideView())
        {
            sound_stop(sfxMagmaBeam);
            playSFX(sfxMagmaBeam);
        }
        with (instance_create(bboxGetXCenter(), bboxGetYCenter(), objMagmaBeam))
        {
            timer = (other.timerMax - other.timerShoot);
            image_angle = other.image_angle;
            image_yscale = other.image_yscale;
            parent = other.id;
        }
    }
}

if (dead)
{
    timer = timerInitial;
}
