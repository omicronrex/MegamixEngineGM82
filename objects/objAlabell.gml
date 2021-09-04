#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// An alarm clock bomb that walks in one direction and jumps when changing numbers (can
// count down from 9). It explodes when time runs out, but can be pushed away with the
// Mega Buster.

event_inherited();

healthpointsStart = 36;
healthpoints = healthpointsStart;

actionTimer = 60;
jumpTimer = 120;
contactDamage = 4; // Damage dealt to Mega Man via contact

// Enemy Specific Code
// @cc - Set time from 1-9 based on when you want Alabell to explode
time = 3;

dir = 0;
currentTime = time;
animBack = false; // Do we reverse the animation?
imgSpd = 0.1;
phase = 0;

init = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (init)
{
    if (dir == 0)
    {
        if (instance_exists(target)) // Set direction
        {
            if (x < target.x)
            {
                dir = 1;
            }
            else
            {
                dir = -1;
            }
        }
    }
    init = 0;
}

if (healthpoints < healthpointsStart)
{
    healthpoints = healthpointsStart; // Always heal damage received - can't be killed
}

if (entityCanStep())
{
    // Change directions when touching wall
    if (xcoll != 0 && (yspeed == 0) && (ground))
    {
        dir = -dir;
    }

    // Movement
    xspeed = 1 * dir;
    actionTimer -= 1;
    switch (phase)
    {
        case 0: // Walking
            jumpTimer -= 1;
            if ((jumpTimer <= 0) && (ground))
            {
                yspeed = -6; // Jump up
                phase = 1;
            }
            break;
        case 1: // Jumping
            if (ground)
            {
                jumpTimer = 120;
                phase = 0;
            }
            break;
    }

    // Animation
    if (!animBack)
    {
        image_index += imgSpd;
        if (image_index >= 3)
        {
            image_index = 2;
            animBack = true;
        }
    }
    else
    {
        image_index -= imgSpd;
        if (image_index <= 0)
        {
            image_index = 1;
            animBack = false;
        }
    }

    switch (currentTime) // Display sprite based on time
    {
        case 1:
            sprite_index = sprAlabell1;
            break;
        case 2:
            sprite_index = sprAlabell2;
            break;
        case 3:
            sprite_index = sprAlabell3;
            break;
        case 4:
            sprite_index = sprAlabell4;
            break;
        case 5:
            sprite_index = sprAlabell5;
            break;
        case 6:
            sprite_index = sprAlabell6;
            break;
        case 7:
            sprite_index = sprAlabell7;
            break;
        case 8:
            sprite_index = sprAlabell8;
            break;
        case 9:
            sprite_index = sprAlabell9;
            break;
        default:
            break;
    }

    if (actionTimer == 0)
    {
        if (currentTime != 1)
        {
            actionTimer = 60;
            currentTime -= 1;
            playSFX(sfxCountBomb);
            exit;
        }
        else
        {
            dead = true;
            explosion = instance_create(x, spriteGetYCenter(), objHarmfulExplosion);
            explosion.contactDamage = 8;
            explosion.damageEnemies = true;
            playSFX(sfxMM9Explosion);
        }
    }
}
else if (dead)
{
    actionTimer = 60;
    jumpTimer = 120;
    currentTime = time;
    xspeed = 0;
    yspeed = 0;
    dir = 0;
    init = 1;
}
#define Other_19
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (other.x < x)
    {
        shiftObject(16, 0, 1);
    }
    else if (other.x > x)
    {
        shiftObject(-16, 0, 1);
    }
    else if (instance_exists(target))
    {
        shiftObject(16 * sign(target.image_xscale), 0, 1);
    }
}
