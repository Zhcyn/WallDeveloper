import UIKit
class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    func dismiss() {
        guard let _ = self.navigationController?.popViewController(animated: true) else {
            self.dismiss(animated: true, completion: nil)
            return
        }
    }
    func addShadow(view: UIView) {
        view.addShadow(cornerRadius: 0, color: .black, offset: CGSize(width: 0.6, height: 0.3), opacity: 0.3, shadowRadius: 3)
    }
}
