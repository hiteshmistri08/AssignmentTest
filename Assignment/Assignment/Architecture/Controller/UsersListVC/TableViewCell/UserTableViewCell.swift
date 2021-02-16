//
//  UserTableViewCell.swift
//  Assignment
//
//  Created by Hitesh on 15/02/21.
//

import UIKit
import SDWebImage

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var imgUserProfile: UIImageView!
    @IBOutlet private weak var lblUserSerialNumber: UILabel!
    @IBOutlet private weak var lblUserName: UILabel!
    @IBOutlet private weak var lblUserEmail: UILabel!
    
    static let identifier = "UserTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI() {
        imgUserProfile.layer.cornerRadius = 25.0
        imgUserProfile.clipsToBounds = true
        imgUserProfile.layer.borderWidth = 2
        imgUserProfile.layer.borderColor = UIColor.gray.cgColor
    }
    
    func configureCell(viewModel:UserDataSource) {
        lblUserSerialNumber.text = viewModel.userSerialNumber
        lblUserName.text = viewModel.name
        lblUserEmail.text = viewModel.email
        imgUserProfile.sd_setImage(with: URL(string: viewModel.avatar))
    }

}
