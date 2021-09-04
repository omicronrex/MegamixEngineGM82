/// arrayNearest(array, elt)
// returns the value of the element in the array nearest in value to `elt`
// if multiple values are equally close to `elt`, the first one in the array is returned.

var a; a = argument0;
var e; e = argument1;
var bestIndex; bestIndex = 0;
var bestDifference; bestDifference = abs(a[0] - e);
var i; for (i = 1; i < array_length_1d(a); i+=1)
{
    var difference; difference = abs(a[i] - e);
    if (difference < bestDifference)
    {
        bestIndex = i;
        bestDifference = difference;
    }
}

return a[bestIndex];
