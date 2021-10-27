import Foundation

public struct HPUInt16: HttpParameter {
	let name: String
	let defaultValue: UInt16
	let minValue: UInt16?
	let maxValue: UInt16?
	let clamped: Bool
	let suppressDefault: Bool

	public init(_ name: String, default: UInt16 = 0, min: UInt16? = nil, max: UInt16? = nil, clamped: Bool = false, suppressDefault: Bool = true) {
		self.name = name
		self.defaultValue = `default`
		self.minValue = min
		self.maxValue = max
		self.clamped = clamped
		self.suppressDefault = suppressDefault
	}

	public init(_ name: String, default: UInt16 = 0, in range: CountableClosedRange<UInt16>, clamped: Bool = false, suppressDefault: Bool = true) {
		self.name = name
		self.defaultValue = `default`
		self.minValue = range.lowerBound
		self.maxValue = range.upperBound
		self.clamped = clamped
		self.suppressDefault = suppressDefault
	}
}

// MARK: - HttpParameterInternal

extension HPUInt16: HttpParameterInternal {}

// MARK: - HttpParameterCodable

extension HPUInt16: HttpParameterCodable, HPBinaryIntegerSupport {
	func dataMsgPack(_ value: UInt16) throws -> Data {
		let (count, mode) = MessagePackUtil.prepare(string: name)

		let data: Data
		switch value {
		case 0x0000...0x007F:
			data = MessagePackUtil.write(capacity: count + 1) { stream in
				stream.write(name, mode: mode)
				stream.write(UInt8(value))
			}

		case 0x0080...0x00FF:
			data = MessagePackUtil.write(capacity: count + 2) { stream in
				stream.write(name, mode: mode)
				stream.write(UInt8(0xCC))
				stream.write(UInt8(value))
			}

		case 0x0100...0xFFFF:
			data = MessagePackUtil.write(capacity: count + 3) { stream in
				stream.write(name, mode: mode)
				stream.write(UInt8(0xCD))
				stream.write(value.bigEndian)
			}

		default:
			throw HttpParameterBuildError.unreachable
		}
		return data
	}
}
