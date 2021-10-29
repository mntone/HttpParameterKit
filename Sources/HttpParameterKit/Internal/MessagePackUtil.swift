import Foundation

struct MessagePackUtil {
	enum StringMode {
		case uint4
		case uint8
		case uint16
		case uint32
	}

	static func prepare(string val: String) -> (Int, StringMode) {
		let utf8 = val.utf8
		let count = utf8.count
#if !os(watchOS) && !arch(i386) && !arch(arm)
		precondition(count <= 0xFFFF_FFFF)
#endif

		if count <= 0x19 {
			return (1 + count, .uint4)
		} else if count <= 0xFF {
			return (2 + count, .uint8)
		} else if count <= 0xFFFF {
			return (3 + count, .uint16)
		} else {
			return (5 + count, .uint32)
		}
	}

	static func write(capacity: Int, action: (OutputStream) -> Void) -> Data {
		let pointer = UnsafeMutablePointer<UInt8>.allocate(capacity: capacity)
		let stream = OutputStream(toBuffer: pointer, capacity: capacity)
		stream.open()
		defer { stream.close() }

		action(stream)
		return Data(bytesNoCopy: pointer, count: capacity, deallocator: .custom { pointer, capacity in
			pointer.deallocate()
		})
	}
}
