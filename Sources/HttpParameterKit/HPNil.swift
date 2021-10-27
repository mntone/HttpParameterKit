import Foundation

public struct HPNil: HttpParameter {
	let name: String
	let suppressDefault: Bool

	public init(_ name: String, suppressDefault: Bool = true) {
		self.name = name
		self.suppressDefault = suppressDefault
	}
}

// MARK: - HttpParameterInternal

extension HPNil: HttpParameterInternal {}

// MARK: - HttpParameterCodable

extension HPNil: HttpParameterCodable {
	func query(_ value: Void?) throws -> String? {
		if !suppressDefault {
			return "\(name.toQuery())=\0"
		} else {
			return nil
		}
	}

	func xml(_ value: Void?) throws -> String? {
		if !suppressDefault {
			return "<\(name)></\(name)>"
		} else {
			return nil
		}
	}

	func json(_ value: Void?) throws -> String? {
		if !suppressDefault {
			return "\"\(name)\":null"
		} else {
			return nil
		}
	}

	func msgpack(_ value: Void?) throws -> Data? {
		if !suppressDefault {
			let (count, mode) = MessagePackUtil.prepare(string: name)
			let data = MessagePackUtil.write(capacity: count + 1) { stream in
				stream.write(name, mode: mode)
				stream.write(UInt8(0xC0))
			}
			return data
		} else {
			return nil
		}
	}
}
