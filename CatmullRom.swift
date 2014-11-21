
#if !TARGET_OS_IPHONE
import Cocoa
typealias UIBezierPath = NSBezierPath
#endif

extension UIBezierPath {
    
    convenience init?(catmullRomPoints: [CGPoint], closed: Bool, alpha: CGFloat) {
        self.init()
        
        if catmullRomPoints.count < 4 {
            return nil
        }
        
        let startIndex = closed ? 0 : 1
        let endIndex = closed ? catmullRomPoints.count : catmullRomPoints.count - 2
        
        for var i = startIndex; i < endIndex; ++i {
            let p0 = catmullRomPoints[i-1 < 0 ? catmullRomPoints.count - 1 : i - 1]
            let p1 = catmullRomPoints[i]
            let p2 = catmullRomPoints[(i+1)%catmullRomPoints.count]
            let p3 = catmullRomPoints[(i+1)%catmullRomPoints.count + 1]
            
            let d1 = p1.deltaTo(p0).length()
            let d2 = p2.deltaTo(p1).length()
            let d3 = p3.deltaTo(p2).length()
            
            var b1 = p2.multiplyBy(pow(d1, 2 * alpha))
            b1 = b1.deltaTo(p0.multiplyBy(pow(d2, 2 * alpha)))
            b1 = b1.addTo(p1.multiplyBy(2 * pow(d1, 2 * alpha) + 3 * pow(d1, alpha) * pow(d2, alpha) + pow(d2, 2 * alpha)))
            b1 = b1.multiplyBy(1.0 / (3 * pow(d1, alpha) * (pow(d1, alpha) + pow(d2, alpha))))
            
            var b2 = p1.multiplyBy(pow(d3, 2 * alpha))
            b2 = b2.deltaTo(p3.multiplyBy(pow(d2, 2 * alpha)))
            b2 = b2.addTo(p2.multiplyBy(2 * pow(d3, 2 * alpha) + 3 * pow(d3, alpha) * pow(d2, alpha) + pow(d2, 2 * alpha)))
            b2 = b2.multiplyBy(1.0 / (3 * pow(d3, alpha) * (pow(d3, alpha) + pow(d2, alpha))))
            
            if i == startIndex {
                moveToPoint(p1)
            }
            
            #if !TARGET_OS_IPHONE
                curveToPoint(p2, controlPoint1: b1, controlPoint2: b2)
            #else
                addCurveToPoint(p2, controlPoint1: b1, controlPoint2: b2)
            #endif
        }
        
        if closed {
            closePath()
        }
    }
}