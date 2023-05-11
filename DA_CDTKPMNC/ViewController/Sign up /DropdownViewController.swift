//
//  DropdownViewController.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/10/23.
//

import UIKit

protocol DropdownViewControllerDelegate: AnyObject {
    func selectedDropdown(_ id: String, dropdownType: Dropdown, title: String)
}

class DropdownViewController: UIViewController {

    weak var delegate: DropdownViewControllerDelegate?
    
    var dropdownType: Dropdown = .gender
    let dataSource = ["Male", "Female"]
    let tableView = UITableView()
    
    var listProvines: [AddressResponse.Provines] = []
    var listDistricts: [DistrictsResponse.District] = []
    var listWard: [WardResponse.Ward] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getListProvines()
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
    }

    private func getListProvines() {
        NetworkManager.shared.getListProvines { result in
            switch result {
                
            case .success(let provines):
                
                guard let provines = provines.data?.provines else {
                    return
                }
                
                self.listProvines = provines
                self.tableView.reloadData()
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
}

extension DropdownViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return dataSource.count
        
        switch dropdownType {
        case .provines:
            return listProvines.count
            
        case .gender:
            return dataSource.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        cell.textLabel?.text = dataSource[indexPath.row]
        switch dropdownType {
        case .provines:
            cell.textLabel?.text = listProvines[indexPath.row].fullName
        default:
            cell.textLabel?.text = dataSource[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch dropdownType {
        case .provines:
            delegate?.selectedDropdown(listProvines[indexPath.row].id, dropdownType: .provines, title: listProvines[indexPath.row].fullName)
            
        case .gender:
            delegate?.selectedDropdown(dataSource[indexPath.row], dropdownType: .gender, title: "")
        default:
            break
        }
        
        dismiss(animated: true)
    }
}
