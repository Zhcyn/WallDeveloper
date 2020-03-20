import UIKit
class HomeViewController: BaseViewController {
    @IBOutlet weak var btnCreate: UIButton!
    private let imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    private func setUpView() {
        imagePicker.delegate = self
        btnCreate.layer.borderWidth = 2
        btnCreate.layer.cornerRadius = 8
        btnCreate.layer.borderColor = UIColor.red.cgColor
    }
    private func presentToEditSizeViewController(_ image: UIImage) {
        let editVC = EditSizeViewController()
        editVC.imagePicker = image
        self.present(editVC, animated: true, completion: nil)
    }
    @IBAction func handleCreateWallpaper(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    }
}
extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            dismiss(animated: true, completion: nil)
            self.presentToEditSizeViewController(pickedImage)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
