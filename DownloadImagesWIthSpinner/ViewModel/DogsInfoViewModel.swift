//
//  DogsInfoViewModel.swift
//  DownloadImagesWIthSpinner
//
//  Created by RaviKrishna on 17/05/24.
//

import Foundation
import UIKit

class DogsInfoViewModel {
    
    var totalDogInfo: DogsInfoModelObject?
    var imageLinks = [String]()
    
    // All Dogs
    func getDogsInfoServiceCall(completion: @escaping () -> Void) {
        
        getServiceCall(categoryName: "images", parameters: nil, type:DogsInfoModelObject.self , completionHandler: {(dogObject) in
            self.totalDogInfo = dogObject
            self.imageLinks = dogObject.message!
            completion()
        })
    }

}
