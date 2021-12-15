import Foundation

public struct HPString: HttpParameter {
	let name: String
	private let defaultValue: String
	let suppressDefault: Bool

	public init(_ name: String, default: String = "", suppressDefault: Bool = true) {
		self.name = name
		self.defaultValue = `default`
		self.suppressDefault = suppressDefault
	}
}

// MARK: - HttpParameterInternal

extension HPString: HttpParameterInternal {}

// MARK: - HttpParameterCodable

extension HPString: HttpParameterCodable {
	func query(_ value: String?, encoding: QueryEncoding) throws -> String? {
		if let val = value {
			let _name: String = _QueryUtil.query(from: name, encoding: encoding)
			let _val: String = _QueryUtil.query(from: val, encoding: encoding)
			return "\(_name)=\(_val)"
		} else if !suppressDefault {
			let _name: String = _QueryUtil.query(from: name, encoding: encoding)
			let _val: String = _QueryUtil.query(from: defaultValue, encoding: encoding)
			return "\(_name)=\(_val)"
		} else {
			return nil
		}
	}

	func querydata(_ value: String?, encoding: QueryEncoding) throws -> HPPair? {
		if let val = value {
			let _name: String = _QueryUtil.query(from: name, encoding: encoding)
			let _val: String = _QueryUtil.query(from: val, encoding: encoding)
			return (_name, _val)
		} else if !suppressDefault {
			let _name: String = _QueryUtil.query(from: name, encoding: encoding)
			let _val: String = _QueryUtil.query(from: defaultValue, encoding: encoding)
			return (_name, _val)
		} else {
			return nil
		}
	}

	func xml(_ value: String?) throws -> String? {
		if let val = value {
			return "<\(name)>\(strXml(val))</\(name)>"
		} else if !suppressDefault {
			return "<\(name)>\(strXml(defaultValue))</\(name)>"
		} else {
			return nil
		}
	}

	private func strXml(_ value: String) -> String {
		var str = String()
		var tokenizer = XmlTextTokenizer(text: value)
		while let token = tokenizer.nextToken() {
			switch token {
			case .quotationMark:
				str.append(contentsOf: "&quot;")
			case .ampersand:
				str.append(contentsOf: "&amp;")
			case .apostrophe:
				str.append(contentsOf: "&apos;")
			case .leftThan:
				str.append(contentsOf: "&lt;")
			case .rightThan:
				str.append(contentsOf: "&gt;")
			case let .string(text):
				str.append(contentsOf: text)
			default:
				fatalError("Unreachable")
			}
		}
		return str
	}

	func json(_ value: String?) throws -> String? {
		if let val = value {
			return "\"\(name)\":\"\(strJson(val))\""
		} else if !suppressDefault {
			return "\"\(name)\":\"\(strJson(defaultValue))\""
		} else {
			return nil
		}
	}

	private func strJson(_ value: String) -> String {
		var str = String()
		var tokenizer = JsonTextTokenizer(text: value)
		while let token = tokenizer.nextToken() {
			switch token {
			case .backspace:
				str.append(contentsOf: "\\b")
			case .tab:
				str.append(contentsOf: "\\t")
			case .lineFeed:
				str.append(contentsOf: "\\n")
			case .formFeed:
				str.append(contentsOf: "\\f")
			case .carriageReturn:
				str.append(contentsOf: "\\r")
			case .quotationMark:
				str.append(contentsOf: "\\\"")
			case .reverseSolidus:
				str.append(contentsOf: "\\\\")
			case let .string(text):
				str.append(contentsOf: text)
			default:
				fatalError("Unreachable")
			}
		}
		return str
	}

	func msgpack(_ value: String?) throws -> Data? {
		do {
			if let val = value {
				return try dataMsgPack(val)
			} else if !suppressDefault {
				return try dataMsgPack(defaultValue)
			} else {
				return nil
			}
		} catch {
			throw error
		}
	}

	private func dataMsgPack(_ value: String) throws -> Data {
		let (countKey, modeKey) = MessagePackUtil.prepare(string: name)
		let (countVal, modeVal) = MessagePackUtil.prepare(string: value)

		let len = countKey + countVal
		let data = MessagePackUtil.write(capacity: len) { stream in
			stream.write(name, mode: modeKey)
			stream.write(value, mode: modeVal)
		}
		return data
	}
}
