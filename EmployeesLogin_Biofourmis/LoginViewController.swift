//
//  LoginViewController.swift
//  EmployeesLogin_Biofourmis
//
//  Created by Ramya - Personal on 13/01/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTxtField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    var viewModel:LoginViewModel?
    var employeesList:[Employee]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginViewModel()
        self.spinner.isHidden = true
        self.blurView.isHidden = true
    }
    
    private func showSpinner() {
        spinner.isHidden = false
        self.blurView.isHidden = false
        spinner.startAnimating()
        
    }

    private func hideSpinner() {
        self.spinner.isHidden = true
        self.blurView.isHidden = true
        spinner.stopAnimating()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.viewModel?.onSuccess = { _ in
            self.viewModel?.fetchUsers()
        }
        self.viewModel?.onError = { _ in
            let alert = UIAlertController(title: "Invalid credentials", message: "Username or password is empty.\n Enter valid username and password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        
        self.viewModel?.onFetch = { employees in
            self.employeesList = employees
            self.performSegue(withIdentifier: "list", sender: self)
            self.hideSpinner()
        }
        
    }
    
    @IBAction func loginUser(_ sender: UIButton) {
        if let username = usernameTxtField.text,let password = passwordTextField.text {
            let loginJSON = createLoginJSON(username: username, password: password)
            self.viewModel?.sendLoginRequest(loginJSON: loginJSON)
            self.showSpinner()
        }
    }
    
    func createLoginJSON(username:String,password:String)->Dictionary<String ,String>{
        var dict:Dictionary<String,String> = Dictionary()
        dict["email"] = username
        dict["password"] = password
        return dict
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! UsersListViewController
        dest.users = self.employeesList
    }
    
}


