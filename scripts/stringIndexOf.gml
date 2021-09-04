/// string_index_of(string, substring)
/// finds index of substring in string; returns 0 if not found

var str; str = argument0;
var substr; substr = argument1;

var l; l = string_length(substr);
var bound; bound = string_length(str) - l + 1;

var i; for (i = 1; i <= bound; i+=1)
{
    if (string_copy(str, i, l) == substr)
        return i;
}

return 0;
