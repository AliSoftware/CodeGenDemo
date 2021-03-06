// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable file_length
fileprivate func compareOptionals<T>(lhs: T?, rhs: T?, compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    switch (lhs, rhs) {
    case let (lValue?, rValue?):
        return compare(lValue, rValue)
    case (nil, nil):
        return true
    default:
        return false
    }
}

fileprivate func compareArrays<T>(lhs: [T], rhs: [T], compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    guard lhs.count == rhs.count else { return false }
    for (idx, lhsItem) in lhs.enumerated() {
        guard compare(lhsItem, rhs[idx]) else { return false }
    }

    return true
}

// MARK: - AutoEquatable for classes, protocols, structs
// MARK: - ImageMetaData AutoEquatable
extension ImageMetaData: Equatable {} 
internal func == (lhs: ImageMetaData, rhs: ImageMetaData) -> Bool {
    guard lhs.title == rhs.title else { return false }
    guard lhs.author == rhs.author else { return false }
    guard lhs.date == rhs.date else { return false }
    guard lhs.tags == rhs.tags else { return false }
    guard lhs.kind == rhs.kind else { return false }
    return true
}

// MARK: - AutoEquatable for Enums

// MARK: -
