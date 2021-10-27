#if swift(>=5.3) && (os(iOS) || os(watchOS) || os(tvOS))

import Foundation

@available(iOS 14.0, watchOS 7.0, tvOS 14.0, *)
public struct HPFloat16: HttpParameter {
	let name: String
	let defaultValue: Float16
	let minValue: Float16?
	let maxValue: Float16?
	let clamped: Bool
	let suppressDefault: Bool

	public init(_ name: String, default: Float16 = 0, min: Float16? = nil, max: Float16? = nil, clamped: Bool = false, suppressDefault: Bool = true) {
		self.name = name
		self.defaultValue = `default`
		self.minValue = min
		self.maxValue = max
		self.clamped = clamped
		self.suppressDefault = suppressDefault
	}

	public init(_ name: String, default: Float16 = 0, in range: ClosedRange<Float16>, clamped: Bool = false, suppressDefault: Bool = true) {
		self.name = name
		self.defaultValue = `default`
		self.minValue = range.lowerBound
		self.maxValue = range.upperBound
		self.clamped = clamped
		self.suppressDefault = suppressDefault
	}
}

// MARK: - HttpParameterInternal

@available(iOS 14.0, watchOS 7.0, tvOS 14.0, *)
extension HPFloat16: HttpParameterInternal {}

// MARK: - HttpParameterCodable

@available(iOS 14.0, watchOS 7.0, tvOS 14.0, *)
extension HPFloat16: HttpParameterCodable, HPFloatingPointSupport {
	func dataMsgPack(_ value: Float16) throws -> Data {
		throw HttpParameterBuildError.unreachable
	}
}

#endif
