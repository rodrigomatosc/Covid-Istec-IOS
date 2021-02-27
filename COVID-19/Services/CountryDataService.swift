//
//  CountryDataService.swift
//  COVID-19
//
//  Created by Rodrigo Matos on 27/02/2021.
//

import Foundation


protocol ServicesDelegateCountry {
    func didGetAllServices(countries: [Country])
}

struct CountryDataServices {
    
    var servicesDelegate : ServicesDelegateCountry?
    
    
    func getAllCountries() -> Void {
        let urlPattern = "https://restcountries.eu/rest/v2/all"
        
        if let url = URL(string: "\(urlPattern)") {
            let urlSession = URLSession(configuration: .default)
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let task = urlSession.dataTask(with: request) { (data, response, error) in
            // Handler a ser executado na conclusão do pedido, seja por erro ou por sucesso
                
                if let safeDate = data {
                    let decoder =  JSONDecoder()
    
                    do {
                        let decoderCountries =  try decoder.decode([Country].self, from: safeDate)
                        self.servicesDelegate?.didGetAllServices(countries: decoderCountries)
                    } catch {
                        print(error)
                    }
                }
            }
            
            task.resume()
        }
    }
}
