#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;

isSolid = 1;
blockCollision = 0;
grav = 0;

action = 1;
actionTimer = 0;

alarmTime = 80;
mySpeed = 3.5;

respawnRange = -1;
despawnRange = -1;

shiftVisible = 1;

alarm[0] = 1;
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sprite_index = sprCompactor;

y += 1;

setSection(x, y + 8, 0);

while (!place_meeting(x, y - 1, objSolid)
&& sectionTop < y && bbox_top - 1 > 0)
{
    y -= 1;
}

image_yscale = ystart - y + 16;
yscalestart = image_yscale;
ystart = y;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // only collide this way
    blockCollision = (action == 2);

    actionTimer += 1;

    switch (action)
    {
        case 1: // wait
            if (actionTimer == alarmTime)
            {
                action += 1;
                actionTimer = 0;
            }
            break;
        case 2: // Down
            yspeed = mySpeed;
            image_yscale += yspeed;
            y = ystart;

            if (checkSolid(0, ceil(yspeed)) || bbox_bottom >= global.sectionBottom)
            {
                action += 1;
                actionTimer = 0;
                yspeed = 0;
                if (insideView() && bbox_bottom < global.sectionBottom)
                {
                    playSFX(sfxCompactor);
                }
            }

            //image_yscale = bbox_bottom - ystart;
            //y = ystart;

            /*if (bbox_bottom >= global.sectionBottom)
            {
                while (bbox_bottom >= global.sectionBottom)
                {
                    image_yscale -= 1;
                }
                action += 1;
                actionTimer = 0;
            }*/
            break;
        case 3: // wait again
            if (actionTimer == 80)
            {
                action += 1;
                actionTimer = 0;
            }
            break;
        case 4: // Up
            image_yscale -= mySpeed * 1.25;
            if (image_yscale <= yscalestart)
            {
                image_yscale = yscalestart;
                action = 1;
            }
            break;
    }
}
else if (dead)
{
    image_yscale = yscalestart;
    actionTimer = 0;
    action = 1;
    yspeed = 0;
    blockCollision = 0;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
drawSelf();

draw_sprite(sprCompactorTop, 0, x, ceil(bbox_bottom - 14));
