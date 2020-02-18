import UIKit
import Firebase
import Foundation
import MessageUI

class AccountViewController: UIViewController,MFMailComposeViewControllerDelegate {
    @IBOutlet weak var closeView: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var shereButton: UIButton!
    @IBOutlet weak var systemRedView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUsername()
        roundCornersAndAddShadows()
    }
    
    func setUsername() {
        
        let db = Firestore.firestore()
        if let userId = Auth.auth().currentUser?.uid {
            
        db.collection("Users").getDocuments() { (snapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
        } else {
            if let currentUserDoc = snapshot?.documents.first(where: { ($0["uid"] as? String) == userId }) {
            let username = currentUserDoc["username"] as Any
            self.usernameLabel.text = username as? String
                }
            }
        }
    }
}
    func roundCornersAndAddShadows() {
        
        closeView.layer.cornerRadius = 5
        shereButton.layer.cornerRadius = 25
        systemRedView.layer.cornerRadius = 25
        systemRedView.layer.shadowColor = UIColor.gray.cgColor
        systemRedView.layer.shadowOpacity = 1
        systemRedView.layer.shadowOffset = .zero
        systemRedView.layer.shadowRadius = 10
        
    }
    @IBAction func logOutButton(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            let homeViewController = storyboard?.instantiateViewController(
                identifier: Constants.StoryBoard.homeViewController
            ) as? HomeViewController
            
            view.window?.rootViewController = homeViewController
            view.window?.makeKeyAndVisible()
            
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    @IBAction func shereiIdeasButton(_ sender: Any) {
        
        let mailComposeViewController = configureMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            
            self.present(mailComposeViewController, animated: true, completion: nil)
            
        } else {
            self.showSendMailErrorAlert()
        }
        
    }

    func configureMailComposeViewController() -> MFMailComposeViewController {
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setCcRecipients(["preport@preport.com"])
        
        return mailComposeVC
    }
    
    func showSendMailErrorAlert() {
        
        let sendMeilErrorAllert = UIAlertView(title: "could not send mail", message: "your account must have an active mail account", delegate: self, cancelButtonTitle: "OK")
        
        sendMeilErrorAllert.show()
        
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
