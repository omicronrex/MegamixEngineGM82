#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
healthpointsStart = 12;
healthpoints = healthpointsStart;
contactDamage = 8;

//@cc - Change colour: 0 (default) = orange, 1 = blue, 2 = green
col = 0;

image_speed = 0;
rotationTimer = 0;
animTable = makeArray(3, 2, 1, 0, 0, 1, 2, 3, 3, 0);
animIter = 5; // frames between animation indices
animTimer = animIter * 3;
jumpTypes = 2;
jumpHeight[0] = 20;
jumpHeight[1] = 36;
jumpDistance[0] = 3 * 16 - 4;
jumpDistance[1] = 32;
msk = mskBigStomper;
category = "big eye, bulky";
dieToSpikes = false;
init = 1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
mask_index = msk;
event_inherited();
mask_index = sprite_index;
if(xcoll!=0)
{
    xspeed=xcoll;
}


//Change colours
if (init)
{
    switch(col)
    {
        case 1:
            sprite_index = sprBigStomperBlue;
            break;
        case 2:
            sprite_index = sprBigStomperGreen;
            break;
        default:
            sprite_index = sprBigStomper;
            break;
    }
    init = 0;
}

if (entityCanStep())
{
    if (!ground)
    {
        // in the air
        animTimer = 3;
        image_index = 0;
        msk = mskBigStomper;
        if (yspeed > 0 && yspeed - grav < 0)
        {
            if (!checkSolid(0, -6))
                y -= 6;
        }
        if (yspeed > 0)
        {
            animTimer = 0;
            image_index = 3;
            msk = mskBigStomperSmall;
        }
    }
    else
    {
        // on ground
        if (ycoll != 0)
            playSFX(sfxHeavyLand);

        // update tall mask
        if (!checkSolid(0, 0) && msk == mskBigStomperSmall)
        {
            msk = mskBigStomper;
            if (checkSolid(0, 0))
                msk = mskBigStomperSmall;
        }

        // play jumping animation
        animTimer+=1;
        xspeed = 0;
        yspeed = 0;
        image_index = animTable[clamp(animTimer div animIter, 0, array_length_1d(animTable) - 1)];
        if (animTimer div animIter >= array_length_1d(animTable) - 1)
        {
            // jump
            var jumpType; jumpType = irandom(jumpTypes - 1);
            var h; h = jumpHeight[jumpType];
            var xDir; xDir = choose(1, -1);
            if (instance_exists(target))
                xDir = sign(target.x - x);
            var d; d = jumpDistance[jumpType] * xDir;
            yspeed = -image_yscale * sqrt(2 * h * grav);
            var time; time = abs(2 * yspeed / grav);
            xspeed = d / time;
        }
    }
    image_index *= 3;
    rotationTimer += 1;
    image_index += rotationTimer div 4 mod 3;
}
else if (dead)
{
    animTimer = animIter * 3;
    msk = mskBigStomper;
}
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
var i; i = instance_create(x,y,objBigExplosion);
with (i)
{
    playSFX(sfxMM9Explosion);
}
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
specialDamageValue(objMagneticShockwave, 4);
