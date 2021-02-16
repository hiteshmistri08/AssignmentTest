//
//  UsersListVC.swift
//  Assignment
//
//  Created by Hitesh on 15/02/21.
//

import UIKit

class UsersListVC: UIViewController {
    //IBOutlet
    @IBOutlet weak var tableView: UITableView?
    
    // Property
    let viewModel = UsersViewModel()
    var isLoading : Bool = false {
        didSet {
            self.tableView?.reloadData()
        }
    }
    
    
    //View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.title = "Users"
        setupTableView()
        fetchUsers()
    }
    private func setupTableView()  {
        tableView?.delegate = self
        tableView?.dataSource = self
    }
    
    func fetchUsers() {
        guard viewModel.isPagingAvailable(), !isLoading else {
            return
        }
        isLoading = true
        viewModel.fetchUsers { [weak self] (error) in
            self?.isLoading = false
        }
    }

}
