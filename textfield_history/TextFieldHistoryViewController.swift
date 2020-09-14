//
//  TextFieldHistoryViewController.swift
//  textfield_history
//
//  Created by Sachin Jindal on 13/09/20.
//  Copyright © 2020 Sachin Jindal. All rights reserved.
//

import UIKit

//UITextFieldDelegate can be an extension. See at it later.

class TextFieldHistoryViewController: UIViewController, UITextFieldDelegate {
    let tableView = UITableView()
    var textField : UITextField!
    var safeArea: UILayoutGuide!
    var playerNameArray = Array<String>(repeating: "abc", count: 5)
    var text: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TextFieldCellHistory")
        setupTextView()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - setupView
    
    func setupTextView() {
        //always add the view first before adding constraints on that view
        textField = UITextField(frame: CGRect(x: 10.0, y: 100.0, width: self.view.bounds.size.width - 20.0, height: 50.0))
        view.addSubview(textField)
        textField.backgroundColor = .yellow
        view.layoutSubviews()
        view.bringSubviewToFront(textField)
        textField.delegate = self
    }
    
    //MARK: - textfield Delegates
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        setupTableView()
        return true
    }
    
    //MARK: - setup table view
    
    func setupTableView() {
        
        view.addSubview(tableView)
        var tableHeight: CGFloat = 0
        tableHeight = tableView.contentSize.height
        
        var tableViewFrame = CGRect(x: 50, y: 50, width: textField.frame.width, height: tableHeight)
        tableViewFrame.origin.x = textField.frame.origin.x
        tableViewFrame.origin.y = textField.frame.origin.y + 50
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.tableView.frame = tableViewFrame
        })

        //Setting tableView style
        tableView.layer.masksToBounds = true
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.layer.cornerRadius = 5.0
        tableView.separatorColor = UIColor.lightGray
        tableView.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        
        view.layoutSubviews()
        view.bringSubviewToFront(tableView)
        tableView.reloadData()
    }
    
    //MARK: - Setting Text in textField based on selection in history
    func setText()
    {
        textField.text = text
        tableView.isHidden = true
        textField.endEditing(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: - UITableViewDataSource

extension TextFieldHistoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return playerNameArray.count
        
    }
    
    // MARK: TableViewDelegate methods
    
    //Adding rows in the tableview with the data from dataList

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCellHistory", for: indexPath) as UITableViewCell
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.text = playerNameArray[indexPath.row]
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("selected row")
    text = playerNameArray[indexPath.row]
    setText()
    }
}
