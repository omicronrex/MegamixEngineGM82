#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
healthpointsStart = 28; // sets it's health to 28, the de
healthpoints = healthpointsStart;
canHit = false; // isn't hittable
sprite_index = sprNothing; // prevents visibility by making it a blank sprite
pose = sprNothing; // here to prevent errors
poseImgSpeed = 0; // here to prevent errors
contactDamage = 0; // no contact damage so you dont get hit by an invisible boss
grav = 0; // no gravity
introType = 2; // no intro
blockCollision = 0; // doesnt interact with blocks

puyoBrickN = 0;
puyoBrickIndex = 0;

// Health Bar
healthBarPrimaryColor[1] = 33;
healthBarSecondaryColor[1] = 40;

// Music
music = "Mega_Man_2.nsf";
musicType = "VGM";
musicTrackNumber = 17;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited(); // inherits the behavior of the boss parent object so that it gains the required functionality for the health bar

healthpoints = ceil(28 * (1 - (puyoBrickIndex) / puyoBrickN));
if (healthpoints <= 0 && isFight)
    event_user(EV_DEATH);
else if (isFight)
{
    // determine if possible to initiate next set of puyos
    var nextSet; nextSet = true;
    if (instance_exists(objPicoKun))
        nextSet = false;
    with (objPicoBrick)
    {
        if (phase > 0)
            nextSet = false;
    }

    if (nextSet)
    {
        // initiate next set of puyos
        var a; a = puyoBrickList[puyoBrickIndex];
        var b; b = puyoBrickList[puyoBrickIndex + 1];
        a.phase = 1;
        b.phase = 1;
        a.partner = b;
        b.partner = a;

        // flip the left one
        if (a.x > b.x)
        {
            b.image_xscale *= -1;
            b.x += 16;
        }
        else
        {
            a.image_xscale *= -1;
            a.x += 16;
        }
        var spd; spd = (3 - 2 * healthpoints / 28) + (global.difficulty == DIFF_HARD);
        a.spd = spd;
        b.spd = spd;
    }
}

// move to position of puyo kun in case of dropping energy element
with (objPicoKun)
{
    other.x = x;
    other.y = y;
}
