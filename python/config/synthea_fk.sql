-- Foreign Keys for Allergies
ALTER TABLE patients_data.allergies
    ADD CONSTRAINT fk_allergies_patient FOREIGN KEY (patient) REFERENCES patients_data.patients (id),
    ADD CONSTRAINT fk_allergies_encounter FOREIGN KEY (encounter) REFERENCES patients_data.encounters (id);

-- Foreign Keys for CarePlans
ALTER TABLE patients_data.careplans
    ADD CONSTRAINT fk_careplans_patient FOREIGN KEY (patient) REFERENCES patients_data.patients (id),
    ADD CONSTRAINT fk_careplans_encounter FOREIGN KEY (encounter) REFERENCES patients_data.encounters (id);

-- Foreign Keys for Claims
ALTER TABLE patients_data.claims
    ADD CONSTRAINT fk_claims_patient FOREIGN KEY (patientid) REFERENCES patients_data.patients (id),
    ADD CONSTRAINT fk_claims_provider FOREIGN KEY (providerid) REFERENCES patients_data.providers (id),
    ADD CONSTRAINT fk_claims_primary_insurance FOREIGN KEY (primarypatientinsuranceid) REFERENCES patients_data.payers (id),
    ADD CONSTRAINT fk_claims_secondary_insurance FOREIGN KEY (secondarypatientinsuranceid) REFERENCES patients_data.payers (id),
    ADD CONSTRAINT fk_claims_referring_provider FOREIGN KEY (referringproviderid) REFERENCES patients_data.providers (id),
    ADD CONSTRAINT fk_claims_appointment FOREIGN KEY (appointmentid) REFERENCES patients_data.encounters (id),
    ADD CONSTRAINT fk_claims_supervising_provider FOREIGN KEY (supervisingproviderid) REFERENCES patients_data.providers (id);

-- Foreign Keys for Claims_Transactions
ALTER TABLE patients_data.claims_transactions
    ADD CONSTRAINT fk_claims_transactions_claim FOREIGN KEY (claimid) REFERENCES patients_data.claims (id),
    ADD CONSTRAINT fk_claims_transactions_patient FOREIGN KEY (patientid) REFERENCES patients_data.patients (id),
    ADD CONSTRAINT fk_claims_transactions_placeofservice FOREIGN KEY (placeofservice) REFERENCES patients_data.organizations (id),
    ADD CONSTRAINT fk_claims_transactions_appointment FOREIGN KEY (appointmentid) REFERENCES patients_data.encounters (id),
    ADD CONSTRAINT fk_claims_transactions_patientinsurance FOREIGN KEY (patientinsuranceid) REFERENCES patients_data.payer_transitions (memberid),
    ADD CONSTRAINT fk_claims_transactions_provider FOREIGN KEY (providerid) REFERENCES patients_data.providers (id),
    ADD CONSTRAINT fk_claims_transactions_supervisingprovider FOREIGN KEY (supervisingproviderid) REFERENCES patients_data.providers (id);

-- Foreign Keys for Conditions
ALTER TABLE patients_data.conditions
    ADD CONSTRAINT fk_conditions_patient FOREIGN KEY (patient) REFERENCES patients_data.patients (id),
    ADD CONSTRAINT fk_conditions_encounter FOREIGN KEY (encounter) REFERENCES patients_data.encounters (id);

-- Foreign Keys for Devices
ALTER TABLE patients_data.devices
    ADD CONSTRAINT fk_devices_patient FOREIGN KEY (patient) REFERENCES patients_data.patients (id),
    ADD CONSTRAINT fk_devices_encounter FOREIGN KEY (encounter) REFERENCES patients_data.encounters (id);

-- Foreign Keys for Encounters
ALTER TABLE patients_data.encounters
    ADD CONSTRAINT fk_encounters_patient FOREIGN KEY (patient) REFERENCES patients_data.patients (id),
    ADD CONSTRAINT fk_encounters_organization FOREIGN KEY (organization) REFERENCES patients_data.organizations (id),
    ADD CONSTRAINT fk_encounters_provider FOREIGN KEY (provider) REFERENCES patients_data.providers (id),
    ADD CONSTRAINT fk_encounters_payer FOREIGN KEY (payer) REFERENCES patients_data.payers (id);

-- Foreign Keys for Imaging Studies
ALTER TABLE patients_data.imaging_studies
    ADD CONSTRAINT fk_imaging_studies_patient FOREIGN KEY (patient) REFERENCES patients_data.patients (id),
    ADD CONSTRAINT fk_imaging_studies_encounter FOREIGN KEY (encounter) REFERENCES patients_data.encounters (id);

-- Foreign Keys for Immunizations
ALTER TABLE patients_data.immunizations
    ADD CONSTRAINT fk_immunizations_patient FOREIGN KEY (patient) REFERENCES patients_data.patients (id),
    ADD CONSTRAINT fk_immunizations_encounter FOREIGN KEY (encounter) REFERENCES patients_data.encounters (id);

-- Foreign Keys for Medications
ALTER TABLE patients_data.medications
    ADD CONSTRAINT fk_medications_patient FOREIGN KEY (patient) REFERENCES patients_data.patients (id),
    ADD CONSTRAINT fk_medications_payer FOREIGN KEY (payer) REFERENCES patients_data.payers (id),
    ADD CONSTRAINT fk_medications_encounter FOREIGN KEY (encounter) REFERENCES patients_data.encounters (id);

-- Foreign Keys for Observations
ALTER TABLE patients_data.observations
    ADD CONSTRAINT fk_observations_patient FOREIGN KEY (patient) REFERENCES patients_data.patients (id),
    ADD CONSTRAINT fk_observations_encounter FOREIGN KEY (encounter) REFERENCES patients_data.encounters (id);

-- Foreign Keys for Payer Transitions
ALTER TABLE patients_data.payer_transitions
    ADD CONSTRAINT fk_payer_transitions_patient FOREIGN KEY (patient) REFERENCES patients_data.patients (id),
    ADD CONSTRAINT fk_payer_transitions_payer FOREIGN KEY (payer) REFERENCES patients_data.payers (id),
    ADD CONSTRAINT fk_payer_transitions_secondary_payer FOREIGN KEY (secondary_payer) REFERENCES patients_data.payers (id);

-- Foreign Keys for Procedures
ALTER TABLE patients_data.procedures
    ADD CONSTRAINT fk_procedures_patient FOREIGN KEY (patient) REFERENCES patients_data.patients (id),
    ADD CONSTRAINT fk_procedures_encounter FOREIGN KEY (encounter) REFERENCES patients_data.encounters (id);

-- Foreign Keys for Providers
ALTER TABLE patients_data.providers
    ADD CONSTRAINT fk_providers_organization FOREIGN KEY (organization) REFERENCES patients_data.organizations (id);

-- Foreign Keys for Supplies
ALTER TABLE patients_data.supplies
    ADD CONSTRAINT fk_supplies_patient FOREIGN KEY (patient) REFERENCES patients_data.patients (id),
    ADD CONSTRAINT fk_supplies_encounter FOREIGN KEY (encounter) REFERENCES patients_data.encounters (id);
