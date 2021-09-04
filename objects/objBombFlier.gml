#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// When hidden in cloud form, they go in a slow wave pattern. But when hit, the cloud disappears
// and they fly fast and straight like a bullet.
event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 2;

category = "flying";

grav = 0;
blockCollision = 0;

facePlayerOnSpawn = true;

// Enemy specific code
phase = 0;

cloudSpeed = 1;
bulletSpeed = 2.5;
sinCounter = 0;

uncoverWaitTimer = 0;

calibrateDirection();
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    switch (phase)
    {
        case 0: // slower flying in a sine pattern
            image_index += 20 / 60;
            xspeed = cloudSpeed * image_xscale;
            sinCounter += 0.1;
            yspeed = -(cos(sinCounter) * 1.3);
            break;
        case 1: // shedding cloud animation
            if (sprite_index == sprBombFlierUncover)
            {
                image_index += 8 / 60; // uncovering animation speed
                if (image_index > image_number - 1)
                {
                    sprite_index = sprBombFlierBullet;
                    image_index = 0;
                    uncoverWaitTimer = 6; // <-- wait time between uncovering and moving forward
                }
                break;
            }
            if (uncoverWaitTimer > 0)
            {
                uncoverWaitTimer -= 1;
            }
            else
            {
                uncoverWaitTimer = 0;
                phase = 2;
                xspeed = bulletSpeed * image_xscale;
            }
            break;
        case 2: // faster flying straight forward
            image_index += 20 / 60;
            break;
    }
}
else if (dead)
{
    phase = 0;
    sinCounter = 0;

    sprite_index = sprBombFlierCloud;
    image_index = 0;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (phase == 0)
{
    if (global.damage != 0)
    {
        phase = 1;

        xspeed = 0;
        yspeed = 0;
        sinCounter = 0;

        sprite_index = sprBombFlierUncover;
        image_index = 0;

        healthpoints += global.damage;
    }
}
else
{
    if (phase != 2)
    {
        other.guardCancel = 2;
    }
}
