//
//  ViewController.swift
//  WSTagsFieldExample
//
//

import UIKit
//import WSTagsField

class ViewController: UIViewController {
    fileprivate let tagsField = WSTagsField()
    @IBOutlet fileprivate weak var tagsView: UIView!
    
    var skills:[Skill] {
        get {
            return []
        }
        set(skillList) {
            tagsField.removeTags()
            tagsField.readOnly = true
            for item in skillList {
                tagsField.addTag(item.name)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagsField.frame = tagsView.bounds
        tagsView.addSubview(tagsField)

        tagsField.placeholder = "Enter a tag"
        tagsField.backgroundColor = .white
        tagsField.frame = tagsView.bounds
        tagsField.returnKeyType = .next
        tagsField.delimiter = " "

        tagsField.placeholderAlwayVisible = true
        tagsField.maxHeight = 100.0

        textFieldEventss()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tagsField.beginEditing()
    }

    override func viewWillLayoutSubviews() {
        tagsField.frame = tagsView.bounds
    }

    @IBAction func touchReadOnly(_ sender: UIButton) {
        tagsField.readOnly = !tagsField.readOnly
        sender.isSelected = tagsField.readOnly
    }

    @IBAction func touchTest(_ sender: UIButton) {
        tagsField.addTag("test1")
        tagsField.addTag("test2")
        tagsField.addTag("test3")
        tagsField.addTag("test4")
    }

    @IBAction func openSelectView(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "selectView") as! SearchTableViewController
        newViewController.viewController = self
        self.navigationController?.pushViewController(newViewController, animated: true)

    }
    
}

extension ViewController {
    fileprivate func textFieldEventss() {
        tagsField.onDidAddTag = { _ in
            print("DidAddTag")
        }

        tagsField.onDidRemoveTag = { _ in
            print("DidRemoveTag")
        }

        tagsField.onDidChangeText = { _, text in
            print("onDidChangeText")
        }

        tagsField.onDidBeginEditing = { _ in
            print("DidBeginEditing")
        }

        tagsField.onDidEndEditing = { _ in
            print("DidEndEditing")
        }

        tagsField.onDidChangeHeightTo = { _, height in
            print("HeightTo \(height)")
        }

        tagsField.onDidSelectTagView = { _, tagView in
            print("Select \(tagView)")
        }

        tagsField.onDidUnselectTagView = { _, tagView in
            print("Unselect \(tagView)")
        }
    }
}
