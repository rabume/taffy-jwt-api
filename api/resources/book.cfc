component extends="taffy.core.resource" taffy_uri="/book" {

    function get(){
        local.bookStruct = {
            "book": {
                "name": "Herr der Ringe",
                "author": "Tokien",
                "pages": "803"
            }
        }

        return rep(local.bookStruct);
    }

}