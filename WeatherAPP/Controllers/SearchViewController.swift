//
//  SearchViewController.swift
//  WeatherAPP
//
//  Created by Lorenzo piombini on 2/13/21.
//

import UIKit


class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
   
    var cities:[City]?
    var isSearch = false
    var filteredCities = [String]()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        

        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
       
        
    }
    
    //#######################################    TABLE VIEW CONFIG  ######################################
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if CityList.shared.citiesDictionary.count > 0 {
        if isSearch{
            return filteredCities.count
        } else {
            return CityList.shared.citiesDictionary.count
        }
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if let cell = tableView.dequeueReusableCell(withIdentifier: "city", for: indexPath) as? cityTableViewCell{
            if filteredCities.count > 0 {
            let city = filteredCities[indexPath.row]
            cell.updateUI(with: city)

            } else {
                cell.textLabel?.text = ""
            }
        
            return cell
    }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if filteredCities.count != 0 {
        let city = filteredCities[indexPath.row]
            
        if  let coord = CityList.shared.citiesDictionary[city]{
        let array:[Any] = [city, coord]
            
            performSegue(withIdentifier: "cityWeather", sender: array)
        } else {
            let alert = UIAlertController(title: "ERROR", message: "This city doesn`t match our record, check if there are any typos or maybe some Capitol letters, Rememebr : City`s name are case sensitive", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [self] (UIAlertAction) in
                self.filteredCities.remove(at: indexPath.row)
                tableView.reloadData()
            }))
            present(alert, animated: true, completion: nil)
        }
        
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cityWeather = segue.destination as? CityWeatherViewController{
            cityWeather.initCityData(array: sender as! [Any])
        }
    }
    
 //#######################################    SEARCH BAR CONFIG  ######################################
   
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearch = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false

    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            isSearch = false
            filteredCities.removeAll()
            tableView.reloadData()
        } else {
              
            if CityList.shared.TriesCity.query(word: searchText) {
                if filteredCities.contains(searchText) == false {
                filteredCities.append(searchText)
               
                }
            }
            if filteredCities.count == 0 {
                isSearch = false
            } else {
                isSearch = true
            }
            
            }
           
           
            
        tableView.reloadData()
            }
    }
    
    


    
    
    


