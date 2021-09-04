/// chooseFromArray(array)
// returns a random element of the given array

var array; array = argument0;
var arrayLength; arrayLength = array_length_1d(array);
var index; index = irandom(array_length_1d(array) - 1);
return array[index];
