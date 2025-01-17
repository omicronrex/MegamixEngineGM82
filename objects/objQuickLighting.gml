#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
canHit = false;

grav = 0;
blockCollision = false;
bubbleTimer = -1;

// 1: full lighting
// 0: no lighting
lightingLevel = 1;
lightingSwitchSpeed = 1 / 20;

// multiplies tile colour by this value:
lightingColor = make_color_rgb(255 * .8, 20, 20);

// adds this factor of the original tile colour to the above:
lightingRetain = 0.2;

lightSource[0] = objTackleFire;
lightSource[1] = objHothead;
lightSource[2] = objElectricGabyoallCurrent;
lightSource[3] = objQuickLaser;
lightSource[4] = objFireBoy;
lightSource[5] = objOil;
lightSource[6] = objHarmfulExplosion;
lightSource[7] = objMagmaBeam;
lightSource[8] = objFireBoyShot;
lightSource[9] = objNapalm;
lightSource[10] = objFireWave;
lightSource[11] = objFireTotem;
lightSource[12] = objChangkeyDragon;
lightSource[13] = objSuzakAndFenix;
lightSource[14] = objDompanFireworkSpark;

// don't edit these
respawnRange = -1;
despawnRange = -1;

// semi: dark red light instead of normal
lightingSemi = false;
roundedLightingLevel = 0;

// global flag system (-1 ignores the flag)
myFlag = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (entityCanStep())
{
    var lighting_active; lighting_active = false;

    var i; for ( i = 0; i < array_length_1d(lightSource); i+=1)
    {
        with (lightSource[i])
        {
            var valid; valid = visible;
            if (object_index == objOil)
                if (!fire)
                    valid = false;
            if (object_index != objHarmfulExplosion)
                if (dead)
                    valid = false;
            if (insideView() && valid)
                lighting_active = true;
        }
    }

    var lighting_semi_desired; lighting_semi_desired = true;
    with (objQuickLightingNormal)
        if (insideView())
        {
            lighting_semi_desired = false;
            lighting_active = true;
        }

    // Flag system
    if (myFlag != -1)
    {
        if (global.flagParent[myFlag].active)
        {
            lighting_semi_desired = false;
            lighting_active = true;
        }
    }

    if (lighting_active && !(lighting_semi_desired ^^ lightingSemi))
        lightingLevel += lightingSwitchSpeed;
    else
        lightingLevel -= lightingSwitchSpeed;
    lightingLevel = clamp(lightingLevel, 0, 1);

    // can only switch between semi and non-semi lighting in the full darkness
    if (lightingLevel == 0)
        lightingSemi = lighting_semi_desired;

    roundedLightingLevel = floor(lightingLevel * 5) / 5;
    var _rrl; _rrl = roundedLightingLevel;

    // oil goes dark
    with (objOil)
        if (!fire)
            image_blend = make_color_rgb(255 * _rrl, 255 * _rrl, 255 * _rrl);
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_alpha(1);
if (lightingLevel == 1 && !lightingSemi)
    exit;

if (lightingSemi)
{
    draw_set_alpha(lightingRetain);
    draw_set_blend_mode_ext(bm_dest_color, bm_src_alpha);
    draw_set_color(lightingColor);
    draw_rectangle(global.sectionLeft, global.sectionTop, global.sectionRight, global.sectionBottom, false);
    draw_set_blend_mode(bm_normal);
}

draw_set_color(c_black);
draw_set_alpha(1 - roundedLightingLevel);
{
    draw_rectangle(global.sectionLeft, global.sectionTop, global.sectionRight, global.sectionBottom, false);
}

draw_set_alpha(1);
