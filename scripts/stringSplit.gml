/// stringSplit(string, delimiter, trim)
// returns an array of strings split on the given delimiter.
// if trim is true, then trim all whitespace

var i;
var str; str = argument[0];
var del; del = argument[1];

var trim; trim = false;
if (argument_count > 2)
{
    trim = argument[2];
}

if (str == "")
{
    return makeArray(str);
}

var prevSplit; prevSplit = 1;
var a;
var aN; aN = 0;
for (i = 1 + (del == ""); i <= string_length(str); i+=1)
{
    if (stringAt(str, del, i))
    {
        a[aN] = stringSubstring(str, prevSplit, i); aN+=1
        i += string_length(del);
        prevSplit = i;
    }
}

a[aN] = stringSubstring(str, prevSplit); aN+=1

if (trim)
{
    for (i = 0; i < aN; i+=1)
    {
        a[i] = stringTrim(a[i]);
    }
}

return a;
