// inRange(x, a, b)
// returns L <= x < U, where L is min(a,b) and U is max(a,b)

var a; a = argument[1];
var b; b = argument[2];
var _x; _x = argument[0];

if (b < a)
    return inRange(_x, b, a);

return (a <= _x && _x < b);
