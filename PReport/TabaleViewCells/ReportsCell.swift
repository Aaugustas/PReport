import UIKit

class ReportsCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var reportTime: UILabel!
    @IBOutlet weak var reportTitle: UILabel!
    @IBOutlet weak var reportLabel: UILabel!
    @IBOutlet weak var reportSender: UILabel!
    @IBOutlet weak var someView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        roundCornersAndSetCollor()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(with reports: Report) {
        reportTitle.text = reports.reportTitle
        reportLabel.text = reports.report
        reportSender.text = reports.sender
        reportTime.text = reports.reportTime
        iconImageView.image = reports.reportIcon
    }
 
    func roundCornersAndSetCollor() {
        someView.layer.cornerRadius = 11.5
        someView.backgroundColor  =  .red
        reportTitle.textColor = .blue
    }
}
