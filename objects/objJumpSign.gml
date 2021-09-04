#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;

blockCollision = 0;
grav = 0;
bubbleTimer = -1;

xOffset = noone;
dir = 1;
timer = 0;
stopRange = 16;
spd = 4;
image_speed = 0.12;

respawnRange = -1;
despawnRange = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// the x origin is suppose to be 24 to make the most sense, and what I reprogrammed it thinking it was, but it's feature locked
// at 56, which is like past the actual width of the sprite, so have fun with a bunch of silly magic number shenanigans   :Y

event_inherited();

if (!global.frozen && !dead
    && !(bbox_right < view_xview[0]
    || bbox_left > view_xview[0] + view_wview[0]
    || bbox_bottom < view_yview[0]
    || bbox_top > view_yview[0] + view_hview))
{
    if (timer == 0)
    {
        // determine which side we're facing
        if (x - 32 < view_xview[0] + view_wview[0]
            / 2) //- 32 here because facing right be default and because stupid sprite origins
        {
            dir = 1;
        }
        else
        {
            dir = -1;
        }

        xOffset = x
            - view_xview[0]; // save the offset from the left side of the screen
        timer = 1;
    }

    if (timer >= 1)
    {
        x = view_xview[0]
            + xOffset; // move back to the previous spot on the screen

        if (timer == 1 && ((dir == -1
            && bbox_right <= view_xview[0] + view_wview[0] - stopRange)
            || (dir == 1 && bbox_left > view_xview[0] + stopRange)))
        {
            timer = 2;

            if (dir == 1)
            {
                xOffset = ((x) - bbox_left) + stopRange;
            }
            else
            {
                xOffset = view_wview[0] + ((x) - bbox_right) - stopRange;
            }
        }

        if (timer >= 2)
        {
            if (timer == 2)
            {
                if (sprite_index == sprSlideSign)
                {
                    playSFX(sfxSlideSlide);
                }
                else
                {
                    playSFX(sfxJumpJump);
                }

                timer = 3;
            }
            else
            {
                if (timer >= 70) // <-=1 time until they leave
                {
                    xOffset += -spd * dir * 3;
                }
                else
                {
                    timer += 1;
                }
            }
        }
        else
        {
            xOffset += spd * dir;
        }
    }
}
else if (dead)
{
    timer = 0;
    dir = 1;
    xOffset = noone;
}
