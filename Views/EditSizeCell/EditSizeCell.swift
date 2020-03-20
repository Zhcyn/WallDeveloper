import UIKit
protocol EditSizeCellDelegate: class {
    func handleBgBlack()
    func handleBgWhite()
    func handleFillEqualScreen()
    func handleFillEqualImage()
}
class EditSizeCell: UICollectionViewCell {
    @IBOutlet weak var btnBlack: UIButton!
    @IBOutlet weak var btnWhite: UIButton!
    @IBOutlet weak var btnExpand: UIButton!
    @IBOutlet weak var btnMinimize: UIButton!
    weak var delegate: EditSizeCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func setupCell() {
        btnBlack.addShadow(cornerRadius: 5,color: .black, offset: CGSize(width: 0.3, height: 0.3), opacity: 0.3, shadowRadius: 1)
        btnBlack.layer.borderColor = UIColor.blue.cgColor
        btnBlack.layer.borderWidth = 1
        btnWhite.addShadow(cornerRadius: 5,color: .black, offset: CGSize(width: 0.3, height: 0.3), opacity: 0.3, shadowRadius: 1)
        btnWhite.layer.borderWidth = 0
        btnWhite.layer.borderColor = UIColor.blue.cgColor
        btnExpand.addShadow(cornerRadius: 5,color: .black, offset: CGSize(width: 0.3, height: 0.3),opacity: 0.3, shadowRadius: 1)
        btnMinimize.addShadow(cornerRadius: 5,color: .black, offset: CGSize(width: 0.3, height: 0.3), opacity: 0.3, shadowRadius: 1)
    }
    @IBAction func handleBlack(_ sender: Any) {
        btnBlack.layer.borderWidth = 1
        btnWhite.layer.borderWidth = 0
        delegate?.handleBgBlack()
    }
    @IBAction func handleWhite(_ sender: Any) {
        btnBlack.layer.borderWidth = 0
        btnWhite.layer.borderWidth = 1
        delegate?.handleBgWhite()
    }
    @IBAction func handleExpand(_ sender: Any) {
        delegate?.handleFillEqualScreen()
    }
    @IBAction func handleMinimumSize(_ sender: Any) {
        delegate?.handleFillEqualImage()
    }
}
extension EditSizeCell {
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    class var identifier: String {
        return String(describing: self)
    }
}
