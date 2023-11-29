// Account Trigger

trigger AccountContactTrigger on Account (after update) {
if(!accountTriggerHandler.recursionAcc)
{
    accountTriggerHandler.recursionAcc=true;
    accountTriggerHandler.accountMethod(trigger.new, trigger.oldMap);
}
}