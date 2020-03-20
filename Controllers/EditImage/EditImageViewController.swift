import UIKit
class EditImageViewController: BaseViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var containerImv: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var width_containerImv: NSLayoutConstraint!
    @IBOutlet weak var leftContainerView: NSLayoutConstraint!
    @IBOutlet weak var containerButtonView: UIView!
    @IBOutlet weak var rightContainerView: NSLayoutConstraint!
    @IBOutlet weak var btnAdjust: UIButton!
    @IBOutlet weak var btnBackground: UIButton!
    @IBOutlet weak var imvEdit: UIImageView!
    @IBOutlet weak var lblAjust: UILabel!
    @IBOutlet weak var imvBackground: UIImageView!
    @IBOutlet weak var lblBackground: UILabel!
    var imageEditSize: UIImage!
    private let colorView                       = ColorsView()
    private var isOpenColorSheetByTop: Bool     = true
    private var colorTop                        = UIColor.white
    private var colorBottom                     = UIColor.white
    private let gradientLayer                   = CAGradientLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        addActionSuperView()
        setupCollectionView()
        addColorView()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.calculatorLayout()
    }
    func setupCollectionView() {
        collectionView.register(FilterImageCell.nib, forCellWithReuseIdentifier: FilterImageCell.identifier)
        collectionView.register(ChooseColorCell.nib, forCellWithReuseIdentifier: ChooseColorCell.identifier)
        collectionView.register(EditSizeCell.nib, forCellWithReuseIdentifier: EditSizeCell.identifier)
        collectionView.isPagingEnabled = true
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        setScrollEnable(false)
        collectionView.collectionViewLayout = layout
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    func addColorView() {
        self.view.addSubview(colorView)
        self.containerImv.layer.insertSublayer(gradientLayer, at:0)
        self.imageView.addBlurEffect()
        colorView.delegate = self
        colorView.translatesAutoresizingMaskIntoConstraints = false
        colorView.bottomAnchor.constraint(equalTo: self.containerButtonView.bottomAnchor, constant: 0).isActive = true
        colorView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        colorView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        colorView.heightAnchor.constraint(equalToConstant: 205).isActive = true
        colorView.alpha = 0
    }
    func addActionSuperView() {
        let gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapSuperView))
        gesture.numberOfTapsRequired = 1
        gesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(gesture)
    }
    func calculatorConstant(_ constant: CGFloat) {
        leftContainerView.constant = constant
        rightContainerView.constant = constant
        DispatchQueue.main.async {
            self.containerImv.addDashedBorder()
            self.addShadow(view: self.containerView)
            self.btnAdjust.layer.cornerRadius = 5
            self.btnBackground.layer.cornerRadius = 5
            self.addShadow(view: self.btnAdjust)
            self.addShadow(view: self.btnBackground)
        }
    }
    func setScrollEnable(_ bool: Bool) {collectionView.isScrollEnabled = bool}
    func clvScrolltoIndex(_ index: Int) {
        collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .left, animated: true)
    }
    func showColorView() {
        UIView.animate(withDuration: 0.3) {
            self.colorView.alpha = 1
        }
    }
    func hideColorView() {
        UIView.animate(withDuration: 0.3) {
            self.colorView.alpha = 0
        }
    }
    func calculatorLayout() {
        imageView.image = imageEditSize
        if Int(Constants.SCREEN_HEIGHT) > Constants.SCREEN_HEIGHT_Ip6Plus {
            width_containerImv.constant = imageView.frame.size.height * (9.0/19.5)
            calculatorConstant(55)
            return
        }
        width_containerImv.constant = imageView.frame.size.height * (9.0/16.0)
        if (Int(Constants.SCREEN_HEIGHT) == Constants.SCREEN_HEIGHT_Ip6Plus) {
            calculatorConstant(65)
            return
        }
        if (Int(Constants.SCREEN_HEIGHT) < Constants.SCREEN_HEIGHT_Ip6Plus) {
            calculatorConstant(70)
            return
        }
    }
    func setColorSelectedButton(isAjust: Bool) {
        if isAjust {
            imvEdit.image = UIImage(named: "edit")
            lblAjust.textColor = UIColor(hexString: "#009AF2")
            imvBackground.image = UIImage(named: "un_color")
            lblBackground.textColor = UIColor(hexString: "#6C818D")
        } else {
            imvEdit.image = UIImage(named: "un_edit")
            lblAjust.textColor = UIColor(hexString: "#6C818D")
            imvBackground.image = UIImage(named: "color")
            lblBackground.textColor = UIColor(hexString: "#009AF2")
        }
    }
    @IBAction func onPress_Back(_ sender: Any) {self.dismiss()}
    @IBAction func onPress_Yes(_ sender: Any) {}
    @IBAction func action_choseFilter(_ sender: UIButton) {
        (sender.tag == 0) ? (clvScrolltoIndex(0)) : (clvScrolltoIndex(1))
        setColorSelectedButton(isAjust: sender.tag == 0)
    }
}
extension EditImageViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        switch indexPath.row {
        case 0:
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
        return CGSize(width: Constants.SCREEN_WIDTH, height: collectionView.frame.size.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollView.isScrollEnabled = false
    }
}
extension EditImageViewController: FilterImageCellDelegate, ChooseColorCellDelegate, ColorsViewDelegate {
    func onChangeSlider(type: typeSlider, value: CGFloat) {
        switch type {
        case .Brightness:
            let parameters = ["inputBrightness": value]
            imageView.image = imageEditSize.imageFiltered(withCoreImageFilter: "CIColorControls", parameters: parameters)
            break
        case .Contrast:
            let parameters = [kCIInputContrastKey: 1 + value]
            imageView.image = imageEditSize.imageFiltered(withCoreImageFilter: "CIColorControls", parameters: parameters)
            break
        case .Blur:
            if let blurredEffectView = imageView.subviews.filter({$0 is UIVisualEffectView}).first {
                blurredEffectView.alpha = value
            }
            break
        }
    }
    func onEndEditSlider(type: typeSlider, value: CGFloat) {
        switch type {
        case .Brightness:
            break
        case .Contrast:
            break
        case .Blur:
            break
        }
    }
    func onTapShowColorView(isTop: Bool) {
        isOpenColorSheetByTop = isTop
        colorView.settextTitle(isTop)
        showColorView()
    }
    func ontapDoneHideColorView() {
        hideColorView()
    }
    func DidChooseColor(color: UIColor) {
        isOpenColorSheetByTop ? (colorTop = color) : (colorBottom = color)
        getCell()
        setGradientBackground()
    }
    func getCell() {
        guard let cell = collectionView.cellForItem(at: IndexPath(row: 1, section: 0)) as? ChooseColorCell else {return}
        cell.topView.backgroundColor = colorTop
        cell.bottomView.backgroundColor = colorBottom
    }
    @objc
    func onTapSuperView() {
        setGradientBackground()
    }
    func setGradientBackground() {
        gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.containerImv.bounds
    }
}
