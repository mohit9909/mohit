//
//  ClientViewModel.swift
//  SWorks
//
//  Created by Mohit Raina  on 20/05/21.
//

import Foundation

class ClientViewModel  {
    
    
    var clientModel : [ClientModel] = []
    
    
    func getClientList(completion : @escaping ()->()) {
        
        NetworkManager.shared.getdata(url: UrlTypes.clientList) { [weak self] (result: Result<ClientResponseModel, NetworkErrors>) in
            switch result {
            case .success(let result):
                guard let self = self else { return }
                self.clientModel = result.orders
                completion()
            case .failure(let error):
                print("failure occured",error)
            }
        }
    }
}
