//
//  HistoryTableViewController.swift
//  COVID-19
//
//  Created by Rodrigo Matos on 26/02/2021.
//

import UIKit

class HistoryTableViewController: UITableViewController, ServicesDelegate {
   
    var dataService = DataServices()
    var informationDates : [String: Float] = [:]
    var informationCovid : InformationCovid!
    @IBOutlet weak var capital: UILabel!
    @IBOutlet weak var continent: UILabel!
    @IBOutlet weak var population: UILabel!
    @IBOutlet weak var lifeExp: UILabel!
    @IBOutlet weak var country: UILabel!
    
    func didGetAllServices(informations: [InformationCovid]) {
        self.informationCovid = informations[0]
        if let dates = self.informationCovid.dates {
            self.informationDates = dates
        
            DispatchQueue.main.async {
                self.setDataScreen(information: self.informationCovid)
                self.tableView.reloadData()
            }
        }
    }
    
    func initScreen() -> Void {
        let defaultValue = "--------"
        
        capital.text = defaultValue
        continent.text = defaultValue
        population.text = defaultValue
        lifeExp.text = defaultValue
        country.text = defaultValue
    }
    
    func setDataScreen(information : InformationCovid) -> Void {
        capital.text = information.capital_city
        country.text = information.country
        continent.text = information.continent
        population.text = information.population?.description
        lifeExp.text = information.life_expectancy
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initScreen()
        dataService.servicesDelegate = self
        dataService.getAllServices(urlParam: "https://covid-api.mmediagroup.fr/v1/history?country=Brazil&status=deaths")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Array(informationDates.keys).count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "history", for: indexPath)

        let value = Array(informationDates.values)[indexPath.row]
        let key = Array(informationDates.keys)[indexPath.row]
        
        cell.textLabel?.text = key
        cell.detailTextLabel?.text = value.description
        return cell
    }
}
