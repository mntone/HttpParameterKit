import Foundation

public protocol HttpParameter {}

protocol HttpParameterInternal {
	var name: String { get }
	var suppressDefault: Bool { get }
}

protocol HttpParameterCodable {
	associatedtype T

	func query(_ value: T?) throws -> String?
	func xml(_ value: T?) throws -> String?
	func json(_ value: T?) throws -> String?
	func msgpack(_ value: T?) throws -> Data?
}
