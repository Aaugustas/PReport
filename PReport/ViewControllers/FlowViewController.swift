import UIKit
import Firebase
import FirebaseFirestore
import FirebaseCore
import FirebaseAuth

class FlowViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let db = Firestore.firestore()
    var report: [Report] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constants.StoryBoard.reportNib, bundle: nil),
                           forCellReuseIdentifier: Constants.StoryBoard.reportCellIndentifier)
       loadReports()
    }
    
    func loadReports() {
        db.collection(Constants.Firebase.reportCollection)
            .order(by: Constants.Firebase.dateField, descending: true)
            .addSnapshotListener { (querySnapshot, error) in
            
            self.report = []
            
            if let err = error {
                print("error retriving data form Firestore \(err)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let reportSender = data[Constants.Firebase.senderField] as? String,
                        let reportBody = data[Constants.Firebase.reportField]as? String,
                        let reportTitle = data[Constants.Firebase.reportTitleField] as? String,
                        let reportIcon = data["image"] as? String {
                            let newReport = Report(sender: reportSender,
                                                   report: reportBody,
                                                   reportTitle: reportTitle,
                                                   reportTime: "0 min. ",
                                                   reportIcon: UIImage(named: reportIcon))
                                
                            self.report.append(newReport)
                        
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
}
extension FlowViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return report.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.StoryBoard.reportCellIndentifier, for: indexPath)
        
        if let reportCell = cell as? ReportsCell {
            let reports = report[indexPath.row]
            reportCell.configure(with: reports)
            
        }
        return cell
    }
}
