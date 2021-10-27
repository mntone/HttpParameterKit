import Foundation

public struct HPPattern: HttpParameter {
	private let sets: [HPSet]

	public init(@HttpParameterSetBuilder sets: () -> [HPSet]) {
		self.sets = sets()
	}
}

extension HPPattern {
	func query(_ value: [String: AnyHashable]) throws -> [String] {
		guard let targetSet = sets.first(where: { $0.validateSet(value) }) else { return [] }
		return try targetSet.query(value)
	}

	func xml(_ value: [String: AnyHashable]) throws -> [String] {
		guard let targetSet = sets.first(where: { $0.validateSet(value) }) else { return [] }
		return try targetSet.xml(value)
	}

	func json(_ value: [String: AnyHashable]) throws -> [String] {
		guard let targetSet = sets.first(where: { $0.validateSet(value) }) else { return [] }
		return try targetSet.json(value)
	}

	func msgpack(_ value: [String: AnyHashable]) throws -> [Data] {
		guard let targetSet = sets.first(where: { $0.validateSet(value) }) else { return [] }
		return try targetSet.msgpack(value)
	}
}
