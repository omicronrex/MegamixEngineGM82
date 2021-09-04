#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
healthpointsStart = 1;
healthpoints = healthpointsStart;
contactDamage = 0;

// Enemy specific code
fade_in_time = 34;

// 0: fade in
// 1: run
phase = 0;
phaseTimer = 0;
canHit = false;

triggered = false;

visible = false;

spriteX = 0;
spriteY = 0;
animTimer = 0;
targetPID = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep())
{
    switch (phase)
    {
        case 0:
            grav = 0;
            spriteX = 0;
            spriteY = 0;
            contactDamage = 0;
            with (instance_place(x, y, objMegaman))
            {
                other.image_xscale = image_xscale;
                other.triggered = true;
                other.target = id;
                other.targetPID = playerID;
                other.targetCID = costumeID;
            }
            if (triggered)
                phaseTimer += 1;
            visible = (phaseTimer div 3) mod 2;
            if (phaseTimer > fade_in_time)
            {
                phaseTimer = 0;
                phase = 1;
            }
            break;
        case 1:
            grav = .25;
            visible = true;
            contactDamage = 2;
            animTimer += 1;
            canHit = true;
            xspeed = 1.8 * image_xscale;

            // face player occasionally
            phaseTimer += 1;
            if (phaseTimer == 15)
            {
                phaseTimer = 0;
                calibrateDirection();
            }
            if (checkSolid(xspeed, 0) && ground)
            {
                // it'll jump when it hits a wall, but only sometimes
                if (irandom_range(1, 2) == 1)
                {
                    yspeed = -3.75;
                }
                else
                {
                    image_xscale *= -1;
                }
            }
            if (!instance_exists(target))
            {
                dead = true;
            }
            if (!ground)
            {
                spriteX = 7 + (animTimer div 8) mod 2;
                spriteY = 0;
            }
            else
            {
                spriteX = 3 + (animTimer div 8) mod 4;
                spriteY = 0;
            }
    }
}
else if (dead)
{
    xspeed = 0;
    triggered = false;
    phaseTimer = 0;
    phase = 0;
    canHit = false;
    contactDamage = 0;
    animTimer = 0;
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
visible = false;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// TODO: proper skin colour palette remapping (this doesn't draw quite accurately.)
if (!dead)
{
    drawCostume(global.playerSprite[targetCID], spriteX, spriteY, x, y, image_xscale, image_yscale,
        c_ltgray, c_black, global.nesPalette[39], c_black);
}
