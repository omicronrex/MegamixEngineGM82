/// sl_plaintext_end()
// completes save/load process, cleaning up resources and, in the case of saving,
// returns a plaintext string containing the save data.
// returns 0 or string if no error, otherwise returns some error code.

if (global.sl_error)
{
    if (global.sl_map >= 0)
        ds_map_destroy(global.sl_map);
    return global.sl_error;
}

// saving:
if (global.sl_save)
{
    print("Saved to plaintext.", WL_VERBOSE);
    return ds_map_write(global.sl_map);
}
else
{
    print("Loaded from plaintext without errors.", WL_VERBOSE);
}

if (global.sl_map >= 0)
    ds_map_destroy(global.sl_map);

return 0;
