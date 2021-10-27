import Foundation

public struct HPInt32: HttpParameter {
	let name: String
	let defaultValue: Int32
	let minValue: Int32?
	let maxValue: Int32?
	let clamped: Bool
	let suppressDefault: Bool

	public init(_ name: String, default: Int32 = 0, min: Int32? = nil, max: Int32? = nil, clamped: Bool = false, suppressDefault: Bool = true) {
		self.name = name
		self.defaultValue = `default`
		self.minValue = min
		self.maxValue = max
		self.clamped = clamped
		self.suppressDefault = suppressDefault
	}

	public init(_ name: String, default: Int32 = 0, in range: CountableClosedRange<Int32>, clamped: Bool = false, suppressDefault: Bool = true) {
		self.name = name
		self.defaultValue = `default`
		self.minValue = range.lowerBound
		self.maxValue = range.upperBound
		self.clamped = clamped
		self.suppressDefault = suppressDefault
	}
}

// MARK: - HttpParameterInternal

extension HPInt32: HttpParameterInternal {}

// MARK: - HttpParameterCodable

extension HPInt32: HttpParameterCodable, HPBinaryIntegerSupport {
	func dataMsgPack(_ value: Int32) throws -> Data {
		let (count, mode) = MessagePackUtil.prepare(string: name)

		let data: Data
		switch value {
		case -32...0x0000_007F:
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

		case 0x0000_0080...0x0000_7FFF, -32_768...(-129):
			data = MessagePackUtil.write(capacity: count + 3) { stream in
				stream.write(name, mode: mode)
				stream.write(UInt8(0xD1))
				stream.write(Int16(value).bigEndian)
			}

		case 0x0000_8000...0x7FFF_FFFF, -2_147_483_648...(-32_769):
			data = MessagePackUtil.write(capacity: count + 5) { stream in
				stream.write(name, mode: mode)
				stream.write(UInt8(0xD2))
				stream.write(value.bigEndian)
			}

		default:
			throw HttpParameterBuildError.unreachable
		}
		return data
	}
}
