#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
displayMessage = true;
runTests = false; // currently running tests?
displayResults = false;

fullTestSuiteSet =
makeArray(
testSuiteBasic, "Basic Test Suite",
testSuiteHelpfulFunctions, "Helpful functions",
testSuiteStringFunctions, "String functions",
testSuiteReflection, "String Execute Partial",
testSuiteBasicExternalLoad, "External Room Loading",
testSuiteRecording, "Recording Fundamentals",
testSuiteBasicMovement, "Mega man's basic movement physics",
testSuiteEntities, "Entities can exist without Mega man on screen.",
testSuiteBossDoors, "Boss doors"
);

testSuiteSet = fullTestSuiteSet
testSuiteN = array_length_1d(testSuiteSet) div 2;
testSuiteCurrent = 0;
suiteBegin = true;
testingBegin = true;
writeToFile = true;

message = "
------ Unit Tests -------
These tests will check
to see if the engine's
behaviour has been
modified or is failling.
To return to the main
menu, press shoot. Use
the arrow keys to scroll
around this screen.

When the tests begin,
you will be prompted to
select a test output
file. Please select this:

  unitTestResults.txt

which is in the main
project directory.

You must run these tests
before submitting any
changes to any aspect of
the engine which is
tested.

You MUST submit the
changes to this file in
your commit in order to
prove you ran the tests.
The file will include a
timestamp.

You MUST NOT submit any
commit which breaks
these unit tests. If the
test is broken, either
fix the problem or
adjust the test (if the
behaviour change is
intentional).

Press space to begin the
tests."

testResultsFile = "";

scroll = 0;
scrollX = 0;

global.unitTestAbortAll = false
global.unitSuiteName = "??"
global.unitTestCase = "??"

//@noformat
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
randomize();

with (objStruct)
{
    instance_destroy();
}

room_speed = global.gameSpeed;

room_goto(rmTitleScreen);
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (room == rmTitleScreen)
{
    instance_destroy();
    exit;
}

room_speed = global.gameSpeed;

if (runTests)
{
    if (testingBegin)
    {
        testingBegin = false;
        global.unitTestGlobalErrorSummaryResult = 0;
        unitTestFullResults = ds_list_create();
        defer(ev_destroy, ev_destroy, 0, dsDestroy, makeArray(unitTestFullResults, ds_type_list));
    }

    room_speed = 1800;

    // run tests
    while (true)
    {
        if (testSuiteCurrent < testSuiteN)
        {
            if (suiteBegin)
            {
                unitSuiteBegin(
                    script_get_name(testSuiteSet[testSuiteCurrent * 2 + 0]) + ' (' + testSuiteSet[testSuiteCurrent * 2 + 1] + ')',
                    testSuiteSet[testSuiteCurrent * 2 + 0]
                );
                suiteBegin = false;
            }

            // perform test suite step update
            if (unitSuiteTick())
            {
                suiteBegin = true;
                ds_list_add(unitTestFullResults, global.unitTestSuiteResults);
                testSuiteCurrent++;
                if (global.unitTestAbortAll)
                {
                    testSuiteCurrent = testSuiteN;
                }
                continue;
            }
            else
            {
                break;
            }
        }
        else
        {
            if (global.unitTestAbortAll)
            {
                global.unitTestGlobalErrorSummaryResult = 3;
            }
            runTests = false;
            displayResults = true;
            scroll = 0;
            scrollX = 0;
            break;
        }
    }

    if (!runTests)
    {
        // save test results
        event_user(0);
    }
}
else if (displayResults || displayMessage)
{
    // scroll input
    scroll += (global.keyDown[0] - global.keyUp[0] + 5 * (global.keyWeaponSwitchRight[0] - global.keyWeaponSwitchLeft[0])) * 4;
    scroll = max(scroll, 0);
    scrollX -= (global.keyLeft[0] - global.keyRight[0]) * 4;
    scrollX = max(scrollX, 0);

    // exit
    if (global.keyShoot[0])
    {
        instance_destroy();
        exit;
    }

    // begin tests on command:
    else if (displayMessage && global.keyPausePressed[0])
    {
        testResultsFile = get_save_filename("text file|*.txt", "unitTestResults.txt")
        if (testResultsFile != "")
        {
            scrollX = 0;
            scroll = 0;
            displayMessage = false;
            runTests = true;
            testingBegin = true;
            suiteBegin = true;
        }
        else
        {
            playSFX(sfxError);
        }
    }
}
else
{
    // TODO: menu
}

//@noformat
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// output results to file

if (!writeToFile)
{
    exit;
}
var file = file_text_open_write(testResultsFile)
if (file >= 0)
{
    var newLine = "
";
    var out = "";
    out += "Tests last run: " + getTimeStamp(timezone_utc);
    out += newLine;
    out += "Test result summary: ";
    switch(global.unitTestGlobalErrorSummaryResult)
    {
        case 0:
            out += "success";
            break;
        case 1:
            out += "success (with warnings)";
            break;
        case 2:
            out += "failure";
            break;
        case 3:
            out += "critical failure"
            break;
    }

    var indent;
    for (var i = 0; i < ds_list_size(unitTestFullResults); i++)
    {
        var suiteResult = ds_list_find_value(unitTestFullResults, i);
        var cases = suiteResult.unitTestCaseResults;

        out += newLine + newLine + "===========================" + newLine;
        out += "Suite: " + suiteResult.suiteName + newLine;
        indent = "  "
        for (var j = 0; j < ds_list_size(cases); j++)
        {
            var result = ds_list_find_value(cases, j);
            indent = "    "
            out += indent + "Case: " + result.caseName + newLine;;
            indent = "      "
            var status = "PASSED";
            var next = "";
            if (ds_list_size(result.warnings) > 0)
            {
                indent = "      ";
                status = "WARNING"
                next += indent + "Warnings:" + newLine;
                indent += "  ";
                for (var k = 0; k < ds_list_size(result.warnings); k++)
                {
                    out += indent + "- " + ds_list_find_value(result.warnings, k) + newLine;
                }
            }
            if (ds_list_size(result.errors) > 0)
            {
                indent = "      ";
                status = "ERROR"
                next += indent + "Errors:" + newLine;
                indent += "  ";
                for (var k = 0; k < ds_list_size(result.errors); k++)
                {
                    out += indent +  "- " + ds_list_find_value(result.errors, k) + newLine;
                }
            }
            indent = "      ";
            out += indent + status + newLine;
            out += next;
        }
    }
    out += newLine;

    file_text_write_string(file, out);
    file_text_close(file);
}

//@noformat
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
clearDrawState();

if (displayMessage)
{
    draw_y = -scroll;
    draw_x = 24 - scrollX;
    draw_text(draw_x, draw_y, message);
}
if (runTests)
{
    draw_set_halign(fa_right);
    draw_text(view_wview[0] + view_xview[0], view_yview[0], "UNIT TEST#" + global.unitSuiteName + "#@" + global.unitTestCase);
}
if (displayResults)
{
    draw_set_halign(fa_left);
    draw_y = -scroll;
    draw_x = 16 - scrollX;
    draw_indent = 0;
    draw_spacing = 12;

    // header
    draw_text(draw_x, draw_y, "Test Complete");
    draw_y += 16;
    switch (global.unitTestGlobalErrorSummaryResult)
    {
        case 0:
            draw_set_color(c_green);
            draw_text(draw_x, draw_y, "All Tests Passed!");
            draw_y += 16;
            break;
        case 1:
            draw_set_color(c_yellow);
            draw_text(draw_x, draw_y, "Tests passed with warnings");
            draw_y += 16;
            draw_text(draw_x, draw_y, "Please investigate and report cause.");
            draw_y += 16;
            break;
        case 2:
            draw_set_color(c_red);
            draw_text(draw_x, draw_y, "Tests failed");
            draw_y += 16;
            draw_text(draw_x, draw_y, "Do not push to master until");
            draw_y += 16;
            draw_text(draw_x, draw_y, "all the errors are fixed, or");
            draw_y += 16;
            draw_text(draw_x, draw_y, "unit tests have been adjusted to");
            draw_y += 16;
            draw_text(draw_x, draw_y, "accept the new behaviour.");
            draw_y += 16;
            break;
        case 3:
            draw_set_color(c_purple);
            draw_text(draw_x, draw_y, "CRITICAL ERROR!");
            draw_y += 16;
            draw_text(draw_x, draw_y, "Unit tests could not finish due to a critical");
            draw_y += 16;
            draw_text(draw_x, draw_y, "test failure. Most likely a major change in");
            draw_y += 16;
            draw_text(draw_x, draw_y, "physics has occurred, causing some unit");
            draw_y += 16;
            draw_text(draw_x, draw_y, "test to be broken.");
            draw_y += 16;
            draw_y += 16;
            draw_text(draw_x, draw_y, "If the behaviour change is intended,");
            draw_y += 16;
            draw_text(draw_x, draw_y, "you must edit the unit tests to require");
            draw_y += 16;
            draw_text(draw_x, draw_y, "the new behaviour.");
            draw_y += 16;
            break;
    }
    draw_y += 8;

    draw_indent = 16;

    // draw all results
    for (var i = 0; i < ds_list_size(unitTestFullResults); i++)
    {
        var suiteResult = ds_list_find_value(unitTestFullResults, i);
        var cases = suiteResult.unitTestCaseResults;

        // draw suite name
        draw_set_color(c_white);
        draw_text(draw_x, draw_y, suiteResult.suiteName);
        draw_y += draw_spacing;

        // draw cases
        for (var j = 0; j < ds_list_size(cases); j++)
        {
            var result = ds_list_find_value(cases, j);

            // draw case name
            draw_set_color(c_green);
            if (ds_list_size(result.warnings) > 0)
                draw_set_color(c_yellow);
            if (ds_list_size(result.errors) > 0)
                draw_set_color(c_red);
            draw_text(draw_x + draw_indent, draw_y, result.caseName);
            draw_y += draw_spacing;

            // draw warnings
            draw_set_color(c_yellow);
            for (var k = 0; k < ds_list_size(result.warnings); k++)
            {
                var drawString = "- " + ds_list_find_value(result.warnings, k)
                    ;
                draw_text(draw_x + draw_indent * 2, draw_y, drawString);
                draw_y += string_height(drawString) + 4;
            }

            // draw errors
            draw_set_color(c_red);
            for (var k = 0; k < ds_list_size(result.errors); k++)
            {
                var drawString = "- " + ds_list_find_value(result.errors, k)
                    ;
                draw_text(draw_x + draw_indent * 2, draw_y, drawString);
                draw_y += string_height(drawString) + 4;
            }
        }
    }

    // fatal marker
    if (global.unitTestGlobalErrorSummaryResult == 3)
    {
        draw_set_color(c_purple);
        draw_text(draw_x + draw_indent, draw_y, "The above error is fatal.");
        draw_y += 16;
    }
}

clearDrawState();