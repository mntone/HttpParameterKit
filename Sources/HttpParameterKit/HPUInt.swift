import Foundation

public struct HPUInt: HttpParameter {
	let name: String
	let defaultValue: UInt
	let minValue: UInt?
	let maxValue: UInt?
	let clamped: Bool
	let suppressDefault: Bool

	public init(_ name: String, default: UInt = 0, min: UInt? = nil, max: UInt? = nil, clamped: Bool = false, suppressDefault: Bool = true) {
		self.name = name
		self.defaultValue = `default`
		self.minValue = min
		self.maxValue = max
		self.clamped = clamped
		self.suppressDefault = suppressDefault
	}

	public init(_ name: String, default: UInt = 0, in range: CountableClosedRange<UInt>, clamped: Bool = false, suppressDefault: Bool = true) {
		self.name = name
		self.defaultValue = `default`
		self.minValue = range.lowerBound
		self.maxValue = range.upperBound
		self.clamped = clamped
		self.suppressDefault = suppressDefault
	}
}

// MARK: - HttpParameterInternal

extension HPUInt: HttpParameterInternal {}

// MARK: - HttpParameterCodable

extension HPUInt: HttpParameterCodable, HPBinaryIntegerSupport {
	func dataMsgPack(_ value: UInt) throws -> Data {
		let (count, mode) = MessagePackUtil.prepare(string: name)

		let data: Data
		switch value {
		case 0x0000_0000_0000_0000...0x0000_0000_0000_007F:
			data = MessagePackUtil.write(capacity: count + 1) { stream in
				stream.write(name, mode: mode)
				stream.write(UInt8(value))
			}

		case 0x0000_0000_0000_0080...0x0000_0000_0000_00FF:
			data = MessagePackUtil.write(capacity: count + 2) { stream in
				stream.write(name, mode: mode)
				stream.write(UInt8(0xCC))
				stream.write(UInt8(value))
			}

		case 0x0000_0000_0000_0100...0x0000_0000_0000_FFFF:
			data = MessagePackUtil.write(capacity: count + 3) { stream in
				stream.write(name, mode: mode)
				stream.write(UInt8(0xCD))
				stream.write(UInt16(value).bigEndian)
			}

		case 0x0000_0000_0001_0000...0x0000_0000_FFFF_FFFF:
			data = MessagePackUtil.write(capacity: count + 5) { stream in
				stream.write(name, mode: mode)
				stream.write(UInt8(0xCE))
#if os(watchOS) || arch(i386) || arch(arm)
				stream.write(value.bigEndian)
#else
				stream.write(UInt32(value).bigEndian)
#endif
			}

#if !os(watchOS) && !arch(i386) && !arch(arm)
		case 0x0000_0001_0000_0000...0xFFFF_FFFF_FFFF_FFFF:
			data = MessagePackUtil.write(capacity: count + 9) { stream in
				stream.write(name, mode: mode)
				stream.write(UInt8(0xCF))
				stream.write(value.bigEndian)
			}
#endif

		default:
			throw HttpParameterBuildError.unreachable
		}
		return data
	}
}
