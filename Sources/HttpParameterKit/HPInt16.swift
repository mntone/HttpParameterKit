import Foundation

public struct HPInt16: HttpParameter {
	let name: String
	let defaultValue: Int16
	let minValue: Int16?
	let maxValue: Int16?
	let clamped: Bool
	let suppressDefault: Bool

	public init(_ name: String, default: Int16 = 0, min: Int16? = nil, max: Int16? = nil, clamped: Bool = false, suppressDefault: Bool = true) {
		self.name = name
		self.defaultValue = `default`
		self.minValue = min
		self.maxValue = max
		self.clamped = clamped
		self.suppressDefault = suppressDefault
	}

	public init(_ name: String, default: Int16 = 0, in range: CountableClosedRange<Int16>, clamped: Bool = false, suppressDefault: Bool = true) {
		self.name = name
		self.defaultValue = `default`
		self.minValue = range.lowerBound
		self.maxValue = range.upperBound
		self.clamped = clamped
		self.suppressDefault = suppressDefault
	}
}

// MARK: - HttpParameterInternal

extension HPInt16: HttpParameterInternal {}

// MARK: - HttpParameterCodable

extension HPInt16: HttpParameterCodable, HPBinaryIntegerSupport {
	func dataMsgPack(_ value: Int16) throws -> Data {
		let (count, mode) = MessagePackUtil.prepare(string: name)

		let data: Data
		switch value {
		case -32...0x007F:
			data = MessagePackUtil.write(capacity: count + 1) { stream in
				stream.write(name, mode: mode)
				stream.write(Int8(value))
			}

		case -128...(-33):
			data = MessagePackUtil.write(capacity: count + 2) { stream in
				stream.write(name, mode: mode)
				stream.write(UInt8(0xD0))
				stream.write(Int8(value))
			}

		case 0x0080...0x7FFF, -32_768...(-129):
			data = MessagePackUtil.write(capacity: count + 3) { stream in
				stream.write(name, mode: mode)
				stream.write(UInt8(0xD1))
				stream.write(value.bigEndian)
			}

		default:
			throw HttpParameterBuildError.unreachable
		}
		return data
	}
}
