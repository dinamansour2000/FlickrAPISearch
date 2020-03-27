


import UIKit

class FlickerDBManager {
    
    lazy var flickerDbRequest = FlickerDatabaseRequest()
    
    func saveFlickerData(data: [PhotoModel]? ){
        flickerDbRequest.saveFlickerData(data: data)
    }
    
    func getFlickerData() -> [PhotoModel]? {
        return flickerDbRequest.getFlickerData()
    }
    
    func deleteFlickerData(){
        flickerDbRequest.deleteFlickerData()
    }
}
