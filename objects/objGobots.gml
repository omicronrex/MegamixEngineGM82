#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// cDistance = <number>; // how far on a sinewave the gobot moves
// cAngle = <number>; // the starting sine angle on which the gobot starts.
// addAngle = <number>; // how quickly the gobot moves on the sinewave
// spd = <number>; // how quickly the gobot moves horizitonally

event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 2;

category = "flying";

blockCollision = 0;
grav = 0;

image_speed = 0;
facePlayerOnSpawn = true;


// Enemy specific code
resetAngle = -9999; // also used for initalization
flameImg = 0;
resetY = ystart;

// creation code variables
cDistance = 40;
cAngle = 90;
addAngle = 1;
spd = 0.75;

animTimer = 0;
imgOffset = 0;

propellerTimer = 0;
propellerStatus = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (resetAngle == -9999) // intialize object creation code
{
    resetAngle = cAngle;
}

event_inherited();

if (entityCanStep())
{
    // movement
    xspeed = spd * image_xscale;
    y = resetY + sin(degtorad(cAngle)) * cDistance;

    cAngle += addAngle;

    if (cAngle >= 360)
    {
        cAngle -= 360;
    }
    if (cAngle < 0)
    {
        cAngle += 360;
    }

    // animation
    propellerTimer+=1;

    if (propellerTimer == 3)
    {
        propellerStatus = !propellerStatus;
        propellerTimer = 0;
    }

    animTimer+=1;

    if (animTimer == 10)
    {
        imgOffset += 1;
        if (imgOffset > 3)
        {
            imgOffset = 0;
        }

        animTimer = 0;
    }

    image_index = imgOffset + (propellerStatus * 4);
    flameImg += 0.325;
}
else if (dead)
{
    xspeed = 0;
    yspeed = 0;
    image_index = 0;

    animTimer = 0;
    imgOffset = 0;

    propellerTimer = 0;
    propellerStatus = false;

    flameImg = 0;
    cAngle = resetAngle;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!iFrames && !dead)
{
    draw_sprite_ext(sprGobotsFire, flameImg, round(x - 10 * image_xscale), round(y - 6), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}
event_inherited();
