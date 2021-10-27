#if swift(>=1.1) && os(macOS)

import Foundation

@available(macOS 10.10, *)
public struct HPFloat80: HttpParameter {
	let name: String
	let defaultValue: Float80
	let minValue: Float80?
	let maxValue: Float80?
	let clamped: Bool
	let suppressDefault: Bool

	public init(_ name: String, default: Float80 = 0, min: Float80? = nil, max: Float80? = nil, clamped: Bool = false, suppressDefault: Bool = true) {
		self.name = name
		self.defaultValue = `default`
		self.minValue = min
		self.maxValue = max
		self.clamped = clamped
		self.suppressDefault = suppressDefault
	}

	public init(_ name: String, default: Float80 = 0, in range: ClosedRange<Float80>, clamped: Bool = false, suppressDefault: Bool = true) {
		self.name = name
		self.defaultValue = `default`
		self.minValue = range.lowerBound
		self.maxValue = range.upperBound
		self.clamped = clamped
		self.suppressDefault = suppressDefault
	}
}

// MARK: - HttpParameterInternal

@available(macOS 10.10, *)
extension HPFloat80: HttpParameterInternal {}

// MARK: - HttpParameterCodable

@available(macOS 10.10, *)
extension HPFloat80: HttpParameterCodable, HPFloatingPointSupport {
	func dataMsgPack(_ value: Float80) throws -> Data {
		throw HttpParameterBuildError.unreachable
	}
}

#endif
