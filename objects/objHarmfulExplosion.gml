#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;
blockCollision = 0;
grav = 0;

//@cc if true enemies will take damage
damageEnemies = false;

//@cc if false players won't take damage
damagePlayer = true;

contactDamage = 4;
attackDelay = 4;
canDamage = false;
image_speed = 0.3;

image_index = 1;

reflectable = 0;
parent = noone;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (damagePlayer && image_index <= 6)
    canDamage = true;
event_inherited();

if (entityCanStep())
{
    //image_speed = 0.3;
    if (damageEnemies && image_index <= 6)
    {
        with (prtEntity)
        {
            if (id == other.id || faction != 3 || !canHit || hitTimer < other.attackDelay || iFrames != 0 || dead)
                continue;
            if (place_meeting(x, y, other))
            {
                with (other)
                {
                    guardCancel = 0;
                    penetrate = 1;
                    with (other)
                        event_user(EV_GUARD);
                    if (guardCancel > 0)
                        global.damage = 0;
                    else
                        global.damage = contactDamage;
                }
                if (global.damage > 0)
                {
                    hitTimer = 0;
                    healthpoints -= global.damage;
                    event_user(EV_HURT);
                    if (healthpoints <= 0)
                        event_user(EV_DEATH);
                }
                global.damage = 0;
            }
        }
    }
}
else
{
    image_speed = 0;
}

if (image_index > 6)
{
    canDamage = false;
}
#define Other_7
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy();
