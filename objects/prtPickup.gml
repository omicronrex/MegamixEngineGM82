#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

faction = 0;

canHit = false;
dieToSpikes = 0;
killOverride = false;

// Pickup variables
disappear = -1;
pushout = 1;
flashTimer = 0;
usePlayerColor = 0; // Make sure to have white mask images for the primary, secondary and outline color

heavy = 0;
grabable = 1;
respawnupondeath = 0;

stopOnFlash = false;

collectPlayer = objMegaman;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (disappear) // count down to flashing
    {
        disappear -= 1;

        if (pushout && blockCollision) // Get pushed out solids if stuck
        {
            pushout = 0;
            if (!respawn && instance_exists(objMegaman))
            {
                if (checkSolid(0, 0))
                {
                    var prey = sign(bboxGetYCenterObject(objMegaman) - bboxGetYCenter());
                    prey -= (prey == 0);

                    repeat (100)
                    {
                        y += prey * 8;
                        if (!checkSolid(0, 0))
                        {
                            break;
                        }
                    }

                    yspeed = 0;
                }
            }
        }
    }

    if (disappear == 0) // Flash and disappear
    {
        flashTimer++;
        if (flashTimer == 60)
        {
            dead = 1;
            event_user(EV_DEATH);
        }
    }

    if (ycoll * sign(grav) > 0) // bounce when landing
    {
        if (!heavy && grav != 0)
        {
            ycoll = -ycoll * 0.5;
            if (ycoll < -0.5)
            {
                yspeed = ycoll;
                ground = 0;
            }
        }
        xspeed = 0;
    }

    if (place_meeting(x, y, objMegaman)) // Get collected
    {
        collectPlayer = instance_place(x, y, objMegaman);

        if (!collectPlayer.teleporting)
        {
            event_user(0);

            if (!respawnupondeath) // Keeps it from reappearing after a death
            {
                if (respawn)
                {
                    with (objGlobalControl)
                    {
                        ds_list_add(pickups, string(room) + '/' + string(other.id));
                    }
                }
            }
        }
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!dead)
{
    instance_create(bboxGetXCenter(), bboxGetYCenter(), objExplosion);
}

dead = 1;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!dead)
{
    if ((flashTimer mod 4) < 2)
    {
        if (usePlayerColor)
        {
            var imgs = floor(image_number / 4);

            image_index = image_index mod imgs;

            drawSelf();
            draw_sprite_ext(sprite_index, image_index + imgs, round(x), round(y), image_xscale, image_yscale, image_angle, global.primaryCol[0], image_alpha);
            draw_sprite_ext(sprite_index, image_index + imgs * 2, round(x), round(y), image_xscale, image_yscale, image_angle, global.secondaryCol[0], image_alpha);
            draw_sprite_ext(sprite_index, image_index + imgs * 3, round(x), round(y), image_xscale, image_yscale, image_angle, global.outlineCol[0], image_alpha);
        }
        else
        {
            drawSelf();
        }
    }
}
