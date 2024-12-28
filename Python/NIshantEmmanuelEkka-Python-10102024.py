class BookLimitExceed(Exception):
    def __init__(self, name):
        super().__init__(f"Book limit exceeded for memeber: {name} Cannot borrow more books")


class Book:
    def __init__(self, book_id, title, author):
        if not title or not author:
            raise ValueError("Title and Author are required")
        
        self.book_id = book_id
        self.title = title
        self.autor = author
        self.available = True

    def borrow_book(self):
        if self.available:
            self.available = False
            return "Book borrowed successfully"
        return "Book is not available"
    
    def return_book(self):
        if not self.available:
            self.available = True
            return "Book returned successfully"
        return "Book is already available"
    

class Member:
    def __init__(self, member_id, name):
        if not name:
            raise ValueError("Name is required")
        
        self.member_id = member_id
        self.name = name
        self.borrowed_books = []
        self.max_books = 3

    def borrow_book(self, book):
        if len(self.borrowed_books) >= self.max_books:
            raise BookLimitExceed(self.name)
        if not book.available:
            raise ValueError("Book is not available")
        self.borrowed_books.append(book)
        book.borrow_book()

    def return_book(self, book):
        self.borrowed_books.remove(book)
        book.return_book()

    def __str__(self):
        return f"{self.name} has borrowed {len(self.borrowed_books)} books"
    
    def books_borrowed(self):
        temp = []
        for book in self.borrowed_books:
            temp.append(book.title)
        return temp

class PremiumMember(Member):
    def __init__(self, member_id, name):
        super().__init__(member_id, name)
        self.max_books = 5

class Library:
    def __init__(self):
        self.book_collection = []
        self.members = []

    def add_book(self, book):
        self.book_collection.append(book)
    
    def register_member(self, member):
        self.members.append(member)

    def lend_book(self, member, book_id):
        book = None
        for b in self.book_collection:
            if b.book_id == book_id:
                book = b
                break
        if book is None:
            raise ValueError(f"Book with id {book_id} not found")
        
        member.borrow_book(book)

    def recieve_return(self, member, book_id):
        book = None
        for b in self.book_collection:
            if b.book_id == book_id:
                book = b
                break
        if book is None:
            raise ValueError(f"Book with id {book_id} not found")
        
        member.return_book(book)



if __name__ == "__main__":
    library = Library()

    book1 = Book(1, "1984", "George Orwell")
    book2 = Book(2, "Brave New World", "Aldous Huxley")
    book3 = Book(3, "Animal Farm", "George Orwell")
    book4 = Book(4, "The Great Gatsby", "F. Scott Fitzgerald")
    book5 = Book(5, "To Kill a Mockingbird", "Harper Lee")
    book6 = Book(6, "86", "Asato Asato")

    library.add_book(book1)
    library.add_book(book2)
    library.add_book(book3)
    library.add_book(book4)
    library.add_book(book5)
    library.add_book(book6)

    member1 = Member(1, "John Doe")
    member2 = PremiumMember(2, "Jane Doe")

    library.register_member(member1)
    library.register_member(member2)


    library.lend_book(member1, 1)
    library.lend_book(member1, 2)
    library.lend_book(member1, 3)

    library.lend_book(member2, 4)
    library.lend_book(member2, 5)
    library.lend_book(member2, 6)
    print(str(member1))
    print(str(member2))
    print(member1.books_borrowed())
    print(member2.books_borrowed())

    library.recieve_return(member1, 1)
    library.recieve_return(member2, 6)
    print(member1.books_borrowed())
    print(member2.books_borrowed())
    