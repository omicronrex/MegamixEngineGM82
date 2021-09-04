/// playerLockGlobalInit()
// initializes global player control lock pools

// TODO: add global.frozen
// TODO: add global.lockTransition
lockPoolReleaseAll(global.timeStopped);
lockPoolReleaseAll(global.playerFrozen);

var i; for (i = 0; i < PL_LOCK_MAX; i+=1)
{
    lockPoolReleaseAll(global.playerLock[i]);
}
