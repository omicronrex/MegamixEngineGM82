#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

isSolid = 1;

flash = 0;
actionTimer = 0;

isTargetable = false;

time = 3;

shownumber = 1;
pressed = 0;

timerstart = noone;
alarm[0] = 1;

blockCollision = 0;
grav = 0;
bubbleTimer = -1;

if (sprite_index == sprCountBomb)
{
    xx = 5;
    yy = 10;
    ex = 9;
    ey = 14;
    xs = 0;
    ys = 4;
}
if (sprite_index == sprCountBombDown)
{
    xx = 5;
    yy = 4;
    ex = 9;
    ey = 8;
    xs = 0;
    ys = -4;
}
if (sprite_index == sprCountBombLeft)
{
    xx = 11;
    yy = 4;
    ex = 14;
    ey = 8;
    xs = 4;
    ys = 0;
}
if (sprite_index == sprCountBombRight)
{
    xx = 5;
    yy = 4;
    ex = 10;
    ey = 8;
    xs = -4;
    ys = 0;
}
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
timerstart = time;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (timerstart == noone)
{
    exit;
}

if (!global.frozen && !dead && !global.timeStopped)
{
    if (instance_exists(target) && image_index == 0)
    {
        doIt = 0;
        with (objMegaman)
        {
            with (other)
            {
                if ((sprite_index == sprCountBomb && other.gravDir == 1)
                    || (sprite_index == sprCountBombDown && other.gravDir == -1))
                {
                    if (place_meeting(x, y - 1 * other.gravDir, other.id) && other.ground)
                    {
                        doIt = 1;
                    }
                }
                if ((sprite_index == sprCountBombDown && other.gravDir == 1)
                    || (sprite_index == sprCountBomb && other.gravDir == -1))
                {
                    if (place_meeting(x, y + 2 * other.gravDir, other.id)) // && !other.target.ground
                    {
                        doIt = 1;
                    }
                }
                if (sprite_index == sprCountBombLeft)
                {
                    if (place_meeting(x - 1, y, other.id) && (other.xspeed > 0
                        || other.isSlide
                        || global.keyRight[other.playerID]))
                    {
                        doIt = 1;
                    }
                }
                if (sprite_index == sprCountBombRight)
                {
                    if (place_meeting(x + 1, y, other.id) && (other.xspeed < 0
                        || other.isSlide
                        || global.keyLeft[other.playerID]))
                    {
                        doIt = 1;
                    }
                }
            }
        }
        if (doIt)
        {
            image_index = 1;
            actionTimer = 8;
            pressed = 8;
        }
    }

    if (actionTimer && !pressed)
    {
        actionTimer -= 1;
        if (actionTimer == 0)
        {
            if (time)
            {
                actionTimer = 18;
                time -= 1;
                shownumber = -3;
                playSFX(sfxCountBomb);
                exit;
            }
            if (time == 0)
            {
                actionTimer = 4;
                time -= 1;
                exit;
            }
            if (flash < 7)
            {
                actionTimer = 4;
                if (image_index == 1)
                {
                    image_index = 2;
                }
                else
                {
                    image_index = 1;
                }
                flash += 1;
                exit;
            }
            else
            {
                event_user(EV_DEATH);
            }
        }
    }
}
else if (dead)
{
    image_index = 0;
    flash = 0;
    actionTimer = 0;
    shownumber = 1;
    pressed = 0;
    if (timerstart != noone)
    {
        time = timerstart;
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_create(x + ex, y + ey, objHarmfulExplosion);
playSFX(sfxMM3Explode);

dead = 1;
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.guardCancel = 3;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if ((timerstart == noone) || (dead))
{
    exit;
}

if (pressed)
{
    x += xs;
    y += ys;
}

event_inherited();

if (time > -1 && shownumber)
{
    draw_sprite(sprCountBombNumbers, time, x + xx, y + yy);
}
else if (!shownumber)
{
    shownumber += 1;
}

if (pressed)
{
    x -= xs;
    y -= ys;
    pressed -= 1;
}
