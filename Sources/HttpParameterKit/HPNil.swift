import Foundation

public struct HPNil: HttpParameter {
	public let name: String
	public let suppressDefault: Bool

	public init(_ name: String, suppressDefault: Bool = true) {
		self.name = name
		self.suppressDefault = suppressDefault
	}
}

// MARK: - HttpParameterInternal

extension HPNil: HttpParameterInternal {}

// MARK: - HttpParameterCodable

extension HPNil: HttpParameterCodable {
	@inlinable
	func query(_ value: Void?, encoding: _QueryUtil.Encoding) throws -> String? {
		if !suppressDefault {
			let _name: String = _QueryUtil.query(as: name, encoding: encoding)
			return "\(_name)=\0"
		} else {
			return nil
		}
	}

	@inlinable
	func xml(_ value: Void?) throws -> String? {
		if !suppressDefault {
			return "<\(name)></\(name)>"
		} else {
			return nil
		}
	}

	@inlinable
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
