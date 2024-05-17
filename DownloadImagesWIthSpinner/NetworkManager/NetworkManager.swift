//
//  NetworkManager.swift
//  DownloadImagesWIthSpinner
//
//  Created by RaviKrishna on 17/05/24.
//

import Foundation

func getServiceCall<T: Codable>( categoryName:String, parameters:String?, type: T.Type, completionHandler:@escaping(_ response: T) -> Void) {

    let urlWithParameters = "\(BASEURL)\(categoryName)"
    guard let mainUrl = URL(string: urlWithParameters) else { return }
    URLSession.shared.dataTask(with: mainUrl) { (data, response, error) in
        
        guard let mainData = data else{
//            guard let serviceError = error else{return}
//            self.showWarningAlert(title: "Service Error", message: serviceError.localizedDescription)
            return
        }
        do {
            let decoder = JSONDecoder()
            let dataModel = try decoder.decode(type, from: mainData)
            completionHandler(dataModel)
        }
        catch let parsingError {
//            self.showWarningAlert(title: "Error", message: parsingError.localizedDescription)
            print(parsingError)
        }
    }.resume()
}

func getServiceCall2<T: Codable>( categoryName:String, parameters:String?, type:T.Type, completionHandler:@escaping(_ response: T) -> Void) {
    
//    let BASEURL = "http://dummy.restapiexample.com/api/v1/"
//    let BASEURL = "https://jsonplaceholder.typicode.com/"
//    let BASEURL = "https://restcountries.eu/rest/v2/"
    let BASEURL = "https://samples.openweathermap.org/data/2.5/box/"

    let urlWithParameters = "\(BASEURL)\(categoryName)"
    guard let mainUrl = URL(string: urlWithParameters) else { return }
    URLSession.shared.dataTask (with: mainUrl) { (data, response, error) in
        guard let mainData = data else {return}
        do{
            let decoder = JSONDecoder()
            let dataModel = try decoder.decode(type, from: mainData)
            completionHandler(dataModel)
        }
        catch let parsingError {
            //            self.showWarningAlert(title: "Error", message: parsingError.localizedDescription)
            print(parsingError)
        }
    }.resume()
}

func postServiceCall<T: Codable>( categoryName:String, parameters:String?, type: T.Type, completionHandler:@escaping(_ response: T) -> Void) {
    
        let urlWithParameters = "\(BASEURL)\(categoryName)"
        guard let mainUrl = URL(string: urlWithParameters) else {return}
        var urlRequest = URLRequest(url: mainUrl)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = parameters?.data(using: .utf8)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
        
         guard let mainData = data,error == nil else{
//            guard let serviceError = error else{return}
//                self.showWarningAlert(title: "Service Error", message: serviceError.localizedDescription)
            return
        }
        do {
            let decoder = JSONDecoder()
            let dataModel = try decoder.decode(type, from: mainData)
            completionHandler(dataModel)
        }
        catch let parsingError {
//            self.showWarningAlert(title: "Error", message: parsingError.localizedDescription)
            print(parsingError)
        }
    }.resume()
}
