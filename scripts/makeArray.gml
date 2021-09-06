/// makeArray(args...)
// turns the given input into an array

var l;l=ds_list_create()

for (i=0;i<argument_count;i+=1) {
    ds_list_add(l,argument[i])
}

return l
