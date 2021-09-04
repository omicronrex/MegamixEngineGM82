#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// An antlion enemy that spits up spiked projectiles.

event_inherited();

// @cc - Use this to change colours: 0 (default) = red, 1 = hot pink, 2 = blue
col = 0;

healthpointsStart = 3;
healthpoints = healthpointsStart;
category = "grounded, nature";

// not confirmed
contactDamage = 3;

animTimer = 0;
phase = 0;

// time to wait before beginning to shoot
init_time = 30;

// time between shots
shoot_time = 30;

// shots per volley
volley_n = 4;

// time to wait after each volley
wait_time = 120;

// speed of shot
shot_xspeed = 1;
high_shot_yspeed = -6;
low_shot_yspeed = -4.5;
imgOffset = 0;
// animation slowness
at = 3;


image_speed = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
imgOffset = col * 3;
if (entityCanStep())
{
    if (phase == 0)
    {
        image_index = 0 + imgOffset;
        if (animTimer > init_time)
        {
            phase = 1;
            animTimer = 0;
        }
    }
    else if (phase == volley_n + 1)
    {
        // sleep briefly
        image_index = 0 + imgOffset;

        // stretch briefly:
        if ((wait_time - animTimer) < at * 2)
            image_index = 1 + imgOffset;
        if (animTimer > wait_time)
        {
            animTimer = 0;
            phase = 0;
        }
    }
    else
    {
        if (abs(animTimer - 2 * at) < 2 * at)
            image_index = 1 + imgOffset;
        if (abs(animTimer - 2 * at) < at)
            image_index = 2 + imgOffset;
        if (animTimer == 2 * at)
        {
            // create projectile
            playSFX(sfxCannonShoot);
            with (instance_create(x + 8, y - 16, objArigockGSpike))
            {
                yspeed = other.high_shot_yspeed;
                switch (other.col)
                {
                    // Hot pink
                    case 1:
                        image_index = 1;
                        break;
                    // Blue
                    case 2:
                        image_index = 2;
                        break;
                }
                if (other.phase == 1 || other.phase == other.volley_n)
                    yspeed = other.low_shot_yspeed;
                xspeed = (1 - 2 * (other.phase mod 2)) * other.shot_xspeed;
            }
        }

        // volley
        if (animTimer > shoot_time)
        {
            animTimer = 0;
            phase += 1;
        }
    }

    animTimer+=1;
}
else if (dead)
{
    animTimer = 0;
    phase = 0;
}
