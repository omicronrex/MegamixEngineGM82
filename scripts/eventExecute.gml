/// scrEventExecute(event, subEvent, target, [asObject], [eventArgs])
// invokes an event on the given instance
// if asObject is true (default: false), then invokes the event on the base object
// rather than the instance.
// if the eventArgs argument is supplied, sets global.eventArgs to the given value.
// this is useful for passing additional information to the given custom event call.

var event; event = argument[0];
var subEvent; subEvent = argument[1];
var target; target = argument[2];
var asObject; asObject = false;
if (argument_count > 3)
{
    asObject = argument[3];
}
if (argument_count > 4)
{
    global.eventArgs = argument[4];
}

if (asObject)
{
    event_perform_object(target, event, subEvent);
}
else
{
    with (target)
    {
        event_perform(event, subEvent);
    }
}
