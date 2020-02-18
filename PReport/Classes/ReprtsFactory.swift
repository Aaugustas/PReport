import UIKit

class ReportsFactory {
    func reports() -> [Reports] {
        let police = Reports(report: "Policija",
                             reportIcon: UIImage(named: "PoliceCar"))
        let radar = Reports(report: "Trikojis radaras",
                            reportIcon: UIImage(named: "Radar"))
        let traffic = Reports(report: "Eismo spūstis",
                              reportIcon: UIImage(named: "TrafficLights"))
        let carCrash = Reports(report: "Avarija",
                               reportIcon: UIImage(named: "Warning"))
        return[police, radar, traffic, carCrash]
    }
}
