#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_perform_object(prtEnemyProjectile, ev_create, 0);
stopOnFlash = false;

cAngle = 0;
cDistance = 10;
cDistanceMax = 24;
addAngle = 0.065;

isTargetable = false;

blockCollision = false;
contactDamage = 4;
iFrames = 0;

curX = x;
curY = y;

xspeed = 0;

image_speed = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    if (instance_exists(objPlantMan))
    {
        cAngle += addAngle * image_xscale;
        x = round(curX + cos(cAngle) * cDistance);
        y = round(curY + sin(cAngle) * cDistance);
        if (xspeed == 0)
        {
            curX = objPlantMan.x;
            curY = objPlantMan.y;
        }
        else
            curX += xspeed;

        if (cDistance < cDistanceMax)
            cDistance += 0.5;

        if (cDistance > cDistanceMax)
            cDistance -= 0.5;

        // plant barrier grows and shrinks in size continously.
        if (cDistance == cDistanceMax && cDistanceMax == 16)
            cDistanceMax = 24;

        if (cDistance == cDistanceMax && cDistanceMax == 24)
            cDistanceMax = 16;


        if (curX >= view_xview + view_wview + 8)
            instance_destroy();

        if (curX <= view_xview - 8)
            instance_destroy();
    }
    else
    {
        instance_destroy();
    }
}
#define Other_18
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (other.object_index == objFlameMixer)
{
    event_user(EV_DEATH);
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.guardCancel = 3;
