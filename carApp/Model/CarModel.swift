//
//  CarModel.swift
//  carApp
//
//  Created by Nurmukhanbet Sertay on 13.03.2023.
//

import CoreData

public class Car: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Car>{
        return NSFetchRequest<Car>(entityName: "Car")
    }

    @NSManaged public var name: String
    @NSManaged public var type: String
    @NSManaged public var location: String
    @NSManaged public var phone: String
    @NSManaged public var summary: String
    @NSManaged public var image: Data
    @NSManaged public var ratingText: String?
    @NSManaged public var isFavorite: Bool
}

extension Car {
    
    enum Rating: String {
        case awesome
        case good
        case okay
        case bad
        case terrible
        
        var image: String {
            switch self {
            case .awesome: return "love"
            case .good: return "cool"
            case .okay: return "happy"
            case .bad: return "sad"
            case .terrible: return "angry"
            }
        }
    }
            
    var rating: Rating? {
        get {
            guard let ratingText = ratingText else {
                return nil
            }
            
            return Rating(rawValue: ratingText)
        }
        
        set {
            self.ratingText = newValue?.rawValue
        }
    }

    
}