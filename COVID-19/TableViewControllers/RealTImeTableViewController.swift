//
//  RealTImeTableViewController.swift
//  COVID-19
//
//  Created by Rodrigo Matos on 24/02/2021.
//

import UIKit

class RealTImeTableViewController: UITableViewController, ServicesDelegate {
 
    @IBOutlet weak var buttonCountry: UIButton!
    var dataService = DataServices()
    var informations : [InformationCovid] = []
    var country : Country?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func didGetAllServices(informations: [InformationCovid]) {
        self.informations = informations
       
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.informations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "realTime", for: indexPath) as!RealTimeTableViewCell

        let information = informations[indexPath.row]
        

        cell.country.text = information.country
        cell.capital.text = information.capital_city
        cell.continent.text = information.continent
        cell.confirmed.text = Int(information.confirmed ?? 0).description
        cell.recovered.text = Int(information.recovered ?? 0).description
        cell.deaths.text = Int(information.deaths ?? 0).description
        cell.population.text = Int(information.population ?? 0).description
        cell.lifeEx.text = information.life_expectancy
       
        if let updated = information.updated {
            cell.update.text = updated
        }
        
        if let longitude = information.long {
            if let latitude = information.lat {
                cell.latLong.text = "\(latitude)/\(longitude)"
            }
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let destination = segue.destination as! SpinnerViewController
               destination.delegateView = self
        
    }

    func setCountry(_ countrySent: Country) {

        if countrySent != nil {
         
            if country != nil && country?.name == countrySent.name {
                return
            }
    
            self.country = countrySent
            
            if let name = self.country?.name {
                
                
                self.informations = []
                
                DispatchQueue.main.async {
                    self.buttonCountry.setAttributedTitle(NSAttributedString(string: name), for: .normal)
                    self.tableView.reloadData()
                }
                
                dataService.servicesDelegate = self
                dataService.getAllServices(urlParam:"https://covid-api.mmediagroup.fr/v1/cases?country=\(name)")
            }
        }
    }
}
