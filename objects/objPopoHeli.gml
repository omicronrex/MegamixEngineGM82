#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Popo Heli
// This enemy spawns under some conditions, if its facing left it will spawn if
// the screen moves right and if it's facing right it will spawn if the screen moves left.
// He will always spawn after a transition.
event_inherited();

healthpointsStart = 1;
contactDamage = 4;
category = "fire, flying, shielded";

image_speed = 0.18;
grav = 0;
facePlayerOnSpawn = false;
blockCollision = false; // Do not have collision
swooceIn = true; // Flying in (do not set in creation code)
respawnRange = 1;
despawnRange = 2;
xspeed = 0;
yspeed = 0;
prevX = xstart;
prevY = ystart;
shootTimer = 12;
moveTimer = 150; // How long is the flamethrower active?
playedSound = false;
accel = 0.08;
spawnHeightOffset = -48;

prevXView = view_xview;
lenght = 112;
init = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (init == 0 && insideSection(prevX, prevY))
{
    x -= image_xscale * 78;
    y += spawnHeightOffset;
    if (!insideSection(x, y))
    {
        if (bbox_right >= global.sectionRight)
        {
            x += -4 + global.sectionRight - bbox_right;
        }
        if (bbox_left <= global.sectionLeft)
        {
            x += 4 + global.sectionLeft - bbox_left;
        }

        if (bbox_bottom >= global.sectionBottom)
        {
            y += -4 + global.sectionBottom - bbox_bottom;
        }
        if (bbox_top <= global.sectionTop)
        {
            y += 4 + global.sectionTop - bbox_top;
        }
    }
    spawnHeightOffset = -abs(y - prevY);
    xstart = x;
    ystart = y;
    init = 1;

    /* if(insideView())
        beenOutsideView=true ;*/
}
event_inherited();
prevXView = view_xview;


if (init && entityCanStep())
{
    if (swooceIn)
    {
        if ((x - prevX) * image_xscale < -lenght / 2)
        {
            // set y to parabolic position based on x
            var yp = ((abs(x - prevX + xspeed + image_xscale * (lenght / 2))) / lenght) * 2;
            yspeed = (prevY - y + (yp * yp * spawnHeightOffset));

            // accelerate
            xspeed += accel * image_xscale;
        }
        else
        {
            yspeed = prevY - y;
            if (abs(x - prevX) > 40)
                xspeed += accel * image_xscale;
            else
                xspeed -= accel * accel * image_xscale;
            if ((sign((prevX - x)) != image_xscale) || (xspeed * image_xscale <= 0))
            {
                swooceIn = false;
                x = prevX;
                xspeed = 0;
                yspeed = 0;
            }
        }
    }
    else // Once in position, release flamethrower
    {
        if (moveTimer != 0)
        {
            moveTimer--;
            shootTimer--;
            if (shootTimer == 0)
            {
                i = instance_create(x + 9 * image_xscale, y + 7, objPopoHeliFire);
                i.image_xscale = image_xscale;
                i.parent = self.id;
                shootTimer = 8;
                if (playedSound == false)
                {
                    playSFX(sfxPopoHeliFire);
                    playedSound = true;
                }
            }
        }
        else // Fly up and away
        {
            if (yspeed > -5)
            {
                yspeed -= 0.1;
            }
        }
    }
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
stopSFX(sfxPopoHeliFire);
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Deflect shots
if (collision_rectangle(x, y - 9,
    x + 19 * image_xscale, y + 8, other.id, false, false))
{
    other.guardCancel = 1;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (spawned)
{
    if (!insideSection(prevX, prevY))
    {
        dead = true;
        spawned = false;
        exit;
    }
    if ((view_xview[0] > global.sectionLeft && view_xview[0] + view_wview[0] < global.sectionRight) && !(sign(prevXView - view_xview[0]) == sign(image_xscale)))
    {
        dead = true;
        spawned = false;
        exit;
    }
    if (image_xscale == -1)
    {
        if (global.sectionLeft < view_xview[0] && global.sectionRight != view_xview + view_wview)
            x = view_xview[0] + 260;
        else
            x = min(prevX + 96, view_xview[0] + 260);
    }
    else
    {
        if (global.sectionRight > view_xview[0] + view_wview[0] && global.sectionLeft != view_xview)
            x = view_xview[0] - 4;
        else
            x = max(prevX - 96, view_xview[0] - 4);
    }

    lenght = abs(x - prevX);

    swooceIn = true;
    shootTimer = 12;
    moveTimer = 150;
    playedSound = false;
    xspeed = 0.25 * image_xscale;
    yspeed = 0;
}
else
{
    // prevXView=view_xview[0]+image_xscale;
    stopSFX(sfxPopoHeliFire);
}
