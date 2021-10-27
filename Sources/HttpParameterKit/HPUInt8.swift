import Foundation

public struct HPUInt8: HttpParameter {
	let name: String
	let defaultValue: UInt8
	let minValue: UInt8?
	let maxValue: UInt8?
	let clamped: Bool
	let suppressDefault: Bool

	public init(_ name: String, default: UInt8 = 0, min: UInt8? = nil, max: UInt8? = nil, clamped: Bool = false, suppressDefault: Bool = true) {
		self.name = name
		self.defaultValue = `default`
		self.minValue = min
		self.maxValue = max
		self.clamped = clamped
		self.suppressDefault = suppressDefault
	}

	public init(_ name: String, default: UInt8 = 0, in range: CountableClosedRange<UInt8>, clamped: Bool = false, suppressDefault: Bool = true) {
		self.name = name
		self.defaultValue = `default`
		self.minValue = range.lowerBound
		self.maxValue = range.upperBound
		self.clamped = clamped
		self.suppressDefault = suppressDefault
	}
}

// MARK: - HttpParameterInternal

extension HPUInt8: HttpParameterInternal {}

// MARK: - HttpParameterCodable

extension HPUInt8: HttpParameterCodable, HPBinaryIntegerSupport {
	func dataMsgPack(_ value: UInt8) throws -> Data {
		let (count, mode) = MessagePackUtil.prepare(string: name)

		let data: Data
		switch value {
		case 0x00...0x7F:
			data = MessagePackUtil.write(capacity: count + 1) { stream in
				stream.write(name, mode: mode)
				stream.write(UInt8(value))
			}

		case 0x80...0xFF:
			data = MessagePackUtil.write(capacity: count + 2) { stream in
				stream.write(name, mode: mode)
				stream.write(UInt8(0xCC))
				stream.write(value)
			}

		default:
			throw HttpParameterBuildError.unreachable
		}
		return data
	}
}
