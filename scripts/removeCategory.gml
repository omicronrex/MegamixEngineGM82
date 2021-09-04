/// removeCategory(entity, category)
/// removes the given category from the given entity, if the entity has it.

var entity; entity = argument0;
var category; category = argument1;
if (category == "")
{
    exit;
}
var a; a = stringSplit(entity.category, ",", true);
var deleteIndex; deleteIndex = indexOf(a, category)

var b; b[0] = "";
var i; for (i = 0; i < array_length_1d(a); i+=1)
{
    if (i != deleteIndex)
    {
        b[i] = a[i];
    }
}

entity.category = stringJoin(b, ", ");
