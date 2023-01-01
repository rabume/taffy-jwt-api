component extends="taffy.core.resource" taffy_uri="/books" {

    function get(){
        local.bookStruct = {
            "books": {
                "Harry Potter": [
                    {
                        "name": "Harry Potter and the Goblet of Fire",
                        "author": "J.K. Rowling",
                        "pages": "734"
                    },
                    {
                        "name": "Harry Potter and the Order of the Phoenix",
                        "author": "J.K. Rowling",
                        "pages": "912"
                    }
                ],
                "Lord of the Rings": [
                    {
                        "name": "The Lord of the Rings",
                        "author": "J.R.R. Tolkien",
                        "pages": "1216"
                    },
                    {
                        "name": "The Fellowship of the Ring",
                        "author": "J.K. Rowling",
                        "pages": "432"
                    }
                ]
            }       
        }

        return rep(local.bookStruct);
    }

}