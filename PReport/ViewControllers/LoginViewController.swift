import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.isSecureTextEntry.toggle()
                setUpElements()
            }
            // Hide the error label
            func setUpElements() {
                errorLabel.alpha = 0
                
                // style the elements
                Utilities.styleTextField(emailTextField)
                Utilities.styleTextField(passwordTextField)
                Utilities.styleFilledButton(loginButton)
            }
            
            @IBAction func logInTapped(_ sender: Any) {
                
                let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
                let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
                
                Auth.auth().signIn(withEmail: email, password: password) { (_, error) in
                    if error != nil {
                        self.errorLabel.text = error?.localizedDescription
                        self.errorLabel.alpha  = 1
                    } else {
                        self.transitionToHome()
                    }
                }
            }
            
             func transitionToHome() {
                let tabViewController = self.storyboard?.instantiateViewController(
                    identifier: Constants.StoryBoard.tabViewController
                    ) as? TabViewController
                 
                self.view.window?.rootViewController = tabViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
