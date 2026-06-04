import Foundation
import Testing
@testable import A11yIdentifiers

@Suite("A11yID")
struct A11yIDTests {
    @Test("initializes from string literal")
    func stringLiteral() {
        let id: A11yID = "login.button"
        #expect(id.rawValue == "login.button")
    }

    @Test("initializes from raw value")
    func rawValue() {
        let id = A11yID(rawValue: "profile.header")
        #expect(id.rawValue == "profile.header")
    }

    @Test("appends string segment")
    func appendString() {
        let id = A11yID(rawValue: "settings").appending("doneButton")
        #expect(id.rawValue == "settings.doneButton")
    }

    @Test("appends int segment")
    func appendInt() {
        let id = A11yID(rawValue: "list").appending(3)
        #expect(id.rawValue == "list.3")
    }

    @Test("appending to empty returns segment")
    func appendToEmpty() {
        let id = A11yID(rawValue: "").appending("root")
        #expect(id.rawValue == "root")
    }

    @Test("conforms to Hashable")
    func hashable() {
        let a = A11yID(rawValue: "a")
        let b = A11yID(rawValue: "a")
        let c = A11yID(rawValue: "b")
        #expect(a == b)
        #expect(a != c)
    }

    @Test("conforms to Sendable")
    func sendable() {
        let id = A11yID(rawValue: "test")
        let boxed: Sendable = id
        #expect((boxed as? A11yID)?.rawValue == "test")
    }
}
