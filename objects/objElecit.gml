#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// An electric enemy that electrifies the ground beneath it and fires out five electric shots.

event_inherited();

healthpointsStart = 6;
healthpoints = healthpointsStart;
contactDamage = 4;

grav = 0;
phase = 0;
imgSpd = 0.1;

category = "floating";

// Enemy specific code
moveTimer = 60;
animTimer = 10;
animBack = false;
shots = 0;
hasShot = false;
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
            moveTimer-=1;
            if (moveTimer <= 10)
            {
                yspeed = 2;

                if (moveTimer <= 0)
                {
                    image_index = 4;
                }

                if (ground)
                {
                    phase = 1;
                    moveTimer = 60;
                }
            }
            break;
        case 1:
            moveTimer-=1;
            if (moveTimer == 30)
            {
                instance_create(x, y - 8, objElecitSpark);
                playSFX(sfxElecnShoot);
            }
            if (moveTimer <= 0)
            {
                yspeed = -2;
                image_index = 0;
                if (-ycoll || y < ystart)
                {
                    phase = 2;
                    moveTimer = 30;
                    yspeed = 0;
                }
            }
            break;
        case 2:
            moveTimer-=1;
            if (moveTimer <= 0)
            {
                if (animBack == false)
                {
                    if (image_index != 3)
                    {
                        image_index += imgSpd;
                    }

                    if (image_index >= 2)
                    {
                        image_index = 3;
                    }

                    if (image_index == 3)
                    {
                        // Fire Shots
                        if (hasShot == false)
                        {
                            switch (shots)
                            {
                                case 0:
                                    var i; i = instance_create(x, y, objElecitShot);
                                    i.xspeed = -2;
                                    playSFX(sfxElectricShot);
                                    break;
                                case 1:
                                    var i; i = instance_create(x, y, objElecitShot);
                                    i.xspeed = 2;
                                    playSFX(sfxElectricShot);
                                    break;
                                case 2:
                                    var i; i = instance_create(x, y, objElecitShot);
                                    i.xspeed = 1;
                                    playSFX(sfxElectricShot);
                                    break;
                                case 3:
                                    var i; i = instance_create(x, y, objElecitShot);
                                    playSFX(sfxElectricShot);
                                    break;
                                case 4:
                                    var i; i = instance_create(x, y, objElecitShot);
                                    i.xspeed = -1;
                                    playSFX(sfxElectricShot);
                                    break;
                            }
                            hasShot = true;
                        }

                        animTimer-=1;
                        if (animTimer <= 0)
                        {
                            animBack = true;
                            shots+=1;
                            hasShot = false;
                            animTimer = 10;
                        }
                    }
                }
                else
                {
                    image_index -= imgSpd;
                    if (image_index <= 0)
                    {
                        animBack = false;
                        if (shots == 5)
                        {
                            phase = 0;
                            moveTimer = 10;
                            shots = 0;
                        }
                    }
                }
            }
            break;
    }
}
else if (dead)
{
    healthpoints = healthpointsStart;
    image_index = 0;
    phase = 0;
    moveTimer = 60;
    shots = 0;
    animTimer = 10;
    animBack = false;
    hasShot = false;
}
