//
//  UsersViewModel.swift
//  Assignment
//
//  Created by Hitesh on 15/02/21.
//

import Foundation

struct UserDataSource {
    let userSerialNumber : String
    let avatar : String
    let name : String
    let email : String
    
    init(_ model:User) {
        self.userSerialNumber = "Serial Number : " + "\(model.id)"
        self.avatar = model.avatar
        self.name = "Name : " + model.firstName + " " + model.lastName
        self.email = "Email : " + model.email
    }
}

class UsersViewModel {
    
    private var users:[User] = []
    private var userResponse:UserResponse?
    private var nextPage = 0
    private var totalPage = 1
    var userDataSource:[UserDataSource] = []
    
    
    init(nextPage:Int = 0 ) {
        self.nextPage = nextPage
    }
    // Fetch users list
    func fetchUsers(completion:@escaping(Error?) -> Void) {
        nextPage += 1
        guard let url = URL(string: ServerEndPoint.users.get() + "?page=\(nextPage)") else { return }
        debugPrint("Url :- ",url.absoluteURL)
        Webservice.get(url: url) { [weak self] (data, urlResponse, error) in
            if let data = data, error == nil {
                do {
                    let response = try JSONDecoder().newJSONDecoder().decode(UserResponse.self, from: data)
                    self?.userDataSource += response.data.map{UserDataSource($0)}
                    self?.users += response.data
                    self?.totalPage = response.totalPages
                } catch {
                    debugPrint("\(url) Error is:- ",error.localizedDescription)
                }
            } else {
                self?.nextPage -= 1
            }
            DispatchQueue.main.async {
                completion(error)
            }
        }
    }
    
    func isPagingAvailable() -> Bool {
        return  nextPage < totalPage
    }
}
