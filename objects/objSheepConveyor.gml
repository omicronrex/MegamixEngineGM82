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
bubbleTimer = -1;

respawnRange = -1;
despawnRange = -1;
shiftVisible = 1;

dir = 1;

spd = 0; // The speed the player moves at when standing on the conveyor belt

imgalarm = 0;
img = 0;
imgSpeed = 0;

myFlag = 0;

sprite = sprMM10Conveyor; // used for the actual conveyor graphic, this sprite is divided by 3 and dependant on the sprite width, so 48/3 will make each segment 16 pixels wide, this will change depending on the sprite width. note: your sprite's witdh should be able to be divided into 3 to match your sprite masks width.
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen && !dead && !global.timeStopped)
{
    // getPlayer's used to get the ID of any player that are above or below the conveyor depending on gravity
    var getPlayer = instance_place(x, y - 1, objMegaman)
    // check that a player exists on the conveyor
    ;
    if (instance_exists(getPlayer))
    {
        // if the player's moving and the current speed's lower then the players movement, change the xspeed to match the players (the xspeed is set to the oposite of the players to keep them in place)
        if (getPlayer.xspeed != 0
            && abs(getPlayer.xspeed) > abs(spd))
        {
            spd = -getPlayer.xspeed;
        }
        else
        {
            // if the speeds of the conveyor doesn't match, decrease the speed (this check is to prevent the conveyor from slowing down when it reaches it's peak speed)
            if (-getPlayer.xspeed != spd)
            {
                spd /= 1.1;
            }
            if (abs(getPlayer.xspeed) >= abs(spd) && spd != 0)
            {
                global.flagParent[myFlag].active = true; // see objSwitchHandler, stayActive needs to be 2 for the conveyor to work.
            }
        }
    }
    else // if there's no player slow down
    {
        spd /= 1.1;
    }

    // imgSpeed takes the current speed (multiplied by gravity direction so it spins the oposite direction when flipped)
    // divided by 6 (meaning that each frame should last about 6 frames is xspeed's at 1)
    // and removes the current image speed value from it, once that's calculated it's then divided by 8 to make it so that it takes 8 frames for it to match the image speed
    imgSpeed += (((spd) / 6) - imgSpeed) / 8;

    // increase image by image speed
    img += imgSpeed;

    // if image is less then 0, add the total number of image indexes from sprite to get it into the positives (going below 0 stops the conveyor)
    if (img < 0)
    {
        img = sprite_get_number(sprite);
    }
    else // set img to modulate itself, idk I just hate having it being really really big for no reason
    {
        img = img mod sprite_get_number(sprite);
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var getWidth = sprite_get_width(sprite) / 3;

for (i = 0; i < image_xscale; i++)
{
    draw_sprite_part(sprite, img mod sprite_get_number(sprite), getWidth * (sign(i) + (i == image_xscale - 1)), 0, getWidth, sprite_height, x + i * getWidth, y);
}
