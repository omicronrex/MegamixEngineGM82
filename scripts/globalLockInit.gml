/// playerLockGlobalInit()
// initializes global player control lock pools

// TODO: add global.frozen
// TODO: add global.lockTransition
global.timeStopped = lockPoolNew();
global.playerFrozen = lockPoolNew();

var i; for (i = 0; i < PL_LOCK_MAX; i+=1)
{
    global.playerLock[i] = lockPoolNew();
}
