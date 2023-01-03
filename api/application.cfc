component extends="taffy.core.api" {

    include "../config.cfm";

    // Set global variables
    application.apiSecret = variables.apiSecret;
    application.issJWT = variables.apiName;
    application.apiKey = variables.globalApikey;

    // Add mappings for taffy
    this.mappings["/resources"] = expandPath("./resources");
    this.mappings["/taffy"] = expandPath("./taffy");
    
    // Set taffy framework settings
    variables.framework = {
        reloadKey = "reload",
        reloadPassword = variables.reloadPassword,
        reloadOnEveryRequest = false,
        disableDashboard = true,
        disabledDashboardRedirect = "/",
    }; 

    function onApplicationStart() {

        // Initialize jwt-cfml
        application.jwt = new jwt.models.jwt();

        // Set timezone
        setTimezone("UTC+00:00");

        /*     
            Defines a array that stores data in a way that is not persistent across application 
            restarts or reinitializations. In a production environment, it would be more appropriate 
            to store this data in a database or other persistent storage solution to ensure its availability 
            beyond a single execution of the application.
        */
        application.bookStruct = {
            "books": [
                {
                    "name": "Harry Potter and the Goblet of Fire",
                    "author": "J.K. Rowling",
                    "pages": "734"
                },
                {
                    "name": "Harry Potter and the Order of the Phoenix",
                    "author": "J.K. Rowling",
                    "pages": "912"
                },
                {
                    "name": "The Lord of the Rings",
                    "author": "J.R.R. Tolkien",
                    "pages": "1216"
                },
                {
                    "name": "The Fellowship of the Ring",
                    "author": "J.K. Rowling",
                    "pages": "432"
                },
            ]   
        }

        // Needed to not completly override the onApplicationStart() from taffy
        super.onApplicationStart();
    }
    

    // This function is called after the request has been parsed and all request details are known
    function onTaffyRequest(verb, cfc, requestArguments, mimeExt, headers){
        
        if(arguments.cfc == "authenticate") {
            return true;
        }
        
        // Check if authorization header exists
        if(!structKeyExists(arguments.headers, "Authorization")){
            return noData().withStatus(401);
        }
        
        // Remove bearer keyword and parse only token
        local.token = trim(ReplaceNoCase(arguments.headers.Authorization, "Bearer", ""));

        // Check if token is valid
        try {
            local.decodedJWT = application.jwt.decode(local.token, application.apiSecret, "HS256")
            local.isValidToken = true;
        }catch(any e) {
            local.isValidToken = false;
        }

        // Return 401 when token isn't valid
        if(!local.IsValidToken){
            return noData().withStatus(401);
        }

        return true;
    }

}