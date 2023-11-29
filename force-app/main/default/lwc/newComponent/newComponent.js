import { LightningElement, api} from 'lwc';

export default class newComponent extends LightningElement {
    @api recordId
     
    @api invoke()
    {
        console.log("invoked",this.recordId)
        Window.open("https://google.com","_blank")
    }
    
}