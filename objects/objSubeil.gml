#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// col = <number> (0 = green (default); 1 = red; 2 = purple)

event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 3;

category = "grounded";

// Enemy specific code
radius = 72;
imageOffset = 0;
hitboxOffset = 6;
activated = false;
imageTimer = 0;
imageTimerMax = 8;

col = 0;

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
    if (target)
    {
        if (!activated && abs(target.x - x) <= radius && abs(target.y - y) <= 16)
        {
            activated = true;
            imageOffset = 2;
            mask_index = sprMousubeil; // REUSING ASSETS CLAP EMOJI
            calibrateDirection();
        }
    }

    imageTimer += 1;
    if (imageTimer > imageTimerMax)
    {
        imageTimer = 0;
    }

    if (!activated)
    {
        if (imageTimer == imageTimerMax / 2 && imageOffset == 0)
        {
            imageOffset = 1;
            imageTimer = 0;
        }
        else if (imageTimer == imageTimerMax / 2 && imageOffset == 1)
        {
            imageOffset = 0;
            imageTimer = 0;
        }
    }

    // animation setup
    if (imageTimer == imageTimerMax && imageOffset > 1 && imageOffset < 5)
    {
        imageOffset += 1;
        imageTimer = 0;
    }
    if (imageTimer == imageTimerMax && imageOffset == 5)
    {
        imageOffset = 3;
        imageTimer = 0;
    }

    if (!ground)
    {
        xspeed = 0;
    }
    else
    {
        if (activated && imageOffset > 2)
        {
            if (xspeed == 0 && yspeed == 0)
            {
                xspeed = 2 * image_xscale;
            }
        }
    }

    // turn around on hitting a wall
    xSpeedTurnaround();
}
else if (dead)
{
    calibrateDirection();
    xspeed = 0;
    yspeed = 0;
    imageOffset = 0;
    hitboxOffset = 6;
    activated = false;
    mask_index = sprSubeil;
}

image_index = (col * 6) + imageOffset;

// if subeil is not activated, it defaults its values.
if (!activated)
{
    contactDamage = 3;
}
else
{
    // set size of hitbox depending on animation frames.
    if (imageOffset <= 2)
    {
        hitboxOffset = -6;
    }
    else if (imageOffset == 2)
    {
        hitboxOffset = 0;
    }
    else
    {
        hitboxOffset = 8;
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*if (other.bbox_bottom < y + hitboxOffset)
{
    other.guardCancel = 2;
}
