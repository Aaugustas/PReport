import UIKit
import Firebase
import FirebaseDatabase

class ReportViewController: UIViewController {
    @IBOutlet weak var reportTextField: UITextField!
    let db = Firestore.firestore()
    var reporting: Reports?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpReport()
}
    func setUpReport() {
        title = reporting?.report
}
    @IBAction func reportButton(_ sender: Any) {
        if reportTextField.text != "" {
        if let someReport = reportTextField.text,
            let email = Auth.auth().currentUser?.email {
            
            if title == "Policija" {
            db.collection(Constants.Firebase.reportCollection).addDocument(data: [
                Constants.Firebase.reportTitleField: "Policija",
                Constants.Firebase.reportField: someReport,
                Constants.Firebase.senderField: email,
                Constants.Firebase.dateField: Date().timeIntervalSince1970,
                "image": "PoliceCar"
                ])
            } else if title == "Trikojis radaras" {
            db.collection(Constants.Firebase.reportCollection).addDocument(data: [
                Constants.Firebase.reportTitleField: "Trikojis radaras",
                Constants.Firebase.reportField: someReport,
                Constants.Firebase.senderField: email,
                Constants.Firebase.dateField: Date().timeIntervalSince1970,
                "image": "Radar"
                ])
            } else if title == "Eismo spūstis" {
            db.collection(Constants.Firebase.reportCollection).addDocument(data: [
                Constants.Firebase.reportTitleField: "Eismo spūstis",
                Constants.Firebase.reportField: someReport,
                Constants.Firebase.senderField: email,
                Constants.Firebase.dateField: Date().timeIntervalSince1970,
                "image": "TrafficLights"
                ])
            } else if title == "Avarija" {
            db.collection(Constants.Firebase.reportCollection).addDocument(data: [
                Constants.Firebase.reportTitleField: "Avarija",
                Constants.Firebase.reportField: someReport,
                Constants.Firebase.senderField: email,
                Constants.Firebase.dateField: Date().timeIntervalSince1970,
                "image": "Warning"
                ])
                }
            }
            
            let flowVC = storyboard?.instantiateViewController(identifier: "flowVC") as? FlowViewController
            
            try! navigationController?.pushViewController(flowVC!, animated: true)
            
        }
    }
}
