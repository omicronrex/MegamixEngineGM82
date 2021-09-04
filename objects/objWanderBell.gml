#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 1;

category = "grounded";

facePlayerOnSpawn = true;

// enemy specific code
normalSpd = 0.25;

image_speed = 0.1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
xs = xspeed;

event_inherited();

if (entityCanStep())
{
    if (xspeed == 0 && xs != 0)
    {
        xspeed = -xs;
        image_xscale = -sign(xs);
    }

    if (ground)
    {
        if (xspeed > 0)
        {
            xs = bbox_right + 1;
        }
        else
        {
            xs = bbox_left - 1;
        }
        if (!positionCollision(xs, bbox_bottom + 1))
        {
            xspeed = -xspeed;
            image_xscale = -image_xscale;
        }
    }
}
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
specialDamageValue(objBusterShot, 1);
specialDamageValue(objBusterShotHalfCharged, 1);
specialDamageValue(objBusterShotCharged, 3);
specialDamageValue(objHornetChaser, 3);
specialDamageValue(objJewelSatellite, 3);
specialDamageValue(objGrabBuster, 3);
specialDamageValue(objTripleBlade, 1);
specialDamageValue(objWheelCutter, 2);
specialDamageValue(objSlashClaw, 2);
specialDamageValue(objSakugarne, 2);
specialDamageValue(objSuperArrow, 1);
specialDamageValue(objWireAdapter, 2);
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (spawned)
{
    image_index = 0;
    xspeed = normalSpd * image_xscale;
}
