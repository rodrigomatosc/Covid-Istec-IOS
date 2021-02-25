//
//   DataServices.swift
//  COVID-19
//
//  Created by Rodrigo Matos on 24/02/2021.
//

import Foundation


protocol ServicesDelegate {
    func didGetAllServices(all: [All])
}

struct DataServices {
    
    var apiRoot : String =  "https://covid-api.mmediagroup.fr/v1/cases?country=France"
    var servicesDelegate : ServicesDelegate?
    
    
    func getAllServices() -> Void {
        if let url = URL(string: "\(apiRoot)") {
            let urlSession = URLSession(configuration: .default)
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let task = urlSession.dataTask(with: request) { (data, response, error) in
            // Handler a ser executado na conclusão do pedido, seja por erro ou por sucesso
                
                if let safeDate = data {
                    let decoder =  JSONDecoder()
                                        
                    do {
                        let decoderServices =  try decoder.decode(InformationCovid.self, from: safeDate)
                        print(decoderServices)
                        //self.servicesDelegate?.didGetAllServices(all: decoderServices)
                    } catch {
                        print(error)
                    }
                }
            }
            
            task.resume()
        }
    }
}
