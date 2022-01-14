//
//  Employee.swift
//  EmployeesLogin_Biofourmis
//
//  Created by Ramya - Personal on 13/01/22.
//

import Foundation


struct Login:Decodable{
    var token:String?
    private enum LoginKeys : String,CodingKey{
        case token = "token"
        case error = "error"
    }
    
    init(from decoder:Decoder) throws{
        let container = try decoder.container(keyedBy: LoginKeys.self)
        self.token = try container.decode(String.self, forKey: .token)
    }
    
}

struct EmployeeList:Decodable{
    var data:[EmployeeData]
    
    private enum ListKeys :String,CodingKey{
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ListKeys.self)
        self.data = try container.decode([EmployeeData].self, forKey: .data)
    }
}
struct EmployeeData:Decodable{
    var id:Int
    var email:String
    var firstName:String
    var lastName:String
    var avatar:String
    
    private enum DataKeys : String,CodingKey{
        case id = "id"
        case email = "email"
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar = "avatar"
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DataKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.email = try container.decode(String.self, forKey: .email)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.avatar = try container.decode(String.self, forKey: .avatar)
        
    }
    
    
}
