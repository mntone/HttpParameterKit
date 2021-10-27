import Foundation

public struct HPUInt32: HttpParameter {
	let name: String
	let defaultValue: UInt32
	let minValue: UInt32?
	let maxValue: UInt32?
	let clamped: Bool
	let suppressDefault: Bool

	public init(_ name: String, default: UInt32 = 0, min: UInt32? = nil, max: UInt32? = nil, clamped: Bool = false, suppressDefault: Bool = true) {
		self.name = name
		self.defaultValue = `default`
		self.minValue = min
		self.maxValue = max
		self.clamped = clamped
		self.suppressDefault = suppressDefault
	}

	public init(_ name: String, default: UInt32 = 0, in range: CountableClosedRange<UInt32>, clamped: Bool = false, suppressDefault: Bool = true) {
		self.name = name
		self.defaultValue = `default`
		self.minValue = range.lowerBound
		self.maxValue = range.upperBound
		self.clamped = clamped
		self.suppressDefault = suppressDefault
	}
}

// MARK: - HttpParameterInternal

extension HPUInt32: HttpParameterInternal {}

// MARK: - HttpParameterCodable

extension HPUInt32: HttpParameterCodable, HPBinaryIntegerSupport {
	func dataMsgPack(_ value: UInt32) throws -> Data {
		let (count, mode) = MessagePackUtil.prepare(string: name)

		let data: Data
		switch value {
		case 0x0000_0000...0x0000_007F:
			data = MessagePackUtil.write(capacity: count + 1) { stream in
				stream.write(name, mode: mode)
				stream.write(UInt8(value))
			}

		case 0x0000_0080...0x0000_00FF:
			data = MessagePackUtil.write(capacity: count + 2) { stream in
				stream.write(name, mode: mode)
				stream.write(UInt8(0xCC))
				stream.write(UInt8(value))
			}

		case 0x0000_0100...0x0000_FFFF:
			data = MessagePackUtil.write(capacity: count + 3) { stream in
				stream.write(name, mode: mode)
				stream.write(UInt8(0xCD))
				stream.write(UInt16(value).bigEndian)
			}

		case 0x0001_0000...0xFFFF_FFFF:
			data = MessagePackUtil.write(capacity: count + 5) { stream in
				stream.write(name, mode: mode)
				stream.write(UInt8(0xCE))
				stream.write(value.bigEndian)
			}

		default:
			throw HttpParameterBuildError.unreachable
		}
		return data
	}
}
