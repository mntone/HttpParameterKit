import Foundation

public struct HPInt: HttpParameter {
	let name: String
	let defaultValue: Int
	let minValue: Int?
	let maxValue: Int?
	let clamped: Bool
	let suppressDefault: Bool

	public init(_ name: String, default: Int = 0, min: Int? = nil, max: Int? = nil, clamped: Bool = false, suppressDefault: Bool = true) {
		self.name = name
		self.defaultValue = `default`
		self.minValue = min
		self.maxValue = max
		self.clamped = clamped
		self.suppressDefault = suppressDefault
	}

	public init(_ name: String, default: Int = 0, in range: CountableClosedRange<Int>, clamped: Bool = false, suppressDefault: Bool = true) {
		self.name = name
		self.defaultValue = `default`
		self.minValue = range.lowerBound
		self.maxValue = range.upperBound
		self.clamped = clamped
		self.suppressDefault = suppressDefault
	}
}

// MARK: - HttpParameterInternal

extension HPInt: HttpParameterInternal {}

// MARK: - HttpParameterCodable

extension HPInt: HttpParameterCodable, HPBinaryIntegerSupport {
	func dataMsgPack(_ value: Int) throws -> Data {
		let (count, mode) = MessagePackUtil.prepare(string: name)

		let data: Data
		switch value {
		case -32...0x0000_0000_0000_007F:
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

		case 0x0000_0000_0000_0080...0x0000_0000_0000_7FFF, -32_768...(-129):
			data = MessagePackUtil.write(capacity: count + 3) { stream in
				stream.write(name, mode: mode)
				stream.write(UInt8(0xD1))
				stream.write(Int16(value).bigEndian)
			}

		case 0x0000_0000_0000_8000...0x0000_0000_7FFF_FFFF, -2_147_483_648...(-32_769):
			data = MessagePackUtil.write(capacity: count + 5) { stream in
				stream.write(name, mode: mode)
				stream.write(UInt8(0xD2))
#if os(watchOS) || arch(i386) || arch(arm)
				stream.write(value.bigEndian)
#else
				stream.write(Int32(value).bigEndian)
#endif
			}

#if !os(watchOS) && !arch(i386) && !arch(arm)
		case 0x0000_0000_8000_0000...0x7FFF_FFFF_FFFF_FFFF, -9_223_372_036_854_775_808...(-2_147_483_649):
			data = MessagePackUtil.write(capacity: count + 9) { stream in
				stream.write(name, mode: mode)
				stream.write(UInt8(0xD3))
				stream.write(value.bigEndian)
			}
#endif

		default:
			throw HttpParameterBuildError.unreachable
		}
		return data
	}
}
