import UIKit
class Loading {
    static let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
    class func showloading(viewcontroller: UIViewController) {
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        viewcontroller.present(alert, animated: true, completion: nil)
    }
    class func hideLoading(viewcontroller: UIViewController, complete: (()->Void)? = nil) {
        alert.removeFromParent()
        viewcontroller.dismiss(animated: true, completion: complete)
    }
}
