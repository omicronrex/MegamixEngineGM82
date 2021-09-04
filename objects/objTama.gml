#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A big cat robot that pukes hairballs balls and throws ticks

event_inherited();

respawn = true;

healthpointsStart = 10;
healthpoints = healthpointsStart;
contactDamage = 4;

introSprite = sprTamaTeleport;

category = "bulky, nature";

dir = image_xscale;

// Enemy specific code
shootTimer = 0;
image_speed = 0;
tailWag = 0;
endTimer = 250;
tailIndex = 0;
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
    if (shootTimer == 5)
        image_index = 1;
    if (shootTimer == 15)
        image_index = 2;
    if (shootTimer == 20)
    {
        ball = instance_create(x + 32 * image_xscale, y + 8, objTamaYarnBall);
        ball.xspeed = image_xscale;
    }
    if (shootTimer == 25)
        image_index = 1;
    if (shootTimer == 30)
        image_index = 0;

    if (shootTimer == 70 + 5)
        image_index = 1;
    if (shootTimer == 70 + 15)
        image_index = 2;
    if (shootTimer == 70 + 20)
    {
        ball = instance_create(x + 32 * image_xscale, y + 8, objTamaYarnBall);
        ball.xspeed = image_xscale;
    }
    if (shootTimer == 70 + 25)
        image_index = 1;
    if (shootTimer == 70 + 30)
        image_index = 0;

    if (shootTimer == 110 && instance_exists(objTamaYarnBall))
        shootTimer -= 10;

    if (shootTimer == 120)
        image_index = 3;
    if (shootTimer == 125)
        image_index = 4;

    if (shootTimer == 130)
    {
        for (i = 0; i <= 2; i += 1)
        {
            flea = instance_create(x - 8 * image_xscale, y, objTamaFlea);
            flea.xspeed = image_xscale + (sign(image_xscale)*((i+5) / 5));
            flea.yspeed = -(3 + i);
        }
    }
    if (shootTimer == 140)
        image_index = 3;
    if (shootTimer == 145)
    {
        if (instance_exists(objTamaFlea))
            shootTimer -= 4;
        image_index = 0;
    }

    shootTimer += 1;
    if (shootTimer >= endTimer)
        shootTimer = 0;

    tailWag += 1;
    if (tailWag == floor(tailWag / 10) * 10)
    {
        if (tailIndex == 0)
            tailIndex = 1;
        else
            tailIndex = 0;
    }
}
else if (!insideView())
{
    image_index = 0;
    shootTimer = 0;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (introTimer > 0 && doesIntro)
{
    event_inherited();
}
else
{
    if (iFrames == 1 || iFrames == 3)
    {
        d3d_set_fog(true, c_white, 0, 0);
    }

    draw_self();
    draw_sprite_ext(sprite_index, 5 + tailIndex, round(x), round(y),
        image_xscale, image_yscale, image_angle, image_blend, image_alpha);

    if (iFrames == 1 || iFrames == 3)
    {
        d3d_set_fog(false, 0, 0, 0);
    }
}
