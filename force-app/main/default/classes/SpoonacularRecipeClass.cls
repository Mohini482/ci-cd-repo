public class SpoonacularRecipeClass {
    public static void Receipe()
    {
        HTTP http = new HTTP();
         HTTPRequest request = new HTTPRequest();
        //Sign in to the site and enter your api secret token after( random?api_key='') in the link.
         request.setEndpoint('https://api.spoonacular.com/recipes/random');
         request.setMethod('GET');
        
         HTTPResponse response = http.send(request);
        System.debug('Response Code' + response.getStatusCode());
        if(response.getStatusCode() == 200)
        {
            System.debug('Response' + response.getBody());
        }
    }
}