import UIKit
import AVFoundation
class ShowImageViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnSave: UIButton!
    var imageEditSize: UIImage!
    var imageEdit: ImageEdit!
    private var heightCell: CGFloat = 0.0
    private var widthtCell: CGFloat = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpCollectionView()
    }
    private func setUpView() {
        btnSave.addShadow(cornerRadius: 8, color: .black, offset: CGSize(width: 0.6, height: 0.3), opacity: 0.3, shadowRadius: 3)
    }
    private func setUpCollectionView() {
        collectionView.register(ImageCollectionViewCell.nib, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        collectionView.isPagingEnabled = true
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            Loading.hideLoading(viewcontroller: self, complete: {
                Utitiles.showAlerOneButton(title: Save_error, mess: error.localizedDescription, title_btn: OK, viewController: self)
            })
        } else {
            Loading.hideLoading(viewcontroller: self, complete: {
                Utitiles.showAlerOneButton(title: Saved, mess: Save_Image_Success, title_btn: OK, viewController: self)
            })
        }
    }
}
extension ShowImageViewController {
    @IBAction func handleSave(_ sender: UIButton) {
        Loading.showloading(viewcontroller: self)
        UIImageWriteToSavedPhotosAlbum(imageEditSize, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    @IBAction func handleCancel(_ sender: UIButton) {
        guard let window = self.view.window else { return }
        window.rootViewController?.dismiss(animated: true, completion: nil)
    }
    @IBAction func handleBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension ShowImageViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as! ImageCollectionViewCell
        cell.imageView.image = imageEditSize
        cell.isClock = indexPath.row == 0 ? true : false
        cell.layoutIfNeeded()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.bounds.height - 32
        heightCell = height
        widthtCell = Constants.SCREEN_HEIGHT >= 812 ? height*9/19.5 : height*9/16
        return CGSize(width: widthtCell, height: heightCell)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
}
