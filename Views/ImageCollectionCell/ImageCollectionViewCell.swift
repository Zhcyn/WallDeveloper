import UIKit
class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var viewBackGround: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var aspectIphoneX: NSLayoutConstraint!
    @IBOutlet weak var aspectIphoneBasic: NSLayoutConstraint!
    @IBOutlet weak var containerVIew: UIView!
    private var imageLayer = CALayer()
    var isClock: Bool!
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    class var identifier: String {
        return String(describing: self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        viewBg.layer.borderWidth = 0.5
        viewBg.layer.backgroundColor = UIColor.black.cgColor
        setUpLayout()
        setUplayer()
    }
    private func setUpLayout() {
        if Constants.SCREEN_HEIGHT >= 812 {
            aspectIphoneX.isActive = true
            aspectIphoneBasic.isActive = false
        } else {
            aspectIphoneX.isActive = false
            aspectIphoneBasic.isActive = true
        }
    }
    private func setUplayer() {
        imageLayer.contentsGravity = CALayerContentsGravity.resizeAspect
        imageLayer.contentsScale = UIScreen.main.scale
        self.containerVIew.layer.addSublayer(imageLayer)
    }
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        if(isClock) {
            let width = containerVIew.bounds.width
            (Constants.SCREEN_HEIGHT_IpX > Int(Constants.SCREEN_HEIGHT) ) ? (imageLayer.frame = viewBg.bounds) : (imageLayer.frame = CGRect(x: 0, y: Constants.STATUS_BAR, width: width, height: width*2048/946))
            imageLayer.contents = #imageLiteral(resourceName: "clock.png").cgImage
        } else {
            let width = containerVIew.bounds.size.width - 20
            imageLayer.frame = CGRect(x: 10, y: Constants.STATUS_BAR, width: width, height: width*1464/966)
            imageLayer.contents = #imageLiteral(resourceName: "Apps").cgImage
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        viewBackGround.addShadow(cornerRadius: 0, color: .black, offset: CGSize(width: 0.6, height: 0.3), opacity: 0.3, shadowRadius: 3)
        setUplayer()
        let width = viewBackGround.bounds.width
        print(width)
    }
}
