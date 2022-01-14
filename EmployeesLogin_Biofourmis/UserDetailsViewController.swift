//
//  UserDeatilsViewController.swift
//  EmployeesLogin_Biofourmis
//
//  Created by Ramya - Personal on 13/01/22.
//

import UIKit

class UserDetailsViewController: UIViewController {

    var image:UIImage?
    var name:String?
    var email:String?
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .plain, target: self, action:#selector(logout)), animated: true)
        
        userName.text = name
        avatar.image = image
        emailLabel.text = email
        
        userName.sizeToFit()
        emailLabel.sizeToFit()

    }
    
    @objc func logout(){
        self.navigationController?.popToRootViewController(animated: true)
    }

}
