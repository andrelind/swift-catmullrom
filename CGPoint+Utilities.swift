import Foundation

extension CGPoint{
    func translate(x: CGFloat, _ y: CGFloat) -> CGPoint {
        return CGPointMake(self.x + x, self.y + y)
    }
    
    func translateX(x: CGFloat) -> CGPoint {
        return CGPointMake(self.x + x, self.y)
    }
    
    func translateY(y: CGFloat) -> CGPoint {
        return CGPointMake(self.x, self.y + y)
    }
    
    func invertY() -> CGPoint {
        return CGPointMake(self.x, -self.y)
    }
    
    func xAxis() -> CGPoint {
        return CGPointMake(0, self.y)
    }
    
    func yAxis() -> CGPoint {
        return CGPointMake(self.x, 0)
    }
    
    func addTo(a: CGPoint) -> CGPoint {
        return CGPointMake(self.x + a.x, self.y + a.y)
    }
    
    func deltaTo(a: CGPoint) -> CGPoint {
        return CGPointMake(self.x - a.x, self.y - a.y)
    }
    
    func multiplyBy(value:CGFloat) -> CGPoint{
        return CGPointMake(self.x * value, self.y * value)
    }
    
    func length() -> CGFloat {
        return CGFloat(sqrt(CDouble(
            self.x*self.x + self.y*self.y
            )))
    }
    
    func normalize() -> CGPoint {
        let l = self.length()
        return CGPointMake(self.x / l, self.y / l)
    }
    
    static func fromString(string: String) -> CGPoint {
        var s = string.stringByReplacingOccurrencesOfString("{", withString: "")
        s = s.stringByReplacingOccurrencesOfString("}", withString: "")
        s = s.stringByReplacingOccurrencesOfString(" ", withString: "")
        
        let x = NSString(string: s.componentsSeparatedByString(",").first! as String).doubleValue
        let y = NSString(string: s.componentsSeparatedByString(",").last! as String).doubleValue
        
        return CGPointMake(CGFloat(x), CGFloat(y))
    }
}