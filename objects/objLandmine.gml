#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// A landmine placed on the ground. When stepped on, it detonates after a certain amount of time.
event_inherited();
canHit = false;
imgIndex = 0;
imgSpd = 0.2;
isSolid = true;
itemDrop = -1;
timer = 0;
phase = 0;
bubbleTimer = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    switch (phase)
    {
        // Inactive
        case 0:
            with (objMegaman)
            {
                if (place_meeting(x, y + gravDir, other.id))
                {
                    if (ground)
                    {
                        with (other)
                        {
                            imgIndex = 1;

                            // mask_index = sprMarsLandmineMask;
                            phase = 1;
                            timer = choose(60, 120, 180);

                            /* with (objMegaman)
                            {
                                y += 1;
                            }*/
                            playSFX(sfxCountBomb);
                        }
                    }
                }
            }
            break;
        // Triggered
        case 1:
            if (timer > 60)
            {
                imgIndex += imgSpd;
            }
            else
            {
                imgIndex+=1;
            }
            if (imgIndex >= 4)
            {
                imgIndex = 1;
            }
            timer-=1;
            if (timer == 0)
            {
                event_user(EV_DEATH);
                dead = true;
                instance_create(x + 8, y + 8, objHarmfulExplosion); //( sprite_width/2,sprite_height/2,objHarmfulExplosion);
                playSFX(sfxMM9Explosion);
            }
            break;
    }
}
else if (dead)
{
    timer = 0;
    imgIndex = 0;
    phase = 0;

    // mask_index = sprMarsLandmine;
}
image_index = imgIndex div 1;
