component extends="taffy.core.resource" taffy_uri="/authenticate/{apiKey}" {

    function get(required string apiKey){

        // Check if the provided API key is valid
        local.apiKeyValid = application.apiKey eq arguments.apiKey;

        // Return 401 when api key isn't valid
        if(not local.apiKeyValid){
            return noData().withStatus(401);
        }

        local.validUntil = dateAdd("s", 60, now())

        local.startDate = createdatetime( '1970','01','01','00','00','00');
        local.unixStamp = datediff("s", local.startDate, local.validUntil);

        local.payload = {
            "iss": application.issJWT,
            "iat": now(),
            "exp": local.unixStamp
        }

        local.enocodedJWT = application.jwt.encode(local.payload, application.apiSecret, 'HS256');

        return rep(["token" : local.enocodedJWT]);
    }

}