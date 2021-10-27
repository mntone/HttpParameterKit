import Foundation

extension OutputStream {
	func write<T>(_ value: T) {
		_ = withUnsafeBytes(of: value) { pointer in
			write(pointer.baseAddress!.assumingMemoryBound(to: UInt8.self), maxLength: pointer.count)
		}
	}

	func write(_ value: String) {
		_ = value.data(using: .utf8)!.withUnsafeBytes { (pointer: UnsafeRawBufferPointer) in
			write(pointer.baseAddress!.assumingMemoryBound(to: UInt8.self), maxLength: pointer.count)
		}
	}

	func write(_ value: String, mode: MessagePackUtil.StringMode) {
		let count = value.count
		switch mode {
		case .uint4:
			write(0xA0 | UInt8(count))

		case .uint8:
			write(0xD9)
			write(UInt8(count))

		case .uint16:
			write(0xDA)
			write(UInt16(count))

		case .uint32:
			write(0xDB)
			write(UInt32(count))
		}

		write(value)
	}
}
