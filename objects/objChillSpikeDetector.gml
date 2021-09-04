#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_perform_object(prtEntity, ev_create, 0);
i = 0;

hitWall = false;
hitFloor = false;
shuntedIntoRoof = false;

// these determine what the detector does

aimAtMegaman = false; // whether or not the detector should find mega man's x position
center = false; // whether or not the detector should stay in the middle of the room (this disables all code)
spreadAttack = false; // this determines whether or not this detector is used for the spread attack. this can be combined with aimAtMegaman to find the nearest floor.

target = objMegaman;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!instance_exists(objChillMan))
{
    instance_destroy();
    exit;
}

// this section of code finds the nearest wall in the direction fo chillman
if (!center)
{
    if (!aimAtMegaman && !spreadAttack)
    {
        if (!checkSolid(8 * image_xscale, 0, 1, 1))
        {
            for (i = 0; i < 256; i += 1)
            {
                x += (1 * image_xscale);
                if (checkSolid(8 * image_xscale, 0, 1, 1))
                {
                    hitWall = true;
                    break;
                }
            }
        }
        if (!hitWall && checkSolid(8 * image_xscale, 0, 1, 1))
        {
            hitWall = true;
        }
    }
    else if (aimAtMegaman)
    {
        shuntedIntoRoof = false;
        if
            (!spreadAttack) // if spread attack is true, the following code to target mega man is skipped. this is so it can still find the floor.
        {
            if (instance_exists(objChillMan))
            {
                if (instance_exists(target))
                {
                    image_xscale = target.image_xscale;
                    x = target.x - image_xscale;
                }
                else
                {
                    x = objChillMan.x + (objChillMan.image_xscale * 64);
                }
            }
        }
        y = view_yview + view_hview - 32;
        hitFloor = false;
        for (i = 0; i < 256; i += 1)
        {
            if (y <= view_yview + 16)
            {
                i = 0;
                delay = 0;
                shuntedIntoRoof = true;
                break;
            }

            if (checkSolid(0, 0, 1, 1) && hitFloor == false)
                y -= 1;
            else if (!checkSolid(0, 0, 1, 1) && hitFloor == false)
                hitFloor = true;
            else
                break;
        }
        if (!shuntedIntoRoof)
        {
            i = 0;
            delay = 4;
        }
    }
    else if (spreadAttack
        && !aimAtMegaman) // this code finds both the nearest wall and the floor.
    {
        shuntedIntoRoof = false;
        y = view_yview + view_hview - 32;
        hitFloor = false;
        for (i = 0; i < 256; i += 1)
        {
            if (y <= view_yview + 16)
            {
                i = 0;
                delay = 0;
                shuntedIntoRoof = true;
                break;
            }

            if (checkSolid(0, 0, 1, 1) && hitFloor == false)
                y -= 1;
            else if (!checkSolid(0, 0, 1, 1) && hitFloor == false)
                hitFloor = true;
            else
                break;
        }
        if (!shuntedIntoRoof)
        {
            i = 0;
            delay = 4;
        }
        if (!checkSolid(4 * image_xscale, 0, 1, 1))
        {
            for (i = 0; i < 256; i += 1)
            {
                x += (1 * image_xscale);
                if (checkSolid(4 * image_xscale, 0, 1, 1))
                {
                    hitWall = true;
                    break;
                }
            }
        }
        if (!hitWall && checkSolid(4 * image_xscale, 0, 1, 1))
        {
            hitWall = true;
        }
    }
}
