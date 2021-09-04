#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 6;
contactDamage = 6;

category = "semi bulky";
facePlayerOnSpawn = true;

imgIndex = 0;
imgSpd = 0.1;
phase = 0;
safeTimer = 0;

block = noone;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    switch (phase)
    {
        case 0:
            if (!instance_exists(objSoshiBreakerDebris))
            {
                if (imgIndex < 2)
                {
                    imgIndex += imgSpd;
                }
                else
                {
                    yspeed = -5;
                    phase = 1;
                }
            }
            break;
        case 1:
            if ((yspeed >= 0) && (!ground))
            {
                imgIndex = 0;
            }
            else if (ground)
            {
                if (imgIndex == 0)
                {
                    imgIndex = 1;
                    playSFX(sfxClamp);
                }
                imgIndex += imgSpd;
                if (imgIndex == 2)
                {
                    imgIndex = 0;
                    phase = 2;
                    block = instance_create(x + 1 * image_xscale, view_yview, objSoshiBreakerCube);
                    block.image_xscale = image_xscale;
                }
            }
            break;
        case 2:
            if (place_meeting(x, y, block))
            {
                with (block)
                {
                    instance_destroy();
                }

                if (imgIndex == 0)
                {
                    imgIndex = 3;
                    phase = 3;
                }
            }
            else //Didn't hit the block for whatever reason? No biggie, start again!
            {
                safeTimer++;
                if (safeTimer == 240)
                {
                    phase = 0;
                    safeTimer = 0;
                }
            }
            break;
        case 3:
            imgIndex += imgSpd;
            if (imgIndex >= 6)
            {
                phase = 0;
                imgIndex = 0;

                // Create 7-way spreadshot
                var i = instance_create(x, y - 8, objSoshiBreakerDebris);
                i.xspeed = -2;
                i.yspeed = 2;
                var i = instance_create(x - 2, y - 9, objSoshiBreakerDebris);
                i.xspeed = -3;
                i.yspeed = 0;
                var i = instance_create(x, y - 10, objSoshiBreakerDebris);
                i.xspeed = -2;
                i.yspeed = -2;
                var i = instance_create(x + 1, y - 12, objSoshiBreakerDebris);
                i.xspeed = 0;
                i.yspeed = -3;
                var i = instance_create(x + 2, y - 10, objSoshiBreakerDebris);
                i.xspeed = 2;
                i.yspeed = -2;
                var i = instance_create(x + 4, y - 9, objSoshiBreakerDebris);
                i.xspeed = 3;
                i.yspeed = 0;
                var i = instance_create(x + 2, y - 8, objSoshiBreakerDebris);
                i.xspeed = 2;
                i.yspeed = 2;

                playSFX(sfxLargeClamp);
            }
            break;
    }
}
else if (dead)
{
    healthpoints = healthpointsStart;
    imgIndex = 0;
    phase = 0;
    safeTimer = 0;
}
image_index = imgIndex div 1;
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (imgIndex >= 3)
{
    other.guardCancel = 1;
}
