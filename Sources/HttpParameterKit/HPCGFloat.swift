#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)

import CoreGraphics
import Foundation

public struct HPCGFloat: HttpParameter {
	let name: String
	let defaultValue: CGFloat
	let minValue: CGFloat?
	let maxValue: CGFloat?
	let clamped: Bool
	let suppressDefault: Bool

	public init(_ name: String, default: CGFloat = 0, min: CGFloat? = nil, max: CGFloat? = nil, clamped: Bool = false, suppressDefault: Bool = true) {
		self.name = name
		self.defaultValue = `default`
		self.minValue = min
		self.maxValue = max
		self.clamped = clamped
		self.suppressDefault = suppressDefault
	}

	public init(_ name: String, default: CGFloat = 0, in range: ClosedRange<CGFloat>, clamped: Bool = false, suppressDefault: Bool = true) {
		self.name = name
		self.defaultValue = `default`
		self.minValue = range.lowerBound
		self.maxValue = range.upperBound
		self.clamped = clamped
		self.suppressDefault = suppressDefault
	}
}

// MARK: - HttpParameterInternal

extension HPCGFloat: HttpParameterInternal {}

// MARK: - HttpParameterCodable

extension HPCGFloat: HttpParameterCodable, HPFloatingPointSupport {
	func dataMsgPack(_ value: CGFloat) throws -> Data {
		let (count, mode) = MessagePackUtil.prepare(string: name)
#if os(watchOS) || arch(i386) || arch(arm)
		let data = MessagePackUtil.write(capacity: count + 5) { stream in
			stream.write(name, mode: mode)
			stream.write(UInt8(0xCA))
			stream.write(value.bitPattern.bigEndian)
		}
#else
		let data = MessagePackUtil.write(capacity: count + 9) { stream in
			stream.write(name, mode: mode)
			stream.write(UInt8(0xCB))
			stream.write(value.bitPattern.bigEndian)
		}
#endif
		return data
	}
}

#endif
