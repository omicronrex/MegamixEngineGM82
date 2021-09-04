#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

yLowOffset = 56;
blinkMultiple = 4; // Interval tracked by blinkTimer.

cannon = noone;

startFiring = false; // Can the cannon shoot yet?
eyeIndex = 0; // 0 = Open, 1 = Half open/closed, 2 = closed.
blinkTimer = blinkMultiple * 2; // Controls blink animation.
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// Creating the cannon at the start of the fight.
if (!global.frozen)
{
    if (isIntro)
    {
        if (!instance_exists(cannon))
        {
            cannon = instance_create(x - 95 * image_xscale, y + 18 * image_yscale,
                objSharkSubmarineCannon);
            cannon.headShark = id;
            cannon.healthpointsStart = healthpoints;
            cannon.healthpoints = cannon.healthpointsStart;
            cannon.respawn = false;
            cannon.parent = id;
        }
    }
}

if (isFight) // Keeping track of health.
{
    healthpoints = 0;
    if (instance_exists(cannon))
    {
        healthpoints += cannon.healthpoints;
    }
}

// Attack pattern.
if (entityCanStep())
{
    if (isFight)
    {
        startFiring = true;

        if (blinkTimer <= 0) // Eye closed.
        {
            eyeIndex = 2;
        }
        if (blinkTimer == blinkMultiple) // Eye half open.
        {
            eyeIndex = 1;
        }
        if (blinkTimer >= blinkMultiple * 2) // Eye wide open.
        {
            eyeIndex = 0;
        }
        blinkTimer+=1;
    }
}
else if (dead)
{
    eyeIndex = 3;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (objSharkSubmarineLaser)
{
    instance_destroy();
}
event_inherited();
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (introTimer <= 0)
{
    if (killed)
        eyeIndex = 2;
    draw_sprite_ext(sprSharkSubmarineEye, eyeIndex, x - 93 * image_xscale,
        round(y) - 5 * image_yscale, image_xscale, image_yscale, image_angle,
        image_blend, image_alpha);
}
