#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

respawn = false;

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 3;

facePlayerOnSpawn = true;

// enemy specific
lands = 0;

yspeed = -1; // <-=1 initial throwing arc
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (xcoll != 0) // blow up if a wall is hit
    {
        event_user(0);
        exit;
    }

    if (ground)
    {
        lands += 1;
        switch (lands)
        {
            case 1:
                yspeed = -4; // <-=1 first bounce height
                break;
            case 2:
                yspeed = -2.6; // <-=1 second bounce height
                break;
            case 3:
                event_user(0); // blow up
        }
    }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy();

explosion = instance_create(x, y, objHarmfulExplosion);
explosion.contactDamage = 6;

playSFX(
    sfxMM3Explode); // the original one didn't make any sound effects, but I decided to add this since it kind of feels empty without it, and there aren't any sound limitations to speak of here unlike the NES
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (spawned)
{
    xspeed = 1 * image_xscale;
}
