#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
healthpointsStart = 2;
healthpoints = healthpointsStart;
contactDamage = 4;
image_speed = 0;

// @cc - Change colour: 0 (default) = blue, 1 = purple
col = 0;

init = 1;
landTimer = 16;
jumpType = 0;
jumpHeight[0] = 80;
jumpDistance[0] = 32;
jumpHeight[1] = 32;
jumpDistance[1] = 48;
jumpXSpeed = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
mask_index = mskGarinkou;
event_inherited();
mask_index = sprite_index;
if (entityCanStep())
{
    if (!ground)
    {
        landTimer = 16;
        image_index = 3;
        xspeed = jumpXSpeed;
    }
    else
    {
        jumpXSpeed = 0;
        xspeed = 0;

        // landing animation
        if (landTimer > 0)
        {
            landTimer--;
            image_index = landTimer div 8;

            //Play sound
            if (landTimer == 15)
                playSFX(sfxGarinkou);
        }

        // jumping animation
        if (landTimer <= 0)
        {
            jumpType = choose(0, 0, 1);
            yspeed = -sqrt(2 * jumpHeight[jumpType] * grav);
            var airTime = 2 * abs(yspeed / grav);
            xspeed = jumpDistance[jumpType] / airTime * image_xscale;
            jumpXSpeed = xspeed;
        }
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
landTimer = 16;
jumpType = 0;
jumpXSpeed = 0;
calibrateDirection();

if (init)
{
    switch (col)
    {
        case 1:
            sprite_index = sprGarinkouPurple;
            break;
        default:
            sprite_index = sprGarinkou;
            break;
    }
    init = 0;
}
