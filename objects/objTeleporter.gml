#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

faction = 2;

contactDamage = 0;
canHit = false;

blockCollision = 0;
grav = 0;
bubbleTimer = -1;

playerMet[global.playerCount] = true;
drawarrow = 0;

permalock = 0;
lock = 0;

lightt = 0;

// Creation Code variables

//@cc room to teleport to
myRoom = -1;

//@cc where to teleport to
X = -1;

//@cc where to teleport to
Y = -1;

//@cc have to press up to use? If not you will teleport as soon as you touch it
pressUp = 0;

//@cc is the teleporter locked when there's enemies in the room?
enemyLock = false;
keylock = false;

//@cc only usable once?
teleportOnce = false;

//@cc use the turn around animation instead of the teleporting animation
isDoor = 0;

//@cc start the next room like a new stage?
newStage = 0;

//@cc returnToHub
returnToHub = false;

lightSprite = sprTeleporterLight;

//@cc isExternal
isExternal = false;

//@cc externalRoomFilename
externalRoomFilename = "";

//@cc[1,6] what blinking light to use for the teleporter tiles behind the object (number corresponds with the teleporter's game)
light = 0;

lightx = 0;
lighty = -32;
lightsp = 1 / 12;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

lock = 0;

if (enemyLock) // If enemy is alive -> lock teleporter
{
    with (prtEntity)
    {
        if (!dead)
        {
            if (contactDamage != 0 || canHit)
            {
                if (global.factionStance[faction, 1])
                {
                    other.lock = 1;
                    break;
                }
            }
        }
    }
}

if (!global.frozen)
{
    lightt += lightsp;
}

if (!global.frozen && !lock)
{
    with (objMegaman)
    {
        other.image_yscale = gravDir;

        if (!playerIsLocked(PL_LOCK_MOVE))
        {
            if (place_meeting(x, y, other.id))
            {
                if (abs(other.x - x) <= 5 && ground && abs(other.y - y) <= 2)
                {
                    other.drawarrow = 1;

                    if ((yDir == -gravDir && other.pressUp)
                        || (!other.playerMet[playerID] && !other.pressUp))
                    {
                        if (other.keylock)
                        {
                            if (global.keyNumber)
                            {
                                global.keyNumber -= 1;
                                other.keylock = 0;
                                playSFX(sfxWheelCutter2);
                            }
                            break;
                        }

                        i = instance_create(x, y, objMegamanExit);
                        i.pid = playerID;
                        i.cid = costumeID;
                        i.type = 2 + other.isDoor;
                        i.image_xscale = image_xscale;
                        i.image_yscale = image_yscale;

                        i.myRoom = other.myRoom;
                        i.X = other.X;
                        i.Y = other.Y;
                        i.newStage = other.newStage;
                        i.returnToHub = other.returnToHub;
                        i.isExternal = other.isExternal;
                        i.externalRoomFilename = other.externalRoomFilename;

                        with (objMegaman)
                        {
                            visible = 0;
                            yDir = 0;
                            xspeed = 0;
                            yspeed = 0;
                        }

                        global.frozen = true;

                        with (other)
                        {
                            global.lastTeleporterX = x;
                            global.lastTeleporterY = y;

                            if (teleportOnce)
                            {
                                instance_destroy();
                            }
                        }
                        break;
                    }
                }
            }
            else
            {
                other.playerMet[playerID] = 0;
            }
        }
        else
        {
            other.playerMet[playerID] = true;
        }
    }
}
else
{
    for (var i = 0; i < global.playerCount; i += 1)
    {
        playerMet[i] = true;
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// drawSelf();
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

if (!lock)
{
    if (light != -1 && !floor(lightt mod 2))
    {
        draw_sprite(lightSprite, light, x + lightx, y + lighty);
    }
}

if (pressUp && drawarrow)
{
    draw_sprite(sprPressUp, (image_yscale == -1), x, y - 22 * image_yscale);
    drawarrow = 0;
}
