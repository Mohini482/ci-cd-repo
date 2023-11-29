import { LightningElement, api} from 'lwc';
import { CloseActionScreenEvent } from 'lightning/actions';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { createRecord } from 'lightning/uiRecordApi';
import createAccount from '@salesforce/apex/AccountHelper.createAccount';

export default class CallingANapexClassFromQuickAction extends LightningElement {
    @api recordId;
    name = '';
    phone = '';
    isSpinner = false;


    handleChange = event => {
        event.preventDefault();
        let name = event.target.name;
        let value = event.target.value;
        if(name === 'name'){
            this.name = value;
        }else{
            this.phone = value;
        }
    }

    closeAction(){
        this.dispatchEvent(new CloseActionScreenEvent());
    }

    handleSave(event){
        console.log('data', this.recordId, this.name, this.phone);
        this.isSpinner = true;
        event.preventDefault();
        createAccount({
            name: this.name,
            phone: this.phone,
            parentRecordId : this.recordId,
        }).then(response => {
            console.log('response', response);
            console.log('account record id', this.recordId);
            this.dispatchEvent(new ShowToastEvent({
                title: 'Success',
                message: 'Account Created',
                variant: 'success'
            }));
            this.closeAction();
        }).catch(error => {
            console.log("error", error);
        }).finally(() => {
            this.isSpinner = false;
        });
    }
}

