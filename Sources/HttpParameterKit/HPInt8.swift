import Foundation

public struct HPInt8: HttpParameter {
	let name: String
	let defaultValue: Int8
	let minValue: Int8?
	let maxValue: Int8?
	let clamped: Bool
	let suppressDefault: Bool

	public init(_ name: String, default: Int8 = 0, min: Int8? = nil, max: Int8? = nil, clamped: Bool = false, suppressDefault: Bool = true) {
		self.name = name
		self.defaultValue = `default`
		self.minValue = min
		self.maxValue = max
		self.clamped = clamped
		self.suppressDefault = suppressDefault
	}

	public init(_ name: String, default: Int8 = 0, in range: CountableClosedRange<Int8>, clamped: Bool = false, suppressDefault: Bool = true) {
		self.name = name
		self.defaultValue = `default`
		self.minValue = range.lowerBound
		self.maxValue = range.upperBound
		self.clamped = clamped
		self.suppressDefault = suppressDefault
	}
}

// MARK: - HttpParameterInternal

extension HPInt8: HttpParameterInternal {}

// MARK: - HttpParameterCodable

extension HPInt8: HttpParameterCodable, HPBinaryIntegerSupport {
	func dataMsgPack(_ value: Int8) throws -> Data {
		let (count, mode) = MessagePackUtil.prepare(string: name)

		let data: Data
		switch value {
		case -32...0x7F:
			data = MessagePackUtil.write(capacity: count + 1) { stream in
				stream.write(name, mode: mode)
				stream.write(value)
			}

		case -128...(-33):
			data = MessagePackUtil.write(capacity: count + 2) { stream in
				stream.write(name, mode: mode)
				stream.write(UInt8(0xD0))
				stream.write(value)
			}

		default:
			throw HttpParameterBuildError.unreachable
		}
		return data
	}
}
