//Contact Trigger

trigger ContactAccountTrigger on contact (after update) {
if(!contactTriggerHandler.recursionAcc)
{
    contactTriggerHandler.recursionAcc=true;
    contactTriggerHandler.contactMethod(trigger.new);
}
}