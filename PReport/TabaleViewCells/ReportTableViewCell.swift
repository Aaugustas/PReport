import UIKit

class ReportTableViewCell: UITableViewCell {
    @IBOutlet weak var reportImage: UIImageView!
    @IBOutlet weak var reportLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with report: Reports) {
        reportLabel.text = report.report
        reportImage.image = report.reportIcon
    }
}
