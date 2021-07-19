//
//  NewOrderViewController.swift
//  CoffeOrderApp
//
//  Created by ecinar on 19.07.2021.
//

import UIKit

class NewOrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    private var vm = AddCoffeeOrderViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var totalCoffe: UITextField!
    private var coffeeSizesSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        setupUI()
    }
    @IBAction func deneme(_ sender: Any) {
        
        print("erdal")
        let name = self.name.text
        let totalOrder = self.totalCoffe.text
        let selectedSize = self.coffeeSizesSegmentedControl.titleForSegment(at: self.coffeeSizesSegmentedControl.selectedSegmentIndex)
        
        guard let indexPath = self.tableView.indexPathForSelectedRow else {
            fatalError("error in selecting")
        }
        
        self.vm.name = name
        self.vm.total = Int(totalOrder ?? "1")!
        self.vm.selectedSize = selectedSize
        self.vm.selectedType = self.vm.coffeeName[indexPath.row]
        
        
        Webservice().load(resource: Order.create(vm: self.vm)) { result in
            
            switch result {
                case .success(let order):
                    print(order)
                case .failure(let error):
                    print(error)
            }
            
        }
    }
    

    private func setupUI() {
        
        self.coffeeSizesSegmentedControl = UISegmentedControl(items: self.vm.size)
        self.coffeeSizesSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.coffeeSizesSegmentedControl)
        
        self.coffeeSizesSegmentedControl.topAnchor.constraint(equalTo: self.tableView.bottomAnchor, constant: 20).isActive = true
        
        self.coffeeSizesSegmentedControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.coffeeName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeTypeTableViewCell", for: indexPath)
        
        cell.textLabel?.text = self.vm.coffeeName[indexPath.row]
        return cell
    }

}
