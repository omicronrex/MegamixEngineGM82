///scriptExecuteNargs(script,argv,argc)

var script,argv,argc;

script=argument0
argv=argument1
argc=argument2

for (i=0;i<argc;i+=1) {
    a[i]=ds_list_find_value(argv,i)
}

ds_list_destroy(argv)

switch (argc) {
    case  0: return script_execute(script)
    case  1: return script_execute(script,a[0])
    case  2: return script_execute(script,a[0],a[1])
    case  3: return script_execute(script,a[0],a[1],a[2])

    case  4: return script_execute(script,a[0],a[1],a[2],a[3])
    case  5: return script_execute(script,a[0],a[1],a[2],a[3],a[4])
    case  6: return script_execute(script,a[0],a[1],a[2],a[3],a[4],a[5])
    case  7: return script_execute(script,a[0],a[1],a[2],a[3],a[4],a[5],a[6])

    case  8: return script_execute(script,a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7])
    case  9: return script_execute(script,a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8])
    case 10: return script_execute(script,a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9])
    case 11: return script_execute(script,a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10])

    case 12: return script_execute(script,a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11])
    case 13: return script_execute(script,a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12])
    case 14: return script_execute(script,a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13])
    case 15: return script_execute(script,a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14])
}
