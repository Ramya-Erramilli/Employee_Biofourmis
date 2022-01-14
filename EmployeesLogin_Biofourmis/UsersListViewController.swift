//
//  UsersListViewController.swift
//  EmployeesLogin_Biofourmis
//
//  Created by Ramya - Personal on 13/01/22.
//

import UIKit

class UsersListViewController: UITableViewController {

    var users:[Employee]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setHidesBackButton(true, animated: true)
        
    }

    @IBAction func logoutActiob(_ sender: UIBarButtonItem) {
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
   
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! UserCell
        let currentUser = self.users?[indexPath.row]
        cell.nameLabel.text = currentUser!.firstName + " " + currentUser!.lastName
        cell.nameLabel.sizeToFit()
        cell.emailLabel.text = currentUser!.email
        cell.emailLabel.sizeToFit()
        let image = loadImage(url: currentUser!.avatar)
        cell.avatarLabel.image = image

        return cell
    }
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let destination = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "details") as! UserDetailsViewController
        let currentUser = self.users?[indexPath.row]
        destination.email = currentUser?.email
        destination.name = currentUser!.firstName + " " + currentUser!.lastName
        destination.image = loadImage(url: currentUser!.avatar)
        
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
    func loadImage(url:String)->UIImage?{
        let url = URL(string: url)
        let data = try? Data(contentsOf: url!)
        return UIImage(data: data!)
    }
}

class UserCell:UITableViewCell{
    @IBOutlet weak var avatarLabel: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
}
