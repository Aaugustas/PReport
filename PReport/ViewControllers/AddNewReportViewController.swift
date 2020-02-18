import UIKit

class AddNewReportViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var report = ReportsFactory().reports()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return report.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReportVC", for: indexPath)
        if let reportCell = cell as? ReportTableViewCell {
            let reports = report[indexPath.row]
            reportCell.configure(with: reports)
        }
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let reportVC = segue.destination as? ReportViewController,
            let reportType = sender as? Reports {
            reportVC.reporting = reportType
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let reportSelected = report[indexPath.row]
        
        performSegue(withIdentifier: "segue", sender: reportSelected)
    }
}
