import UIKit
protocol ColorsViewDelegate: class {
    func ontapDoneHideColorView()
    func DidChooseColor(color: UIColor)
}
class ColorsView: BaseView {
    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate: ColorsViewDelegate?
    var arrColor: [UIColor] = []
    override func firstInit() {
        getAllColors()
        setupCollectionView()
    }
    func getAllColors() {
        arrColor = Colors.colors
        collectionView.reloadData()
    }
    func setupCollectionView() {
        collectionView.register(ColorCell.nib, forCellWithReuseIdentifier: ColorCell.identifier)
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    func settextTitle(_ isTop: Bool) {}
}
extension ColorsView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrColor.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.identifier, for: indexPath) as! ColorCell
        cell.setupCell(color: arrColor[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 60)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.DidChooseColor(color: arrColor[indexPath.row])
    }
}
