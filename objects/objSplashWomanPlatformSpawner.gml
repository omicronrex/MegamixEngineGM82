#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
visible=0;
blockCollision=0;
grav=0;
bubbleTimer = -1;
canDamage=0;
canHit=0;
despawnRange=-1;
respawnRange=-1;


//@cc the amount of frames to wait before spawning the platform
waitTime=16;

//@cc the ammount of frames to wait after spawning the platform
coolDownTime = 0;

//@cc the amount of frames the spawned platform will be active
activeTime=32;

//@cc the speed of the platform
platformSpeed = 2;

timer=0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();

if(entityCanStep())
{
    if(timer>=0)
    {
        timer+=1;
        if(timer>=abs(waitTime))
        {
            timer =-1;
            //spawn platform
            var ID; ID = instance_create(x,y,objSplashWomanPlatform);
            ID.activeTime = activeTime;
            ID.respawn=false;
            ID.spd = abs(platformSpeed)*sign(image_xscale);
            ID.startupTime = 30;
            ID.image_xscale=abs(image_xscale);
            ID.image_yscale=abs(image_yscale);
        }
    }
    else
    {
        timer-=1;
        if(timer<-abs(activeTime+30+coolDownTime))
        {
            timer=0;
        }
    }
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited();
timer=0;
