component extends="taffy.core.resource" taffy_uri="/deleteBook/{bookId}" {
    
    function delete(required numeric bookId) {        
        application.bookStruct.books.deleteAt(arguments.bookId);
        return noData().withStatus(200);
    }
}