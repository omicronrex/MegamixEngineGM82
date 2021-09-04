#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

despawnRange = -1;

faction = 3;
contactDamage = 0;
canHit = false;

stopOnFlash = false;

respawnupondeath = 1;
grabable = 0;

jumped = 0;

sparkletimer = 0;
primarycol = 0;
secondarycol = 0;

timer = 0;

name = "";

alreadyCollected = false;
energyElementLock = false;

script = scrNoEffect;
code = "";
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (yspeed > 0)
    {
        jumped = 0;
    }

    if (y >= global.sectionBottom - 8)
    {
        yspeed = -9;
        jumped = 1;
    }

    if (instance_exists(target))
    {
        if (xspeed == 0)
        {
            if (jumped && yspeed < 0)
            {
                xspeed = arcCalcXspeed(yspeed, grav, bboxGetXCenter(), bboxGetYCenter(), target.x, target.y);
            }
        }

        // move to player if inside solid object
        if (checkSolid(0, 0,1,1))
        {
            aimAtPoint(4, view_xview + (view_wview/2), view_yview + (view_hview/2));
            /*var cy; cy = y - target.y;
            var cx; cx = x - target.x;

            if (abs(cy) > 4)
            {
                y -= cy;
            }
            else if (abs(cx) > 4)
            {
                x -= cx;
            }*/
        }
    }

    if (!timer)
    {
        if (!(sparkletimer mod 6))
        {
            if (!indexOf(global.elementsCollected, name))
            {
                primarycol = choose(global.primaryCol[0], global.secondaryCol[0], c_white, make_color_rgb(255, 228, 164));
                do
                {
                    secondarycol = choose(global.primaryCol[0], global.secondaryCol[0], c_white, make_color_rgb(255, 228, 164));
                }
                    until (primarycol != secondarycol)

                if (!(sparkletimer mod 12))
                {
                    with (instance_create(bboxGetXCenter(), bboxGetYCenter(), objSlideDust))
                    {
                        sprite_index = sprShine;
                        image_xscale = choose(1, -1);
                        direction = irandom(360);
                        rotationMovement(xstart, ystart, irandom_range(5, 12), 0);
                    }
                }
            }
            else // element already collected
            {
                alreadyCollected = true;
                primarycol = global.nesPalette[0];
                secondarycol = global.nesPalette[13];
            }
        }

        sparkletimer+=1;
    }
    else
    {
        timer+=1;

        if (timer >= 360) // players beam out
        {
            playerFreeMovement(energyElementLock);

            with (objMegaman)
            {
                i = instance_create(x, y, objMegamanExit);
                i.pid = playerID;
                i.cid = costumeID;

                visible = 0;
                instance_destroy();
            }

            instance_destroy();
        }
    }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!timer)
{
    playMusic('Mega_Man_10.nsf', "VGM", 19, 0, 0, false, 1);
    playSFX(sfxElementGrab);

    for (j = 0; j < global.playerCount; j += 1) // Refill stuff
    {
        global.playerHealth[j] = 28;
        for (i = 0; i <= global.totalWeapons; i += 1)
        {
            global.ammo[j, i] = 28;
        }
    }

    energyElementLock = playerLockMovement();


    visible = 0;
    timer = 1;

    // global effect of attaining the element
    if (!alreadyCollected)
    {
        arrayAppend(global.elementsCollected, name);
        script_execute(script);
        stringExecutePartial(code);

        // update count of number of elements collected:
        global.energyElements = array_length_1d(global.elementsCollected) - numberOf(global.elementsCollected, "");
    }

    // save the game file
    saveLoadGame(true);
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!dead)
{
    drawSelf();
    draw_sprite_ext(sprite_index, 1, round(x), round(y), image_xscale, image_yscale, image_angle, primarycol, image_alpha);
    draw_sprite_ext(sprite_index, 2, round(x), round(y), image_xscale, image_yscale, image_angle, secondarycol, image_alpha);
}
