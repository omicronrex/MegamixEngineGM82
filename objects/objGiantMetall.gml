#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// A giant met that flies up and down
event_inherited();

healthpointsStart = 10;
healthpoints = healthpointsStart;
contactDamage = 8;

category = "flying, mets";

blockCollision = 0;
grav = 0;

// creation code
dir = image_xscale;

// Enemy specific code
shootTimer = 0;
image_speed = 0.3;
doesIntro = false;
yCutoff = 0;
blink = false;
metallTimer = 0;
spd = 0.75;
coolDown = 0;
blinkWait = choose(60, 120, 180);
blinkTimer = 8;

checkRange = 16 * 10; // 10 blocks

while (!place_meeting(x, y + 1, objSolid) && y < ystart + checkRange)
    y += 8;

if (place_meeting(x, y + 1, objSolid))
{
    yCutoff = sprite_height;
    y += sprite_height;
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    if (yCutoff > 0)
    {
        y -= spd;
        yCutoff -= spd;
    }
    else
    {
        yCutoff = 0;
        if (shootTimer > 0)
            shootTimer -= 1;
        else
        {
            shootTimer = 60 * 4;
            dir = -dir;
            if (coolDown == 0)
                event_user(choose(0, 1));
        }
        if (y < ystart - 16)
        {
            if (dir == -1 && coolDown == 0)
                event_user(choose(0, 1));
            dir = 1;
        }
        if (y > ystart + 16)
        {
            if (dir == 1 && coolDown == 0)
                event_user(choose(0, 1));
            dir = -1;
        }
        y += dir * spd;
        if (metallTimer > 0)
        {
            if (metallTimer == floor(metallTimer / 20) * 20)
            {
                met = instance_create(x + 8 * image_xscale, y + 32, objMetall);
                with (met)
                {
                    yspeed = -2;
                    cooldownTimer = -600;
                    image_index = 3;
                    canShoot = false;
                    image_xscale = other.image_xscale;
                    respawn = false;
                    isFromMiniboss = true;
                    facePlayerOnSpawn = true;
                }
            }
            metallTimer -= 1;
        }
        if (coolDown > 0)
        {
            coolDown -= 1;
        }
        blinkWait--;
        if (blinkWait == 0)
        {
            blink = true;
        }

        if (blink == true)
        {
            blinkTimer--;
            if (blinkTimer == 0)
            {
                blinkTimer = 8;
                blink = false;
                blinkWait = choose(60, 120, 180);
            }
        }
    }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Balls
for (i = -1; i <= 1; i += 1)
{
    ball = instance_create(x + 8 * image_xscale, y + 24, objGiantMetallBall);
    ball.xspeed = (1 - (abs(i) / 2)) * image_xscale;
    ball.yspeed = i * 1;
}

coolDown = 60;
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Metall
metallTimer = 60;

coolDown = 120;
#define Other_21
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//other.guardCancel = 2;

if (other.y < y - 16 && other.y > y - 32
    && other.x * image_xscale < (x - 8) * image_xscale
    && other.x * image_xscale > (x + 4) * image_xscale)
{
    other.guardCancel = 0;
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
draw_sprite_part_ext(sprite_index, (round(image_index) mod 2) + blink * 2, 0,
    0, abs(sprite_width), sprite_height - abs(yCutoff),
    round(x) + sprite_xoffset * image_xscale, round(y) - sprite_yoffset,
    image_xscale, image_yscale, image_blend, image_alpha);
