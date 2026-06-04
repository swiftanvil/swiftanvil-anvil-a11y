import Foundation

public struct A11yID: RawRepresentable, ExpressibleByStringLiteral, Hashable, Sendable {
    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }

    public init(stringLiteral value: String) {
        self.rawValue = value
    }

    public func appending(_ segment: String) -> A11yID {
        A11yID(rawValue: rawValue.isEmpty ? segment : "\(rawValue).\(segment)")
    }

    public func appending(_ segment: Int) -> A11yID {
        A11yID(rawValue: rawValue.isEmpty ? "\(segment)" : "\(rawValue).\(segment)")
    }
}

#if canImport(SwiftUI) && !os(watchOS)
import SwiftUI

extension View {
    /// Assigns a typed accessibility identifier to a SwiftUI view.
    @inlinable
    public func a11ID(_ id: A11yID) -> some View {
        accessibilityIdentifier(id.rawValue)
    }
}
#endif

#if canImport(UIKit) && !os(watchOS)
import UIKit

extension UIView {
    /// Assigns a typed accessibility identifier to a UIKit view.
    @inlinable
    public func setA11ID(_ id: A11yID) {
        accessibilityIdentifier = id.rawValue
    }
}

extension UIBarItem {
    /// Assigns a typed accessibility identifier to a UIKit bar item.
    @inlinable
    public func setA11ID(_ id: A11yID) {
        accessibilityIdentifier = id.rawValue
    }
}
#endif
