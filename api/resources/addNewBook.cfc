component extends="taffy.core.resource" taffy_uri="/addNewBook" {
    
    function post() {

        if(!structKeyExists(request._taffyrequest, "bodyargs")){
            return noData().withStatus(400);
        }
        
        application.books.books.append(request._taffyrequest.bodyargs, true);
        return noData().withStatus(201);
    }
}