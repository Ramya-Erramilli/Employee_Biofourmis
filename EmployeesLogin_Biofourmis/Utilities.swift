//
//  Utilities.swift
//  EmployeesLogin_Biofourmis
//
//  Created by Ramya - Personal on 14/01/22.
//

import Foundation

enum HTTPMethods:String{
    case Post = "POST"
    case Get = "GET"
}

struct Employee{
    var id:Int
    var email:String
    var firstName:String
    var lastName:String
    var avatar:String
}

struct API{
    static var url = "https://reqres.in"
    
    enum Endpoints:String{
        case login = "/api/login"
        case userDetails = "/api/users"
        case userList = "/api/users?page=2"
    }
}
