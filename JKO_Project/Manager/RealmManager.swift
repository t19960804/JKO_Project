import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    private var realmDB = try! Realm()
    
    private init() {
        
    }
    
    func replaceRealDB(db: Realm) {
        self.realmDB = db
    }
    
    func save(_ item: Object) {
        do {
            try realmDB.write {
                realmDB.add(item)
            }
        } catch {
            print("Warning - Can't write data in realm:\(error)")
        }
    }
    
    func fetch<Element: Object>(_ type: Element.Type) -> Results<Element> {
        let objects = realmDB.objects(Element.self)
        return objects
    }
    
    func update(handler: (() -> Void)) {
        do {
            try realmDB.write {
                handler()
            }
        } catch {
            print("Warning - Can't update data in realm:\(error)")
        }
    }
    
    func delete(_ item: Object) {
        do {
            try realmDB.write {
                realmDB.delete(item)
            }
        } catch {
            print("Warning - Can't delete data in realm:\(error)")
        }
    }
}

