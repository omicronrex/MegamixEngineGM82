#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
healthpointsStart = 28;
healthpoints = healthpointsStart;
blockCollision = 0;
grav = 0;
pose = sprite_index;
contactDamage = 0;
moveDir = 1;
ground = false;
attackTimer = 0;
shotsFired = 0;
phase = 0;
image_speed = 0;
chosenPipe = noone;
delayPipe = 0;
introType = 0;

// Health Bar
healthBarPrimaryColor[1] = 25;
healthBarSecondaryColor[1] = 40;

// Music
music = "Mega_Man_3.nsf";
musicType = "VGM";
musicTrackNumber = 13;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// Handle Intro
if (!global.frozen)
{
    with (objKamegoroTornadoMakerH)
    {
        if (id != other.chosenPipe)
            attackTimer = 0;
    }
    bubbleTimer = 0;
    image_speed = 0;

    // Starting the intro animation
    if (startIntro)
    {
        if (image_xscale == -1)
        {
            x = view_xview[0] + view_wview[0];
        }
        else
        {
            x = view_xview[0] - sprite_xoffset;
        }
        startIntro = false;
        isIntro = true;
        drawBoss = true;
    }
    else if (isIntro)
    {
        if (((x < xstart) && image_xscale == 1) || ((x > xstart) && image_xscale == -1))
        {
            x += image_xscale;
        }
        else
        {
            visible = true;
            isIntro = false;
            grav = gravStart;
            blockCollision = blockCollisionStart;
        }
    }
}
if (entityCanStep())
{
    if (isFight)
    {
        attackTimer += 1;
        if (delayPipe > 0)
            delayPipe -= 1;
        contactDamage = 8;
        if (!instance_exists(objKamegoroTornado) && delayPipe == 0)
        {
            var inst = instance_find(objKamegoroTornadoMakerH, irandom(instance_number(objKamegoroTornadoMakerH) - 1));
            if (chosenPipe != inst.id)
            {
                chosenPipe = inst.id;
                delayPipe = 64;
            }
        }
        switch (phase)
        {
            case 0: // move about
                image_index = 0;
                xspeed = 1.5 * moveDir;
                if (place_meeting(x + 2, y, objSolid) && moveDir == 1 || place_meeting(x - 2, y, objSolid) && moveDir == -1)
                    moveDir *= -1;
                if (attackTimer >= 72)
                {
                    image_index = 1;
                    attackTimer = 0;
                    xspeed = 0;
                    phase = 1;
                }
                break;
            case 1: // summon kamegoro
                if (attackTimer == 16)
                {
                    instance_create(x, y + 32, objExplosion);
                    with (instance_create(x, y + 32, objKamegoro))
                        spd = (0.75 * other.shotsFired) + 1.5;
                    shotsFired += 1;
                }
                if (attackTimer == 24)
                    image_index = 0;
                if (attackTimer > 24 && !instance_exists(objKamegoro))
                {
                    attackTimer = 0;
                    phase = 0;
                }
                break;
        }
        if (healthpoints <= 0)
            event_user(EV_DEATH);

        // Face the player
        calibrateDirection();
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
with (objKamegoro)
    instance_destroy();
with (objKamegoroTornado)
    instance_destroy();
with (objKamegoroShell)
    instance_destroy();
with (objKamegoroTornadoMakerH)
{
    kamegoroDead = true;
    attackTimer = 0;
    active = false;
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (other.penetrate >= 2)
{
    other.guardCancel = 2;
}
else
{
    other.guardCancel = 1;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (phase == 1)
{
    if (attackTimer < 16)
    {
        draw_sprite_ext(sprKamegoro, 0, round(x), round(y) + (attackTimer * 2), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
    }
}
event_inherited();
