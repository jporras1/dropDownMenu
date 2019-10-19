//
//  ViewController.swift
//  dropDownMenu
//
//  Created by Javier Porras jr on 10/19/19.
//  Copyright © 2019 Javier Porras jr. All rights reserved.
//

import UIKit
private let reuseIdentifier = "DropDownCell"

class ViewController: UIViewController {
    
    //MARK: Properties
    var tableView: UITableView!
    var showMenu: Bool = false
    var tableViewHeightConstraint: NSLayoutConstraint?
    let colorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(r: 17, g: 154, b: 237)
        return view
    }()
    
    //MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        configureTableView()
        
        view.addSubview(colorView)
        colorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        colorView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 32).isActive = true
        colorView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        colorView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        //colorView.backgroundColor = UIColor.blue()
    }
    
    //MARK: Selectors
    @objc func handleDropDown(){
        showMenu = !showMenu
        print("Drop down menu...")
        
        var indexPaths = [IndexPath]()
        Colors.allCases.forEach { (color) in
            //print("Color: \(color) Raw Value: \(color.rawValue)")
            let indexPath = IndexPath(row: color.rawValue, section: 0)
            indexPaths.append(indexPath)
        }
        tableViewHeightConstraint?.constant = showMenu ? 220 : 70
        if showMenu{
            tableView.insertRows(at: indexPaths, with: .fade)
        }else{
            tableView.deleteRows(at: indexPaths, with: .fade)
        }
    }

    //MARK: Handlers
    func configureTableView(){
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.rowHeight = 50
        
        tableView.register(DropDownCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 44).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableViewHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: 70)
        tableViewHeightConstraint?.isActive = true
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("Select Color", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleDropDown), for: .touchUpInside)
        button.backgroundColor = UIColor.blue()
        return button
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showMenu ? Colors.allCases.count : 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! DropDownCell
        cell.titleLabel.text = Colors(rawValue: indexPath.row)?.description
        cell.backgroundColor = Colors(rawValue: indexPath.row)?.color
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let color = Colors(rawValue: indexPath.row) else { return }
        colorView.backgroundColor = color.color
    }
}

extension UIColor{
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat){
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    static func blue() -> UIColor{
        return UIColor(r: 17, g: 154, b: 237)
    }
    static func purple() -> UIColor{
        return UIColor(r: 98, g: 0, b: 238)
    }
    static func pink() -> UIColor{
        return UIColor(r: 255, g: 148, b: 194)
    }
    static func teal() -> UIColor{
        return UIColor(r: 3, g: 218, b: 197)
    }
}

enum Colors: Int, CaseIterable{
    case Purple
    case Pink
    case Teal
    
    var description: String{
        switch self {
        case .Purple:
            return "Purple"
        case .Pink:
            return "Pink"
        case .Teal:
            return "Teal"
        }
    }
    
    var color: UIColor{
        switch self {
        case .Purple:
            return UIColor.purple()
        case .Pink:
            return UIColor.pink()
        case .Teal:
            return UIColor.teal()
        }
    }
}
