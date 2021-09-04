#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
global.telTelWeather = 0;

// 0 = clear
// 1 = rain
// 2 = snow

animTimer = -1;
weatherImg = 0;

darkenAlpha = 0;

// What to kill in rain
weakToRain[0] = objTackleFire;
weakToRain[1] = objNitronFire;
weakToRain[2] = objFireBoyShot;
weakToRain[3] = objFireTellyShot;
weakToRain[4] = objJumpRollerFlame;
weakToRain[5] = objPopoHeliFire;
weakToRain[6] = objChangkeyDragonFire;
weakToRain[7] = objHotDogFire;
weakToRain[8] = objSFFire;
weakToRain[9] = objFireFlame;
weakToRain[10] = objHeatManFire;
weakToRain[11] = objMechaDragonFire;
weakToRain[12] = objHeatMan;
weakToRain[13] = objPUOilFire;
weakToRain[14] = objFireBlockFire;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if (!global.frozen)
{
    // Interactions with other objects
    if (global.telTelWeather == 1)
    {
        // Play rain sfx
        if (!audio_is_playing(sfxTelTelRain))
        {
            playSFX(sfxTelTelRain);
        }

        // Ice weapons trigger snowy weather
        for (i = 0; i < array_length_1d(weakToRain); i++)
        {
            if (instance_exists(weakToRain[i]))
            {
                with (weakToRain[i])
                {
                    if (!dead && insideView())
                    {
                        if ((object_index != objHeatMan) || (object_index == objHeatMan && isFight))
                        {
                            healthpoints = 0;
                            playSFX(sfxSplash);
                            event_user(EV_DEATH);
                        }
                    }
                }
            }
        }
    }
}
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Reset
global.telTelWeather = 0;

instance_destroy();
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// Rain/snow drawing + animation
animTimer++;

switch (global.telTelWeather)
{
    // Rain
    case 1:
        draw_set_color(c_black);
        storealpha = draw_get_alpha();
        draw_set_alpha(darkenAlpha);
        draw_rectangle(view_xview - 1, view_yview - 1, view_xview + view_wview + 1,
            view_yview + view_hview + 1, false);
        draw_set_alpha(storealpha);

        // Sky darkens before rain
        if (animTimer mod 10 == 0)
        {
            if (darkenAlpha < (1 / 4))
            {
                darkenAlpha += (1 / 12);
            }
        }

        // Weather img
        if (animTimer mod 3 == 0)
        {
            weatherImg += 1;
            if (weatherImg > 3)
            {
                weatherImg = 0;
            }
        }
        var tr = instance_exists(objToadRain);
        var dox = view_xview mod 16;
        var doy = view_yview mod 16;
        for (var i = view_xview - 16; i <= view_xview + view_wview + 16; i += 16)
        {
            for (var e = view_yview - 16; e <= view_yview + view_hview + 16; e += 16)
            {
                if (!tr || (tr && !place_meeting(i - dox, e - doy, objToadRain)))
                {
                    draw_sprite_ext(sprTelTelRain, weatherImg, i - dox, e - doy, 1, 1, 0, c_white, darkenAlpha * 3);
                }
            }
        }
        break;

    // Snow
    case 2: // Weather img
        if (animTimer mod 7 == 0)
        {
            weatherImg += 1;
            if (weatherImg > 3)
            {
                weatherImg = 0;
            }
        }
        var dox = view_xview mod 16;
        var doy = view_yview mod 16;
        for (var i = view_xview - 16; i <= view_xview + view_wview + 16; i += 16)
        {
            for (var e = view_yview - 16; e <= view_yview + view_hview + 16; e += 16)
            {
                draw_sprite_ext(sprTelTelSnow, weatherImg, i - dox, e - doy, 1, 1, 0, c_white, 1);
            }
        }

        // Flash
        depth = 0;
        draw_set_color(c_white);
        storealpha = draw_get_alpha();
        draw_set_alpha(darkenAlpha);
        draw_rectangle(view_xview - 1, view_yview - 1, view_xview + view_wview + 1,
            view_yview + view_hview + 1, false);
        draw_set_alpha(storealpha);

        // Sky brightens before fading out
        if (animTimer mod 10 == 0)
        {
            if (darkenAlpha > 0 && animTimer >= 20)
            {
                darkenAlpha -= (1 / 4);
            }
        }
        depth = -1;
        break;
}
