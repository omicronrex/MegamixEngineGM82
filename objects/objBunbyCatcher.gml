#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// An infamous enemy from MM9 that will stay invisible, then pop up and drop down when approached.
// If it grabs Mega Man, it will carry him very quickly until it feels like stopping or Mega Man hits a wall.

// Creation code (all optional):
// col - color. 0 = orange; 1 = pink
// stopX = X coordinate to stop carrying MM at. If not set, MM will be carried on until he hits a wall.
// catcherSpeed = xspeed for when the Bunby Catcher starts taking off after grabbing MM. Default 4

// NOTE: Its carrying direction relies on what image_xscale you give it in the editor.

event_inherited();

respawn = true;

healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 0;
category = "flying";

blockCollision = 0;
grav = 0;

// Enemy specific code
despawnRange = 32;
respawnRange = 32;

poppedUp = false;
stopTimer = -1;

othersGrabbed = false;

grabbedPlayer = false;
myPlayer = noone;

animTimer = 0;
image_speed = 0;
imageOffset = 0;

stopX = noone;
catcherSpeed = 4;

leaveTime = 120;
leaving = false;

xOffset = 0;
yOffset = 14;

col = 0; // 0 = orange; 1 = pink
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    // This is to be on the safe side. A lot of crashes have occurred due to not checking if target exists.
    if (instance_exists(target))
    {
        // Check if the target (nearest player) is close.
        if (collision_rectangle(x - 16, y - 224, x + 16, y + 224, target, false,
            true) && !poppedUp)
        {
            poppedUp = true;
            yspeed = 5.5;
            y = view_yview[0];
        }

        // Grab player
        if (collision_rectangle(x - 8, y + 6, x + 8, y + 15, target, false, true) && !grabbedPlayer && !leaving)
        {
            // Making sure other Bunby Catchers haven't grabbed Mega Man.
            othersGrabbed = false;
            with (objBunbyCatcher)
            {
                if (grabbedPlayer && myPlayer == other.target && !leaving)
                {
                    other.othersGrabbed = true;
                }
            }
            if (!othersGrabbed)
            {
                grabbedPlayer = true;
                myPlayer = target;
                playSFX(sfxBunbyCatcher);
                yspeed = 0;
            }
        }
    }

    if (grabbedPlayer && instance_exists(myPlayer))
    {
        // lock controls
        global.keyLeft[myPlayer.playerID] = false;
        global.keyRight[myPlayer.playerID] = false;
        global.keyUp[myPlayer.playerID] = false;
        global.keyDown[myPlayer.playerID] = false;

        global.keyLeftPressed[myPlayer.playerID] = false;
        global.keyRightPressed[myPlayer.playerID] = false;
        global.keyUpPressed[myPlayer.playerID] = false;
        global.keyDownPressed[myPlayer.playerID] = false;

        // yOffset
        if (myPlayer.ground)
        {
            yOffset = 12;
        }
        else
        {
            yOffset = 16;
        }

        // xOffset
        xOffset = -myPlayer.image_xscale;

        // start gaining V E L O C I T Y
        if (abs(xspeed) < catcherSpeed)
        {
            xspeed += 0.15 * image_xscale;
        }

        if ((abs(xspeed) >= catcherSpeed) && stopTimer == -1)
        {
            xspeed = sign(xspeed) * catcherSpeed;
            stopTimer = 0;
        }

        // timer for flying away
        if (stopTimer >= 0)
        {
            stopTimer += 1;
        }

        if (((stopTimer >= leaveTime) || (stopX != noone)) && !leaving)
        {
            if ((stopX != noone && ((image_xscale == 1 && x > stopX) || (image_xscale == -1 && x < stopX))) || (stopTimer >= leaveTime))
            {
                leaving = true;
                grabbedPlayer = false;
            }
        }

        // update player position
        with (myPlayer)
        {
            shiftObject(other.xspeed - other.image_xscale, 0, 1);
        }
        x = myPlayer.x - xOffset;
        y = ceil(myPlayer.y - yOffset);
    }

    if (myPlayer != noone)
    {
        if (!instance_exists(myPlayer))
        {
            leaving = true;
            grabbedPlayer = false;
        }
    }

    // fly away like a coward
    if (leaving)
    {
        yspeed -= gravAccel;
        xspeed = 0;
    }

    // Animation
    animTimer += 1;
    if (animTimer == 2)
    {
        animTimer = 0;
        imageOffset = !imageOffset;
    }
}
else if (dead)
{
    poppedUp = false;
    stopTimer = -1;
    grabbedPlayer = false;
    myPlayer = noone;
    leaving = false;
    yspeed = 0;
    xspeed = 0;
}

image_index = (imageOffset + (grabbedPlayer * 2)) + (col * 4);
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// This enemy is invincible, so just do this to reflect bullets.

// The above comment is a liar.

if (poppedUp)
{
    if (grabbedPlayer && (other.object_index == objBusterShot || other.object_index == objBusterShotHalfCharged || other.object_index = objBusterShotCharged))
    {
        other.guardCancel = 3;
    }
    else
    {
        other.guardCancel = 0;
    }
}
else
{
    other.guardCancel = 2;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!poppedUp)
{
    exit;
}

event_inherited();
