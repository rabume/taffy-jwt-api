component extends="taffy.core.api" {

    include "../config.cfm";

    // JWT
    application.jwt = new jwt.models.jwt();
    application.apiSecret = variables.apiSecret;
    application.issJWT = variables.apiName;
    application.apiKey = variables.globalApikey;

    // Add mappings for taffy
    this.mappings["/resources"] = expandPath("./resources");
    this.mappings["/taffy"] = expandPath("./taffy");
    
    // Set timezone
    setTimezone("UTC+00:00");

    // Set taffy framework settings
    variables.framework = {
        reloadKey = "reload",
        reloadPassword = variables.reloadPassword,
        reloadOnEveryRequest = false,
        disableDashboard = true,
        disabledDashboardRedirect = "/",
    }; 

    // this function is called after the request has been parsed and all request details are known
    function onTaffyRequest(verb, cfc, requestArguments, mimeExt, headers){

        if(arguments.cfc eq "authenticate") {
            return true;
        }

        // Check if authorization header exists
        if(not structKeyExists(arguments.headers, "Authorization")){
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
        if(not local.IsValidToken){
            return noData().withStatus(401);
        }

        return true;
    }

}