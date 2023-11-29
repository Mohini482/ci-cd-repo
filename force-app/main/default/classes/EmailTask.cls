public class EmailTask {
   public static void emailMethod()
   {
       EmailTemplate[] emailTemplate = [SELECT Id, Subject, HtmlValue, Body FROM EmailTemplate WHERE DeveloperName = 'random_number'];
Messaging.SingleEmailMessage email = Messaging.renderStoredEmailTemplate(emailTemplate[0].id, '0035g00000BPhtMAAT', '0015g00000Jc6TXAAZ');
//system.debug();
String templateHtmlBody = email.getPlainTextbody();
Integer i = Integer.valueof((Math.random() * 100));
string qwer = String.valueOf(i);
templateHtmlBody=templateHtmlBody.replace('OTP',qwer);
email.setHtmlBody(templateHtmlBody);
system.debug(email.getHTMLbody());
Messaging.sendEmail(new list<Messaging.SingleEmailMessage>{email});
   }
}