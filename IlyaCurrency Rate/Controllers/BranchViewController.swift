//
//  BranchViewController.swift
//  IlyaCurrency Rate
//
//  Created by Admin on 21.01.2020.
//  Copyright © 2020 Ilya Ilushenko. All rights reserved.
//

import UIKit

class BranchViewController: UITableViewController {

    var cities = [String]()
    var branches = Branches()
    var cityService = GetBranchService(city: "")
    var selectedCity: String = ""
    var branchService: GetBranchService?
    var picker: UIPickerView?
    var isPickerShow: Bool {
        return picker?.superview != nil
    }
    @IBOutlet private weak var selectCityButton: UIBarButtonItem!

    func updateUI() {
        selectCityButton.title = isPickerShow ? "Done" : "Select City"
    }

    @IBAction private func actionSelectCity(_ sender: Any) {
        guard let picker = picker else {
            return
        }
        if isPickerShow {
            picker.removeFromSuperview()
            loadBranches()
        } else {
            picker.delegate = self
            picker.dataSource = self
            view.addSubview(picker)
        }
        updateUI()
    }

    func loadBranches() {
        if !selectedCity.isEmpty {
            branchService = GetBranchService(city: selectedCity)
            branchService?.request(complition: { branches, error in
                DispatchQueue.main.async {
                    if let branches = branches {
                        self.branches = branches
                    } else {
                        print(error ?? "")
                    }
                    self.tableView.reloadData()
                }
            })
        }
    }

    func loadCities() {
        cityService.getAllCities { cities in
            DispatchQueue.main.async {
                self.cities = cities
                self.picker?.reloadAllComponents()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCities()
        picker = UIPickerView(frame: CGRect(x: 0, y: 200, width: self.view.frame.width, height: 300))
        picker?.delegate = self
        picker?.dataSource = self
        updateUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCities()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return branches.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let branch = branches [indexPath.row]
        cell.textLabel?.text = "\(branch.index), \(branch.address),\(branch.name)"
        cell.detailTextLabel?.text = "\(branch.phone), \(branch.email)"
        return cell
    }
}
extension BranchViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCity = cities[row]
    }
}
