import UIKit
import AVFoundation;
class EditSizeViewController: BaseViewController {
    @IBOutlet weak var viewBackGround: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var viewDashed: UIView!
    @IBOutlet weak var aspectIphoneBasic: NSLayoutConstraint!
    @IBOutlet weak var aspectIphoneX: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var containerImg: UIView!
    @IBOutlet weak var topBottomView: NSLayoutConstraint!
    @IBOutlet var RotateTouch: UIRotationGestureRecognizer!
    @IBOutlet var panTouch: UIPanGestureRecognizer!
    @IBOutlet var pinchTouch: UIPinchGestureRecognizer!
    private var imageLayer                      = CALayer()
    private var colorTop                        = UIColor.black
    private var colorBottom                     = UIColor.black
    private let gradientLayer                   = CAGradientLayer()
    private let viewColor                       = ColorsView()
    private var indexScroll: Int                = 0
    private var isTop: Bool                     = true
    private var firstPointImage: CGPoint!
    var imagePicker: UIImage!
}
extension EditSizeViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpGestureRecognizer()
        containerImg.layer.insertSublayer(gradientLayer, at:0)
        setUpLayout()
        setUpView()
        setupCollectionView()
        addColorView()
        setUplayer()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewBackGround.addShadow(cornerRadius: 0, color: .black, offset: CGSize(width: 0.6, height: 0.3), opacity: 0.3, shadowRadius: 3)
        viewDashed.addDashedBorder()
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
        self.viewDashed.layer.addSublayer(imageLayer)
    }
    private func setUpView() {
        imageView.image = imagePicker
        firstPointImage = imageView.frame.origin
        viewDashed.clipsToBounds = true
        self.imageView.addBlurEffect()
    }
    private func setUpGestureRecognizer() {
        RotateTouch.cancelsTouchesInView = false
        panTouch.cancelsTouchesInView = false
        pinchTouch.cancelsTouchesInView = false
        RotateTouch.delegate = self
        pinchTouch.delegate = self
    }
    private func setupCollectionView() {
        collectionView.register(FilterImageCell.nib, forCellWithReuseIdentifier: FilterImageCell.identifier)
        collectionView.register(ChooseColorCell.nib, forCellWithReuseIdentifier: ChooseColorCell.identifier)
        collectionView.register(EditSizeCell.nib, forCellWithReuseIdentifier: EditSizeCell.identifier)
        collectionView.isPagingEnabled = true
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.isScrollEnabled = false
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    private func addColorView() {
        self.view.addSubview(viewColor)
        self.viewColor.alpha = 0
        self.viewColor.addShadow(cornerRadius: 0, color: .black, offset: CGSize(width: 0.6, height: 0.3), opacity: 0.3, shadowRadius: 3)
        viewColor.frame = CGRect(x: 0, y: Int(Constants.SCREEN_HEIGHT - 160), width: Int(Constants.SCREEN_WIDTH), height: 160)
        viewColor.delegate = self
    }
    private func animateAspectImage( mode: UIView.ContentMode) {
        UIView.animate(withDuration: 0.3) {
            self.imageView.transform = .identity
            self.imageView.frame.origin = self.firstPointImage
            self.imageView.contentMode = mode
        }
    }
    private func showColorView() {
        viewColor.settextTitle(isTop)
        UIView.animate(withDuration: 0.3) {
            self.viewColor.alpha = 1
        }
    }
    private func hideColorView() {
        UIView.animate(withDuration: 0.3) {
            self.viewColor.alpha = 0
        }
    }
    private func setGradientBackground() {
        gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.viewDashed.bounds
    }
    private func setcolorDefault(color: UIColor) {
        colorTop = color
        colorBottom = color
        setGradientBackground()
    }
}
extension EditSizeViewController: UIGestureRecognizerDelegate
{
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
extension EditSizeViewController
{
    @IBAction func act_Pre(_ sender: Any) {
        if(indexScroll <= 2 && indexScroll > 0) {
            indexScroll -= 1
            collectionView.scrollToItem(at: IndexPath(row: indexScroll, section: 0), at: .left, animated: true)
        }
    }
    @IBAction func act_Next(_ sender: Any) {
        if(indexScroll < 2 && indexScroll >= 0) {
            indexScroll += 1
            collectionView.scrollToItem(at: IndexPath(row: indexScroll, section: 0), at: .left, animated: true)
        }
    }
    @IBAction func handleBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func handleSuccess(_ sender: UIButton) {
        let showVC = ShowImageViewController()
        let img = containerImg.takeScreenshot()
        showVC.imageEditSize = img
        self.present(showVC, animated: true, completion: nil)
    }
    @IBAction func handleChangValueSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            imageLayer.contents = nil
            break
        case 1:
            let width = viewDashed.bounds.size.width
            (Constants.SCREEN_HEIGHT_IpX > Int(Constants.SCREEN_HEIGHT) ) ? (imageLayer.frame = viewDashed.bounds) : (imageLayer.frame = CGRect(x: 0, y: Constants.STATUS_BAR, width: width, height: width*2048/946))
            imageLayer.contents = #imageLiteral(resourceName: "clock").cgImage
            break
        case 2:
            let width = viewDashed.bounds.size.width - 20
            imageLayer.frame = CGRect(x: 10, y: Constants.STATUS_BAR, width: width, height: width*1464/966)
            imageLayer.contents = #imageLiteral(resourceName: "Apps").cgImage
            break
        default:
            break
        }
    }
}
extension EditSizeViewController: FilterImageCellDelegate, ChooseColorCellDelegate, ColorsViewDelegate, EditSizeCellDelegate
{
    func handleBgBlack() {
        containerImg.backgroundColor = .black
        setcolorDefault(color: .black)
    }
    func handleBgWhite() {
        containerImg.backgroundColor = .white
        setcolorDefault(color: .white)
    }
    func handleFillEqualScreen() {
        if imageView.contentMode == .scaleAspectFill && firstPointImage == imageView.frame.origin {
            imageView.shake()
        } else {
            animateAspectImage(mode: .scaleAspectFill)
        }
    }
    func handleFillEqualImage() {
        animateAspectImage(mode: .scaleAspectFit)
    }
    func onChangeSlider(type: typeSlider, value: CGFloat) {
        switch type {
        case .Brightness:
            let parameters = [kCIInputBrightnessKey: value]
            imageView.image = imagePicker.imageFiltered(withCoreImageFilter: "CIColorControls", parameters: parameters)
            break
        case .Contrast:
            let parameters = [kCIInputContrastKey: 1 + value]
            imageView.image = imagePicker.imageFiltered(withCoreImageFilter: "CIColorControls", parameters: parameters)
            break
        case .Blur:
            if let blurredEffectView = imageView.subviews.filter({$0 is UIVisualEffectView}).first {
                blurredEffectView.alpha = value
            }
            break
        }
        enableGesture()
    }
    func onEndEditSlider(type: typeSlider, value: CGFloat) {
        enableGesture()
    }
    func onTapShowColorView(isTop: Bool) {
        self.isTop = isTop
        showColorView()
    }
    func ontapDoneHideColorView() {
        getCell()
    }
    func DidChooseColor(color: UIColor) {
        if(isTop) {
            colorTop = color
            setGradientBackground()
        } else {
            colorBottom = color
            setGradientBackground()
        }
        hideColorView()
        getCell()
    }
    private func getCell() {
        guard let cell = collectionView.cellForItem(at: IndexPath(row: 2, section: 0)) as? ChooseColorCell else {return}
        cell.topView.backgroundColor = colorTop
        cell.bottomView.backgroundColor = colorBottom
    }
    private func enableGesture() {
        RotateTouch.isEnabled = false
        panTouch.isEnabled = false
        pinchTouch.isEnabled = false
    }
}
extension EditSizeViewController
{
    @IBAction func handlePinGesture(_ sender: UIPinchGestureRecognizer) {
        if sender.scale > 0.3 {
            let pinchView = imageView
            let bounds = pinchView?.bounds
            var pinchCenter: CGPoint? = nil
            if let pinchView = pinchView {
                pinchCenter = sender.location(in: pinchView)
            }
            pinchCenter?.x -= bounds!.midX
            pinchCenter?.y -= bounds!.midY
            var transform = pinchView?.transform
            transform = transform!.translatedBy(x: pinchCenter!.x, y: pinchCenter!.y)
            let scale = sender.scale
            transform = transform?.scaledBy(x: scale, y: scale)
            transform = transform?.translatedBy(x: -(pinchCenter?.x ?? 0.0), y: -(pinchCenter?.y ?? 0.0))
            if let transform = transform {
                pinchView?.transform = transform
            }
            sender.scale = 1.0
        }
    }
    @IBAction func handleRotateGesture(_ sender: UIRotationGestureRecognizer) {
        let pinchView = imageView
        let bounds = pinchView?.bounds
        var pinchCenter: CGPoint? = nil
        if let pinchView = pinchView {
            pinchCenter = sender.location(in: pinchView)
        }
        pinchCenter?.x -= bounds!.midX
        pinchCenter?.y -= bounds!.midY
        var transform = pinchView?.transform
        transform = transform!.translatedBy(x: pinchCenter!.x, y: pinchCenter!.y)
        let rotation = sender.rotation
        transform = transform?.rotated(by: rotation)
        transform = transform?.translatedBy(x: -(pinchCenter?.x ?? 0.0), y: -(pinchCenter?.y ?? 0.0))
        if let transform = transform {
            pinchView?.transform = transform
        }
        sender.rotation = 0
    }
    @IBAction func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        imageView.center = CGPoint(x: imageView.center.x + translation.x, y: imageView.center.y + translation.y)
        sender.setTranslation(.zero, in: self.view)
    }
}
extension EditSizeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        switch indexPath.row {
        case 0:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: EditSizeCell.identifier, for: indexPath) as! EditSizeCell
            (cell as! EditSizeCell).setupCell()
            (cell as! EditSizeCell).delegate = self
        case 1:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterImageCell.identifier, for: indexPath) as! FilterImageCell
            (cell as! FilterImageCell).delegate = self
            break
        default:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChooseColorCell.identifier, for: indexPath) as! ChooseColorCell
            (cell as! ChooseColorCell).delegate = self
            break
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.SCREEN_WIDTH - 90, height: collectionView.frame.size.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollView.isScrollEnabled = false
    }
}
