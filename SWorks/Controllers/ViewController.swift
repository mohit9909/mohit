//
//  ViewController.swift
//  SWorks
//
//  Created by Mohit Raina  on 20/05/21.
//

import UIKit

class ViewController: UIViewController {

    
    let viewModel = ClientViewModel()
    
    
    var listTableView : UITableView  = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        return tableView
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(listTableView)
        self.title = "Client List"
        registerCell()
        listTableView.delegate = self
        listTableView.dataSource = self
        addContraints()
        viewModel.getClientList {
                DispatchQueue.main.async {
                    self.listTableView.reloadData()
                }
        }
    }
    
    private func registerCell() {
        listTableView.register(ClientTableViewCell.nib, forCellReuseIdentifier: ClientTableViewCell.reuseIdentifier)
    }
    
    func addContraints() {
        listTableView.translatesAutoresizingMaskIntoConstraints = false
        listTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        listTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        listTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        listTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension ViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Count",viewModel.clientModel.count)
        return viewModel.clientModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ClientTableViewCell.reuseIdentifier, for: indexPath) as? ClientTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        let clientModel = viewModel.clientModel[indexPath.row]
        cell.setUpData(with: clientModel)
        return cell
    
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension ViewController : ClientTableViewCellDelegate {
    func handleTapOnMap(clientModel: ClientModel) {
        let vc = MapLoactionViewController(cordinates: clientModel.location)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func handleTapOnCall(mobileNumber : Int64) {
        if let phoneCallURL = URL(string: "tel://\(mobileNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            } else {
                let alert = UIAlertController(title: "Error", message: "Works On mobile", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
        }
    }
}


