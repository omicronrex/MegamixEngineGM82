#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
stopOnFlash = false;
contactDamage = 4;
blobMove = noone; // Movement set in Mercury's Step
attackTimer = 0;
phase = 0;
big = false; // For use when Mercury is using his bouncing pattern
blobID = 0; // Used to establish "dominant" blob when bouncing
image_speed = 0.25;
trigBlob = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // Slide
    if (blobMove == 0)
    {
        if (objMercury.xspeed == 0)
        {
            attackTimer+=1;
            if (attackTimer >= 60)
            {
                xspeed = 2 * image_xscale;

                // Destroy if touching Mercury
                if (place_meeting(x, y, objMercury))
                {
                    instance_destroy();
                }
            }
        }
    } // Bounce
    else
    {
        // Jumping
        if (phase == 0)
        {
            if ((ground) && (xcoll == 0))
            {
                yspeed = -4;
                xspeed = 1.5 * image_xscale;
                playSFX(sfxNumetallShoot);
            }
            else if (xcoll != 0)
            {
                xspeed = 0;
                phase = 1;
            }
            if (x <= view_xview + 128 && image_xscale == -1 || x >= view_xview + 128 && image_xscale == 1 || xcoll != 0)
            {
                trigBlob = true;
            }
        } // Standing still
        else
        {
            if (place_meeting(x, y, objMercurySmallBlob))
            {
                with (objMercurySmallBlob)
                {
                    if (blobID == 0)
                    {
                        instance_destroy();
                    }
                }
                sprite_index = sprMercuryBigBlob;
                big = true;
            }
        }
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
iFrames = 0;
with (other)
{
    if ((penetrate < 2) && (pierces < 2))
    {
        event_user(EV_DEATH);
    }
}
other.guardCancel = 2;
