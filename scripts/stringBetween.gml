/// stringBetween(string, delimiter_a, delimiter_b)
/// returns the content of the string between delimiter a and delimiter b, or
/// the empty string if that is invalid.
/// delimiter a must appear before delimiter b lest empty string be returned.

var str; str = argument0;
var da; da = argument1;
var db; db = argument2;

if (string_pos(da, str) == 0)
    return "";
if (string_pos(db, str) == 0)
    return "";
if (string_pos(db, str) < string_pos(str, da))
    return "";

var lmark; lmark = string_pos(da, str) + string_length(da);

return string_copy(str, lmark, string_pos(db, str) - lmark);
