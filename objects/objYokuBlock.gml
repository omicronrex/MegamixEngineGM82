#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Note: creation code is mandatory.
// Note: Yoku Blocks appear and disappear regardless of whether they are on-screen or off-screen
// This is to prevent inconsistent timing, such as the ones in Heat Man's stage in MM2

event_inherited();

sprite_index = sprYokuBlock;

canHit = false;

grav = 0;
bubbleTimer = -1;

// creation code setup stuff

//@cc the amount of frames it takes for the Yoku block to first appear
startup = 0;

//@cc the amount of frames the Yoku block is active before disappearing
active = 120;

//@cc (optional) true = will reappear after disappearing for the first time (default); false = only appears once (setting this to false will eliminate the need to set the wait variable)
neverDespawn = true;

//@cc the amount of frames the Yoku block needs to reappear after disappearing
wait = 120;

//@cc the sprite to use (optional)
sprite = noone;

//@cc if false no sound will play once it appears (optional)
doSFX = true;

spike = false; // don't set creation code to make yoku spikes, use the objYokuSpike object

timer = 0;
phase = 0; // 0 = waiting to appear; 1 = active; 2 = waiting to reappear after disappearing; 3 = inactive;
mySolid = -12;

respawnRange = -1;
despawnRange = -1;

alarm[0] = 1;
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!neverDespawn)
{
    wait = -1;
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    switch (phase)
    {
        case 0: // Waiting to appear
        // timer
            timer += 1;
            if (timer >= startup)
            {
                timer = 0;
                phase = 1;
                image_index = 0;

                event_user(0); // shunt mega man

                if (insideView() && doSFX)
                {
                    playSFX(sfxYokuBlock);
                }
            }
            break;
        case 1: // active
        // have solid
            if (insideView())
            {
                visible = true;

                if (!instance_exists(mySolid))
                {
                    if (!spike)
                    {
                        mySolid = instance_create(x, y, objSolid);
                    }
                    else
                    {
                        mySolid = instance_create(x, y, objSpike);
                    }
                }
            }

            // Animation
            if (image_index < image_number - 1)
            {
                image_speed = 0.25;
            }
            else
            {
                image_speed = 0;
                image_index = image_number - 1;
            }

            // timer
            timer += 1;
            if (timer >= active)
            {
                timer = 0;
                image_index = 0;

                if (neverDespawn)
                {
                    phase = 2;
                }
                else
                {
                    phase = 3; // set to inactive phase
                }
            }
            break;
        case 2: // Waiting to reappear after disappearing
        // timer
            timer += 1;
            if (timer >= wait)
            {
                timer = 0;
                phase = 1;
                image_index = 0;

                event_user(0); // shunt mega man

                if (insideView() && doSFX)
                {
                    playSFX(sfxYokuBlock);
                }
            }
            break;
        case 3: // inactive
            break;
    }
}
else if (dead)
{
    phase = 0;
    timer = 0;
    image_speed = 0;
    image_index = 0;
    visible = false;
}

if (phase != 1)
{
    visible = false;
    if (instance_exists(mySolid))
    {
        with (mySolid)
            instance_destroy();
    }
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// default yoku spike sprite
if (spike && sprite == noone && (sprite_index == sprYokuBlock
    || sprite_index == sprYokuBlockPreview))
{
    sprite_index = sprYokuSpike;
}

// custom sprite using sprite variable (for sake of compatability after studio port)
if ((sprite_index == sprYokuBlock
    || sprite_index == sprYokuBlockPreview) && sprite != noone)
{
    sprite_index = sprite;
}

if (sprite == noone)
{
    if (sprite_index == sprYokuBlockPreview)
    {
        // default yoku block sprite
        sprite_index = sprYokuBlock;
    }
    else
    {
        // custom sprite was set using sprite_index instead
        // don't do anything actually
    }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=605
invert=0
arg0=shunt megaman
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!spike) // don't need to shunt if it's a spike, since mega man gunna die
{
    with (objMegaman)
    {
        if (place_meeting(x, y, other))
        {
            with (other)
            {
                var xx; xx = 0;
                var yy; yy = -other.gravDir;

                size = (other.bbox_bottom - other.bbox_top) * yy;

                if (checkSolid(0, size))
                {
                    yy = 0;

                    size = other.bbox_right - other.bbox_left;

                    if (!checkSolid(size, 0))
                    {
                        xx = 1;
                    }
                    else
                    {
                        if (!checkSolid(-size, 0))
                        {
                            xx = -1;
                        }
                        else
                        {
                            exit;
                        }
                    }
                }

                with (other)
                {
                    if (yy != 0)
                    {
                        y = round(y);
                        ground = true;
                        yspeed = 0;
                    }
                    while (place_meeting(x, y, other.id))
                    {
                        x += xx;
                        y += yy;
                    }
                }
            }
        }
    }
}
