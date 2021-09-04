#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// usesRng = <boolean>. If true, the sea mine will use RNG to determine if it'll blow up if you get close. Default true.

event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 6;

grav = 0;

// Enemy specific code
yspeed = -0.25;
actionTimer = 0;
action = 1;

usesRng = true;

inWater = -1; // shouldn't have collision with the water
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (instance_exists(target))
    {
        if (abs(target.x - x) < 64)
        {
            if (abs(target.y - y) < 32)
            {
                if (action != 5)
                {
                    if (irandom(40) == 0 || !usesRng)
                    {
                        image_speed = 0.2;
                        action = 5;
                        actionTimer = 0;
                        yspeed = 0;
                    }
                }
            }
        }
    }

    if (action)
    {
        actionTimer += 1;
        switch (action)
        {
            case 1:
                if (actionTimer == 64)
                {
                    action += 1;
                    actionTimer = 0;
                    yspeed = 0;
                }
                break;
            case 2:
                if (actionTimer == 29)
                {
                    action += 1;
                    actionTimer = 0;
                    yspeed = 0.25;
                }
                break;
            case 3:
                if (actionTimer == 64)
                {
                    action += 1;
                    actionTimer = 0;
                    yspeed = 0;
                }
                break;
            case 4:
                if (actionTimer == 29)
                {
                    action = 1;
                    actionTimer = 0;
                    yspeed = -0.25;
                }
                break;
            case 5:
                if (actionTimer == 64)
                {
                    dead = 1;
                    visible = 0;
                    instance_create(spriteGetXCenter(), spriteGetYCenter(),
                        objHarmfulExplosion);
                    playSFX(sfxExplosion2);
                }
                break;
        }
    }
}
else if (dead)
{
    yspeed = -0.25;
    actionTimer = 0;
    action = 1;
    image_speed = 0;
    image_index = 0;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (other.penetrate != 2)
{
    other.guardCancel = 1;
}
else
{
    other.guardCancel = 2;
}
