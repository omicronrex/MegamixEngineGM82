#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;

isSolid = 2;

blockCollision = 0;
grav = 0;
bubbleTimer = -1;

respawnRange = -1;
despawnRange = -1;

image_speed = 0.4;

phase = 2;
timer = 0;

if(yspeed==0)
    yspeed=-2;
spd=abs(yspeed);
yspeed = spd*sign(yspeed);
startDir = sign(yspeed);


timeri = 0;
dir = startDir;
drawDir = dir;
yo = dir;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    ++timeri;
    if (timeri >= 3)
    {
        if(drawDir!=0)
        {
            drawDir = 0
        }
        else
        {
            drawDir=dir;
        }
        yo = drawDir;
        timeri = 0;
    }
    timer += 1;
    switch (phase)
    {
        case 0:
            if (timer == 16)
            {
                yspeed = spd*dir;
                timer = 0;
                phase = 2;
            }
            break;
        case 2:
            if (!touchedStopper&&place_meeting(round(x), round(y + sign(yspeed)), objTomahawkPlatformStop))
            {
                phase = 0;
                yspeed = 0;
                timer = 0;
                dir*=-1;
            }
            break;
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if(spawned)
{
    touchedStopper = false;
    dir = startDir;
    drawDir = dir;
    yspeed = spd*dir;
    timeri = 0;
    yo= drawDir;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,round(x),round(y)+yo,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
