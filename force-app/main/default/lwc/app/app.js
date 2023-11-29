/* import module elements :
lwc - module , lightningElement - class */
import { LightningElement } from 'lwc';

// declare class to expose the component
export default class App extends LightningElement {
   name = 'Electra X4';
   description = 'A sweet bike built for comfort.';
   category = 'Mountain';
   material = 'Steel';
   price = '$2,700';
   pictureUrl = 'https://s3-us-west-1.amazonaws.com/sfdc-demo/ebikes/electrax4.jpg';
   /* you want to display data, but you know it can take some time to load. You can use if:false and 
   if:true conditional directives within your template to determine which visual elements are rendered.
   The content in the “display” div tag doesn’t appear until the value of ready is true in the HTML file.
   This holds our data values and sets a 3-second timer. After 3 seconds, the content should appear. */

   // use lifecycle hook

   ready = false;
   connectedCallback() {
       setTimeout(() => {
           this.ready = true;
       }, 3000);

     /*  LightningElement is the base class for Lightning web components, which allows us to use 
     connectedCallback(). The connectedCallback() method is one of our lifecycle hooks. 
      
     Lifecycle Hooks -
     Lightning Web Components provides methods that allow you to “hook” your code up to critical events
     in a component’s lifecycle. These events include when a component is:
     Created ,Added to the DOM, Rendered in the browser ,Encountering errors,Removed from the DOM
     
     Respond to any of these lifecycle events using callback methods. For example, the connectedCallback() 
     is invoked when a component is inserted into the DOM. The disconnectedCallback() is invoked when 
     a component is removed from the DOM.

       
     Decorators -
     Decorators are often used in JavaScript to modify the behavior of a property or function.
     To use a decorator, import it from the lwc module and place it before the property or function.
     You can import multiple decorators, but a single property or function can have only one decorator.
     For example, a property can’t have @api and @wire decorators.

     Code : import { LightningElement, api } from 'lwc';
            export default class MyComponent extends LightningElement{
            @api message;
        }


        1. @api: Marks a field as public. Public properties define the API for a component. 
           All public properties are reactive, which means that the framework observes the property for changes.
           When the property’s value changes, the framework reacts and rerenders the component.
        
        2. @track: Tells the framework to observe changes to the properties of an object or to the elements of an array.
           Use @track only if a field contains an object or an array and if you want the framework to observe changes to
         the properties of the object or to the elements of the array.
         If you want to change the value of the whole property, you don’t need to use @track.

         3. @wire: Gives you an easy way to get and bind data from a Salesforce org.

         Ex : @api decorator to render a value from one component (bike) in another component (app).

         <!-- app.html -->
         <template>
             <div>
              <c-bike bike={bike}></c-bike>
              </div>
             </template>


            // app.js
            import { LightningElement } from 'lwc';
            export default class App extends LightningElement {
            bike = {
            name: 'Electra X4',
             picture: 'https://s3-us-west-1.amazonaws.com/sfdc-demo/ebikes/electrax4.jpg'
               };
             }

            <!-- bike.html -->
            <template>
              <img src={bike.picture} alt="bike picture" />
                <p>{bike.name}</p>
              </template>

            // bike.js
            import { LightningElement, api } from 'lwc';
            export default class Bike extends LightningElement {
             @api bike;
               }



               .js-meta.xml. This file provides metadata for Salesforce, 
               including the design configuration for components intended for use in Lightning App Builder.

               isExposed ( true or false) makes the component available from other namespaces.
                Only set this to true to make a Lightning component usable in these specific cases:


                Optional targets specify which types of Lightning pages the component can be added to in 
                the Lightning App Builder.

                 targetConfigs let you specify behavior specific to each type of Lightning page, including 
                 things like which objects support the component.
                  */
}
}