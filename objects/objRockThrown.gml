#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Creation code (all optional):
// col = <number> (0 = green(default); 1 = red; 2 = orange; )

event_inherited();

healthpointsStart = 3;
healthpoints = healthpointsStart;
contactDamage = 4;

category = "semi bulky, rocky";

facePlayer = true;

// Enemy specific code
hasFired = false;
imageOffset = 0;
imageTimer = 0;
imageTimerMax = 12;

objectThrown = objThrownRock;

col = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
image_index = (5 * col) + imageOffset;
if (entityCanStep())
{
    imageTimer += 1;

    if (imageTimer == imageTimerMax && imageOffset < 4)
    {
        imageOffset += 1;
        imageTimer = 0;
        imageTimerMax = 12;
    }
    else if (imageTimer == imageTimerMax && imageOffset == 4)
    {
        imageOffset = 0;
        imageTimer = 0;
        hasFired = false;
    }
    var ID;
    if (imageOffset == 3 && hasFired == false)
    {
        hasFired = true;
        imageTimerMax = 16;
        var ID;
        ID = instance_create(x + image_xscale, spriteGetYCenter() - 4,
            objectThrown);
        {
            ID.xscale = image_xscale;
            ID.col = col;
            ID.respawn=false;
        }
    }
}
else if (dead == true)
{
    xspeed = 0;
    yspeed = 0;
    image_index = 0;
}
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
specialDamageValue(objHornetChaser, 3);
specialDamageValue(objJewelSatellite, 3);
specialDamageValue(objGrabBuster, 3);
