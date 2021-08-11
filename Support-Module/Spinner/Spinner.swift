
import UIKit
import Foundation
import UIKit

open class Spinner {
    
    internal static var spinner: UIActivityIndicatorView?
    public static var style: UIActivityIndicatorView.Style = .gray
    public static var baseBackColor = UIColor.black.withAlphaComponent(0.4)
    public static var baseColor = UIColor.black
    
    public static func start(style: UIActivityIndicatorView.Style = style, backColor: UIColor = baseBackColor, baseColor: UIColor = baseColor) {
        NotificationCenter.default.addObserver(self, selector: #selector(update), name: UIDevice.orientationDidChangeNotification, object: nil)
        if self.spinner == nil, let window = UIApplication.shared.keyWindow {
            let frame = UIScreen.main.bounds
            self.spinner = UIActivityIndicatorView(frame: frame)
            self.spinner!.backgroundColor = backColor
            self.spinner!.style = style
            self.spinner?.color = baseColor
            window.addSubview(self.spinner!)
            self.spinner!.startAnimating()
            
        }
    }
    public static func stop() {
        if self.spinner != nil {
            DispatchQueue.main.async {
                self.spinner?.stopAnimating()
                self.spinner?.removeFromSuperview()
                self.spinner = nil
            }
        }
    }
    @objc public static func update() {
        if self.spinner != nil {
            DispatchQueue.main.async {
                self.stop()
                self.start()
            }
        }
    }
}
