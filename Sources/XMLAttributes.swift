//
//  XMLAttributes.swift
//  VinFoundation
//
//  Created by Maurice Parker on 2/25/17.
//  Copyright © 2017 Vineyard Enterprise Software, Inc. All rights reserved.
//
import libxml2

public struct XMLAttributes: Collection {

    unowned var parent: XMLElement

    init(parent: XMLElement) {
        self.parent = parent
    }

    public var startIndex: String {
      
        if let firstAttr = parent.nodePtr.pointee.properties {
            let attribute = XMLAttribute(parent: parent, attrPtr: firstAttr)
            return attribute.name ?? String()
        }
        
        return String()
    }
    
    public var endIndex: String {
        return String()
    }
    
    public func index(after i: String) -> String {
        if let current = self[i] {
            return (current.next?.name ?? "")
        }
        return String()
    }
    
    public subscript(index: String) -> XMLAttribute? {

        if let attrPtr = xmlHasProp(parent.nodePtr, index.xmlChars) {
            return XMLAttribute(parent: parent, attrPtr: attrPtr)
        }
        
        return nil
        
    }
    
//    func makeIterator() -> AnyIterator<XMLAttribute> {
//        
//        return AnyIterator {
//            
//            guard self.current != nil else { return nil }
//            let c = self.current!
//            self.current = self.next
//            return c
//            
//        }
//        
//    }
    
}

    /// The position of the first element in a nonempty dictionary.
    ///
    /// If the collection is empty, `startIndex` is equal to `endIndex`.
    ///
    /// - Complexity: Amortized O(1) if the dictionary does not wrap a bridged
    ///   `NSDictionary`. If the dictionary wraps a bridged `NSDictionary`, the
    ///   performance is unspecified.
//    public var startIndex: Index { get }
    
//    public var endIndex: DictionaryIndex<Key, Value> { get }
//    public func index(after i: DictionaryIndex<Key, Value>) -> DictionaryIndex<Key, Value>
//    public func index(forKey key: Key) -> DictionaryIndex<Key, Value>?
//    
//    public subscript(position: DictionaryIndex<Key, Value>) -> (key: Key, value: Value) { get }
//    
//    public subscript(key: Key) -> Value?
//    
//    public mutating func updateValue(_ value: Value, forKey key: Key) -> Value?
//    
//    public mutating func remove(at index: DictionaryIndex<Key, Value>) -> (key: Key, value: Value)
//    
//    public mutating func removeValue(forKey key: Key) -> Value?
//    
//    public mutating func removeAll(keepingCapacity keepCapacity: Bool = default)
//    
//    public var count: Int { get }
//    
//    public func makeIterator() -> DictionaryIterator<Key, Value>
//    
//    public init(dictionaryLiteral elements: (Key, Value)...)
//    
//    public var keys: LazyMapCollection<[Key : Value], Key> { get }
//    
//    public var values: LazyMapCollection<[Key : Value], Value> { get }
//    
//    public var isEmpty: Bool { get }
//    
//    public mutating func popFirst() -> (key: Key, value: Value)?
//
//    public func map<T>(_ transform: (Key, Value) throws -> T) rethrows -> [T]
//    
//    public func dropFirst(_ n: Int) -> Slice<Dictionary<Key, Value>>
//    
//    public func dropLast(_ n: Int) -> Slice<Dictionary<Key, Value>>
//    
//    public func prefix(_ maxLength: Int) -> Slice<Dictionary<Key, Value>>
//    
//    public func suffix(_ maxLength: Int) -> Slice<Dictionary<Key, Value>>
//    
//    public func prefix(upTo end: DictionaryIndex<Key, Value>) -> Slice<Dictionary<Key, Value>>
//    
//    public func suffix(from start: DictionaryIndex<Key, Value>) -> Slice<Dictionary<Key, Value>>
//    
//    public func prefix(through position: DictionaryIndex<Key, Value>) -> Slice<Dictionary<Key, Value>>
//    
//    public func split(maxSplits: Int = default, omittingEmptySubsequences: Bool = default, whereSeparator isSeparator: (Key, Value) throws -> Bool) rethrows -> [Slice<Dictionary<Key, Value>>]
//    
//    public func index(where predicate: (Key, Value) throws -> Bool) rethrows -> DictionaryIndex<Key, Value>?
//    
//    public func sorted(by areInIncreasingOrder: ((key: Key, value: Value), (key: Key, value: Value)) -> Bool) -> [(key: Key, value: Value)]
//    
//    public subscript(bounds: ClosedRange<DictionaryIndex<Key, Value>>) -> Slice<Dictionary<Key, Value>> { get }
//    
//    public var indices: DefaultIndices<Dictionary<Key, Value>> { get }
//    
//    public var lazy: LazySequence<Dictionary<Key, Value>> { get }
//    
//    public func map<T>(_ transform: (Key, Value) throws -> T) rethrows -> [T]
//    
//    public func filter(_ isIncluded: (Key, Value) throws -> Bool) rethrows -> [(key: Key, value: Value)]
//    
//    public var underestimatedCount: Int { get }
//    
//    public func forEach(_ body: (Key, Value) throws -> Void) rethrows
//
//    public func first(where predicate: (Key, Value) throws -> Bool) rethrows -> (key: Key, value: Value)?
//    
//    public func dropFirst() -> Slice<Dictionary<Key, Value>>
//    
//    public func dropLast() -> Slice<Dictionary<Key, Value>>
//    
//    public func enumerated() -> EnumeratedSequence<Dictionary<Key, Value>>
//    
//
//    @warn_unqualified_access
//    public func min(by areInIncreasingOrder: ((key: Key, value: Value), (key: Key, value: Value)) throws -> Bool) rethrows -> (key: Key, value: Value)?
//    
//    @warn_unqualified_access
//    public func max(by areInIncreasingOrder: ((key: Key, value: Value), (key: Key, value: Value)) throws -> Bool) rethrows -> (key: Key, value: Value)?
//    
//    public func starts<PossiblePrefix where PossiblePrefix : Sequence, PossiblePrefix.Iterator.Element == (key: Key, value: Value)>(with possiblePrefix: PossiblePrefix, by areEquivalent: ((key: Key, value: Value), (key: Key, value: Value)) throws -> Bool) rethrows -> Bool
//    
//    public func elementsEqual<OtherSequence where OtherSequence : Sequence, OtherSequence.Iterator.Element == (key: Key, value: Value)>(_ other: OtherSequence, by areEquivalent: ((key: Key, value: Value), (key: Key, value: Value)) throws -> Bool) rethrows -> Bool
//    
//    public func lexicographicallyPrecedes<OtherSequence where OtherSequence : Sequence, OtherSequence.Iterator.Element == (key: Key, value: Value)>(_ other: OtherSequence, by areInIncreasingOrder: ((key: Key, value: Value), (key: Key, value: Value)) throws -> Bool) rethrows -> Bool
//
//    public func contains(where predicate: (Key, Value) throws -> Bool) rethrows -> Bool
//    
//    public func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, (key: Key, value: Value)) throws -> Result) rethrows -> Result
//    
//    public func reversed() -> [(key: Key, value: Value)]
//    
//    public func flatMap<SegmentOfResult : Sequence>(_ transform: (Key, Value) throws -> SegmentOfResult) rethrows -> [SegmentOfResult.Iterator.Element]
//    
//    public func flatMap<ElementOfResult>(_ transform: (Key, Value) throws -> ElementOfResult?) rethrows -> [ElementOfResult]
