name = "Cut Man";
name_color = global.nesPalette[31];
text = "I'll have you know that I'm a CUT above the rest!####Let's see how you do against Kung Fu Cut Man! /1HEEYA!!!/0";
mugshot_start = 1;
mugshot_end = 1;
face_player = true;

idle_sprite = sprCutStand;
idle_end = 0;
talkSprite = sprCutIntro;
talkEnd = 1;
talkSpeed = 0.125;
code_on_talk_start = "playSFX(sfxCutManSnip);";
option[0] = "what";
option_text[0] = "...wait, you're not even familiar with that phrase? I can't believe you'd even call yourself an internet junkie if you're not familiar with "+'"Kung Fu Cut Man."'+" For shame, Mega Man. For shame.";
option_code_on_talk_end[0] = "
playSFX(sfxError);
instance_create(x - 8, y - 24, objEnemyBullet);
with (objEnemyBullet)
{
    reflectable = 0;
    canDamage = false;
    sprite_index = sprDestroyField;
    alarmDie = 30;
}
";
option[1] = "You're toast, mister!";
option_text[1] = "(insert amazing battle sequence here)";
option_code_on_talk_end[1] = "
idle_sprite = sprCutThrow;
sprite_index = sprCutThrow;
screenFlash(8);
image_xscale = 1;
playSFX(sfxExplosion2);
screenShake(38, 2, 2);
with (objMegaman)
{
    x = 912;
    y = 624;
    instance_create(x, y, objBigExplosion);
    image_xscale = -1;
    playerGetShocked(false, 0, true, 60);
    xspeed = 4;
}
idle_sprite = sprCutStand;
"; //witness an amazing kung fu action scene

option[2] = "I LEFT THE OVEN ON AAAAAAAAAA";
option_text[2] = "/1RUN COWARD!!!!/0"
option_code_on_talk_end[2] = "
instance_create(x, y, objCustomSpawner);
with (objCustomSpawner)
{
        respawn = false;
        startWait = 0;
        spawnWait = 10;
        object = objHarmfulExplosion;
        code = '
        screenShake(10, choose(1, 2), choose(1, 2));
        playSFX(sfxExplosion2);
        x = irandom_range(view_xview, view_xview + 256);
        contactDamage = 0;
        y = irandom_range(view_yview, view_yview + 224);'
}
"
/*        code = '
        contactDamage = 0;
        x = view_xview + irandom_range(0, 256);
        y = view_yview + irandom_range(0, 224);
        ';
