import UIKit
enum typeSlider {
    case Brightness
    case Contrast
    case Blur
}
protocol FilterImageCellDelegate: class {
    func onChangeSlider(type: typeSlider, value: CGFloat)
    func onEndEditSlider(type: typeSlider, value: CGFloat)
}
class FilterImageCell: UICollectionViewCell {
    weak var delegate: FilterImageCellDelegate?
    @IBOutlet weak var brightness_slider: UISlider!
    @IBOutlet weak var contrast_slider: UISlider!
    @IBOutlet weak var blur_slider: UISlider!
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    class var identifier: String {
        return String(describing: self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        brightness_slider.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        contrast_slider.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        blur_slider.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
    }
    @IBAction func onChangeSlider(_ sender: UISlider) {
        switch sender.tag {
        case 1:
            delegate!.onChangeSlider(type: .Brightness, value: CGFloat(sender.value))
            break
        case 2:
            delegate!.onChangeSlider(type: .Contrast, value: CGFloat(sender.value))
            break
        case 3:
            delegate!.onChangeSlider(type: .Blur, value: CGFloat(sender.value))
            break
        default:
            break
        }
    }
    @IBAction func endEdit(_ sender: UISlider) {
        switch sender.tag {
        case 1:
            delegate!.onEndEditSlider(type: .Brightness, value: CGFloat(sender.value))
            break
        case 2:
            delegate!.onEndEditSlider(type: .Contrast, value: CGFloat(sender.value))
            break
        case 3:
            delegate!.onEndEditSlider(type: .Blur, value: CGFloat(sender.value))
            break
        default:
            break
        }
    }
}
