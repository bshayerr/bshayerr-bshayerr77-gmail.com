

import MapKit
import CoreLocation 
@objc class PlaceInfo: NSObject,NSCoding {
   var placeID: String?
    var title: String?
    var subtitle: String?
    var latitude:Double?
    var longitude:Double?
//    var coordinate: CLLocationCoordinate2D
    var imageName: String?
    
    
    init(placeID:String?,title: String?, subtitle: String?, latitude: Double,longitude:Double, imageName:String) {
        self.placeID = placeID
        self.title = title
        self.subtitle = subtitle
        self.longitude = longitude
        self.latitude = latitude
        self.imageName = imageName
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.placeID = (aDecoder.decodeObject(forKey: "id") as! String)
        self.title = (aDecoder.decodeObject(forKey: "title") as? String)
        self.subtitle = (aDecoder.decodeObject(forKey: "subtitle") as? String)
        self.longitude = (aDecoder.decodeObject(forKey: "longitude") as! Double)
        self.latitude = (aDecoder.decodeObject(forKey: "latitude") as! Double)
        self.imageName = (aDecoder.decodeObject(forKey: "imageName") as? String)

    
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.placeID, forKey: "id")
        aCoder.encode(self.title, forKey: "title")
        aCoder.encode(self.subtitle, forKey: "subtitle")
        aCoder.encode(self.longitude, forKey: "longitude")
        aCoder.encode(self.latitude, forKey: "latitude")
        aCoder.encode(self.imageName, forKey: "imageName")

        
    }

    
    
    static func getPlaces() -> [PlaceInfo] {
        guard let path = Bundle.main.path(forResource: "Locations", ofType: "plist"), let dic = NSDictionary(contentsOfFile: path) else { return [] }
        
        var places = [PlaceInfo]()
  
        let keys=dic.allKeys
        
        for dataOfKey in keys {
            
             let type = dataOfKey as! String
             var imageName=""
            
            switch type {
            case "Hospital":
                imageName="pinHospital"
                break
            case "Parking Lot":
                imageName="pinParking"
                break
            case "Parks":
                imageName="pinParks"
                break
            case "Hotel":
                imageName="pinHotel"
                break
            case "Banks":
                imageName="pinBank"
                break
            case "SpecialNeedCenter":
                imageName="pinCenter"
                break
            case "GYM":
                imageName="pinGYM"
                break
            case "Pharmacy":
                imageName="pinPharmacy"
                break
            case "Restaurant":
                imageName="pinRestaurant"
                break
            case "SuperMarket":
                imageName="pinSM"
                break
            case "Tele":
                imageName="pinTele"
                break
            case "Police":
                imageName="pinPolice"
                break
            case "Store":
                imageName="pinStore"
                break
            default:
                imageName="pinStore"
                break
            }
        
            
            if let object=dic[dataOfKey] as? [[String:Any]]{
              
                for singleLocation in object{
                    
                    let latitude = singleLocation["latitude"] as? Double ?? 0, longitude = singleLocation["longitude"] as? Double ?? 0

                    let place =  PlaceInfo(placeID:singleLocation["id"] as? String,title: singleLocation["title"] as? String, subtitle:  singleLocation["subtitle"] as? String, latitude: (singleLocation["latitude"] as? Double)!,longitude:(singleLocation["longitude"] as? Double)!,imageName:imageName)
                    places.append(place)
                }
            }
        }
        return places as [PlaceInfo]
    }
}

extension PlaceInfo: MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude!, longitude: self.longitude!)
    }
    

    
}
