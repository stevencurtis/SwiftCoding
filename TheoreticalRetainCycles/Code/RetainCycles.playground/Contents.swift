import UIKit


//class Book {
//    private var pages = [Page]()
//
//    func add(_ page : Page) {
//        pages.append(page)
//    }
//}
//
//class Page {
//    private var book : Book
//
//    required init(book : Book) {
//        self.book = book
//    }
//}
//
//let book = Book()
//let page = Page(book: book)
//book.add(page)


//class Tutorial {
//    private var students = [Student]()
//    func enroll(_ student: Student) {
//        students.append(student)
//    }
//    init() {
//        print ("Tutorial initialized")
//    }
//    deinit {
//        print ("Tutorial deinitialized")
//    }
//}
//
//class Student {
//    private var tutorial : Tutorial
//    private var name : String
//    init(tutorial: Tutorial, name: String) {
//        print ("Tutorial initialized")
//        self.tutorial = tutorial
//        self.name = name
//    }
//    deinit {
//        print ("Tutorial deinitialized")
//    }
//}
//
//var computing : Tutorial? = Tutorial()
//var dave : Student? = Student(tutorial: computing!, name: "Dave")
//computing?.enroll(dave!)
//computing = nil
//dave = nil




//struct Book {
//    var pages = [Page]()
//
//    mutating func add(_ page : Page) {
//        pages.append(page)
//    }
//}
//
//struct Page {
//    private var book : Book
//
//    init(book : Book) {
//        self.book = book
//    }
//}
//
//var book = Book()
//let page = Page(book: book)
//book.add(page)
//book.pages.count


//struct Tutorial {
//    private var students = [Student]()
//    mutating func enroll(_ student: Student) {
//        students.append(student)
//    }
//}
//
//struct Student {
//    var tutorial : Tutorial
//    var name : String
//    init(tutorial: Tutorial, name: String) {
//        self.tutorial = tutorial
//        self.name = name
//    }
//}
//
//var computing : Tutorial? = Tutorial()
//var dave : Student? = Student(tutorial: computing!, name: "Dave")
//computing?.enroll(dave!)
//dave?.name



//print (computing)
//computing = nil
//dave = nil




//class TestClass {
//
//    weak var testClass: TestClass? = nil //Now this is a weak reference!
//
//    init() {
//        print("init")
//
//    }
//
//    deinit {
//        print("deinit")
//    }
//
//}
//
//var testClass1: TestClass? = TestClass()
//var testClass2: TestClass? = TestClass()
//
//testClass1?.testClass = testClass2
//testClass2?.testClass = testClass1
//
//testClass1 = nil
//testClass2 = nil





class Tutorial {
    private var students = [Student]()
    func enroll(_ student: Student) {
        students.append(student)
    }
    func releaseStudents(){
        students.removeAll()
    }
    init() {
        print ("Tutorial initialized")
    }
    deinit {
        print ("Tutorial deinitialized")
    }
}

class Student {
    weak var tutorial : Tutorial? = nil
    private var name : String
    init(tutorial: Tutorial, name: String) {
        print ("Student initialized")
        self.tutorial = tutorial
        self.name = name
    }
    deinit {
        self.tutorial!.releaseStudents()
        self.tutorial = nil
        print ("Student deinitialized")
    }
}

var computing : Tutorial? = Tutorial()
var dave : Student? = Student(tutorial: computing!, name: "Dave")
computing?.enroll(dave!)
computing = nil
dave = nil

