

import Foundation
import UIKit

public class AnimationView : UIView{
    override open func layoutSubviews() {
        self.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        UIView.animate(withDuration: 3.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
                        self.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
    }
}

public class AnimationLabel : UILabel{
    override open func layoutSubviews() {
        self.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        UIView.animate(withDuration: 3.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
                        self.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
    }
}

public class AnimationImageView : UIImageView{
    override open func layoutSubviews() {
        self.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        UIView.animate(withDuration: 3.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
                        self.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
    }
}

//MARK:- Wifi, Mobile Data, Internet Check Message
let kInternetConnectionMsg = "Please check your mobile data or wifi internet connectivity";
