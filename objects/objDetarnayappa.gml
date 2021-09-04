#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
healthpointsStart = 1;
healthpoints = 1;
respawn = false;
grav = 0;
blockCollision = false;
facePlayerOnSpawn = false;
despawnRange = 4;
contactDamage = 3;

dir = -1;
endY = -1;
shootY = -1;
_im = 0;
yspd = random_range(2.5, 3.15);
timer = -1;
phase = 0;
shotCount = 0;
col = 0;
init = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

//Change colours
if (init)
{
    switch(col)
    {
        case 1:
            sprite_index = sprDetarnayappaRed;
            break;
        default:
            sprite_index = sprDetarnayappa;
            break;
    }
    init = 0;
}

if (entityCanStep())
{
    if (endY == -1)
    {
        if (instance_exists(target))
        {
            var ey = distanceToSolid(x, y, 0, 16 * dir, false, true);
            if (ey != -1)
            {
                ey = y + dir * 16 * ey;
            }
            if (ey == -1)
            {
                ey = view_yview[0] + view_hview[0] * (dir == 1);
            }
            var distToPlayer = 0;
            var tgt = self;
            if (instance_exists(target))
            {
                tgt = target.id;
                if (dir == 1)
                {
                    distToPlayer = abs(bbox_bottom - (tgt.bbox_bottom+32));
                }
                else
                {
                    distToPlayer = -abs(bbox_top -( tgt.bbox_top-32));
                }
            }

            var mini = y;
            if (dir == -1)
                mini = ey;
            var maxi = ey;
            if (dir == -1)
                maxi = y;
            endY = clamp(ey - dir * irandom(abs(ey-(y+distToPlayer))), mini, maxi);
            shootY = endY - dir * floor(abs(endY - ystart) / 2);
        }
        else
        {
            endY = y + 16 * dir;
        }
    }
    if (phase == 0)
    {
        if (sign(y - endY) == -dir)
        {
            image_index = 0;
            yspeed = dir * yspd;
        }
        else
        {
            phase = 1;
            timer = -1;
        }
    }
    else if (phase == 1)
    {
        if (timer == -1)
        {
            yspeed = 0;
            timer = 0;
            shotCount += 1;
            var ycenter = bbox_top + (bbox_bottom - bbox_top) / 2;
            var i = instance_create(bbox_right, ycenter, objEnemyBullet);
            i.xspeed = 2;
            var i = instance_create(bbox_left, ycenter, objEnemyBullet);
            i.xspeed = -2;
            playSFX(sfxEnemyShoot);
        }
        if (timer < 15)
        {
            timer += 1;
            animationLoop(1, 2, 0.3);
        }
        else
        {
            phase = 2;
        }
    }
    else if (phase == 2)
    {
        image_index = 0;
        yspeed = -dir * 1.85;
        if (shotCount == 1 && sign(y - shootY) == -dir)
        {
            timer = -1;
            phase = 1;
        }
    }
}
if (!insideView() || sign(y - ystart) == -dir)
{
    instance_destroy();
}
