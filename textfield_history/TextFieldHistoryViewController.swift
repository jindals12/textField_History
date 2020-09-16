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
    var textField1 : UITextField!
    var textField2 : UITextField!
    var dummyButton : UIButton!
    var safeArea: UILayoutGuide!
    var playerNameArray = Array<String>(repeating: "abc", count: 5)
    var text: String = ""
    var activeTextField : Int = 0
    var textFieldText : String = ""
    var currentPosition: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TextFieldCellHistory")
        textField1 = UITextField(frame: CGRect(x: 10.0, y: 100.0, width: self.view.bounds.size.width - 20.0, height: 50.0))
        textField2 = UITextField(frame: CGRect(x: 10.0, y: 250.0, width: self.view.bounds.size.width - 20.0, height: 50.0))
        setupTextView(textField : textField1)
        setupTextView(textField : textField2)
        dummyButton = UIButton(frame: CGRect(x:10.0, y:700, width: 50.0, height: 50.0))
        setupButton()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - setupView
    
    func setupTextView(textField: UITextField) {
        //always add the view first before adding constraints on that view
        view.addSubview(textField)
        textField.backgroundColor = .yellow
        view.layoutSubviews()
        view.bringSubviewToFront(textField)
        textField.delegate = self
    }
    
    func setupButton() {
        dummyButton.backgroundColor = .blue
        dummyButton.addTarget(self, action: #selector(pressed(_:)), for: .touchUpInside)
        view.addSubview(dummyButton)
        view.layoutSubviews()
        view.bringSubviewToFront(dummyButton)
        
    }
    
    @objc func pressed(_ sender: UIButton!) {
        if(currentPosition == 5) {
            currentPosition = 0
        }
        if(activeTextField == 1) {
            textField1.endEditing(true)
            playerNameArray[currentPosition] = textField1.text!
            currentPosition+=1
        }
        if(activeTextField == 2) {
            textField2.endEditing(true)
            playerNameArray[currentPosition] = textField2.text!
            currentPosition+=1
        }
        
    
    }
    
    //MARK: - textfield Delegates
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if (textField == textField1) {
            activeTextField = 1
            textField2.isHidden = true
        }
        else if(textField == textField2) {
            activeTextField = 2
        }
        setupTableView(textField: textField)
        return true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField == textField1) {
            textField2.isHidden = false
        }
        tableView.isHidden = true
        textFieldText = textField.text!
    }
    
    
    //MARK: - setup table view
    
    func setupTableView(textField: UITextField) {
        
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
        tableView.isHidden = false
        view.layoutSubviews()
        view.bringSubviewToFront(tableView)
        tableView.reloadData()
    }
    
    //MARK: - Setting Text in textField based on selection in history
    func setText()
    {
        if (activeTextField == 1) {
            textField1.text = text
            textField1.endEditing(true)
        }
        else if(activeTextField == 2) {
            textField2.text = text
            textField2.endEditing(true)
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
