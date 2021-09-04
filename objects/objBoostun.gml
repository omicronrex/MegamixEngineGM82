#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// An enemy that flies into the air when walking off a ledge. It then flies after Mega Man and fires missiles at him.
event_inherited();

healthpointsStart = 3;
contactDamage = 4;
facePlayer = true;

blockCollision = 0;
category = "flying";
grav = 0;

imgIndex = 0; // Used to handle animation
imgSpd = 0.1; // Animation speed
animBack = false; // Reverse animation?

radius = 6 * 16; // Range Mega Man must enter before Boostun flies
phase = 0; // Current phase
angle = 0;
moveTimer = 60; // Steps until action is performed
shootTimer = 60; // Steps until missile is fired
flyTimer = 30; // time to wait before flying
missile = noone; // Missile
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
        // Walk on the ground
        case 0:
            xspeed = 0.7 * image_xscale;
            if (animBack == false)
            {
                imgIndex += imgSpd;
                if (imgIndex >= 3)
                {
                    imgIndex = 1;
                    animBack = true;
                }
            }
            else
            {
                imgIndex -= imgSpd;
                if (imgIndex < 0)
                {
                    imgIndex = 1;
                    animBack = false;
                }
            }
            if ((!positionCollision(x + 12 * image_xscale, bbox_bottom + 2))
                || (distance_to_object(target) < radius))
            {
                imgIndex = 3;
                animBack = false;
                phase = 1;
            }
            break;
        // Fly into the air
        case 1: // Initial movement
            moveTimer-=1;
            if (moveTimer > 0)
            {
                yspeed = -1;
            }
            else
            {
                xspeed = 0;
                yspeed = 0;

                // Shoot
                if (instance_exists(target))
                {
                    shootTimer-=1;

                    // Get target
                    megaDir = point_direction(x, y, target.x, target.y + 5);

                    // Set angle
                    if (image_xscale == 1)
                    {
                        // aim from east to south
                        if ((megaDir <= 360) && (megaDir > 338) || (megaDir >= 0) && (megaDir < 22))
                        {
                            angle = 0;
                        }
                        else if ((megaDir <= 338) && (megaDir > 315))
                        {
                            angle = 338;
                        }
                        else if ((megaDir <= 315) && (megaDir > 293))
                        {
                            angle = 315;
                        }
                        else if ((megaDir <= 293) && (megaDir > 280))
                        {
                            angle = 293;
                        }
                        else if (megaDir >= 270)
                        {
                            angle = 270;
                        } // aim from east to north
                        else if ((megaDir >= 22) && (megaDir < 45))
                        {
                            angle = 22;
                        }
                        else if ((megaDir >= 45) && (megaDir < 67))
                        {
                            angle = 45;
                        }
                        else if ((megaDir >= 67) && (megaDir < 80))
                        {
                            angle = 67;
                        }
                        else if (megaDir <= 90)
                        {
                            angle = 90;
                        }
                    } // If facing left...
                    else
                    {
                        // aim from west to south
                        if ((megaDir >= 180) && (megaDir < 202) || (megaDir <= 180) && (megaDir > 158))
                        {
                            angle = 180;
                        }
                        else if ((megaDir >= 202) && (megaDir < 225))
                        {
                            angle = 202;
                        }
                        else if ((megaDir >= 225) && (megaDir < 247))
                        {
                            angle = 225;
                        }
                        else if ((megaDir >= 247) && (megaDir < 260))
                        {
                            angle = 247;
                        }
                        else if ((megaDir >= 260) && (megaDir <= 270))
                        {
                            angle = 270;
                        } // aim from west to north
                        else if ((megaDir <= 158) && (megaDir > 135))
                        {
                            angle = 158;
                        }
                        else if ((megaDir <= 135) && (megaDir > 112))
                        {
                            angle = 135;
                        }
                        else if ((megaDir <= 112) && (megaDir > 100))
                        {
                            angle = 112;
                        }
                        else if (megaDir >= 90)
                        {
                            angle = 90;
                        }
                    }
                    angle = wrapAngle(angle);

                    if (shootTimer < 0)
                    {
                        if (!instance_exists(missile))
                        {
                            var i; i = instance_create(x + 4 * image_xscale, y - 9, objBoostunMissile);
                            missile = i.id;
                            i.parent = id;
                            i.dir = angle;
                            i.image_xscale = image_xscale;
                            playSFX(sfxMissileLaunch);

                            // Set image used for missile
                            switch (angle)
                            {
                                case 0:
                                    i.image_index = 0;
                                    break;
                                case 22:
                                    i.image_index = 1;
                                    i.image_yscale = -1;
                                    break;
                                case 45:
                                    i.image_index = 2;
                                    i.image_yscale = -1;
                                    break;
                                case 67:
                                    i.image_index = 3;
                                    i.image_yscale = -1;
                                    break;
                                case 90:
                                    i.image_index = 4;
                                    i.image_yscale = -1;
                                    break;
                                case 112:
                                    i.image_index = 3;
                                    i.image_yscale = -1;
                                    break;
                                case 135:
                                    i.image_index = 2;
                                    i.image_yscale = -1;
                                    break;
                                case 158:
                                    i.image_index = 1;
                                    i.image_yscale = -1;
                                    break;
                                case 180:
                                    i.image_index = 0;
                                    break;
                                case 202:
                                    i.image_index = 1;
                                    break;
                                case 225:
                                    i.image_index = 2;
                                    break;
                                case 247:
                                    i.image_index = 3;
                                    break;
                                case 270:
                                    i.image_index = 4;
                                    break;
                                case 293:
                                    i.image_index = 3;
                                    break;
                                case 315:
                                    i.image_index = 2;
                                    break;
                                case 338:
                                    i.image_index = 1;
                                    break;
                                case 360:
                                    i.image_index = 0;
                                    break;
                            }
                        }
                        else
                        {
                            flyTimer-=1;
                            if (flyTimer <= 0)
                            {
                                moveTowardPoint(target.x, target.y, 1);
                            }
                        }
                    }
                }
            }

            // Animation
            if (animBack == false)
            {
                imgIndex += imgSpd;
                if (imgIndex >= 5)
                {
                    imgIndex = 4;
                    animBack = true;
                }
            }
            else
            {
                imgIndex -= imgSpd;
                if (imgIndex <= 3)
                {
                    imgIndex = 4;
                    animBack = false;
                }
            }
            break;
    }
}
else if (dead)
{
    healthpoints = healthpointsStart;
    imgIndex = 0;
    phase = 0;
    animBack = false;
    moveTimer = 60;
    shootTimer = 60;
    flyTimer = 30;
    angle = 0;
}

image_index = imgIndex div 1;
