trigger newClassTrigger on OpportunityContactRole (after insert,after update) {
    fetchContactRolesNewClass.fetchContactRolesNewClass(trigger.new);
}