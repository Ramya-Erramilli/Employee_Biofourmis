//
//  LoginViewModel.swift
//  EmployeesLogin_Biofourmis
//
//  Created by Ramya - Personal on 13/01/22.
//

import Foundation

class LoginViewModel{
    
    var onSuccess:((String)->Void)?
    var onError:((String)->Void)?
    var onFetch:(([Employee])->Void)?
    
    func fetchUsers(){
        
        var req = URLRequest(url: URL(string: API.url+API.Endpoints.userList.rawValue)!)
        req.httpMethod = HTTPMethods.Get.rawValue
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        
        var emps:[Employee] = []
        
        let task = session.dataTask(with: req) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, let receivedData = data
            else {
                print("error: not a valid http response")
                return
            }
            switch (httpResponse.statusCode)
            {
            case 200:
                
                do {
                    let getResponse = try JSONDecoder().decode(EmployeeList.self, from: receivedData)
                    DispatchQueue.main.async {
                        for emp in getResponse.data{
                            emps.append(Employee(id: emp.id, email: emp.email, firstName: emp.firstName, lastName: emp.lastName, avatar: emp.avatar))
                        }
                        self.onFetch?(emps)
                    }
                } catch {
                    print("error serializing JSON: \(error)")
                }
                break
            default:
                DispatchQueue.main.async {
                    self.onError?("Error")
                }
                print("API request status code: \(httpResponse.statusCode)")
            }
            
        }
        task.resume()
    }
    
    func sendLoginRequest(loginJSON:Dictionary<String ,String>) {
        var request = URLRequest(url: URL(string: API.url+API.Endpoints.login.rawValue)!)
        request.httpMethod = HTTPMethods.Post.rawValue
        request.httpBody = try? JSONSerialization.data(withJSONObject: loginJSON, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data,response,error -> Void in
            guard let httpResponse = response as? HTTPURLResponse, let receivedData = data
            else {
                print("error: not a valid http response")
                return
            }
            switch (httpResponse.statusCode)
            {
            case 200:
                
                do {
                    let getResponse = try JSONDecoder().decode(Login.self, from: receivedData)
                    print(getResponse)
                    DispatchQueue.main.async {
                        self.onSuccess?("Success")
                    }
                } catch {
                    print("error serializing JSON: \(error)")
                }
                break
            default:
                DispatchQueue.main.async {
                    self.onError?("Error")
                }
                print("API request status code: \(httpResponse.statusCode)")
            }
        }
        task.resume()
    }
}
