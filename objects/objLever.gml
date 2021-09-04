#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

contactDamage = 0;
canHit = false;
bubbleTimer = -1;

state = 0; //@cc 0: up, 1: down
uptag = ""; //@cc tag for the leverfield to activate when up
downtag = ""; //@cc tag for the leverfield to activate when down
oneShot = false; //@cc if set to true, lever can only be flipped once, then is stuck.

respawnRange = -1;
despawnRange = -1;

touchingPlayer = false; // set to true when the player is touching to prevent toggling back and forth
transition_anim = 0;
flipped = false;

grav = 0;
blockCollision = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    // detect player touching and whether they're moving up or down
    var touching, player_yspeed, prev_state;
    touching = false;
    player_yspeed = 0;
    prev_state = state;

    if (!flipped || !oneShot)
    {
        with (objMegaman)
        {
            // normal check touching
            if (place_meeting(x, y - 1, other) && !ground)
            {
                if ((yspeed > 0 && y < other.y) || (yspeed < 0 && y > other.y))
                {
                    player_yspeed = yspeed;
                }
                touching = true;
            }
        }

        if (touching
            && !touchingPlayer) // suddenly touching; was not touching in previous frame.
        {
            touchingPlayer = true;
            if (player_yspeed > 0) // player moving down
            {
                state = 1;
            }
            if (player_yspeed < 0) // player moving up:
            {
                state = 0;
            }
        }

        if (!touching) // no longer touching, but was in previous frame:
        {
            touchingPlayer = false;
        }
    }

    // toggled this frame:
    if (state != prev_state)
    {
        transition_anim = 5;
        flipped = true;
    }

    image_index = 2 * state;

    // for a few frames, lever is in center:
    if (transition_anim > 0)
    {
        transition_anim -= 1;
        image_index = 1;
    }

    // set leverfields to active / inactive depending on state
    with (objLeverField)
    {
        if (other.state == 0)
        {
            if (tag == other.uptag)
                active = true;
            if (tag == other.downtag)
                active = false;
        }
        else if (other.state == 1)
        {
            if (tag == other.uptag)
                active = false;
            if (tag == other.downtag)
                active = true;
        }
    }
}
