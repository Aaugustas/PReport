import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

           setUpElements()
        }
    
        func setUpElements() {
            
            //  style the elements
            Utilities.styleFilledButton(loginButton)
            Utilities.styleHollowButton(signupButton)
    }
}
