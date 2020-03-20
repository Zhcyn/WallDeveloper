import UIKit
struct Constants {
    static let SCREEN_HEIGHT_IpX            = 812
    static let SCREEN_HEIGHT_Ip6Plus        = 736
    static let SCREEN_HEIGHT_Ip6            = 667
    static let ratio_IPX                    = CGFloat(9.0/19.5)
    static let ratio_IPBasic                = CGFloat(9.0/6.0)
    static let default_leftConstant_IPX     = CGFloat(55)
    static let default_leftConstant_IPPlus  = CGFloat(65)
    static let default_leftConstant_IP6     = CGFloat(70)
    static let SCREEN_WIDTH                 = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT                = UIScreen.main.bounds.size.height
    static let STATUS_BAR = Constants.SCREEN_HEIGHT > 812 ? CGFloat(44) : CGFloat(20)
}
let OK    = "OK"
let Error = "Error"
let Save_error = "Save error"
let Saved = "Saved"
let Save_Image_Success = "Image has been saved to your photos."
