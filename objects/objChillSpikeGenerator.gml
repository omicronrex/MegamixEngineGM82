#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

spike = 0;
cooldownTimer = 8;
image_speed = 0.25;

i = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!global.frozen)
{
    if (cooldownTimer > 0)
    {
        cooldownTimer -= 1;
    }

    if (cooldownTimer == 0)
    {
        if (!i)
        {
            playSFX(sfxChillShoot);
            switch (spike)
            {
                case 0: // generate spike
                    i = instance_create(x, y - 16, objChillSpikeDetector);
                    i.image_xscale = -1;
                    i.spreadAttack = true;
                    break;
                case 1: // generate spike
                    i = instance_create(x - 48, y, objChillSpikeDetector);
                    i.image_xscale = -1;
                    i.spreadAttack = true;
                    i.aimAtMegaman = true;
                    break;
                case 2: // generate spike
                    i = instance_create(x, y, objChillSpikeDetector);
                    i.image_xscale = 1;
                    i.spreadAttack = true;
                    i.aimAtMegaman = true;
                    break;
                case 3: // generate spike
                    i = instance_create(x + 48, y, objChillSpikeDetector);
                    i.image_xscale = 1;
                    i.spreadAttack = true;
                    i.aimAtMegaman = true;
                    break;
                case 4: // generate spike
                    i = instance_create(x, y, objChillSpikeDetector);
                    i.image_xscale = 1;
                    i.spreadAttack = true;
                    break;
            }
            cooldownTimer = 2;
        }
        else
        {
            switch (spike)
            {
                case 0:
                    cS = instance_create(x, y, objChillSpike);
                    cS.image_xscale = -1;
                    cS.toWall = true;
                    cS.spreadAttack = true;
                    cS.direction = 270 - 48;
                    break;
                case 1:
                    cS = instance_create(x, y, objChillSpike);
                    cS.image_xscale = -1;
                    cS.spreadAttack = true;
                    cS.imageReset = 3;
                    cS.image_index = cS.imageReset;
                    cS.imageMax = 5;
                    cS.direction = 270 - 28;
                    break;
                case 2:
                    cS = instance_create(x, y, objChillSpike);
                    cS.image_xscale = 1;
                    cS.spreadAttack = true;
                    cS.imageReset = 6;
                    cS.image_index = cS.imageReset;
                    cS.imageMax = 8;
                    cS.direction = 270;
                    break;
                case 3:
                    cS = instance_create(x, y, objChillSpike);
                    cS.image_xscale = 1;
                    cS.spreadAttack = true;
                    cS.imageReset = 3;
                    cS.image_index = cS.imageReset;
                    cS.imageMax = 5;
                    cS.direction = 270 + 28;
                    break;
                case 4:
                    cS = instance_create(x, y, objChillSpike);
                    cS.image_xscale = 1;
                    cS.toWall = true;
                    cS.spreadAttack = true;
                    cS.direction = 270 + 48;
                    break;
            }
            instance_destroy();
        }
    }
}
