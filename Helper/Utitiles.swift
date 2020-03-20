import Foundation
import UIKit
struct Utitiles {
    static func showAlerOneButton(title: String, mess: String, title_btn: String, viewController: UIViewController) {
        let ac = UIAlertController(title: title, message: mess, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: title_btn, style: .default))
        viewController.present(ac, animated: true)
    }
}
