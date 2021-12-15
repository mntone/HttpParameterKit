import Foundation

public protocol HttpParameter {}

protocol HttpParameterInternal {
	var name: String { get }
	var suppressDefault: Bool { get }
}

public typealias HPPair = (name: String, value: String)

protocol HttpParameterCodable {
	associatedtype T

	func query(_ value: T?, encoding: QueryEncoding) throws -> String?
	func querydata(_ value: T?, encoding: QueryEncoding) throws -> HPPair?
	func xml(_ value: T?) throws -> String?
	func json(_ value: T?) throws -> String?
	func msgpack(_ value: T?) throws -> Data?
}
