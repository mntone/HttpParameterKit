import Foundation

public struct HPDouble: HttpParameter {
	let name: String
	let defaultValue: Double
	let minValue: Double?
	let maxValue: Double?
	let clamped: Bool
	let suppressDefault: Bool

	public init(_ name: String, default: Double = 0, min: Double? = nil, max: Double? = nil, clamped: Bool = false, suppressDefault: Bool = true) {
		self.name = name
		self.defaultValue = `default`
		self.minValue = min
		self.maxValue = max
		self.clamped = clamped
		self.suppressDefault = suppressDefault
	}

	public init(_ name: String, default: Double = 0, in range: ClosedRange<Double>, clamped: Bool = false, suppressDefault: Bool = true) {
		self.name = name
		self.defaultValue = `default`
		self.minValue = range.lowerBound
		self.maxValue = range.upperBound
		self.clamped = clamped
		self.suppressDefault = suppressDefault
	}
}

// MARK: - HttpParameterInternal

extension HPDouble: HttpParameterInternal {}

// MARK: - HttpParameterCodable

extension HPDouble: HttpParameterCodable, HPFloatingPointSupport {
	func dataMsgPack(_ value: Double) throws -> Data {
		let (count, mode) = MessagePackUtil.prepare(string: name)
		let data = MessagePackUtil.write(capacity: count + 9) { stream in
			stream.write(name, mode: mode)
			stream.write(UInt8(0xCB))
			stream.write(value.bitPattern.bigEndian)
		}
		return data
	}
}
