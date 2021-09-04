#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// image_xscale = 1 or -1 //(Use editor for this!!) // determines the direction Mad Grinder is locked in.
event_inherited();
respawn = true;
introSprite = sprMadGrinderTeleport;
healthpointsStart = 18;
healthpoints = healthpointsStart;
contactDamage = 4;
blockCollision = 1;
grav = 0.15 * image_yscale;
faction = 5;
penetrate = 3;

category = "bulky, fire, shielded";

// Enemy specific code
image_speed = 0;
image_index = 1;
doQuake = 0;
phase = 0;
jitterFrame = 0;
mouthOpen = false;
wheelFrame = 0;
rollerFrame = 0;
cutterFrame = 0;
hasCutter = true;
child = noone;

shotsFired = 0;

attackTimer = 0;
attackTimerMax = 24;

moveDir = image_xscale;

//@cc if set to 1, mad grinder does not use his fireball attack that was exclusive to power fighters and the intro to MM7.
variant = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep()
    && introTimer <= 0)
{
    if (doQuake > 0) // quake effect
    {
        screenShake(2, 2, 2);
        if (doQuake == 48)
        {
            playSFX(sfxGutsQuake);
        }
        doQuake-=1;
        with (objMegaman)
        {
            if (ground) // shunt mega man off the floor to prevent sliding and break dash
            {
                y -= 1.5 * (irandom(3) + 1);
            }
        }
    }


    // animation setup
    if (xspeed != 0)
    {
        jitterFrame += 0.25 * sign(xspeed);
        if (jitterFrame >= 2)
            jitterFrame -= 2;
        else if (jitterFrame < 0)
            jitterFrame += 2;
        wheelFrame += 0.125 * sign(xspeed);
        if (wheelFrame >= 3)
            wheelFrame -= 3;
        else if (wheelFrame < 0)
            wheelFrame += 3;
        rollerFrame += 0.25 * sign(xspeed);
        if (rollerFrame >= 8)
            rollerFrame -= 8;
        else if (rollerFrame < 0)
            rollerFrame += 8;
    }

    switch (phase)
    {
        case 0:
        case 2:
        case 6:
        case 8: // move
        // turn around
            xspeed = 0.75 * moveDir;
            if (xcoll != 0 || !positionCollision(x + 8 * moveDir, y + 33) || positionCollision(x + 128 * moveDir, y) && moveDir == image_xscale)
            {
                xspeed = 0;
                moveDir *= -1;
                phase+=1;
            }
            break;
        case 1:
        case 5:
        case 11: // fire cutter
            if (cutterFrame < 6)
            {
                cutterFrame += 0.25;
            }
            if (cutterFrame == 6 && attackTimer == 0)
            {
                var inst; inst = instance_create(x + 24 * image_xscale, y - 24, objMadGrinderBlade);
                inst.image_xscale = image_xscale;
                inst.parent = id;
                child = inst.id;
                playSFX(sfxWheelCutter1);
                attackTimer = 1;
                hasCutter = false;
            }
            if (!instance_exists(child) && attackTimer == 1)
            {
                hasCutter = true;
                cutterFrame = 0;
                phase+=1;
                attackTimer = 0;
                playSFX(sfxCrashBombArm);
            }
            break;
        case 3:
        case 9: // jump
            yspeed = -4;
            playSFX(sfxCyberGabyoallBoost);
            phase+=1;
            break;
        case 4:
        case 10: // land
            attackTimer+=1;
            if (ground)
            {
                attackTimer = 0;
                doQuake = 48;
                phase+=1;
            }
            break;
        case 7: // fire fireballs if variant 0;
            if (variant != 0)
            {
                phase = 1;
            }
            else
            {
                jitterFrame = 2;
                mouthOpen = true;
                attackTimer+=1;

                if (attackTimer == attackTimerMax && shotsFired < 4)
                {
                    var fire; fire = instance_create(x + 16 * image_xscale, y - 16, objMadGrinderFire);
                    with (fire)
                    {
                        instance_create(x, y, objExplosion);
                    }
                    playSFX(sfxEnemyShootClassic);
                    switch (shotsFired)
                    {
                        case 0:
                            fire.image_xscale = image_xscale;
                            fire.xspeed = 2 * image_xscale;
                            fire.yspeed = -1;
                            break;
                        case 1:
                            fire.image_xscale = image_xscale;
                            fire.xspeed = 3 * image_xscale;
                            fire.yspeed = 0;
                            break;
                        case 2:
                            fire.image_xscale = image_xscale;
                            fire.xspeed = 2 * image_xscale;
                            fire.yspeed = 1;
                            break;
                        case 3:
                            fire.image_xscale = image_xscale;
                            fire.xspeed = 1.5 * image_xscale;
                            fire.yspeed = 1.5;
                            break;
                    }
                    shotsFired+=1;
                    attackTimer = 0;
                }

                if (shotsFired == 4)
                {
                    mouthOpen = false;
                }
                if (attackTimer == attackTimerMax * 2)
                {
                    attackTimer = 0;
                    shotsFired = 0;
                    phase+=1;
                }
            }
            break;
        case 12: // reset pattern
            phase = 0;
            break;



    }
}
else if (!insideView())
{
    image_index = 0;
    y = ystart;
    x = xstart;
    attackTimer = 0;
    jitterFrame = 0;
    wheelFrame = 0;
    rollerFrame = 0;
    phase = 0;
    doQuake = 0;
    turnTrigger = false;
    findYSpeed = false;
}
#define Other_12
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=605
invert=0
arg0=drawing mad grinder
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index, 1 + clamp(jitterFrame, 0, 2 + mouthOpen), round(x), round(y), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
draw_sprite_ext(sprite_index, 8 + clamp(rollerFrame, 0, 8), round(x), round(y) - (image_index - 2), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
draw_sprite_ext(sprite_index, 5 + clamp(wheelFrame, 0, 3), round(x), round(y) - (image_index - 2), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
draw_sprite_ext(sprite_index, 4, round(x), round(y) - round(clamp(jitterFrame, 0, 2)), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
if (hasCutter)
    draw_sprite_ext(sprite_index, 16 + cutterFrame mod 6, round(x), round(y) - (image_index - 2), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
if (yspeed < 0)
{
    draw_sprite(sprMadGrinderJet, (attackTimer / 2) mod 2, round(x), round(y) + 32);
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
facePlayerOnSpawn = false;
with (objMadGrinderBlade)
{
    if (parent == other.id)
    {
        instance_destroy();
    }
}
event_inherited();
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (other.y > y - 8)
{
    other.guardCancel = 1;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// handles stuff differently than the Puny Regular Enemies....
if (introTimer > 0 && doesIntro)
{
    draw_sprite_ext(introSprite, 2 - (min(2, min(introTimer, 15) / 5)), x,
        y - max(introTimer - 10, 0) * image_yscale, image_xscale, image_yscale, 0, c_white, 1);
}
else
{
    // this debug message should be left in until
    // the spawn system stops breaking every week.

    if (spawned == -1)
    {
        show_debug_message(object_get_name(object_index) + " drawn without having ever spawned!");
    }
    if ((ceil(iFrames / 2) mod 4) || !iFrames)
    {
        if ((ceil(iFrames / 2) mod 2) || (iceTimer > 0))
        {
            var flashcol; flashcol = c_white;
            if (iceTimer > 0)
            {
                flashcol = make_color_rgb(0, 120, 255);
            }

            d3d_set_fog(true, flashcol, 0, 0);
            event_user(2);
            d3d_set_fog(false, 0, 0, 0);

            if (iceTimer > 0)
            {
                draw_set_blend_mode(bm_add);
                event_user(2);
                draw_set_blend_mode(bm_normal);
            }
        }
        else
        {
            event_user(2);
        }
    }
}
