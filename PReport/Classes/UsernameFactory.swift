import Foundation
import Firebase

class UsernameFactory {
    static func setUsername() {
        
        let db = Firestore.firestore()
        if let userId = Auth.auth().currentUser?.uid {
            
        db.collection("Users").getDocuments() { (snapshot, error) in
            if let currentUserDoc = snapshot?.documents.first(where: { ($0["uid"] as? String) == userId }) {
            let username = currentUserDoc["username"] as Any
                    }
                }
            }
        }
    }
