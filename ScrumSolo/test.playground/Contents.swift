import UIKit
import FMDB


class Item:CustomDebugStringConvertible {
    var id:UInt64?
    var title:String
    init(_ title:String){
        self.title = title
    }
    
    static var db = Database(filename: "test.db")
    class var all:[Item]{
        return db.query("select * from items", map: { (rst) -> Item in
            let item = Item(rst.string(forColumn: "title") ?? "")
            item.id = rst.unsignedLongLongInt(forColumn: "id")
            return item
        })
    }
    func save()->Bool{
        if db.exe("INSERT INTO items (title) VALUES (?)", args: [self.title])
        {
            print("inserted")
            id = db.query("select last_insert_rowid() as id from items"){$0.unsignedLongLongInt(forColumn: "id")}.first
            print("get back \(String(describing: id))")
            return true
        }
        return false
    }
    
    var debugDescription: String{
        return "Item(title:\(self.title),id:\(id ?? .max))"
    }
}


extension Item{
    unowned var db:Database{
        return Item.db
    }
}

class Database {
    
    private var db:FMDatabase
    init(filename:String){
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)
        let path = paths.first!.appending("/\(filename)")
        db = FMDatabase(path: path)
        db.open()
        
        // type 
        // 0 - story
        // 1 - task
//        clear()
        db.executeStatements("CREATE TABLE IF NOT EXISTS items (id INTEGER PRIMARY KEY, title TEXT, type INTEGER DEFAULT 0)")
    }
    
    func exe(_ sql:String, args:[Any]! = nil)->Bool{
        do {
            try db.executeQuery(sql, values: args).next()
            return true
        }catch _ {
            return false
        }
    }
    
    func query<T>(_ sql:String, args:[Any]! = nil, map black:(FMResultSet)->T)->Array<T>{
        var result:Array<T> = []
        if let rs = try? db.executeQuery(sql, values: args) {
            while rs.next() {
                result.append(black(rs))
            }
        }
        return result
    }
    
    func clear(){
        db.executeStatements("DROP TABLE IF EXISTS items")
    }
}

let item = Item("hello")
item.save()
print(item)
