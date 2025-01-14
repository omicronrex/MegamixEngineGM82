/// sl(value, [key], [isArray], [default])
// saves value to file (set in slBegin) and returns value input,
// or if loading, returns value loaded from file (or value input if error, unless default specified)
// key is optional argument to attach variable to a name, this prevents
// the variable from being corrupted if save file format is reordered.
// otherwise, a key will be generated according to the order of the sl calls.
// isArray: must be true if loading an array.
// default: return this value if loading fails (by default, return value)

var value; value = argument[0];
var defaultValue; defaultValue = value;
var key; key = "";
var isArray; isArray = false;
if (argument_count > 1)
{
    key = argument[1];
}
else
{
    // autogenerate key
    key = "_VARN_" + string(global.sl_varcounter); global.sl_varcounter+=1
}

if (argument_count > 2)
    isArray = argument[2];

if (argument_count > 3)
    defaultValue = argument[3];

if (global.sl_error)
{
    return value;
}

if (global.sl_save)
{
    ds_map_set(global.sl_map,key,value);
    return value;
}
else
{
    var lookup; lookup = ds_map_get(global.sl_map,key);
    if (!is_undefined(lookup))
    {
        // handle arrays specially
        if (isArray)
        {
            if (is_real(lookup))
            {
                var list; list = lookup;
                {
                    if (ds_list_size(list) > 0)
                    {
                        var returnArray;
                        var i; for (i = 0; i < ds_list_size(list); i+=1)
                        {
                            returnArray[i] = ds_list_find_value(list, i);
                        }
                        return returnArray;
                    }
                }
            }

            printErr("Unexpected value when searching for array in " + global.sl_filename + ": " + string(key) + " (using default.)");
            return defaultValue;
        }
        else
        {
            // return saved value
            return lookup;
        }
    }

    // not found in file -=1 return default, throw no error (!)
    print("Key not found in " + global.sl_filename + ": " + string(key) + " (using default.)", WL_VERBOSE);
    return defaultValue;
}
