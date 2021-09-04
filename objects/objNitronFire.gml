#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

ogContactDamage = 2;
contactDamage = ogContactDamage;

phase = 0;
imgSpd = 0.3;
image_speed = 0;
imgIndex = 0;
peakTimer = 40;
sprites = noone;
explosion = noone;

col = 0;

reflectable = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !global.timeStopped)
{
    switch (phase)
    {
        // set sprite
        case 0: // Set the correct color
            switch (col)
            {
                case 0:
                    sprites = sprNitronFireOrange;
                    break;
                case 1:
                    sprites = sprNitronFireBlue;
                    break;
                default:
                    sprites = sprNitronFireOrange;
                    break;
            }
            sprite_index = sprites;
            phase+=1;
            break;

        // dropping through the air
        case 1:
            grav = 0.25;
            if (ground)
            {
                y -= yspeed;
                grav = 0;
                phase+=1;
                imgIndex = 0;
                explosion = instance_create(x, y, objExplosion);
                image_alpha = 0;
                contactDamage = 0;
                playSFX(sfxNitronFire);
            }
            break;

        // explosion animation
        case 2:
            if (!instance_exists(explosion))
            {
                contactDamage = ogContactDamage;
                image_alpha = 1;

                imgIndex = 1;
                phase+=1;
            }
            break;

        // rising
        case 3:
            imgIndex += imgSpd;
            if (imgIndex >= 5)
            {
                phase+=1;
            }
            break;

        // stay suspended at peak for a bit
        case 4:
            imgIndex += imgSpd;
            if (imgIndex >= image_number)
            {
                imgIndex = 5 + (imgIndex mod image_number);
            }
            peakTimer -= 1;
            if (peakTimer <= 0)
            {
                phase+=1;
                imgIndex = 5;
            }
            break;

        // go back down
        case 5:
            imgIndex -= imgSpd;
            if (imgIndex <= 0)
            {
                instance_destroy();
                exit;
            }
            break;
    }
}

image_index = imgIndex div 1;
