import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore

class SignupViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signupButton: UIButton!
    
    let userDefault = UserDefaults.standard
    let launchedBefore = UserDefaults.standard.bool(forKey: "userSignedIn")

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    func setUpElements() {
        // hide the error button
        errorLabel.alpha = 0
            // style the elements
        Utilities.styleTextField(usernameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signupButton)
    }
            func validateFields() -> String? {
            // check that all fields are  filled in
                if usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                    emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                    passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
                    return "Please fill in all fields."
                }
            //check is the password  is secure
                let cleanedPassword = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
                
                if Utilities.isPasswordValid(cleanedPassword) == false {
                    //password  isin't secure enough
        return "Pleace make sure that password is at least 8 charactiers, contains special character and number."
                }
            return nil
        }
        
        @IBAction func signupTapped(_ sender: Any) {
            
        //  Validate the fields
            let error = validateFields()
            
            if let err = error {
                // there's something wrong with the fields, show error message.
                showError(message: err)
            } else {
                
         // Create cleaned versions of the data
                let username = usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
                let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
                let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
                
        // Create the user
                Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                    
                    //Check for errors
                    if err != nil {
                        // there no error
                        self.showError(message: "Error creaathing user")
                    } else {
                        
                        //User was created secsesful(y, now store the username.
                        let db = Firestore.firestore()
                        db.collection("Users").addDocument(data: ["username": username,
                                                                  "uid": result?.user.uid as Any]) { (error) in
                            
                            if error != nil {
                                //show error message
                                self.showError(message: "Error saving user data")
                            }
                        }
                        
                         // Transition to the home screen
                        self.transitionToHome()
                    }
                }
    }
}
        func showError(message: String) {
            errorLabel.text = message
            errorLabel.alpha = 1
        }
          // Transition to the home screen
             func  transitionToHome() {
                 
        let tabViewController = storyboard?.instantiateViewController(
            identifier: Constants.StoryBoard.tabViewController
        ) as? TabViewController
                 
                 view.window?.rootViewController = tabViewController
                 view.window?.makeKeyAndVisible()
    }
}
