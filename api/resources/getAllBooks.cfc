component extends="taffy.core.resource" taffy_uri="/getAllBooks" {

    function get(){
        return rep(application.books).withStatus(200);
    }
}