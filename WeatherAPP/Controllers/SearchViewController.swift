//
//  SearchViewController.swift
//  WeatherAPP
//
//  Created by Lorenzo piombini on 2/13/21.
//

import UIKit


class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var TrieCities = Trie()
    var citiesDictionary = [String : coord]()
    var cities:[City]?
    var isSearch = false
    var filteredCities = [String]()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        fetchingCityList { [self] (Cities) in
            var index = 0
            for _ in Cities {
                TrieCities.insert(word: Cities[index].name)
                index += 1
            }
            citiesDictionary = Cities.reduce(into: [String : coord]()){
                $0[$1.name] = $1.coord
            }
          
            tableView.reloadData()
            
            
        } onError: { (String) in
            print(String)
        }
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
       
        
    }
    
    //#######################################    TABLE VIEW CONFIG  ######################################
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if citiesDictionary.count > 0 {
        if isSearch{
            return filteredCities.count
        } else {
            return citiesDictionary.count
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
        let city = filteredCities[indexPath.row]
        let coord = citiesDictionary[city]!
        let array:[Any] = [city, coord]
       
        performSegue(withIdentifier: "cityWeather", sender: array)
        
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
              
            if  TrieCities.query(word: searchText) {
                filteredCities.append(searchText)
               
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


    
    
    


