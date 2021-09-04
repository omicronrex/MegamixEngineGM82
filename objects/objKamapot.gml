#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

canHit = false;
blockCollision = false;
bubbleTimer = -1;
respawn = false;
isSolid = true;
grav = 0;

delayDisplay = 2;
kamapotSpeed = noone;
jitter = true;
jitterTime = 4;
moveTimer = 0;
imgIndex = 0;
imgSpd = 0.3;
child = noone;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (delayDisplay > 0)
    {
        delayDisplay--;
    }

    moveTimer--;

    if (moveTimer > 0)
    {
        if (jitter == true)
        {
            if (jitterTime == 4)
            {
                y -= 1;
            }
            jitterTime--;

            if (jitterTime == 0)
            {
                jitter = false;
                jitterTime = 4;
            }
        }
        else
        {
            if (jitterTime == 4)
            {
                y += 1;
            }
            jitterTime--;

            if (jitterTime == 0)
            {
                jitter = true;
                jitterTime = 4;
            }
        }
    }
    else
    {
        imgIndex += imgSpd;

        yspeed = kamapotSpeed;

        // shift up player if theyre on top of the kamapot
        if place_meeting(x, y - 1 * image_yscale, objMegaman)
        {
            with instance_place(x, y - 1 * image_yscale, objMegaman)
            {
                shiftObject(0, -1 * image_yscale, true);
            }
        }

        if (!collision_rectangle(x - (16 * image_yscale == -1), y - (26 * image_yscale == -1),
        x + (16 * image_yscale == 1), y + 26 * (image_yscale == 1), objSolid, false, true))
        {
            if (instance_exists(child))
            {
                with (child)
                {
                    if (deathTimer <= 0)
                    {
                        instance_destroy();
                    }
                }
            }
        }
    }
}
image_index = imgIndex div 1;
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (collision_rectangle(x - (16 * image_yscale == -1), y - (26 * image_yscale == -1),
x + (16 * image_yscale == 1), y + 26 * (image_yscale == 1), objSolid, false, true))
{
    var cover = instance_create(x, y, objGundrillCover); // Use this to hide underground parts
    cover.parent = id;
    child = cover.id;
    cover.image_yscale = image_yscale;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (delayDisplay <= 0)
{
    event_inherited();
}
