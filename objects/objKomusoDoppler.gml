#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

calibrateDirection();
respawn = false;

healthpointsStart = 99;
healthpoints = healthpointsStart;
contactDamage = 4;
stopOnFlash = false;
blockCollision = 0;
grav = 0;

// Enemy specific code
xspeed = 0;
yspeed = 0;
image_speed = 0;
image_index = 0;

hasFired = false;
phase = 0;
moveToLocation = 0;
locationX = 0;
locationY = view_yview + 64;
debugABSX = 0;
debugABSY = 0;

deadlyShadowClones = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (!instance_exists(objKomusoMan))
    instance_destroy();

if (entityCanStep())
{
    // setup locations to transport to
    switch (moveToLocation)
    {
        case 0:
            locationX = view_xview + 48;
            break;
        case 1:
            locationX = view_xview + (view_wview / 2);
            break;
        case 2:
            locationX = view_xview + view_wview - 48;
            break;
    }
    debugABSX = abs(x - locationX);
    debugABSY = abs(y - locationY);

    switch (phase)
    {
        case 0:
            if (image_index < 2)
                image_index += 0.10;
            if (xspeed == 0)
                xspeed = (2.5 + deadlyShadowClones) * image_xscale;
            if ((image_xscale == 1 && x >= view_xview + (view_wview / 2)
                && deadlyShadowClones == false) || (image_xscale == -1
                && x <= view_xview + (view_wview / 2)
                && deadlyShadowClones == false) || (image_xscale == 1
                && x >= view_xview + (view_wview - 32)
                && deadlyShadowClones == true) || (image_xscale == -1
                && x <= view_xview + 32 && deadlyShadowClones == true))
                phase = 1;
            break;
        case 1:
            sprite_index = sprKomusoDoppler1;
            xspeed = 0;
            yspeed = 0;
            mp_linear_step(locationX, locationY, 3.5, false);
            if (abs(x - locationX) <= 2 && abs(y - locationY) <= 2)
            {
                x = locationX;
                y = locationY;
                phase = 2;
                with (objKomusoMan)
                    attackTimer = 0;
            }
            break;
        case 3:
            sprite_index = sprKomusoDoppler3;
            if (instance_exists(objKomusoMan))
                image_index = objKomusoMan.image_index;
            if (image_index >= 3 && hasFired == false)
            {
                hasFired = true;
                var ID;
                ID = instance_create(x, y, objKomusoBullet);
                ID.angle = 90 + 180;
                ID.xscale = image_xscale;
                ID = instance_create(x, y, objKomusoBullet);
                ID.angle = 135 + 180;
                ID.xscale = image_xscale;
                ID = instance_create(x, y, objKomusoBullet);
                ID.angle = 45 + 180;
                ID.xscale = image_xscale;
            }
            break;
        case 4:
            moveToLocation = 1;
            if (instance_exists(objKomusoMan))
                locationY = objKomusoMan.resetY;
            image_index = 3;
            mp_linear_step(locationX, locationY, 2, false);
            if (abs(x - locationX) <= 2 && abs(y - locationY) <= 2)
                instance_destroy();
            break;
    }
}
else if (dead)
{
    instance_destroy();
}
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.guardCancel = 3;
