#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

image_speed = 0.2;

phase = 1;
timer = 0;

X = x;
Y = y;

viewX = 0;
viewY = 0;

overwriteAnimation = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!overwriteAnimation)
{
    image_index = image_index mod 3;
}

if (collision_rectangle(x - 16, y - 12, x + 16, y + 12, objGravityFlipUp, false, true))
{
    sprite_index = sprGalaxyManPortalReverse;
}

if (phase == 1) // Trigger teleportation
{
    if (place_meeting(x, y, objMegaman))
    {
        playSFX(sfxPortal);
        player = instance_place(x, y, objMegaman);
        with (player)
        {
            visible = 0;
            xspeed = 0;
            yspeed = 0;
            x = other.x;
            y = other.y;
            frozen = 1;
        }
        phase = 2;
    }
}

if (phase == 2)
{
    if (instance_exists(player))
    {
        if (timer < 25)
        {
            timer += 1;

            if (timer < 20)
            {
                image_index = (3 + ((timer / 2) mod 3));
            }
            else
            {
                image_index = (6 + ((timer / 2) mod 3));
            }

            viewX = view_xview;
            viewY = view_yview;
        }
        else
        {
            // var xs; xs = viewX;
            // var ys; ys = viewY;

            // viewX = clamp(viewX + clamp((X - view_wview / 2) - viewX, -8, 8), global.sectionLeft, global.sectionRight - view_wview);
            // viewY = clamp(viewY + clamp((Y - view_hview / 2) - viewY, -8, 8), global.sectionTop, global.sectionBottom - view_hview);

            // if (xs != viewX or ys != viewY)

            var xs; xs = view_xview;
            var ys; ys = view_yview;

            playerCamera(0);

            if (xs == view_xview && ys == view_yview)
            {
                timer += 1;

                player.x = X;
                player.y = Y - 20 * player.image_yscale;

                if (place_meeting(X, Y, objGalaxyManPortal))
                {
                    with (instance_place(X, Y, objGalaxyManPortal))
                    {
                        phase = 3;
                        overwriteAnimation = true;

                        if (other.timer < 20 + 25)
                        {
                            image_index = (3 + ((other.timer / 2) mod 3));
                        }
                        else if (other.timer < 50)
                        {
                            image_index = (6 + ((other.timer / 2) mod 3));
                        }
                        else
                        {
                            overwriteAnimation = false;
                        }
                    }
                }

                if (timer >= 50)
                {
                    with (player)
                    {
                        visible = 1;
                        frozen = 0;
                        yspeed = -jumpSpeed * gravDir - 0.5;
                        canMinJump = false;
                    }

                    phase = 3;
                    timer = 0;
                }
            }
        }
    }
}

if (phase == 3)
{
    if (!place_meeting(x, y, objMegaman))
    {
        phase = 1;
    }
}
