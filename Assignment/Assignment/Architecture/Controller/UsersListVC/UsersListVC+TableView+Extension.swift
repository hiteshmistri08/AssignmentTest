//
//  UsersListVC+TableView+Extension.swift
//  Assignment
//
//  Created by Hitesh on 15/02/21.
//

import UIKit

//MARK:- UITableViewDataSource
extension UsersListVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier) as! UserTableViewCell
        cell.configureCell(viewModel: viewModel.userDataSource[indexPath.row])
        // Pagination
        if indexPath.row == viewModel.userDataSource.count - 1, viewModel.isPagingAvailable(), !isLoading {
            fetchUsers()
        }
        return cell
    }

}
//MARK:- UITableViewDelegate
extension UsersListVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex, isLoading, viewModel.isPagingAvailable() {
            let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            
            self.tableView?.tableFooterView = spinner
            self.tableView?.tableFooterView?.isHidden = false
        } else {
            self.tableView?.tableFooterView = nil
            self.tableView?.tableFooterView?.isHidden = true
        }
    }
}
