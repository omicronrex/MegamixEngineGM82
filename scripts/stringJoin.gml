/// stringJoin(array, delimiter)
// returns a string of the given array concatenated and joined by the delimiter.
// example: stringJoin(makeArray(4, 3, 2), ", ") gives "4, 3, 2"

var str; str = "";
var a; a = argument0;
var d; d = argument1;
var i;

for (i = 0; i < array_length_1d(a); i+=1)
{
    if (i != 0)
    {
        str += d;
    }
    str += string(a[i]);
}

return str;
