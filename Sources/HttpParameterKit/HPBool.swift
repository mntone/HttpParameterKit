import Foundation

public struct HPBool: HttpParameter {
	public let name: String
	public let defaultValue: Bool
	public let suppressDefault: Bool
	public let falseOutput: String
	public let trueOutput: String

	public init(_ name: String, default: Bool = false, suppressDefault: Bool = true, output: QueryOutputType = .upperOne) {
		self.name = name
		self.defaultValue = `default`
		self.suppressDefault = suppressDefault

		switch output {
		case .number:
			self.falseOutput = "0"
			self.trueOutput = "1"

		case .lower:
			self.falseOutput = "false"
			self.trueOutput = "true"

		case .upper:
			self.falseOutput = "False"
			self.trueOutput = "True"

		case .allUpper:
			self.falseOutput = "FALSE"
			self.trueOutput = "TRUE"

		case .lowerOne:
			self.falseOutput = "f"
			self.trueOutput = "t"

		case .upperOne:
			self.falseOutput = "F"
			self.trueOutput = "T"

		case .lowerYesNo:
			self.falseOutput = "no"
			self.trueOutput = "yes"

		case .upperYesNo:
			self.falseOutput = "No"
			self.trueOutput = "Yes"

		case .allUpperYesNo:
			self.falseOutput = "NO"
			self.trueOutput = "YES"

		case .lowerYesNoOne:
			self.falseOutput = "n"
			self.trueOutput = "y"

		case .upperYesNoOne:
			self.falseOutput = "N"
			self.trueOutput = "Y"

		case let .custom(`false`, `true`):
			self.falseOutput = `false`
			self.trueOutput = `true`
		}
	}

	public enum QueryOutputType {
		case number
		case lower
		case upper
		case allUpper
		case lowerOne
		case upperOne
		case lowerYesNo
		case upperYesNo
		case allUpperYesNo
		case lowerYesNoOne
		case upperYesNoOne
		case custom(false: String, true: String)
	}
}

// MARK: - HttpParameterInternal

extension HPBool: HttpParameterInternal {}

// MARK: - HttpParameterCodable

extension HPBool: HttpParameterCodable {
	@inlinable
	func query(_ value: Bool?, encoding: QueryEncoding) throws -> String? {
		if let val = value, !suppressDefault || val != defaultValue {
			let _name: String = _QueryUtil.query(from: name, encoding: encoding)
			let _val: String = _QueryUtil.query(from: val ? trueOutput : falseOutput, encoding: encoding)
			return "\(_name)=\(_val)"
		} else {
			return nil
		}
	}

	@inlinable
	func querydata(_ value: Bool?, encoding: QueryEncoding) throws -> HPPair? {
		if let val = value, !suppressDefault || val != defaultValue {
			let _name: String = _QueryUtil.query(from: name, encoding: encoding)
			let _val: String = _QueryUtil.query(from: val ? trueOutput : falseOutput, encoding: encoding)
			return (_name, _val)
		} else {
			return nil
		}
	}

	@inlinable
	func xml(_ value: Bool?) throws -> String? {
		if let val = value, !suppressDefault || val != defaultValue {
			return "<\(name)>\(val ? "true" : "false")</\(name)>"
		} else {
			return nil
		}
	}

	@inlinable
	func json(_ value: Bool?) throws -> String? {
		if let val = value, !suppressDefault || val != defaultValue {
			return "\"\(name)\":\(val ? "true" : "false")"
		} else {
			return nil
		}
	}

	func msgpack(_ value: Bool?) throws -> Data? {
		if let val = value, !suppressDefault || val != defaultValue {
			let (count, mode) = MessagePackUtil.prepare(string: name)
			let data = MessagePackUtil.write(capacity: count + 1) { stream in
				stream.write(name, mode: mode)
				stream.write(UInt8(val ? 0xC3 : 0xC2))
			}
			return data
		} else {
			return nil
		}
	}
}
