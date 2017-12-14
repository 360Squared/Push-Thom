//
//  addItemTableViewCell.swift
//  WSTagsFieldExample
//
//  Created by Thom Peele on 14/12/2017.
//  Copyright © 2017 Whitesmith. All rights reserved.
//

import UIKit

class addItemTableViewCell: UITableViewCell {

    var parentTableViewController: SearchTableViewController?
    var skill: Skill?
    @IBOutlet weak var plusUILabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var addRemoveButton: UIButton!
    @IBAction func addRemoveButtonAction(_ sender: UIButton) {
        var changedStuff = false
        for item in (parentTableViewController?.addedSkills)! {
            let skillItem = item as Skill
            if skillItem.name == skill!.name {
                parentTableViewController?.toAddSkills.append(skill!)
                changedStuff = true
            }
        }
        if changedStuff {
            var index = parentTableViewController?.addedSkills.index(where: { (item) -> Bool in
                item.name == skill!.name // test if this is the item you're looking for
            })
            parentTableViewController?.addedSkills.remove(at: index!)
        }
        if !changedStuff {
            for item in (parentTableViewController?.toAddSkills)! {
                let skillItem = item as Skill
                if skillItem.name == skill!.name {
                    parentTableViewController?.addedSkills.append(skill!)
                    changedStuff = true
                }
            }
            if changedStuff {
                var index = parentTableViewController?.toAddSkills.index(where: { (item) -> Bool in
                    item.name == skill!.name // test if this is the item you're looking for
                })
                parentTableViewController?.toAddSkills.remove(at: index!)
            }
        }
        parentTableViewController?.tableView.reloadData()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
