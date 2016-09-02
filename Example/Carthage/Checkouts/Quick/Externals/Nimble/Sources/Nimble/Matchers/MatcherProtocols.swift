import Foundation

/// Implement this protocol to implement a custom matcher for Swift
public protocol Matcher {
    associatedtype ValueType
    func matches(_ actualExpression: Expression<ValueType>, failureMessage: FailureMessage) throws -> Bool
    func doesNotMatch(_ actualExpression: Expression<ValueType>, failureMessage: FailureMessage) throws -> Bool
}

#if _runtime(_ObjC)
/// Objective-C interface to the Swift variant of Matcher.
@objc public protocol NMBMatcher {
    func matches(_ actualBlock: @escaping () -> NSObject!, failureMessage: FailureMessage, location: SourceLocation) -> Bool
    func doesNotMatch(_ actualBlock: @escaping () -> NSObject!, failureMessage: FailureMessage, location: SourceLocation) -> Bool
}
#endif

#if _runtime(_ObjC)
/// Protocol for types that support contain() matcher.
@objc public protocol NMBContainer {
    @objc(containsObject:)
    func contains(_ anObject: Any) -> Bool
}

// FIXME: NSHashTable can not conform to NMBContainer since swift-DEVELOPMENT-SNAPSHOT-2016-04-25-a
//extension NSHashTable : NMBContainer {} // Corelibs Foundation does not include this class yet
#else
public protocol NMBContainer {
    func contains(_ anObject: AnyObject) -> Bool
}
extension NMBContainer {
    func contains(_ anObject: Any) -> Bool {
        return contains(anObject as! AnyObject)
    }
}
#endif

extension NSArray : NMBContainer {}
extension NSSet : NMBContainer {}

#if _runtime(_ObjC)
/// Protocol for types that support only beEmpty(), haveCount() matchers
@objc public protocol NMBCollection {
    var count: Int { get }
}

extension NSHashTable : NMBCollection {} // Corelibs Foundation does not include these classes yet
extension NSMapTable : NMBCollection {}
#else
public protocol NMBCollection {
    var count: Int { get }
}
#endif

extension NSSet : NMBCollection {}
extension NSIndexSet : NMBCollection {}
extension NSDictionary : NMBCollection {}

#if _runtime(_ObjC)
/// Protocol for types that support beginWith(), endWith(), beEmpty() matchers
@objc public protocol NMBOrderedCollection : NMBCollection {
    @objc(indexOfObject:)
    func index(of anObject: Any) -> Int
}
#else
public protocol NMBOrderedCollection : NMBCollection {
    func index(of anObject: AnyObject) -> Int
}
extension NMBOrderedCollection {
    func index(of anObject: Any) -> Int {
        return index(of: anObject as! AnyObject)
    }
}
#endif

extension NSArray : NMBOrderedCollection {}

public protocol NMBDoubleConvertible {
    var doubleValue: CDouble { get }
}

extension Double : NMBDoubleConvertible {
    public var doubleValue: CDouble {
        get {
            return self
        }
    }
}

extension Float : NMBDoubleConvertible {
    public var doubleValue: CDouble {
        get {
            return CDouble(self)
        }
    }
}

extension NSNumber : NMBDoubleConvertible {
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSS"
    formatter.locale = Locale(identifier: "en_US_POSIX")

    return formatter
}()

extension Date: NMBDoubleConvertible {
    public var doubleValue: CDouble {
        get {
            return self.timeIntervalSinceReferenceDate
        }
    }
}

extension Date: TestOutputStringConvertible {
    public var testDescription: String {
        return dateFormatter.string(from: self as Date)
    }
}

/// Protocol for types to support beLessThan(), beLessThanOrEqualTo(),
///  beGreaterThan(), beGreaterThanOrEqualTo(), and equal() matchers.
///
/// Types that conform to Swift's Comparable protocol will work implicitly too
#if _runtime(_ObjC)
@objc public protocol NMBComparable {
    func NMB_compare(_ otherObject: NMBComparable!) -> ComparisonResult
}
#else
// This should become obsolete once Corelibs Foundation adds Comparable conformance to NSNumber
public protocol NMBComparable {
    func NMB_compare(_ otherObject: NMBComparable!) -> ComparisonResult
}
#endif

extension NSNumber : NMBComparable {
    public func NMB_compare(_ otherObject: NMBComparable!) -> ComparisonResult {
        return compare(otherObject as! NSNumber)
    }
}
extension NSString : NMBComparable {
    public func NMB_compare(_ otherObject: NMBComparable!) -> ComparisonResult {
        return compare(otherObject as! String)
    }
}
