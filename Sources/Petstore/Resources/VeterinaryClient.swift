/// Veterinary and medical records for pets
public final class VeterinaryClient: Sendable {
    private let httpClient: HTTPClient

    public init(config: ClientConfig) {
        self.httpClient = HTTPClient(config: config)
    }

    /// Create a medical record for a pet
    ///
    /// Create a new medical record entry for a pet
    public func createMedicalRecord(request: MedicalRecord, requestOptions: RequestOptions? = nil)
        async throws -> MedicalRecord
    {
        return try await httpClient.performRequest(
            method: .post,
            path: "/veterinary/medical-records",
            body: request,
            requestOptions: requestOptions,
            responseType: MedicalRecord.self
        )
    }

    /// Get medical records for a pet
    ///
    /// Retrieve all medical records for a specific pet
    /// - Parameter petId: ID of pet to get medical records for
    public func getMedicalRecordsByPetId(petId: Int64, requestOptions: RequestOptions? = nil)
        async throws -> [MedicalRecord]
    {
        return try await httpClient.performRequest(
            method: .get,
            path: "/veterinary/medical-records/\(petId)",
            requestOptions: requestOptions,
            responseType: [MedicalRecord].self
        )
    }

    /// Update a medical record
    ///
    /// Update an existing medical record
    /// - Parameter recordId: ID of medical record to update
    public func updateMedicalRecord(
        recordId: Int64, request: MedicalRecord, requestOptions: RequestOptions? = nil
    ) async throws -> MedicalRecord {
        return try await httpClient.performRequest(
            method: .put,
            path: "/veterinary/medical-records/\(recordId)",
            body: request,
            requestOptions: requestOptions,
            responseType: MedicalRecord.self
        )
    }

    /// Create veterinarian information
    ///
    /// Create a new veterinarian profile
    public func createVeterinarianInfo(
        request: VeterinarianInfo, requestOptions: RequestOptions? = nil
    )
        async throws -> VeterinarianInfo
    {
        return try await httpClient.performRequest(
            method: .post,
            path: "/veterinary/veterinarians",
            body: request,
            requestOptions: requestOptions,
            responseType: VeterinarianInfo.self
        )
    }

    /// Get veterinarian information
    ///
    /// Retrieve information about a specific veterinarian
    /// - Parameter vetId: ID of veterinarian to retrieve
    public func getVeterinarianById(vetId: Int64, requestOptions: RequestOptions? = nil)
        async throws -> VeterinarianInfo
    {
        return try await httpClient.performRequest(
            method: .get,
            path: "/veterinary/veterinarians/\(vetId)",
            requestOptions: requestOptions,
            responseType: VeterinarianInfo.self
        )
    }

    /// Schedule an appointment
    ///
    /// Schedule a new veterinary appointment
    public func scheduleAppointment(request: Appointment, requestOptions: RequestOptions? = nil)
        async throws -> Appointment
    {
        return try await httpClient.performRequest(
            method: .post,
            path: "/veterinary/appointments",
            body: request,
            requestOptions: requestOptions,
            responseType: Appointment.self
        )
    }

    /// Get appointment details
    ///
    /// Retrieve details of a specific appointment
    /// - Parameter appointmentId: ID of appointment to retrieve
    public func getAppointmentById(appointmentId: Int64, requestOptions: RequestOptions? = nil)
        async throws -> Appointment
    {
        return try await httpClient.performRequest(
            method: .get,
            path: "/veterinary/appointments/\(appointmentId)",
            requestOptions: requestOptions,
            responseType: Appointment.self
        )
    }
}
