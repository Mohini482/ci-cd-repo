trigger Task4Trigger on Opportunity(after insert) {
    Task4.Task4(trigger.new);
}