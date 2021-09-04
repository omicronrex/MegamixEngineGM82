#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// X = ;
// Y = ;
// myroom = ;
// exitType = ; (0 = none (default), 1 = shrink, 2 = rise)

event_inherited();
canHit = false;

image_speed = 0;

blockCollision = 0;
grav = 0;
bubbleTimer = -1;

despawnRange = -1;
respawnRange = -1;

travel = 4; // in blocks
myFlag = 0;
y = ystart + (travel * 16);
active = false;
exitTimer = 60;

// Creation Code variables
myRoom = room;
X = -1;
Y = -1;
exitType = 0;

//@cc 0 = teleport land, 1 = teleport in, 2 = fall in, 3 = Jump in, 4 = stand there (set showDuringReady to true), 8 = Skull elevator
respawnAnimation = 8;

mask = instance_create(x, ystart + (travel * 16) - 4, objSkullElevatorMask);

with (mask)
{
    parent = other.id;
    image_xscale = other.image_xscale;
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if ((!global.frozen || active) && !dead && !global.timeStopped)
{
    if (!(active && exitType == 2))
    {
        y = ystart + ((travel * 16) * (1 - global.flag[myFlag]));

        if (y != ystart + ((travel * 16) * round(1 - global.flag[myFlag])))
        {
            if (!instance_exists(objSplash))
            {
                instance_create(x + 16, ystart + 2, objSplash);
                instance_create(x - 16, ystart + 2, objSplash);
                instance_create(x, ystart + 2, objSplash);

                with (objSplash)
                {
                    blockCollision = 0;
                    active = true;
                }
            }
        }
    }

    if (place_meeting(x, y, objMegaman) && global.flag[myFlag] == 1)
    {
        var player = instance_place(x, y, objMegaman);
        if (((player.x >= x && image_xscale == 1 && player.x < x + sprite_width - 2)
            || (player.x <= x && image_xscale == -1 && player.x > x + sprite_width - 2))
            && (player.y > y - 28))
        {
            global.flagParent[myFlag].active = false;
            active = true;
            global.frozen = true;
            player.visible = false;
        }
    }

    if (active)
    {
        if (global.flag[myFlag] > 0 && exitType == 1)
        {
            global.flag[myFlag] -= 1 / 120;
        }
        else if (exitType == 2 && y > view_yview)
        {
            y--;
        }
        else if (exitTimer > 0)
        {
            exitTimer--;
        }
        else
        {
            global.hasTeleported = 1;
            global.teleportX = X;
            global.teleportY = Y;
            global.nextRoom = myRoom;
            global.respawnAnimation = respawnAnimation;
        }
    }
}
else if (dead)
{
    yspeed = 0;
    x = xstart;
    y = ystart + ((travel * 16) * (1 - global.flag[myFlag]));
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_part_ext(sprite_index, 0, 0, 0, 52,
    sprite_height * global.flag[myFlag],
    round(x) - sprite_xoffset, round(y) - sprite_yoffset - (3 * global.flag[myFlag] <= .93), image_xscale, image_yscale, image_blend, image_alpha);

// Draw the shaft rising upwards
if (y < ystart)
{
    draw_sprite_part(sprSkullElevatorShaft, 0, 0, 0, 48, (ystart - y) mod 16, x - 28, ystart - ((ystart - y) mod 16));

    if ((ystart - y) >= 16)
    {
        for (i = 0; i < floor((ystart - y) / 16); i++)
            draw_sprite(sprSkullElevatorShaft, 0, x - 4, y + i * 16);
    }
}
