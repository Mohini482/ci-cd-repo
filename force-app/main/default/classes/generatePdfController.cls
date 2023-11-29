public with sharing class generatePdfController {
    @AuraEnabled
    public static string getPdfFileAsBase64String(){
      
        PageReference pdfPage = Page.envelope;
        Blob pdfBlob = pdfPage.getContent();
        String base64Pdf = EncodingUtil.base64Encode(pdfBlob);
        return base64Pdf;

     
      
    }
}

