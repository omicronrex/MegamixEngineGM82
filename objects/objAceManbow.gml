#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// image_yscale = 1 or -1 //(Use editor for this!!) // if -1, Ace Manbow will go up instead of down at beginning.
// moveDistance = <number> // The distance in which Ace Manbow moves before changing direction. Default is 80 pixels. Should be divisible by spd.
// spd = <number> //How fast Ace Manbow moves. Default is 0.5. Number should be divisible by 0.03125
// cooldownMax = <number> // How quickly Ace Manbow fires its spread. Default is 128.

event_inherited();

respawn = true;
healthpointsStart = 4;
healthpoints = healthpointsStart;
contactDamage = 3;
blockCollision = 0;
category = "aquatic, nature";

grav = 0;
facePlayerOnSpawn = true;

// Enemy specific code
spd = 0.5;
delay = -1;

storeSpd = 0;
storeYScale = image_yscale;

moveTimer = 0;
moveDistance = 80;
yspeed = 0.5;
cooldownTimer = 0;
cooldownMax = 128;
col = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    // this animates Ace Manbow, who changes frames at certain times, such as before shooting.
    cooldownTimer += 1;
    if ((cooldownTimer > round(cooldownMax / 2) - 16 && cooldownTimer < round(cooldownMax / 4) - 16) || (cooldownTimer > round(cooldownMax - 16)))
        image_index = 1;
    else
        image_index = 0;

    // fire bullet spread
    if (cooldownTimer == cooldownMax)
    {
        cooldownTimer = 0;
        for (var i = 0; i < 8; i += 1)
        {
            var inst;
            inst = instance_create(x, y, objMM1MetBullet);
            inst.dir = 45 * i;
            inst.xscale = image_xscale;
            inst.sprite_index = sprEnemyBullet;
            playSFX(sfxEnemyShootClassic);
        }
    }

    // move Ace Manbow
    yspeed = spd * image_yscale;

    // count how far Manbow has moved.
    if (moveTimer < moveDistance)
    {
        moveTimer += abs(yspeed);

        // if the user has changed the movespeed, this stores the new speed rather than the default one.
        if (storeSpd == 0)
            storeSpd = abs(spd);
    }

    // if Ace Manbow has reached its desired move destination, begin turnaround sequence
    if (moveTimer >= moveDistance)
    {
        // during entire sequence, ace manbow moves forward.
        xspeed = 0.5 * image_xscale;

        // if there is no delay, change Ace Manbow's vertical speed.
        if (delay <= 0)
            spd -= 0.03125;

        // when Ace Manbow is at speed 0, it only moves forwards, and does this for 4 pixels worth of movement.
        if (spd <= 0 && delay == -1)
        {
            delay = 8;
            spd = 0;
        }
        if (delay > 0)
            delay -= 1;

        // if speed is reverse of store speed, Ace Manbow has successfully done a 180 in its speed, reset its variables and change direction it is moving, so it starts moving afresh.
        if (spd == 0 - storeSpd)
        {
            spd = storeSpd;
            image_yscale *= -1;
            moveTimer = 0;
            xspeed = 0;
            delay = -1;
        }
    }
}
else if (dead)
{
    moveTimer = 0;
    spd = 0.5;
    storeSpd = 0;
    image_yscale = storeYScale;
    cooldownTimer = 0;
    delay = -1;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Ace Manbow is always drawn upright, regardless of what Image_Yscale says. Image_yscale is used to determine which direction it moves in.
if (!dead)
{
    draw_sprite_ext(sprite_index, image_index, round(x), floor(y), image_xscale, 1, image_angle, image_blend, image_alpha);
}
if ((iFrames == 1 || iFrames == 3) || (iceTimer > 0))
{
    var flashcol = c_white;
    if (iceTimer > 0)
        flashcol = make_color_rgb(0, 120, 255);
    d3d_set_fog(true, flashcol, 0, 0);
    draw_sprite_ext(sprite_index, image_index, round(x), floor(y), image_xscale, 1, image_angle, image_blend, image_alpha);
    d3d_set_fog(false, 0, 0, 0);
    if (iceTimer > 0)
    {
        draw_set_blend_mode(bm_add);
        draw_sprite_ext(sprite_index, image_index, round(x), floor(y), image_xscale, 1, image_angle, image_blend, image_alpha);
        draw_set_blend_mode(bm_normal);
    }
}
