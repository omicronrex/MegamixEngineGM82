/// arrayAppendUnique(array, element)
// appends element to the given array if it is not already in the array.

var array; array = argument0;
var elt; elt = argument1;
if (indexOf(array, elt) == -1)
{
    arrayAppend(array, elt);
}
