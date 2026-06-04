import Foundation
import Testing
@testable import A11yIdentifiers

@Suite("A11yID Extended")
struct A11yIDExtendedTests {
    // MARK: - Hashable
    @Test("equal IDs have same hash")
    func equalHash() {
        let a = A11yID(rawValue: "login.button")
        let b = A11yID(rawValue: "login.button")
        #expect(a.hashValue == b.hashValue)
    }

    @Test("different IDs have different hash")
    func differentHash() {
        let a = A11yID(rawValue: "a")
        let b = A11yID(rawValue: "b")
        #expect(a.hashValue != b.hashValue)
    }

    @Test("can be used as dictionary key")
    func dictionaryKey() {
        let id1: A11yID = "key.one"
        let id2: A11yID = "key.two"
        var dict: [A11yID: String] = [id1: "first", id2: "second"]
        #expect(dict[id1] == "first")
        #expect(dict[id2] == "second")
    }

    @Test("can be used in a Set")
    func setMembership() {
        let id1: A11yID = "a"
        let id2: A11yID = "b"
        let id3: A11yID = "a"
        let set: Set<A11yID> = [id1, id2, id3]
        #expect(set.count == 2)
        #expect(set.contains(id1))
    }

    // MARK: - Sendable
    @Test("can cross actor boundary")
    func sendableAcrossActors() async {
        let id = A11yID(rawValue: "cross.actor")
        let result = await checkSendable(id)
        #expect(result == "cross.actor")
    }

    @Test("string literal is Sendable")
    func stringLiteralSendable() async {
        let id: A11yID = "literal.sendable"
        let result = await checkSendable(id)
        #expect(result == "literal.sendable")
    }

    // MARK: - Chained appending
    @Test("chained string appending")
    func chainedStringAppend() {
        let id = A11yID(rawValue: "root")
            .appending("section")
            .appending("button")
        #expect(id.rawValue == "root.section.button")
    }

    @Test("chained int appending")
    func chainedIntAppend() {
        let id = A11yID(rawValue: "list")
            .appending(0)
            .appending("cell")
        #expect(id.rawValue == "list.0.cell")
    }

    @Test("mixed string and int appending")
    func mixedAppend() {
        let id = A11yID(rawValue: "table")
            .appending("section")
            .appending(2)
            .appending("row")
        #expect(id.rawValue == "table.section.2.row")
    }

    @Test("appending int to empty returns int")
    func appendIntToEmpty() {
        let id = A11yID(rawValue: "").appending(42)
        #expect(id.rawValue == "42")
    }

    // MARK: - ExpressibleByStringLiteral edge cases
    @Test("empty string literal")
    func emptyLiteral() {
        let id: A11yID = ""
        #expect(id.rawValue == "")
    }

    @Test("string literal with dots")
    func literalWithDots() {
        let id: A11yID = "a.b.c.d"
        #expect(id.rawValue == "a.b.c.d")
    }

    @Test("rawValue preserves special characters")
    func specialCharacters() {
        let id = A11yID(rawValue: "login_button-1.test")
        #expect(id.rawValue == "login_button-1.test")
    }

    // MARK: - Platform guards (compile-time only)
    @Test("rawRepresentable conformance")
    func rawRepresentable() {
        let id = A11yID(rawValue: "test")
        #expect(id.rawValue == "test")
        let raw: String = id.rawValue
        #expect(raw == "test")
    }
}

@globalActor
actor TestActor {
    static let shared = TestActor()
}

func checkSendable(_ id: A11yID) async -> String {
    id.rawValue
}
