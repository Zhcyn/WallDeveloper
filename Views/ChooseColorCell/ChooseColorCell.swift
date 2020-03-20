import UIKit
protocol ChooseColorCellDelegate: class {
    func onTapShowColorView(isTop: Bool)
}
class ChooseColorCell: UICollectionViewCell {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    class var identifier: String {
        return String(describing: self)
    }
    weak var delegate: ChooseColorCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        topView.backgroundColor = .black
        bottomView.backgroundColor = .black
        topView.addShadow(cornerRadius: 17, color: .black, offset: CGSize(width: 0.6, height: 0.3), opacity: 0.3, shadowRadius: 3)
        bottomView.addShadow(cornerRadius: 17, color: .black, offset: CGSize(width: 0.6, height: 0.3), opacity: 0.3, shadowRadius: 3)
        topView.isUserInteractionEnabled = true
        let gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTap_Top))
        gesture.numberOfTapsRequired = 1
        topView.addGestureRecognizer(gesture)
        bottomView.isUserInteractionEnabled = true
        let gestureBottom:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTap_Bottom))
        gesture.numberOfTapsRequired = 1
        bottomView.addGestureRecognizer(gestureBottom)
    }
    @objc
    func onTap_Top() {
        delegate?.onTapShowColorView(isTop: true)
    }
    @objc
    func onTap_Bottom() {
        delegate?.onTapShowColorView(isTop: false)
    }
}
