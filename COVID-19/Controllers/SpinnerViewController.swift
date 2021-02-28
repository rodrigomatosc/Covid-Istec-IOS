//
//  SpinnerViewController.swift
//  COVID-19
//
//  Created by Rodrigo Matos on 27/02/2021.
//

import UIKit

class SpinnerViewController: UIViewController, ServicesDelegateCountry {
    
    @IBOutlet weak var pickerCountry: UIPickerView!
    @IBOutlet weak var confirm: UIButton!
    @IBOutlet weak var cancel: UIButton!
    
    var countries : [Country] = []
    var countryDataService = CountryDataServices()
    var delegateView : UITableViewController?
    
    func didGetAllServices(countries: [Country]) {
        self.countries = countries
       
        DispatchQueue.main.async {
            self.pickerCountry.reloadComponent(0)
        }
    }
    
    
    @IBAction func onClickCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onClickConfirm(_ sender: Any) {
        var indexSelected = [pickerCountry .selectedRow(inComponent: 0)][0];
        var country = self.countries[indexSelected]

        if let ecra = self.delegateView as? RealTImeTableViewController {
             dismiss(animated: true, completion: {
                ecra.setCountry(country)
             })
        }
        
        if let ecra = self.delegateView as? HistoryTableViewController {
             dismiss(animated: true, completion: {
                ecra.setCountry(country)
             })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerCountry.dataSource = self
        pickerCountry.delegate = self
        
        if countries.count > 1 {return}
        
        countryDataService.servicesDelegate = self
        countryDataService.getAllCountries()
            
    }
}

extension SpinnerViewController : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.countries.count
    }
    
    
}

extension SpinnerViewController : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.countries[row].name
    }
}
