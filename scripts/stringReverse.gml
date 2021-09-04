/// string_reverse(string)
/// returns the reverse of the given string

var str; str = argument0;
var rev; rev = "";
var i; for (i = string_length(str); i > 0; i-=1)
    rev += string_char_at(str, i);

return rev;
