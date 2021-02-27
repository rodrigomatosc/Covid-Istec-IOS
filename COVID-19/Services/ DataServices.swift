//
//   DataServices.swift
//  COVID-19
//
//  Created by Rodrigo Matos on 24/02/2021.
//

import Foundation


protocol ServicesDelegate {
    func didGetAllServices(informations: [InformationCovid])
}

struct DataServices {
    
    var servicesDelegate : ServicesDelegate?
    
    
    func getAllServices(urlParam:String) -> Void {
        if let url = URL(string: "\(urlParam)") {
            let urlSession = URLSession(configuration: .default)
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let task = urlSession.dataTask(with: request) { (data, response, error) in
            // Handler a ser executado na conclusão do pedido, seja por erro ou por sucesso
                
                if let safeDate = data {
                    let decoder =  JSONDecoder()
    
                    do {
                        let decoderInformations =  try decoder.decode([String:InformationCovid].self, from: safeDate)
                        var informations: [InformationCovid] = []
                        if let information = decoderInformations["All"] {
                            informations.append(information)
                            self.servicesDelegate?.didGetAllServices(informations: informations )
                        }
                    } catch {
                        print(error)
                    }
                }
            }
            
            task.resume()
        }
    }
}
