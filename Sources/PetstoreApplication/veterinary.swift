import Foundation
import Petstore

// MARK: - Veterinary Examples

func createMedicalRecord() async {
    print("=== Creating Medical Record ===")

    // Example vaccination record
    let vaccinationRecord = VaccinationRecord(
        petId: 1,
        veterinarianId: 501,
        createdAt: Date(),
        vaccineName: "Rabies",
        vaccinationDate: Date(),
        nextDueDate: Calendar.current.date(byAdding: .year, value: 1, to: Date()) ?? Date(),
        vaccinationSite: "Left shoulder"
    )

    let medicalRecord = MedicalRecord.vaccination(vaccinationRecord)

    do {
        let result = try await client.veterinary.createMedicalRecord(request: medicalRecord)
        print("✅ Medical record created successfully")
        print("Record: \(result)")
    } catch {
        print("❌ Error creating medical record: \(error)")
    }
}

func getMedicalRecordsByPetId() async {
    print("\n=== Getting Medical Records for Pet ===")

    do {
        let records = try await client.veterinary.getMedicalRecordsByPetId(petId: 1)
        print("✅ Found \(records.count) medical records")
        for record in records {
            print("Record: \(record)")
        }
    } catch {
        print("❌ Error getting medical records: \(error)")
    }
}

func updateMedicalRecord() async {
    print("\n=== Updating Medical Record ===")

    // Example checkup record with simple union test result
    let checkupRecord = CheckupRecord(
        id: 1001,
        petId: 1,
        veterinarianId: 501,
        createdAt: Date(),
        updatedAt: Date(),
        urgencyLevel: .routine,
        notes: "Annual checkup completed",
        weightKg: 25.5,
        temperatureCelsius: 38.5,
        heartRateBpm: 120,
        followUpRequired: false,
        examinationFindings: "Healthy, good body condition",
        primaryTestResult: .number(95.5)
    )

    let medicalRecord = MedicalRecord.checkup(checkupRecord)

    do {
        let result = try await client.veterinary.updateMedicalRecord(recordId: 1001, request: medicalRecord)
        print("✅ Medical record updated successfully")
        print("Updated record: \(result)")
    } catch {
        print("❌ Error updating medical record: \(error)")
    }
}

func getVeterinarianById() async {
    print("\n=== Getting Veterinarian Information ===")

    do {
        let vet = try await client.veterinary.getVeterinarianById(vetId: 501)
        print("✅ Veterinarian found")
        print("Dr. \(vet.firstName) \(vet.lastName)")
        print("License: \(vet.licenseNumber)")
        if let specialization = vet.specialization {
            print("Specialization: \(specialization)")
        }
        if let clinic = vet.clinicName {
            print("Clinic: \(clinic)")
        }
    } catch {
        print("❌ Error getting veterinarian: \(error)")
    }
}

func scheduleAppointment() async {
    print("\n=== Scheduling Appointment ===")

    let appointment = Appointment(
        petId: 1,
        veterinarianId: 501,
        appointmentDate: Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date(),
        appointmentStatus: .scheduled,
        urgencyLevel: .routine,
        reasonForVisit: "Annual checkup and vaccinations",
        estimatedDurationMinutes: 30,
        specialInstructions: "Pet is nervous around strangers",
        createdAt: Date()
    )

    do {
        let result = try await client.veterinary.scheduleAppointment(request: appointment)
        print("✅ Appointment scheduled successfully")
        print("Appointment ID: \(result.id ?? 0)")
        print("Date: \(result.appointmentDate)")
        print("Status: \(result.appointmentStatus)")
    } catch {
        print("❌ Error scheduling appointment: \(error)")
    }
}

func getAppointmentById() async {
    print("\n=== Getting Appointment Details ===")

    do {
        let appointment = try await client.veterinary.getAppointmentById(appointmentId: 2001)
        print("✅ Appointment found")
        print("Pet ID: \(appointment.petId)")
        print("Veterinarian ID: \(appointment.veterinarianId)")
        print("Date: \(appointment.appointmentDate)")
        print("Status: \(appointment.appointmentStatus)")
        if let reason = appointment.reasonForVisit {
            print("Reason: \(reason)")
        }
    } catch {
        print("❌ Error getting appointment: \(error)")
    }
}



func demonstrateSimpleUnion() async {
    print("\n=== Simple Union Demo (string | number | boolean) ===")
    
    // Create checkup records with different test result types
    let checkups = [
        CheckupRecord(
            petId: 1,
            veterinarianId: 501,
            createdAt: Date(),
            followUpRequired: false,
            examinationFindings: "Blood type test",
            primaryTestResult: .string("O negative")  // string result
        ),
        CheckupRecord(
            petId: 2,
            veterinarianId: 501,
            createdAt: Date(),
            followUpRequired: false,
            examinationFindings: "Blood glucose test",
            primaryTestResult: .number(95.5)  // number result
        ),
        CheckupRecord(
            petId: 3,
            veterinarianId: 501,
            createdAt: Date(),
            followUpRequired: true,
            examinationFindings: "Pregnancy test",
            primaryTestResult: .boolean(false)  // boolean result
        )
    ]
    
    print("🧪 CheckupRecord with Simple Union test results:")
    for (index, checkup) in checkups.enumerated() {
        print("   Checkup \(index + 1): \(checkup.examinationFindings ?? "Unknown test")")
        
        if let testResult = checkup.primaryTestResult {
            switch testResult {
            case .string(let value):
                print("      Result: \"\(value)\" (string)")
            case .number(let value):
                print("      Result: \(value) (number)")
            case .boolean(let value):
                print("      Result: \(value) (boolean)")
            }
        }
    }
}
