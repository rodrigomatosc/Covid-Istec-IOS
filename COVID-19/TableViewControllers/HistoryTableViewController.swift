//
//  HistoryTableViewController.swift
//  COVID-19
//
//  Created by Rodrigo Matos on 26/02/2021.
//

import UIKit

class HistoryTableViewController: UITableViewController, ServicesDelegate {
   
    var dataService = DataServices()
    var informationCovid : InformationCovid!
    @IBOutlet weak var typeSegment: UISegmentedControl!
    var countryObject : Country?
    @IBOutlet weak var countryButton: UIButton!
    @IBOutlet weak var capital: UILabel!
    @IBOutlet weak var continent: UILabel!
    @IBOutlet weak var population: UILabel!
    @IBOutlet weak var lifeExp: UILabel!
    @IBOutlet weak var country: UILabel!
    var dates : [String] = []
    var values : [Float] = []
    
    let dateFormatter = DateFormatter()
    
    func didGetAllServices(informations: [InformationCovid]) {
        self.informationCovid = informations[0]
        if let dates = self.informationCovid.dates {
           
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            let sorted = dates.sorted(by: {
                let date1 = dateFormatter.date(from:  $0.0)
                let date2 = dateFormatter.date(from:  $1.0)
                return date1 ?? Date() > date2 ?? Date()
            })
            
            for (key, value) in sorted {
                self.dates.append(key)
                self.values.append(value)
            }
            
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
        population.text = Int(information.population ?? 0).description
        lifeExp.text = information.life_expectancy
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initScreen()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.dates.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "history", for: indexPath)

        let value = values[indexPath.row]
        let key = dates[indexPath.row]
        
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd"

        if let date = dateFormatter.date(from: key) {
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let dateString = dateFormatter.string(from: date)

            cell.textLabel?.text = dateString
            cell.detailTextLabel?.text = Int(value).description
        }
        
        return cell
    }
    
    @IBAction func onChange(_ sender: Any) {
        if let name = self.countryObject?.name {
            loadDataSceen(countryName: name)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! SpinnerViewController
               destination.delegateView = self
    }
    
    func loadDataSceen(countryName : String) -> Void {
        
        self.dates = []
        self.values = []
        self.informationCovid = nil
        
        DispatchQueue.main.async {
            self.countryButton.setAttributedTitle(NSAttributedString(string: countryName), for: .normal)
            self.tableView.reloadData()
            self.initScreen()
        }
        
        
        if let type = self.typeSegment.titleForSegment(at: typeSegment.selectedSegmentIndex) {
            dataService.servicesDelegate = self
            dataService.getAllServices(urlParam: "https://covid-api.mmediagroup.fr/v1/history?country=\(countryName)&status=\(type)")
        }
    }
    
    func setCountry(_ countrySent: Country) {

        if countrySent != nil {
         
            if countryObject != nil && countryObject?.name == countrySent.name {
                return
            }
    
            self.countryObject = countrySent
    
            if let name = self.countryObject?.name {
                loadDataSceen(countryName: name)
            }
        }
    }
}
