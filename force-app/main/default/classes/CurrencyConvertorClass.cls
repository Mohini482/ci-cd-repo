public class CurrencyConvertorClass 
{
    
   public static Decimal ConvertCurrencytoINR(Decimal eur)
     {
         //API Callout 
         Decimal inr = 0.0;
         HTTP h = new HTTP();
         HTTPRequest req = new HTTPRequest();
         req.setEndpoint('');
         req.setMethod('GET');
         HTTPResponse res = h.send(req);
         
         //In response, we got JSON body & then we deserialize and converted into map.
         Map<String,Object> jsonBody = (Map<String,Object>) Json.deserializeUntyped(res.getBody());
         System.debug(jsonBody);
        Map<String,Object> mMap = (Map<String,Object>) jsonBody.get('rates');
         
        Decimal conversionRate = (Decimal) mMap.get('INR');
         inr = eur * conversionRate;
         return inr ;
                         
      
      }
}