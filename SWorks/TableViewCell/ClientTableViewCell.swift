//
//  ClientTableViewCell.swift
//  SWorks
//
//  Created by Mohit Raina  on 21/05/21.
//

import UIKit

protocol ClientTableViewCellDelegate : class {
    func handleTapOnMap(clientModel : ClientModel)
    func handleTapOnCall(mobileNumber : Int64)
}

class ClientTableViewCell: UITableViewCell {

    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var DirectionButton: UIButton!
    
    private var clientModel : ClientModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.white
        // Initialization code
    }
    
    weak var delegate : ClientTableViewCellDelegate?
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }

    func setUpData(with model : ClientModel) {
        self.clientModel = model
        clientNameLabel.text = model.name
    }
    
    @IBAction func mapsButtonTapped(_ sender: UIButton) {
        
        if let clientModel = clientModel {
            delegate?.handleTapOnMap(clientModel: clientModel)
        }
    }
    
    @IBAction func callButtonTapped(_ sender: UIButton) {
        delegate?.handleTapOnCall(mobileNumber: clientModel?.phone ?? 0)
    }
    
}
