import Foundation
import UIKit
class CustomNavigation: UINavigationController {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationBar.isOpaque = true
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = false
    }
}
