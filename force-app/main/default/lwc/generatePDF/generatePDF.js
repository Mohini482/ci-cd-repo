import { LightningElement } from 'lwc';
import { loadScript } from 'lightning/platformResourceLoader';
import downloadjs from '@salesforce/http://danml.com/download.html/downloadjs';
import downloadPDF from '@salesforce/apex/generatePdfController.getPdfFileAsBase64String';

export default class GeneratePDF extends LightningElement {
    boolShowSpinner = false;
    pdfString;
    generatePdf(){
        this.boolShowSpinner = true;
        downloadPDF({}).then(response => {
            console.log(response);
            this.boolShowSpinner = false;
            var strFile = "data:application/pdf;base64,"+response;
            window.download(strFile, "sample.pdf", "application/pdf");

        }).catch(error => {
            console.log('Error: ' +error.body.message);
        });
    }
    renderedCallback() {
        loadScript(this, downloadjs)
        .then(() => console.log('Loaded download.js'))
        .catch(error => console.log(error));
}
}