//
//  SearchTableViewController.swift
//  WSTagsFieldExample
//
//  Created by Thom Peele on 13/12/2017.
//  Copyright © 2017 Whitesmith. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    let skills = [
        Skill(category:"Chocolate", name:"Chocolate Bar"),
        Skill(category:"Chocolate", name:"Chocolate Chip"),
        Skill(category:"Chocolate", name:"Dark Chocolate"),
        Skill(category:"Hard", name:"Lollipop"),
        Skill(category:"Hard", name:"Candy Cane"),
        Skill(category:"Hard", name:"Jaw Breaker"),
        Skill(category:"Other", name:"Caramel"),
        Skill(category:"Other", name:"Sour Chew"),
        Skill(category:"Other", name:"Gummi Bear"),
        Skill(category:"Other", name:"Candy Floss"),
        Skill(category:"Chocolate", name:"Chocolate Coin"),
        Skill(category:"Chocolate", name:"Chocolate Egg"),
        Skill(category:"Other", name:"Jelly Beans"),
        Skill(category:"Other", name:"Liquorice"),
        Skill(category:"Hard", name:"Toffee Apple")
        ]
    
    var addedSkills = [Skill]()
    var toAddSkills = [Skill]()
    var filteredAddedSkills = [Skill]()
    var filteredToAddSkills = [Skill]()

    var searchController = UISearchController(searchResultsController: nil)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        toAddSkills = skills
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false


        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Candies"
//        navigationItem.searchController = searchController
        definesPresentationContext = true
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            if isFiltering() {
                return filteredAddedSkills.count
            }
            return addedSkills.count
        } else {
            if isFiltering() {
                return filteredToAddSkills.count
            }
            return toAddSkills.count
        }

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> addItemTableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as? addItemTableViewCell
        var skill: Skill

        if indexPath[0] == 0 {
            
            if isFiltering() {
                skill = filteredAddedSkills[indexPath.row]
            } else {
                skill = addedSkills[indexPath.row]
            }
            cell?.addRemoveButton.setImage(UIImage(named: "removeButton"), for: .normal)
            cell?.skill = skill
            
        } else {
            
            if isFiltering() {
                skill = filteredToAddSkills[indexPath.row]
            } else {
                skill = toAddSkills[indexPath.row]
            }
            cell?.addRemoveButton.setImage(UIImage(named: "plusButton"), for: .normal)
            cell?.skill = skill

        }
        cell?.plusUILabel?.text = skill.name
        cell?.parentTableViewController = self
        
        return cell!
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredAddedSkills = addedSkills.filter({( skill : Skill) -> Bool in
            return skill.name.lowercased().contains(searchText.lowercased())
        })
        filteredToAddSkills = toAddSkills.filter({( skill : Skill) -> Bool in
            return skill.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }

    // Added after lecture for REFRESHING
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // make it a little clearer when each pull from Twitter
        // occurs in the table by setting section header titles
        if section == 0 {
            return "Toegevoegd"
        } else {
            return "Toe te voegen"
        }
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    }

}

extension SearchTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
