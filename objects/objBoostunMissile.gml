#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// A missile fired by Boostun. It only travels in one direction, but can be fired in twenty directions
event_inherited();

canHit = true;
contactDamage = 6;
grav = 0;
dir = 0;

respawn = false;
blockCollision = 0;
parent = noone;

jetTimer = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    xspeed = abs(cos(degtorad(dir))) * 2 * image_xscale;
    yspeed = -sin(degtorad(dir)) * 2;

    // Jet Animation
    jetTimer += 1;
    if (jetTimer >= 4)
    {
        if (sprite_index == sprBoostunMissile)
        {
            sprite_index = sprBoostunMissile2;
        }
        else
        {
            sprite_index = sprBoostunMissile;
        }

        jetTimer = 0;
    }

    if (!instance_exists(parent))
    {
        dead = true;
    }
}
else if (dead)
{
    with (parent)
    {
        flyTimer = 30;
        shootTimer = 60;
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
instance_create(x, y, objExplosion);
playSFX(sfxEnemyHit);

/* with (parent)
{
    flyTimer = 30;
    shootTimer = 60;
}
