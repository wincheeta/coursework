global books
global borrowed_books 
books = {}
borrowed_books = {}

def borrow_book(book_name: str):
    try:
        if books[book_name] <= 0:
            print("No copies available for borrowing.")
            raise RuntimeError("No copies available for borrowing.")
        else:
            books[book_name] -= 1
        
        if book_name in borrowed_books.keys():
            borrowed_books[book_name] += 1
        else:
            borrowed_books[book_name] = 1
        print(f"Borrowed '{book_name}'.")
    except Error:
        #print("Book not found in the library.")
        raise ValueError("Book not found in the library.")
    
def return_book(book_name: str):
    try:
        if borrowed_books[book_name] == 1:
            del borrowed_books[book_name]
        else:
            borrowed_books[book_name] -= 1
        books[book_name] += 1
        print(f"Returned '{book_name}'.")
    except:
        print("This book was not borrowed.")
        RuntimeError("This book was not borrowed.")


def test_borrow_book():
    try:	
        books = {'Python Basics': 3, 'Data Science': 2, 'Algorithms': 1}
        borrow_book('Python Basics')
        return True
    except:
        raise ValueError
def test_borrow_book_not_found():
    books = {}
    borrowed_books = {}
    try:
        borrow_book ("AWDA")
        raise ValueError
    except:
        return True

def test_return_book():
    try:
        borrowed_books = {'Python Basics': 3, 'Data Science': 2, 'Algorithms': 1}
        return_book('Python Basics')
        return True
    except:
        raise ValueError

def test_return_book_not_borrowed():
    books = {}
    borrowed_books = {}
    try:
        return_book("AWDA")
        raise ValueError
    except:
        return True
    

    NameError