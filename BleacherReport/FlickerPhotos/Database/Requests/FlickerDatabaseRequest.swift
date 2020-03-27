

import Foundation
import RealmSwift

class FlickerDatabaseRequest: NSObject{
    
    var mDispatchQueue: DispatchQueue?
    
    func saveFlickerData(data: [PhotoModel]? ){
        
        if mDispatchQueue == nil{
            mDispatchQueue = DispatchQueue.main //TODO:: performance , we need to convert this ti background
        }
        
        mDispatchQueue?.async {
            let realm = try! Realm()
            realm.beginWrite()
            
            if let dataArray = data {
                for itemModel in dataArray {
                    let dataModel: PhotoModel = itemModel
                    realm.add(dataModel)
                }
            }
            try! realm.commitWrite()
        }
    }
    
    func getFlickerData() -> [PhotoModel]?{
        let realm = try! Realm()
        return  realm.objects(PhotoModel.self).toArray()
    }
    
    func deleteFlickerData() {
        mDispatchQueue?.async {
            let realm = try! Realm()
            realm.beginWrite()
            realm.delete(realm.objects(PhotoModel.self))
            try! realm.commitWrite()
        }
    }
}


