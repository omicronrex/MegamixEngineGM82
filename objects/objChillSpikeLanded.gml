#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

bulletLimitCost = 0;

contactDamage = 5;

penetrate = 0;
pierces = 0;

dir = 1; // 0: ceiling, 1: ground, 2: left wall, 3: right wall
firstFrame = true;

timer = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (firstFrame)
{
    firstFrame = false;

    // find correct orientation / position
    if (dir >= 2)
    {
        sprite_index = sprChillSpikeWall;
    }
    if (dir == 0)
    {
        image_yscale = -1;
    }
    if (dir == 3)
    {
        image_xscale = -1;
    }

    y = floor(y);
    x = floor(x);

    // sink to ground

    normal = 1;
    if (dir == 1 || dir == 3)
    {
        normal = -1;
    }

    settle_dist = 1;

    if (dir == 0)
    {
        settle_dist = 0;
    }
    if (dir == 3)
    {
        settle_dist = 2;
    }

    if (dir <= 1)
    {
        n_tries = 16;

        // move horizontally to avoid wall:
        sg = 1;
        r = 0;

        while (place_meeting(x + sg * r, y + normal * settle_dist, objSolid) && n_tries > 0)
        {
            sg *= -1;
            if (sg == 1)
                r += 1;
            n_tries -= 1;
        }
        x += sg * r;
        n_tries = 12;

        // sink to ground:
        while (!place_meeting(x, y + normal * settle_dist, objSolid) && n_tries > 0)
        {
            y -= normal;
            n_tries -= 1;
        }

        if (n_tries <= 0)
        {
            event_user(EV_DEATH);
        }
    }
    else
    {
        n_tries = 16;

        // move vertically to avoid floor/ceiling:
        sg = 1;
        r = 0;

        while (place_meeting(x + normal * settle_dist, y + sg * r, objSolid) && n_tries > 0)
        {
            sg *= -1;
            if (sg == 1)
                r += 1;
            n_tries -= 1;
        }

        y += sg * r;
        n_tries = 12;

        // shift over to wall:
        while (!place_meeting(x + normal * settle_dist, y, objSolid) && n_tries > 0)
        {
            x -= normal;
            n_tries -= 1;
        }

        if (n_tries <= 0)
        {
            event_user(EV_DEATH);
        }
    }
}

if (!global.frozen)
{
    timer += 1;
}

if (timer >= 2)
{
    image_index = 1;
}

if (timer >= 60 * 3)
{
    event_user(EV_DEATH);
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!instance_exists(objSectionSwitcher))
{
    sound_stop(sfxReflect);
    playSFX(sfxChillSpikeShatter);

    // code swiped from whoever made chill man. thank you! <3
    for (i = 0; i < 3; i += 1)
    {
        a = instance_create(bboxGetXCenter() + random(8) - random(8), bboxGetYCenter(), objChillDebris);
        a.xspeed = -choose(0.25, 0.5);
        if (i == 1)
        {
            a.xspeed *= -1;
        }
        a.image_xscale = choose(-1, 1);
        a.yspeed = -0.25 * irandom(12);
    }
    healthpoints = 0;
}
