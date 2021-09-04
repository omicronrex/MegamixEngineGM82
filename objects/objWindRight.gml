#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// An object that will push Mega Man in the shown direction when he touches it.

event_inherited();

canHit = false;

grav = 0;
blockCollision = 0;
bubbleTimer = -1;

//@cc the speed of the wind, in pixels per frame.
mySpeed = 1;

dir = "right";

// getPlayerX = 0;
// getPlayerY = 0;
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

// Do wind
if (instance_place(x, y, objMegaman)) // check for the player
{
    var player; player = instance_place(x, y, objMegaman);

    if (player)
    {
        with (player)
        {
            if (!global.frozen && !climbing)
            {
                switch (other.dir)
                {
                    case "right":
                        shiftObject(other.mySpeed, 0, 1);
                        break;
                    case "left":
                        shiftObject(-other.mySpeed, 0, 1);
                        break;
                    case "up":
                        if (yspeed > -other.mySpeed)
                        {
                            yspeed -= grav * 2;
                        }
                        break;
                    case "down":
                        if (!ground)
                        {
                            shiftObject(0, other.mySpeed, 1);
                        }
                        break;
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
/// No
