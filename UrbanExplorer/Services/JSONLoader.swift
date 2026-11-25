import Foundation

enum JSONLoaderError: Error, LocalizedError {
    case archivoNoEncontrado(String)

    var errorDescription: String? {
        switch self {
        case .archivoNoEncontrado(let nombre):
            return "No se encontró el archivo '\(nombre).json' en el Bundle principal."
        }
    }
}

enum JSONLoader {

    /// Decodifica cualquier tipo Decodable a partir de Data usando fechas ISO 8601.
    static func decodificar<T: Decodable>(_ tipo: T.Type, de datos: Data) throws -> T {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(T.self, from: datos)
    }

    /// Carga y decodifica un archivo JSON del Bundle lanzando errores si algo falla.
    static func cargarSpots(nombreArchivo: String = "spots", en bundle: Bundle = .main) throws -> [Spot] {
        guard let url = bundle.url(forResource: nombreArchivo, withExtension: "json") else {
            throw JSONLoaderError.archivoNoEncontrado(nombreArchivo)
        }
        let datos = try Data(contentsOf: url)
        return try decodificar([Spot].self, de: datos)
    }

    /// Carga segura para la aplicación: captura errores con do/try/catch e imprime diagnóstico en consola.
    static func cargarSpotsSeguro(nombreArchivo: String = "spots") -> [Spot] {
        do {
            return try cargarSpots(nombreArchivo: nombreArchivo)
        } catch let error as DecodingError {
            imprimirDetalleDecodingError(error)
            return []
        } catch {
            print("❌ Error al cargar '\(nombreArchivo).json': \(error.localizedDescription)")
            return []
        }
    }

    private static func imprimirDetalleDecodingError(_ error: DecodingError) {
        switch error {
        case .keyNotFound(let key, let context):
            let ruta = context.codingPath.map(\.stringValue).joined(separator: " -> ")
            print("❌ DecodingError.keyNotFound: falta la clave '\(key.stringValue)' en [\(ruta)]")
        case .typeMismatch(let type, let context):
            let ruta = context.codingPath.map(\.stringValue).joined(separator: " -> ")
            print("❌ DecodingError.typeMismatch: tipo esperado '\(type)' en [\(ruta)] - \(context.debugDescription)")
        case .valueNotFound(let type, let context):
            let ruta = context.codingPath.map(\.stringValue).joined(separator: " -> ")
            print("❌ DecodingError.valueNotFound: valor nulo para '\(type)' en [\(ruta)]")
        case .dataCorrupted(let context):
            print("❌ DecodingError.dataCorrupted: \(context.debugDescription)")
        @unknown default:
            print("❌ Error de decodificación desconocido: \(error.localizedDescription)")
        }
    }
}