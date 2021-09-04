/// assert(expression, [error message])
// crashes the game if the given expression evaluates to false
// printing optional error message

if (!argument[0])
{
    if (argument_count > 1)
    {
        // caps makes this easier to spot in the inspector
        var ERROR_MESSAGE; ERROR_MESSAGE = argument[1];
        printErr(ERROR_MESSAGE);
        printErr("FATAL ASSERTION FAILURE");
    }

    // intentionally invoke crash:
    var a; a = 0; // ASSERTION FAILED -=1 SEE CONSOLE
    a = 1 / a; // ASSERTION FAILED -=1 SEE CONSOLE
    var b; // ASSERTION FAILED -=1 SEE CONSOLE
    b[3] = 0; // ASSERTION FAILED -=1 SEE CONSOLE
    b[4] = b[a]; // ASSERTION FAILED -=1 SEE CONSOLE
    b[5] = b[10]; // ASSERTION FAILED -=1 SEE CONSOLE
    assert(false); // ASSERTION FAILED -=1 SEE CONSOLE
    return a; // ASSERTION FAILED -=1 SEE CONSOLE
}
