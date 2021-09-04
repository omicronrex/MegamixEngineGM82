#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

blockCollision = 0;
grav = 0.25;
lowGrav = 0.25 / 2;

contactDamage = 2;

xtravel = 0;
ytravel = 0;

version = 1; // 1 = left low; 2 = right low; 3 = left high; 4 = right high;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !global.timeStopped)
{
    if (xtravel == 0 && ytravel == 0)
    {
        if (version mod 2 == 0) // True = Right; False = Left;
        {
            xtravel = 1;
        }
        else
        {
            xtravel = -1;
        }

        if (version - 2 > 0) // True = High; False = Low;
        {
            ytravel = 64;
            xtravel *= 32;
        }
        else
        {
            ytravel = 24;
            xtravel *= 36;
        }
        yspeed = -sqrt(abs(2 * gravAccel * ytravel));
        airTime = abs(2 * yspeed / gravAccel);
        xspeed = xtravel / airTime;
    }
}
