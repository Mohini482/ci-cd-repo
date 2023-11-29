@RestResource(urlMapping ='/LeadCreate/')
global class ExternalSystemtoSF {
@HTTPPost
    global static String doPost()
    {
        String fieldValue;
        String fieldName;
        String fName;
        String lName;
        String comp;
        
        List<String> leadList = new String[3];
        
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        
        System.debug('Param is :'+ request.params);
        System.debug('Param is :'+ request.requestBody);
        
        String arr = request.requestBody.toString();
        
        JSONParser parser = JSON.createParser(arr);
        While(Parser.nextToken()!=null)
        {
            if(Parser.getCurrentToken()!=JSONToken.END_OBJECT)
            {
                parser.nextValue();
                fieldName = parser.getCurrentName();
                fieldValue = parser.getText();
                
                if(fieldName=='First Name')
                {
                    fName= parser.getText();
                }
                
              else if(fieldName=='Last Name')
                {
                    lName= parser.getText();
                }
                
              else if(fieldName== 'Company')
                {
                    comp = parser.getText();
                }
                
            }
        }
    
        lead lc = new lead(firstName = fName, lastName = lName, Company = comp);
        insert lc;
        return lc.Id;
    }
}