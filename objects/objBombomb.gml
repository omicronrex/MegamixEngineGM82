#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// The original pit-dwelling enemy. Quite a bit different from the traditional one, though. It will
// pop out when Mega Man approaches AND it specifically is ready to pop out - the timer for this set as popDelay.
// When it pops out, it will shortly explode into four exploding shrapnel pieces that explode.

// One thing to note: An object called objBombombStopper will make this enemy explode on touch with that
// object, instead of the default arc. Use it if you want.

event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 3;
contactStart = contactDamage;

grav = 0;

// Enemy specific code
phase = 1;

//@cc color. 0 = blue; 1 = red
col = 0; // 0 = blue, 1 = red
init = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Set color on spawn.
if (init)
{
    init = 0;
    switch (col)
    {
        case 0:
            sprite_index = sprBombomb;
            break;
        case 1:
            sprite_index = sprBombombRed;
            break;
    }
}

event_inherited();

if (entityCanStep())
{
    switch (phase)
    {
        case 1:
            if (target)
            {
                // Check if the target (nearest player) is close.
                if (collision_rectangle(x - 96, view_yview, x + 96, view_yview + view_hview, target, false, true))
                {
                    phase = 2;
                    yspeed = -7.5;
                    grav = 0.25;

                    // Check for the custom stopper object.
                    i = collision_rectangle(bbox_left + 1, y, bbox_right - 1, y - view_hview, objBombombStopper, false, false);
                    if (i)
                    {
                        yspeed = ySpeedAim(y, i.y, 0.25);
                    }
                }
            }
            break;
        case 2: // If it's starting to move downwards, explode.
            if (yspeed > 0 && healthpoints > 0)
            {
                dead = 1;
                with instance_create(x + 8, y + 8, objHarmfulExplosion)
                {
                    sprite_index = sprExplosion;
                }

                playSFX(sfxClassicExplosion);
                repeat (2)
                {
                    image_xscale *= -1;
                    i = instance_create(x + 8, bboxGetYCenter(), objShrapnel);
                    i.xspeed = 1.5 * image_xscale;
                    i.yspeed = -3.8;
                    if (col == 1)
                    {
                        i.sprite_index = sprBombombShrapnelRed;
                    }
                    i = instance_create(x + 8, bboxGetYCenter(), objShrapnel);
                    i.xspeed = 2.5 * image_xscale;
                    i.yspeed = -3.5;
                    if (col == 1)
                    {
                        i.sprite_index = sprBombombShrapnelRed;
                    }
                }
            }
            break;
    }
}

visible = (phase > 1);
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
dead = 1;

instance_create(bboxGetXCenter(), bboxGetYCenter(), objHarmfulExplosion);
playSFX(sfxMM3Explode);
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// This enemy is invincible, so just do this to reflect bullets.
other.guardCancel = 2;//3
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

grav = 0;
phase = 1;
