#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
healthpointsStart = 12;
healthpoints = healthpointsStart;
contactDamage = 6;
image_speed = 0;
landTimer = 0;
jumpTimer = 0;
jumpType = 0;
spinTimer = 0;
jumpHeight[0] = 2.5 * 16;
jumpDistance[0] = 48;
jumpHeight[1] = 2.5 * 16;
jumpDistance[1] = 96;
jumpXSpeed = 0;
category = "big eye, bulky";
dieToSpikes = false;
// @cc - Change colours: 0 (default) = orange, 1 = red, 2 = green, 3 = blue
col = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
mask_index = mskTsurareStamp;
event_inherited();
mask_index = sprite_index;
if(xcoll!=0)
{
    xspeed=xcoll;
}

if (entityCanStep())
{
    if (!ground)
    {
        landTimer = 30;
        jumpTimer = 0;
        xspeed = jumpXSpeed;
        image_index = 3;
    }
    else
    {
        xspeed = 0;
        jumpXSpeed = 0;
        if (ycoll)
            playSFX(sfxTsurareStamp);

        // landing animation
        if (landTimer > 0)
        {
            landTimer--;
            var animTable = makeArray(0, 9, 6);
            image_index = animTable[landTimer div 10];
        } // determine jump
        else if (landTimer == 0 && jumpTimer == 0)
        {
            if (instance_exists(target))
            {
                calibrateDirection();
                if (target.ground)
                    jumpType = 0;
                else
                    jumpType = 1;
                jumpTimer = 6 * 3;
            }
            image_index = 0;
        }

        // jumping animation
        if (jumpTimer > 0)
        {
            jumpTimer--;
            if (jumpType == 0)
                image_index = 0;
            else
            {
                var animTable = makeArray(9, 9, 6);
                image_index = animTable[jumpTimer div 6];
            }
            if (jumpTimer == 0)
            {
                yspeed = -sqrt(2 * jumpHeight[jumpType] * grav);
                var airTime = 2 * abs(yspeed / grav);
                xspeed = jumpDistance[jumpType] / airTime * image_xscale;
                jumpXSpeed = xspeed;
            }
        }
        image_index += spinTimer div 4;
        spinTimer = (spinTimer + 1) mod 12;
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
var i = instance_create(x,y,objBigExplosion);
with (i)
{
    playSFX(sfxMM9Explosion);
}
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
specialDamageValue(objMagneticShockwave, 4);
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
landTimer = 0;
jumpTimer = 0;
jumpType = 0;
spinTimer = 0;
jumpXSpeed = 0;
switch (col)
{
    case 1:
        sprite_index = sprTsurareStampRed;
        break;
    case 2:
        sprite_index = sprTsurareStampGreen;
        break;
    case 3:
        sprite_index = sprTsurareStampBlue;
        break;
    default:
        sprite_index = sprTsurareStamp;
        break;
}
