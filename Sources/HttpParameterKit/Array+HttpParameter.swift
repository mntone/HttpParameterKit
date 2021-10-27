import Foundation

private extension Optional {
	func toArray() -> [Wrapped] {
		guard let value = self else { return [] }
		return [value]
	}
}

public extension Collection where Iterator.Element == HttpParameter {
	func query(_ parameters: [String: AnyHashable]) throws -> String {
		do {
			return try flatMap { item -> [String] in
				switch item {
				case let nilItem as HPNil:
					return try nilItem.query(()).toArray()
				case let boolItem as HPBool:
					return try boolItem.query(parameters[boolItem.name] as? Bool).toArray()
				case let stringItem as HPString:
					return try stringItem.query(parameters[stringItem.name] as? String).toArray()
				case let integerItem as HPInt:
					return try integerItem.query(parameters[integerItem.name] as? Int).toArray()
				case let int8Item as HPInt8:
					return try int8Item.query(parameters[int8Item.name] as? Int8).toArray()
				case let int16Item as HPInt16:
					return try int16Item.query(parameters[int16Item.name] as? Int16).toArray()
				case let int32Item as HPInt32:
					return try int32Item.query(parameters[int32Item.name] as? Int32).toArray()
				case let int64Item as HPInt64:
					return try int64Item.query(parameters[int64Item.name] as? Int64).toArray()
				case let uintItem as HPUInt:
					return try uintItem.query(parameters[uintItem.name] as? UInt).toArray()
				case let uint8Item as HPUInt8:
					return try uint8Item.query(parameters[uint8Item.name] as? UInt8).toArray()
				case let uint16Item as HPUInt16:
					return try uint16Item.query(parameters[uint16Item.name] as? UInt16).toArray()
				case let uint32Item as HPUInt32:
					return try uint32Item.query(parameters[uint32Item.name] as? UInt32).toArray()
				case let uint64Item as HPUInt64:
					return try uint64Item.query(parameters[uint64Item.name] as? UInt64).toArray()
				case let floatItem as HPFloat:
					return try floatItem.query(parameters[floatItem.name] as? Float).toArray()
				case let doubleItem as HPDouble:
					return try doubleItem.query(parameters[doubleItem.name] as? Double).toArray()
				case let patternItem as HPPattern:
					return try patternItem.query(parameters)
				default:
#if swift(>=5.3) && (os(iOS) || os(watchOS) || os(tvOS))
					if #available(iOS 14.0, watchOS 7.0, tvOS 14.0, *),
					   let float16Item = item as? HPFloat16 {
						return try float16Item.query(parameters[float16Item.name] as? Float16).toArray()
					}
#endif
#if swift(>=1.1) && os(macOS)
					if #available(macOS 10.10, *),
					   let float80Item = item as? HPFloat80 {
						return try float80Item.query(parameters[float80Item.name] as? Float80).toArray()
					}
#endif
					throw HttpParameterBuildError.invalidType
				}
			}.joined(separator: "&")
		} catch {
			throw error
		}
	}

	func xml(_ parameters: [String: AnyHashable], root rootName: String) throws -> String {
		do {
			let xmlString = try flatMap { item -> [String] in
				switch item {
				case let nilItem as HPNil:
					return try nilItem.xml(()).toArray()
				case let boolItem as HPBool:
					return try boolItem.xml(parameters[boolItem.name] as? Bool).toArray()
				case let stringItem as HPString:
					return try stringItem.xml(parameters[stringItem.name] as? String).toArray()
				case let integerItem as HPInt:
					return try integerItem.xml(parameters[integerItem.name] as? Int).toArray()
				case let int8Item as HPInt8:
					return try int8Item.xml(parameters[int8Item.name] as? Int8).toArray()
				case let int16Item as HPInt16:
					return try int16Item.xml(parameters[int16Item.name] as? Int16).toArray()
				case let int32Item as HPInt32:
					return try int32Item.xml(parameters[int32Item.name] as? Int32).toArray()
				case let int64Item as HPInt64:
					return try int64Item.xml(parameters[int64Item.name] as? Int64).toArray()
				case let uintItem as HPUInt:
					return try uintItem.xml(parameters[uintItem.name] as? UInt).toArray()
				case let uint8Item as HPUInt8:
					return try uint8Item.xml(parameters[uint8Item.name] as? UInt8).toArray()
				case let uint16Item as HPUInt16:
					return try uint16Item.xml(parameters[uint16Item.name] as? UInt16).toArray()
				case let uint32Item as HPUInt32:
					return try uint32Item.xml(parameters[uint32Item.name] as? UInt32).toArray()
				case let uint64Item as HPUInt64:
					return try uint64Item.xml(parameters[uint64Item.name] as? UInt64).toArray()
				case let floatItem as HPFloat:
					return try floatItem.xml(parameters[floatItem.name] as? Float).toArray()
				case let doubleItem as HPDouble:
					return try doubleItem.xml(parameters[doubleItem.name] as? Double).toArray()
				case let patternItem as HPPattern:
					return try patternItem.xml(parameters)
				default:
#if swift(>=5.3) && (os(iOS) || os(watchOS) || os(tvOS))
					if #available(iOS 14.0, watchOS 7.0, tvOS 14.0, *),
					   let float16Item = item as? HPFloat16 {
						return try float16Item.xml(parameters[float16Item.name] as? Float16).toArray()
					}
#endif
#if swift(>=1.1) && os(macOS)
					if #available(macOS 10.10, *),
					   let float80Item = item as? HPFloat80 {
						return try float80Item.xml(parameters[float80Item.name] as? Float80).toArray()
					}
#endif
					throw HttpParameterBuildError.invalidType
				}
			}.joined()
			return "<\(rootName)>\(xmlString)</\(rootName)>"
		} catch {
			throw error
		}
	}

	func json(_ parameters: [String: AnyHashable]) throws -> String {
		do {
			let jsonString = try flatMap { item -> [String] in
				switch item {
				case let nilItem as HPNil:
					return try nilItem.json(()).toArray()
				case let boolItem as HPBool:
					return try boolItem.json(parameters[boolItem.name] as? Bool).toArray()
				case let stringItem as HPString:
					return try stringItem.json(parameters[stringItem.name] as? String).toArray()
				case let integerItem as HPInt:
					return try integerItem.json(parameters[integerItem.name] as? Int).toArray()
				case let int8Item as HPInt8:
					return try int8Item.json(parameters[int8Item.name] as? Int8).toArray()
				case let int16Item as HPInt16:
					return try int16Item.json(parameters[int16Item.name] as? Int16).toArray()
				case let int32Item as HPInt32:
					return try int32Item.json(parameters[int32Item.name] as? Int32).toArray()
				case let int64Item as HPInt64:
					return try int64Item.json(parameters[int64Item.name] as? Int64).toArray()
				case let uintItem as HPUInt:
					return try uintItem.json(parameters[uintItem.name] as? UInt).toArray()
				case let uint8Item as HPUInt8:
					return try uint8Item.json(parameters[uint8Item.name] as? UInt8).toArray()
				case let uint16Item as HPUInt16:
					return try uint16Item.json(parameters[uint16Item.name] as? UInt16).toArray()
				case let uint32Item as HPUInt32:
					return try uint32Item.json(parameters[uint32Item.name] as? UInt32).toArray()
				case let uint64Item as HPUInt64:
					return try uint64Item.json(parameters[uint64Item.name] as? UInt64).toArray()
				case let floatItem as HPFloat:
					return try floatItem.json(parameters[floatItem.name] as? Float).toArray()
				case let doubleItem as HPDouble:
					return try doubleItem.json(parameters[doubleItem.name] as? Double).toArray()
				case let patternItem as HPPattern:
					return try patternItem.json(parameters)
				default:
#if swift(>=5.3) && (os(iOS) || os(watchOS) || os(tvOS))
					if #available(iOS 14.0, watchOS 7.0, tvOS 14.0, *),
					   let float16Item = item as? HPFloat16 {
						return try float16Item.json(parameters[float16Item.name] as? Float16).toArray()
					}
#endif
#if swift(>=1.1) && os(macOS)
					if #available(macOS 10.10, *),
					   let float80Item = item as? HPFloat80 {
						return try float80Item.json(parameters[float80Item.name] as? Float80).toArray()
					}
#endif
					throw HttpParameterBuildError.invalidType
				}
			}.joined(separator: ",")
			return "{\(jsonString)}"
		} catch {
			throw error
		}
	}

	func msgpack(_ parameters: [String: AnyHashable]) throws -> Data {
		do {
			let dataArray = try flatMap { item -> [Data] in
				switch item {
				case let nilItem as HPNil:
					return try nilItem.msgpack(()).toArray()
				case let boolItem as HPBool:
					return try boolItem.msgpack(parameters[boolItem.name] as? Bool).toArray()
				case let stringItem as HPString:
					return try stringItem.msgpack(parameters[stringItem.name] as? String).toArray()
				case let integerItem as HPInt:
					return try integerItem.msgpack(parameters[integerItem.name] as? Int).toArray()
				case let int8Item as HPInt8:
					return try int8Item.msgpack(parameters[int8Item.name] as? Int8).toArray()
				case let int16Item as HPInt16:
					return try int16Item.msgpack(parameters[int16Item.name] as? Int16).toArray()
				case let int32Item as HPInt32:
					return try int32Item.msgpack(parameters[int32Item.name] as? Int32).toArray()
				case let int64Item as HPInt64:
					return try int64Item.msgpack(parameters[int64Item.name] as? Int64).toArray()
				case let uintItem as HPUInt:
					return try uintItem.msgpack(parameters[uintItem.name] as? UInt).toArray()
				case let uint8Item as HPUInt8:
					return try uint8Item.msgpack(parameters[uint8Item.name] as? UInt8).toArray()
				case let uint16Item as HPUInt16:
					return try uint16Item.msgpack(parameters[uint16Item.name] as? UInt16).toArray()
				case let uint32Item as HPUInt32:
					return try uint32Item.msgpack(parameters[uint32Item.name] as? UInt32).toArray()
				case let uint64Item as HPUInt64:
					return try uint64Item.msgpack(parameters[uint64Item.name] as? UInt64).toArray()
				case let floatItem as HPFloat:
					return try floatItem.msgpack(parameters[floatItem.name] as? Float).toArray()
				case let doubleItem as HPDouble:
					return try doubleItem.msgpack(parameters[doubleItem.name] as? Double).toArray()
				case let patternItem as HPPattern:
					return try patternItem.msgpack(parameters)
				default:
					throw HttpParameterBuildError.invalidType
				}
			}

			let count = dataArray.count
			let data: Data
			switch count {
			case 0x0000_0000...0x0000_000F:
				data = MessagePackUtil.write(capacity: 1) { stream in
					stream.write(0x80 | (0x0F & UInt8(count)))
				}

			case 0x0000_0010...0x0000_FFFF:
				data = MessagePackUtil.write(capacity: 3) { stream in
					stream.write(0xDE)
					stream.write(UInt16(count))
				}

#if arch(i386) || arch(arm)
			case 0x0001_0000...0x7FFF_FFFF:
				data = MessagePackUtil.write(capacity: 5) { stream in
					stream.write(0xDF)
					stream.write(UInt32(count))
				}
#else
			case 0x0001_0000...0xFFFF_FFFF:
				data = MessagePackUtil.write(capacity: 5) { stream in
					stream.write(0xDF)
					stream.write(UInt32(count))
				}
#endif

			default:
				throw HttpParameterBuildError.unreachable
			}
			return dataArray.reduce(data) { $0 + $1 }
		} catch {
			throw error
		}
	}
}
