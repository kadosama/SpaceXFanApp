import RealmSwift

class FavoriteRocket : Object {
    @Persisted(primaryKey: true) var id : String = ""
    @Persisted var user_id: String = ""

}

//class Account : Object  {
//    @Persisted(primaryKey: true) var userID : String = ""
//}

