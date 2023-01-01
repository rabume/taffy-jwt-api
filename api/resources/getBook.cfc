component extends="taffy.core.resource" taffy_uri="/getBook/{bookId}" {

    function get(required numeric bookId){

        if(arguments.bookId > len(application.bookStruct.books) || arguments.bookId == 0){
            return noData().withStatus(400);
        }

        return rep(application.bookStruct.books[arguments.bookId]).withStatus(200);
    }
}