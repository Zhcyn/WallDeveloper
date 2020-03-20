import UIKit
extension UIView {
    func takeScreenshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            return image
        } else {
            return UIImage()
        }
    }
    func removeShapeLayer()  {
        if let layers = self.layer.sublayers {
            layers.forEach { (layer) in
                if layer.isKind(of: CAShapeLayer.self) { layer.removeFromSuperlayer() }
            }
        }
    }
    func addDashedBorder() {
        removeShapeLayer()
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6, 3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 0).cgPath
        self.layer.addSublayer(shapeLayer)
    }
    func addShadow(cornerRadius: CGFloat, color: UIColor, offset: CGSize, opacity: Float, shadowRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = shadowRadius
    }
    func shake() {
        self.transform = CGAffineTransform(translationX: 20, y: 0)
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {
        let cgimage = image.cgImage!
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        let contextSize: CGSize = contextImage.size
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }
        let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)
        let imageRef: CGImage = cgimage.cropping(to: rect)!
        let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
        return image
    }
}
extension NSLayoutConstraint {
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self.firstItem!, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
}
@available(iOS 9.0, *)
extension UIImage {
    public func imageFiltered(withCoreImageFilter name: String, parameters: [String: Any]? = nil) -> UIImage? {
        var image: CoreImage.CIImage? = ciImage
        if image == nil, let CGImage = self.cgImage {
            image = CoreImage.CIImage(cgImage: CGImage)
        }
        guard let coreImage = image else { return nil }
        #if swift(>=4.2)
        let context = CIContext(options: [.priorityRequestLow: true])
        #else
        let context = CIContext(options: [kCIContextPriorityRequestLow: true])
        #endif
        var parameters: [String: Any] = parameters ?? [:]
        parameters[kCIInputImageKey] = coreImage
        #if swift(>=4.2)
        guard let filter = CIFilter(name: name, parameters: parameters) else { return nil }
        #else
        guard let filter = CIFilter(name: name, withInputParameters: parameters) else { return nil }
        #endif
        guard let outputImage = filter.outputImage else { return nil }
        let cgImageRef = context.createCGImage(outputImage, from: outputImage.extent)
        return UIImage(cgImage: cgImageRef!, scale: scale, orientation: imageOrientation)
    }
}
