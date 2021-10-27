import Foundation

public struct HPFloat: HttpParameter {
	let name: String
	let defaultValue: Float
	let minValue: Float?
	let maxValue: Float?
	let clamped: Bool
	let suppressDefault: Bool

	public init(_ name: String, default: Float = 0, min: Float? = nil, max: Float? = nil, clamped: Bool = false, suppressDefault: Bool = true) {
		self.name = name
		self.defaultValue = `default`
		self.minValue = min
		self.maxValue = max
		self.clamped = clamped
		self.suppressDefault = suppressDefault
	}

	public init(_ name: String, default: Float = 0, in range: ClosedRange<Float>, clamped: Bool = false, suppressDefault: Bool = true) {
		self.name = name
		self.defaultValue = `default`
		self.minValue = range.lowerBound
		self.maxValue = range.upperBound
		self.clamped = clamped
		self.suppressDefault = suppressDefault
	}
}

// MARK: - HttpParameterInternal

extension HPFloat: HttpParameterInternal {}

// MARK: - HttpParameterCodable

extension HPFloat: HttpParameterCodable, HPFloatingPointSupport {
	func dataMsgPack(_ value: Float) throws -> Data {
		let (count, mode) = MessagePackUtil.prepare(string: name)
		let data = MessagePackUtil.write(capacity: count + 5) { stream in
			stream.write(name, mode: mode)
			stream.write(UInt8(0xCA))
			stream.write(value.bitPattern.bigEndian)
		}
		return data
	}
}
