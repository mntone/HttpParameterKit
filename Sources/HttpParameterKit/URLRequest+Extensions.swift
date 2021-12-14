import Foundation

public extension URLRequest {
	mutating func setBodyAsQuery(_ parameters: [String: AnyHashable], define: [HttpParameter], encoding: _QueryUtil.Encoding = .default) throws {
		do {
			let query = try define.query(parameters, encoding: encoding)
			httpBody = query.data(using: .utf8)!
		} catch {
			throw error
		}

		setContentType("application/x-www-form-urlencoded")
	}

	mutating func setBodyAsXml(_ parameters: [String: AnyHashable], define: [HttpParameter], root rootName: String) throws {
		do {
			let xml = try define.xml(parameters, root: rootName)
			httpBody = xml.data(using: .utf8)!
		} catch {
			throw error
		}

		setContentType("application/xml")
	}

	mutating func setBodyAsJson(_ parameters: [String: AnyHashable], define: [HttpParameter]) throws {
		do {
			let json = try define.json(parameters)
			httpBody = json.data(using: .utf8)!
		} catch {
			throw error
		}

		setContentType("application/json")
	}

	mutating func setBodyAsMsgPack(_ parameters: [String: AnyHashable], define: [HttpParameter]) throws {
		do {
			let query = try define.msgpack(parameters)
			httpBody = query
		} catch {
			throw error
		}

		setContentType("application/x-msgpack")
	}

	private mutating func setContentType(_ mineType: String) {
		setValue("\(mineType); charset=utf-8", forHTTPHeaderField: "Content-Type")
	}
}
