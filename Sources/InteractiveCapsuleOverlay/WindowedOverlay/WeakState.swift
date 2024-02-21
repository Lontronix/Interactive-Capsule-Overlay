//
//  WeakState.swift
//
//
//  Created by Lonnie Gerol on 2/20/24.
//

import SwiftUI

/**
 A property wrapper capable of holding weak references to reference types.

 Adapted from: https://github.com/nathantannar4/Transmission/blob/main/Sources/Transmission/Sources/DynamicProperty/WeakState.swift
 */
@propertyWrapper
struct WeakState<Value: AnyObject>: DynamicProperty {

    @usableFromInline
    class Storage: ObservableObject {

        weak var value: Value? {
            didSet {
                if oldValue !== value {
                    objectWillChange.send()
                }
            }
        }

        @usableFromInline
        init(value: Value?) { self.value = value }

    }

    @usableFromInline
    var storage: StateObject<Storage>

    @inlinable
    init(wrappedValue thunk: @autoclosure @escaping () -> Value?) {
        storage = StateObject<Storage>(wrappedValue: { Storage(value: thunk()) }())
    }

    var wrappedValue: Value? {
        get { storage.wrappedValue.value }
        nonmutating set { storage.wrappedValue.value = newValue }
    }

    var projectedValue: Binding<Value?> {
        storage.projectedValue.value
    }
}
