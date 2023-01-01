component extends="taffy.core.resource" taffy_uri="/deleteBook/{bookId}" {
    
    function delete(required numeric bookId) {

        if(len(application.bookStruct.books) < 1){
            return rep("No books available!").withStatus(500);
        }

        application.bookStruct.books.deleteAt(arguments.bookId);
        return noData().withStatus(200);
    }
}