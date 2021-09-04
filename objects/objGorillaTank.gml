#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// This big gorilla is pushed back when his big arm is shot, his big arm also deflects shots

event_inherited();

respawn = true;

category = "bulky, nature, primate";

healthpointsStart = 24;
healthpoints = healthpointsStart;
contactDamage = 6; // 4 punch, 2 shot
doesIntro = false;

// creation code
dir = image_xscale;

// Enemy specific code
shootTimer = 0;
image_speed = 0;

hand = noone;
recoil = false;
attack = choose(0, 1);
attack = 1;
animTimer = 0;
introTimer = 60;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (recoil)
    {
        if ((image_xscale == -1 && x < xstart) || (image_xscale == 1 && x > xstart))
        {
            x -= image_xscale * 3;
            if (instance_exists(hand))
            {
                if (hand.xspeed == 0 && hand.yspeed == 0 && hand.dir == 1)
                {
                    hand.x -= image_xscale * 3;
                }
            }
        }

        recoil = false;
    }

    if (instance_exists(hand))
    {
        if (hand.attack == false)
        {
            shootTimer += 1;
        }
    }

    if (shootTimer >= 60)
    {
        if (attack == 0)
        {
            if (instance_exists(hand))
            {
                hand.attack = true;
            }

            shootTimer = 0;
            attack = choose(0, 1);
        }
        else if (attack == 1)
        {
            if (shootTimer == floor(shootTimer / 8) * 8)
            {
                playSFX(sfxEnemyShoot);
                shoot = instance_create(x + 16 * image_xscale, y - 10, objEnemyBullet);
                with (shoot)
                {
                    var spd;
                    spd = 2;
                    {
                        var angle;
                        angle = point_direction(spriteGetXCenter(),
                            spriteGetYCenter(),
                            spriteGetXCenter() + 16 * other.image_xscale,
                            spriteGetYCenter() - (other.shootTimer - 80));

                        xspeed = cos(degtorad(angle)) * spd;
                        yspeed = -sin(degtorad(angle)) * spd;
                    }
                }
            }

            if (shootTimer >= 60 + (8 * 5))
            {
                shootTimer = 0;
                attack = choose(0, 1);
            }
        }
    }

    if ((x > view_xview + 64 && image_xscale == -1)
        || (x < view_xview + view_wview - 64 && image_xscale == 1))
        if (instance_exists(hand) && !(attack == 1 && shootTimer > 60))
        {
            if (hand.xspeed == 0 && hand.yspeed == 0 && hand.dir == 1)
            {
                x += image_xscale / 5;
                hand.x += image_xscale / 5;
            }
        }

    if (animTimer < 5)
    {
        animTimer += 1;
    }
    else
    {
        if (image_index < 2)
        {
            image_index += 1;
        }
        else
        {
            image_index = 0;
        }

        animTimer = 0;
    }

    // if (shootTimer == 60 * 3)
    //{ }
    if (instance_exists(hand))
    {
        hand.getX = x - 4 * image_xscale;
        hand.getY = y;
    }
}
else if (!insideView())
{
    image_index = 0;
    shootTimer = 0;
}

if (entityCanStep())
{
    introTimer -= 1;
    if (introTimer == 1)
    {
        if (!instance_exists(hand))
        {
            hand = instance_create(x - 4 * image_xscale, y, objGorillaTankHand);
            hand.parent = id;
            hand.image_xscale = image_xscale;
        }
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (instance_exists(hand))
{
    with (hand)
    {
        instance_destroy();
    }
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!collision_rectangle(x, y - 20, x + (44 * image_xscale), y - 32, other.id,
    false, true))
{
    other.guardCancel = 1;
    recoil = true;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (iFrames == 1 || iFrames == 3)
{
    d3d_set_fog(true, c_white, 0, 0);
}

if (introTimer == 0)
{
    drawSelf();
    if (attack == 1 && shootTimer > 60)
    {
        draw_sprite_ext(sprite_index, 3, round(x), round(y), image_xscale,
            image_yscale, image_angle, image_blend, image_alpha);
    }
}
else
{
    draw_sprite_ext(sprGorillaTankEyes, -1, round(x), round(y), image_xscale,
        image_yscale, image_angle, image_blend, image_alpha);
    draw_sprite_ext(sprite_index, -1, round(x), round(y), image_xscale,
        image_yscale, image_angle, image_blend,
        1 - ((floor(introTimer / (30 / 2)) * (30 / 2)) / 30));
}

if (iFrames == 1 || iFrames == 3)
{
    d3d_set_fog(false, 0, 0, 0);
}
