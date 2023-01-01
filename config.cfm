<cfscript>
    variables.apiName = "Example-API";

    // Generate a secure secret
    variables.apiSecret = "verySecureSecretThatYouShouldNeverUse";

    /* 
    For this example I hardcoded an API key.
    In a real life scenario you should always generate them
    for each user seperatly and store them secure. 
    */
    
    variables.globalApikey = "youShouldNeverUseGlobalHardcodedApiKeys"
</cfscript>