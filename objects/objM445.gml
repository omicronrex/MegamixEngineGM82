#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// a smaller and slower version of CWU-01P with spikes. It descends slowly down from the ceiling,
/// but once its aligned with Megaman, it will fly towards it in a wave pattern

event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "aquatic, floating";

blockCollision = 0;
grav = 0;

facePlayer = true;

// Enemy specific code
image_speed = 0.1; // STOP USING THIS VARIABLE

popDelay = 64;
popDelayStart = popDelay;

sineWave = false;
sinCounter = 0;

contactStart = contactDamage;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    image_speed = 0.1;
    if (popDelay)
    {
        popDelay -= 1;
        if (!popDelay)
        {
            yspeed = 0.5;
        }
    }
    else
    {
        if (!sineWave)
        {
            if (collision_line(x - 512, y, x + 512, y, target, false, true))
            {
                sineWave = true;
                xspeed = image_xscale;
            }
        }
        else
        {
            sinCounter += .035;
            yspeed = -(cos(sinCounter) * 1.3);
        }
    }
}
else
{
    image_speed = 0;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// On spawn
event_inherited();

popDelay = popDelayStart;
sineWave = false;
sinCounter = 0;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!popDelay)
{
    event_inherited();
    canHit = true;
    contactDamage = contactStart;
}
else
{
    canHit = false;
    contactDamage = 0;
}
