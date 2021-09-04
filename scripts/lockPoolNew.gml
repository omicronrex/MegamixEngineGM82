/// lockPoolNew()
// creates a new lock pool, returning its ID

var i; for (i = 0; i < global.lockPoolN; i+=1)
{
    if (global.lockPoolAvailable[i])
    {
        global.lockPoolAvailable[i] = false;
        global.lockPoolLockCount[i] = 0;
        global.lockPoolTombstone[i] = false;
        return i;
    }
}

// add a new pool to the list:
global.lockPoolAvailable[global.lockPoolN] = false;
global.lockPoolLockCount[global.lockPoolN] = 0;
global.lockPoolTombstone[global.lockPoolN] = false;

var ret;ret=global.lockPoolN
global.lockPoolN+=1
return ret;
