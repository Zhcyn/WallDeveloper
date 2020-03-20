import UIKit
class ColorCell: UICollectionViewCell {
    @IBOutlet weak var colorView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func setupCell(color: UIColor) {
        DispatchQueue.main.async {
            self.colorView.backgroundColor = color
            self.colorView.addShadow(cornerRadius: 20, color: .black, offset: CGSize(width: 0.6, height: 0.3), opacity: 0.3, shadowRadius: 3)
        }
    }
}
extension ColorCell {
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    class var identifier: String {
        return String(describing: self)
    }
}
