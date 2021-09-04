#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 3;
canHit = true;
contactDamage = 3;

bounces = 0;
countdown = 300;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    xspeed = 0.5 * image_xscale;

    if (xcoll != 0)
    {
        image_xscale *= -1;
    }

    if (ground)
    {
        if (bounces < 2)
        {
            bounces++;
            yspeed = -4;
        }
        else
        {
            bounces = 0;
            yspeed = -5;
        }
    }

    countdown--;
    if (countdown == 0)
    {
        event_user(EV_DEATH);
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
