#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// image_xscale = 1 or -1 //(Use editor for this!!) // change what direction Shiro is locked in the entire fight.

event_inherited();
respawn = true;
introSprite = sprShirokumachineTeleport;
healthpointsStart = 32;
healthpoints = healthpointsStart;
contactDamage = 8;
blockCollision = 1;
grav = 0.15;
facePlayerOnSpawn = false;
category = "bulky, nature";

// Enemy specific code
image_speed = 0;
image_index = 0;
storeXScale = 0;
phase = 0;

// event triggers
attackTimer = 0;
attackTimerMax = 90;
bullet = noone;

// creation code variables

//@cc if 0, shiro will use both attacks, otherwise if 1 he'll only use the ice ball attack.
variant = 0;

//@cc determines the amount of shards to create.
shardsCreated = 3;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
if (entityCanStep()
    && introTimer <= 0)
{
    attackTimer+=1;

    var halfAttack; halfAttack = attackTimerMax / 2;
    var quarterAttack; quarterAttack = attackTimerMax / 4;

    switch (phase)
    {
        case 0: // spawn ice ball
            if (attackTimer == round(halfAttack))
            {
                playSFX(sfxTigerRoar);
            }
            if (attackTimer >= halfAttack && attackTimer < attackTimerMax)
            {
                image_index = (attackTimer / 4) mod 3;

                if (attackTimer mod 8 == 0)
                {
                    instance_create(x + (17 + irandom(6)) * image_xscale, y - 5 + irandom(4), objSlideDust);
                }

                if (attackTimer == round(halfAttack + quarterAttack))
                {
                    with (instance_create(x + 20 * image_xscale, y - 3, objShiroIceBall))
                    {
                        parent = other.id;
                        other.bullet = id;
                        image_xscale = other.image_xscale;
                    }
                }
            }
            if (attackTimer == attackTimerMax)
            {
                image_index = 0;
                attackTimer = 0;
                phase = 1;
            }
            break;
        case 1: // knock ice ball
            if (attackTimer == 20)
            {
                image_index = 4;
            }
            if (attackTimer == 24)
            {
                image_index = 5;
            }
            if (attackTimer == 28)
            {
                image_index = 6;
                if (instance_exists(bullet))
                {
                    with (bullet)
                    {
                        playSFX(sfxCurlingerBounce);
                        hitByBear = true;
                        xspeed = 2 * image_xscale;
                    }
                }
            }
            if (attackTimer == 36)
            {
                image_index = 0;
                attackTimer = -16;
                if (variant == 1) // depending on variant, either continue attack pattern or reset
                {
                    phase = 0;
                }
                else
                {
                    phase = 2;
                }
            }
            break;
        case 2: // summon ice shards
            if (attackTimer == round(halfAttack))
            {
                playSFX(sfxTigerRoar);
                screenShake(halfAttack, 1, 1);
            }
            if (attackTimer >= halfAttack && attackTimer < halfAttack + quarterAttack)
            {
                image_index = (attackTimer / 4) mod 3;
            }
            if (attackTimer >= halfAttack + quarterAttack)
            {
                if ((attackTimer / 4) mod 4 < 3)
                {
                    image_index = 7 + (attackTimer / 4) mod 4;
                }
                else
                {
                    image_index = 8;
                }
            }
            if (attackTimer == attackTimerMax)
            {
                var tarX;
                if (instance_exists(target))
                {
                    tarX = target.x;
                }
                else
                {
                    tarX = x - 64 * image_xscale;
                }

                instance_create(tarX, view_yview + 16, objShiroShard);
                var i; for ( i = shardsCreated mod 2; i < shardsCreated; i += 2)
                {
                    instance_create(tarX + ceil(i / 2) * 32, view_yview + 16, objShiroShard);
                    instance_create(tarX - ceil(i / 2) * 32, view_yview + 16, objShiroShard);
                }
                attackTimer = -16;
                phase = 0;
            }
            break;



    }
}
else if (!insideView())
{
    image_index = 0;
    y = ystart;
    x = xstart;
    attackTimer = 0;
    phase = 0;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (objStompyProjectile)
{
    if (parent == other.id)
    {
        instance_destroy();
    }
}
event_inherited();
