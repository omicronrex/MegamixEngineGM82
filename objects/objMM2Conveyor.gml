#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
    Instructions:
    Change its xscale from the editor to set its direction and stretch it to the sides
    until it has the size you want
*/
event_inherited();

//@cc Total amount of frames per sub image group, 2 by default
animFrames = 2;

animTime = 5;

canHit = false;
isSolid = 1;
hasBelt=false;

respawn = true;

grav = 0;
blockCollision = 0;

respawnRange = -1;
despawnRange = -1;
shiftVisible = 1;
bubbleTimer = -1;

dir = sign(image_xscale);

if (image_xscale < 0)
{
    image_xscale = abs(image_xscale);
    x -= sprite_width;
    xstart = x;
}
if(image_yscale<0)
{
    image_yscale=abs(image_yscale);
    y -= sprite_height;
    ystart = y;
}

spd = 1; // The speed the player moves at when standing on the conveyor belt

imgalarm = 0;
img = 0;

sprite_index = sprMM2Conveyor;

// merge conveyor belt objects if this one is the leftmost object in the chain
if (dir == 1)
{
    if (!place_meeting(x - 16, y, object_index))
    {
        while (place_meeting(x + 16, y, object_index))
        {
            with (instance_place(x + 16, y, object_index))
            {
                instance_destroy();
            }
            image_xscale += 1;
        }
    }
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    var exspd = spd * dir;

    if (exspd != 0)
    {
        with (prtEntity)
        {
            if (blockCollision && !dead && ground && grav != 0)
            {
                if (object_index != objCrusher && object_index!=objOshitsuOsarettsu && object_index!=objMetalMan)
                {
                    if(place_meeting(x,y+2*sign(grav), other))
                    {
                        if(!other.hasBelt)
                            shiftObject(exspd, 0, 1);
                        else
                            shiftObject(exspd*sign(grav), 0, 1);
                    }
                }
            }
        }
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if ((!global.frozen && !global.timeStopped) || instance_exists(objSectionSwitcher))
{
    imgalarm += 1;
    if (imgalarm >= animTime)
    {
        imgalarm = 0;
        img = (img+1) mod animFrames;
    }
}

var imgadd;

for (i = 0; i < image_xscale; i += 1)
{
    if(i==0&&image_xscale==1)//single block
    {
        imgadd = 6*animFrames + animFrames*(dir<0);
    }
    else if (i == 0)//left block
    {
        imgadd = animFrames*(dir<0);
    }
    else if(i==image_xscale-1)//right block
    {
        imgadd = 4*animFrames + animFrames*(dir<0);
    }
    else // Middle block
    {
        imgadd = 2*animFrames + animFrames*(dir<0);
    }
    draw_sprite(sprite_index, img + imgadd, x + i * 16, y);
}
