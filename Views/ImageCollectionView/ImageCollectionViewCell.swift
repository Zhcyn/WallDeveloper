import UIKit
class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var viewBackGround: UIView!
    @IBOutlet weak var imageView: UIImageView!
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    class var identifier: String {
        return String(describing: self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        viewBackGround.addShadow(cornerRadius: 0, color: .black, offset: CGSize(width: 0.6, height: 0.3), opacity: 0.3, shadowRadius: 3)
    }
}
