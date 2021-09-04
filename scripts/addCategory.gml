/// addCategory(entity, category)
/// adds a category to the given entity
var entity; entity = argument0;
var category; category = argument1;
if (entity.category == "")
{
    entity.category = category;
}
else if (!hasCategory(entity.category, category))
{
    entity.category += ", " + category;
}
