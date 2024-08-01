-- Comments for Allergies
COMMENT ON TABLE patients_data.allergies IS 'Patient allergy data';
COMMENT ON COLUMN patients_data.allergies.start IS 'The date the allergy was diagnosed';
COMMENT ON COLUMN patients_data.allergies.stop IS 'The date the allergy ended, if applicable';
COMMENT ON COLUMN patients_data.allergies.patient IS 'Foreign key to the Patient';
COMMENT ON COLUMN patients_data.allergies.encounter IS 'Foreign key to the Encounter when the allergy was diagnosed';
COMMENT ON COLUMN patients_data.allergies.code IS 'Allergy code';
COMMENT ON COLUMN patients_data.allergies.system IS 'Terminology system of the Allergy code. RxNorm if this is a medication allergy, otherwise SNOMED-CT';
COMMENT ON COLUMN patients_data.allergies.description IS 'Description of the Allergy';
COMMENT ON COLUMN patients_data.allergies.type IS 'Identify entry as an allergy or intolerance';
COMMENT ON COLUMN patients_data.allergies.category IS 'Identify the category as drug, medication, food, or environment';
COMMENT ON COLUMN patients_data.allergies.reaction1 IS 'Optional SNOMED code of the patient''s reaction';
COMMENT ON COLUMN patients_data.allergies.description1 IS 'Optional description of the Reaction1 SNOMED code';
COMMENT ON COLUMN patients_data.allergies.severity1 IS 'Severity of the reaction: MILD, MODERATE, or SEVERE';
COMMENT ON COLUMN patients_data.allergies.reaction2 IS 'Optional SNOMED code of the patient''s second reaction';
COMMENT ON COLUMN patients_data.allergies.description2 IS 'Optional description of the Reaction2 SNOMED code';
COMMENT ON COLUMN patients_data.allergies.severity2 IS 'Severity of the second reaction: MILD, MODERATE, or SEVERE';

-- Comments for CarePlans
COMMENT ON TABLE patients_data.careplans IS 'Patient care plan data, including goals';
COMMENT ON COLUMN patients_data.careplans.id IS 'Primary Key. Unique Identifier of the care plan';
COMMENT ON COLUMN patients_data.careplans.start IS 'The date the care plan was initiated';
COMMENT ON COLUMN patients_data.careplans.stop IS 'The date the care plan ended, if applicable';
COMMENT ON COLUMN patients_data.careplans.patient IS 'Foreign key to the Patient';
COMMENT ON COLUMN patients_data.careplans.encounter IS 'Foreign key to the Encounter when the care plan was initiated';
COMMENT ON COLUMN patients_data.careplans.code IS 'Code from SNOMED-CT';
COMMENT ON COLUMN patients_data.careplans.description IS 'Description of the care plan';
COMMENT ON COLUMN patients_data.careplans.reasoncode IS 'Diagnosis code from SNOMED-CT that this care plan addresses';
COMMENT ON COLUMN patients_data.careplans.reasondescription IS 'Description of the reason code';

-- Comments for Claims
COMMENT ON TABLE patients_data.claims IS 'Patient claim data';
COMMENT ON COLUMN patients_data.claims.id IS 'Primary Key. Unique Identifier of the claim';
COMMENT ON COLUMN patients_data.claims.patientid IS 'Foreign key to the Patient';
COMMENT ON COLUMN patients_data.claims.providerid IS 'Foreign key to the Provider';
COMMENT ON COLUMN patients_data.claims.primarypatientinsuranceid IS 'Foreign key to the primary Payer';
COMMENT ON COLUMN patients_data.claims.secondarypatientinsuranceid IS 'Foreign key to the second Payer';
COMMENT ON COLUMN patients_data.claims.departmentid IS 'Placeholder for department';
COMMENT ON COLUMN patients_data.claims.patientdepartmentid IS 'Placeholder for patient department';
COMMENT ON COLUMN patients_data.claims.diagnosis1 IS 'SNOMED-CT code corresponding to a diagnosis related to the claim';
COMMENT ON COLUMN patients_data.claims.diagnosis2 IS 'SNOMED-CT code corresponding to a diagnosis related to the claim';
COMMENT ON COLUMN patients_data.claims.diagnosis3 IS 'SNOMED-CT code corresponding to a diagnosis related to the claim';
COMMENT ON COLUMN patients_data.claims.diagnosis4 IS 'SNOMED-CT code corresponding to a diagnosis related to the claim';
COMMENT ON COLUMN patients_data.claims.diagnosis5 IS 'SNOMED-CT code corresponding to a diagnosis related to the claim';
COMMENT ON COLUMN patients_data.claims.diagnosis6 IS 'SNOMED-CT code corresponding to a diagnosis related to the claim';
COMMENT ON COLUMN patients_data.claims.diagnosis7 IS 'SNOMED-CT code corresponding to a diagnosis related to the claim';
COMMENT ON COLUMN patients_data.claims.diagnosis8 IS 'SNOMED-CT code corresponding to a diagnosis related to the claim';
COMMENT ON COLUMN patients_data.claims.referringproviderid IS 'Foreign key to the Provider who made the referral';
COMMENT ON COLUMN patients_data.claims.appointmentid IS 'Foreign key to the Encounter';
COMMENT ON COLUMN patients_data.claims.currentillnessdate IS 'The date the patient experienced symptoms';
COMMENT ON COLUMN patients_data.claims.servicedate IS 'The date of the services on the claim';
COMMENT ON COLUMN patients_data.claims.supervisingproviderid IS 'Foreign key to the supervising Provider';
COMMENT ON COLUMN patients_data.claims.status1 IS 'Status of the claim from the Primary Insurance. BILLED or CLOSED';
COMMENT ON COLUMN patients_data.claims.status2 IS 'Status of the claim from the Secondary Insurance. BILLED or CLOSED';
COMMENT ON COLUMN patients_data.claims.statusp IS 'Status of the claim from the Patient. BILLED or CLOSED';
COMMENT ON COLUMN patients_data.claims.outstanding1 IS 'Total amount of money owed by Primary Insurance';
COMMENT ON COLUMN patients_data.claims.outstanding2 IS 'Total amount of money owed by Secondary Insurance';
COMMENT ON COLUMN patients_data.claims.outstandingp IS 'Total amount of money owed by Patient';
COMMENT ON COLUMN patients_data.claims.lastbilleddate1 IS 'Date the claim was sent to Primary Insurance';
COMMENT ON COLUMN patients_data.claims.lastbilleddate2 IS 'Date the claim was sent to Secondary Insurance';
COMMENT ON COLUMN patients_data.claims.lastbilleddatep IS 'Date the claim was sent to the Patient';
COMMENT ON COLUMN patients_data.claims.healthcareclaimtypeid1 IS 'Type of claim: 1 is professional, 2 is institutional';
COMMENT ON COLUMN patients_data.claims.healthcareclaimtypeid2 IS 'Type of claim: 1 is professional, 2 is institutional';


-- Comments for Claims_Transactions
COMMENT ON TABLE patients_data.claims_transactions IS 'Transactions per line item per claim';
COMMENT ON COLUMN patients_data.claims_transactions.id IS 'Primary Key. Unique Identifier of the claim transaction';
COMMENT ON COLUMN patients_data.claims_transactions.claimid IS 'Foreign key to the Claim';
COMMENT ON COLUMN patients_data.claims_transactions.chargeid IS 'Charge ID';
COMMENT ON COLUMN patients_data.claims_transactions.patientid IS 'Foreign key to the Patient';
COMMENT ON COLUMN patients_data.claims_transactions.type IS 'Type of transaction: CHARGE, PAYMENT, ADJUSTMENT, TRANSFERIN, or TRANSFEROUT';
COMMENT ON COLUMN patients_data.claims_transactions.amount IS 'Dollar amount for a CHARGE or TRANSFERIN';
COMMENT ON COLUMN patients_data.claims_transactions.method IS 'Payment method: CASH, CHECK, ECHECK, COPAY, SYSTEM, or CC';
COMMENT ON COLUMN patients_data.claims_transactions.fromdate IS 'Transaction start date';
COMMENT ON COLUMN patients_data.claims_transactions.todate IS 'Transaction end date';
COMMENT ON COLUMN patients_data.claims_transactions.placeofservice IS 'Foreign key to the Organization';
COMMENT ON COLUMN patients_data.claims_transactions.procedurecode IS 'SNOMED-CT or other code (e.g. CVX for Vaccines) for the service';
COMMENT ON COLUMN patients_data.claims_transactions.modifier1 IS 'Unused. Modifier on procedure code';
COMMENT ON COLUMN patients_data.claims_transactions.modifier2 IS 'Unused. Modifier on procedure code';
COMMENT ON COLUMN patients_data.claims_transactions.diagnosisref1 IS 'Number indicating which diagnosis code from the claim applies to this transaction, 1-8 are valid options';
COMMENT ON COLUMN patients_data.claims_transactions.diagnosisref2 IS 'Number indicating which diagnosis code from the claim applies to this transaction, 1-8 are valid options';
COMMENT ON COLUMN patients_data.claims_transactions.diagnosisref3 IS 'Number indicating which diagnosis code from the claim applies to this transaction, 1-8 are valid options';
COMMENT ON COLUMN patients_data.claims_transactions.diagnosisref4 IS 'Number indicating which diagnosis code from the claim applies to this transaction, 1-8 are valid options';
COMMENT ON COLUMN patients_data.claims_transactions.units IS 'Number of units of the service';
COMMENT ON COLUMN patients_data.claims_transactions.departmentid IS 'Placeholder for department';
COMMENT ON COLUMN patients_data.claims_transactions.notes IS 'Description of the service or transaction';
COMMENT ON COLUMN patients_data.claims_transactions.unitamount IS 'Cost per unit';
COMMENT ON COLUMN patients_data.claims_transactions.transferoutid IS 'If the transaction is a TRANSFERIN, the Charge ID of the corresponding TRANSFEROUT row';
COMMENT ON COLUMN patients_data.claims_transactions.transfertype IS '1 if transferred to the primary insurance, 2 if transferred to the secondary insurance, or p if transferred to the patient';
COMMENT ON COLUMN patients_data.claims_transactions.payments IS 'Dollar amount of a payment for a PAYMENT row';
COMMENT ON COLUMN patients_data.claims_transactions.adjustments IS 'Dollar amount of an adjustment for an ADJUSTMENTS row';
COMMENT ON COLUMN patients_data.claims_transactions.transfers IS 'Dollar amount of a transfer for a TRANSFERIN or TRANSFEROUT row';
COMMENT ON COLUMN patients_data.claims_transactions.outstanding IS 'Dollar amount left unpaid after this transaction was applied';
COMMENT ON COLUMN patients_data.claims_transactions.appointmentid IS 'Foreign key to the Encounter';
COMMENT ON COLUMN patients_data.claims_transactions.linenote IS 'Note';
COMMENT ON COLUMN patients_data.claims_transactions.patientinsuranceid IS 'Foreign key to the Payer Transitions table member ID';
COMMENT ON COLUMN patients_data.claims_transactions.feescheduleid IS 'Fixed to 1';
COMMENT ON COLUMN patients_data.claims_transactions.providerid IS 'Foreign key to the Provider';
COMMENT ON COLUMN patients_data.claims_transactions.supervisingproviderid IS 'Foreign key to the supervising Provider';

-- Comments for Conditions
COMMENT ON TABLE patients_data.conditions IS 'Patient conditions or diagnoses';
COMMENT ON COLUMN patients_data.conditions.start IS 'The date the condition was diagnosed';
COMMENT ON COLUMN patients_data.conditions.stop IS 'The date the condition resolved, if applicable';
COMMENT ON COLUMN patients_data.conditions.patient IS 'Foreign key to the Patient';
COMMENT ON COLUMN patients_data.conditions.encounter IS 'Foreign key to the Encounter when the condition was diagnosed';
COMMENT ON COLUMN patients_data.conditions.code IS 'Diagnosis code from SNOMED-CT';
COMMENT ON COLUMN patients_data.conditions.description IS 'Description of the condition';

-- Comments for Devices
COMMENT ON TABLE patients_data.devices IS 'Patient-affixed permanent and semi-permanent devices';
COMMENT ON COLUMN patients_data.devices.start IS 'The date and time the device was associated to the patient';
COMMENT ON COLUMN patients_data.devices.stop IS 'The date and time the device was removed, if applicable';
COMMENT ON COLUMN patients_data.devices.patient IS 'Foreign key to the Patient';
COMMENT ON COLUMN patients_data.devices.encounter IS 'Foreign key to the Encounter when the device was associated';
COMMENT ON COLUMN patients_data.devices.code IS 'Type of device, from SNOMED-CT';
COMMENT ON COLUMN patients_data.devices.description IS 'Description of the device';
COMMENT ON COLUMN patients_data.devices.udi IS 'Unique Device Identifier for the device';

-- Comments for Encounters
COMMENT ON TABLE patients_data.encounters IS 'Patient encounter data';
COMMENT ON COLUMN patients_data.encounters.id IS 'Primary Key. Unique Identifier of the encounter';
COMMENT ON COLUMN patients_data.encounters.start IS 'The date and time the encounter started';
COMMENT ON COLUMN patients_data.encounters.stop IS 'The date and time the encounter concluded';
COMMENT ON COLUMN patients_data.encounters.patient IS 'Foreign key to the Patient';
COMMENT ON COLUMN patients_data.encounters.organization IS 'Foreign key to the Organization';
COMMENT ON COLUMN patients_data.encounters.provider IS 'Foreign key to the Provider';
COMMENT ON COLUMN patients_data.encounters.payer IS 'Foreign key to the Payer';
COMMENT ON COLUMN patients_data.encounters.encounterclass IS 'The class of the encounter, such as ambulatory, emergency, inpatient, wellness, or urgentcare';
COMMENT ON COLUMN patients_data.encounters.code IS 'Encounter code from SNOMED-CT';
COMMENT ON COLUMN patients_data.encounters.description IS 'Description of the type of encounter';
COMMENT ON COLUMN patients_data.encounters.base_encounter_cost IS 'The base cost of the encounter, not including any line item costs related to medications, immunizations, procedures, or other services';
COMMENT ON COLUMN patients_data.encounters.total_claim_cost IS 'The total cost of the encounter, including all line items';
COMMENT ON COLUMN patients_data.encounters.payer_coverage IS 'The amount of cost covered by the Payer';
COMMENT ON COLUMN patients_data.encounters.reasoncode IS 'Diagnosis code from SNOMED-CT, only if this encounter targeted a specific condition';
COMMENT ON COLUMN patients_data.encounters.reasondescription IS 'Description of the reason code';

-- Comments for Imaging Studies
COMMENT ON TABLE patients_data.imaging_studies IS 'Patient imaging metadata';
COMMENT ON COLUMN patients_data.imaging_studies.id IS 'Non-unique identifier of the imaging study. An imaging study may have multiple rows';
COMMENT ON COLUMN patients_data.imaging_studies.date IS 'The date and time the imaging study was conducted';
COMMENT ON COLUMN patients_data.imaging_studies.patient IS 'Foreign key to the Patient';
COMMENT ON COLUMN patients_data.imaging_studies.encounter IS 'Foreign key to the Encounter where the imaging study was conducted';
COMMENT ON COLUMN patients_data.imaging_studies.series_uid IS 'Imaging Study series DICOM UID';
COMMENT ON COLUMN patients_data.imaging_studies.bodysite_code IS 'A SNOMED Body Structures code describing what part of the body the images in the series were taken of';
COMMENT ON COLUMN patients_data.imaging_studies.bodysite_description IS 'Description of the body site';
COMMENT ON COLUMN patients_data.imaging_studies.modality_code IS 'A DICOM-DCM code describing the method used to take the images';
COMMENT ON COLUMN patients_data.imaging_studies.modality_description IS 'Description of the modality';
COMMENT ON COLUMN patients_data.imaging_studies.instance_uid IS 'Imaging Study instance DICOM UID';
COMMENT ON COLUMN patients_data.imaging_studies.sop_code IS 'A DICOM-SOP code describing the Subject-Object Pair (SOP) that constitutes the image';
COMMENT ON COLUMN patients_data.imaging_studies.sop_description IS 'Description of the SOP code';
COMMENT ON COLUMN patients_data.imaging_studies.procedure_code IS 'Procedure code from SNOMED-CT';

-- Comments for Immunizations
COMMENT ON TABLE patients_data.immunizations IS 'Patient immunization data';
COMMENT ON COLUMN patients_data.immunizations.date IS 'The date the immunization was administered';
COMMENT ON COLUMN patients_data.immunizations.patient IS 'Foreign key to the Patient';
COMMENT ON COLUMN patients_data.immunizations.encounter IS 'Foreign key to the Encounter where the immunization was administered';
COMMENT ON COLUMN patients_data.immunizations.code IS 'Immunization code from CVX';
COMMENT ON COLUMN patients_data.immunizations.description IS 'Description of the immunization';
COMMENT ON COLUMN patients_data.immunizations.base_cost IS 'The line item cost of the immunization';

-- Comments for Medications
COMMENT ON TABLE patients_data.medications IS 'Patient medication data';
COMMENT ON COLUMN patients_data.medications.start IS 'The date and time the medication was prescribed';
COMMENT ON COLUMN patients_data.medications.stop IS 'The date and time the prescription ended, if applicable';
COMMENT ON COLUMN patients_data.medications.patient IS 'Foreign key to the Patient';
COMMENT ON COLUMN patients_data.medications.payer IS 'Foreign key to the Payer';
COMMENT ON COLUMN patients_data.medications.encounter IS 'Foreign key to the Encounter where the medication was prescribed';
COMMENT ON COLUMN patients_data.medications.code IS 'Medication code from RxNorm';
COMMENT ON COLUMN patients_data.medications.description IS 'Description of the medication';
COMMENT ON COLUMN patients_data.medications.base_cost IS 'The line item cost of the medication';
COMMENT ON COLUMN patients_data.medications.payer_coverage IS 'The amount covered or reimbursed by the Payer';
COMMENT ON COLUMN patients_data.medications.dispenses IS 'The number of times the prescription was filled';
COMMENT ON COLUMN patients_data.medications.totalcost IS 'The total cost of the prescription, including all dispenses';
COMMENT ON COLUMN patients_data.medications.reasoncode IS 'Diagnosis code from SNOMED-CT specifying why this medication was prescribed';
COMMENT ON COLUMN patients_data.medications.reasondescription IS 'Description of the reason code';

-- Comments for Observations
COMMENT ON TABLE patients_data.observations IS 'Patient observations including vital signs and lab reports';
COMMENT ON COLUMN patients_data.observations.date IS 'The date and time the observation was performed';
COMMENT ON COLUMN patients_data.observations.patient IS 'Foreign key to the Patient';
COMMENT ON COLUMN patients_data.observations.encounter IS 'Foreign key to the Encounter where the observation was performed';
COMMENT ON COLUMN patients_data.observations.category IS 'Observation category';
COMMENT ON COLUMN patients_data.observations.code IS 'Observation or Lab code from LOINC';
COMMENT ON COLUMN patients_data.observations.description IS 'Description of the observation or lab';
COMMENT ON COLUMN patients_data.observations.value IS 'The recorded value of the observation';
COMMENT ON COLUMN patients_data.observations.units IS 'The units of measure for the value';
COMMENT ON COLUMN patients_data.observations.type IS 'The datatype of Value: text or numeric';

-- Comments for Organizations
COMMENT ON TABLE patients_data.organizations IS 'Provider organizations including hospitals';
COMMENT ON COLUMN patients_data.organizations.id IS 'Primary key of the Organization';
COMMENT ON COLUMN patients_data.organizations.name IS 'Name of the Organization';
COMMENT ON COLUMN patients_data.organizations.address IS 'Organization''s street address without commas or newlines';
COMMENT ON COLUMN patients_data.organizations.city IS 'Street address city';
COMMENT ON COLUMN patients_data.organizations.state IS 'Street address state abbreviation';
COMMENT ON COLUMN patients_data.organizations.zip IS 'Street address zip or postal code';
COMMENT ON COLUMN patients_data.organizations.lat IS 'Latitude of Organization''s address';
COMMENT ON COLUMN patients_data.organizations.lon IS 'Longitude of Organization''s address';
COMMENT ON COLUMN patients_data.organizations.phone IS 'Organization''s phone number';
COMMENT ON COLUMN patients_data.organizations.revenue IS 'The monetary revenue of the organization during the entire simulation';
COMMENT ON COLUMN patients_data.organizations.utilization IS 'The number of Encounters performed by this Organization';

-- Comments for Patients
COMMENT ON TABLE patients_data.patients IS 'Patient demographic data';
COMMENT ON COLUMN patients_data.patients.id IS 'Primary Key. Unique Identifier of the patient';
COMMENT ON COLUMN patients_data.patients.birthdate IS 'The date the patient was born';
COMMENT ON COLUMN patients_data.patients.deathdate IS 'The date the patient died';
COMMENT ON COLUMN patients_data.patients.ssn IS 'Patient Social Security identifier';
COMMENT ON COLUMN patients_data.patients.drivers IS 'Patient Drivers License identifier';
COMMENT ON COLUMN patients_data.patients.passport IS 'Patient Passport identifier';
COMMENT ON COLUMN patients_data.patients.prefix IS 'Name prefix, such as Mr., Mrs., Dr., etc.';
COMMENT ON COLUMN patients_data.patients.first IS 'First name of the patient';
COMMENT ON COLUMN patients_data.patients.middle IS 'Middle name of the patient';
COMMENT ON COLUMN patients_data.patients.last IS 'Last or surname of the patient';
COMMENT ON COLUMN patients_data.patients.suffix IS 'Name suffix, such as PhD, MD, JD, etc.';
COMMENT ON COLUMN patients_data.patients.maiden IS 'Maiden name of the patient';
COMMENT ON COLUMN patients_data.patients.marital IS 'Marital Status. M is married, S is single. Currently no support for divorce (D) or widowing (W)';
COMMENT ON COLUMN patients_data.patients.race IS 'Description of the patient''s primary race';
COMMENT ON COLUMN patients_data.patients.ethnicity IS 'Description of the patient''s primary ethnicity';
COMMENT ON COLUMN patients_data.patients.gender IS 'Gender. M is male, F is female';
COMMENT ON COLUMN patients_data.patients.birthplace IS 'Name of the town where the patient was born';
COMMENT ON COLUMN patients_data.patients.address IS 'Patient''s street address without commas or newlines';
COMMENT ON COLUMN patients_data.patients.city IS 'Patient''s address city';
COMMENT ON COLUMN patients_data.patients.state IS 'Patient''s address state';
COMMENT ON COLUMN patients_data.patients.county IS 'Patient''s address county';
COMMENT ON COLUMN patients_data.patients.fips IS 'Patient''s FIPS county code';
COMMENT ON COLUMN patients_data.patients.zip IS 'Patient''s zip code';
COMMENT ON COLUMN patients_data.patients.lat IS 'Latitude of Patient''s address';
COMMENT ON COLUMN patients_data.patients.lon IS 'Longitude of Patient''s address';
COMMENT ON COLUMN patients_data.patients.healthcare_expenses IS 'The total lifetime cost of healthcare to the patient (i.e. what the patient paid)';
COMMENT ON COLUMN patients_data.patients.healthcare_coverage IS 'The total lifetime cost of healthcare services that were covered by Payers (i.e. what the insurance company paid)';
COMMENT ON COLUMN patients_data.patients.income IS 'Annual income for the Patient';

-- Comments for Payer Transitions
COMMENT ON TABLE patients_data.payer_transitions IS 'Payer Transition data (i.e. changes in health insurance)';
COMMENT ON COLUMN patients_data.payer_transitions.patient IS 'Foreign key to the Patient';
COMMENT ON COLUMN patients_data.payer_transitions.memberid IS 'Member ID for the Insurance Plan';
COMMENT ON COLUMN patients_data.payer_transitions.start_date IS 'The year the coverage started (inclusive)';
COMMENT ON COLUMN patients_data.payer_transitions.end_date IS 'The year the coverage ended (inclusive)';
COMMENT ON COLUMN patients_data.payer_transitions.payer IS 'Foreign key to the Payer';
COMMENT ON COLUMN patients_data.payer_transitions.secondary_payer IS 'Foreign key to the Secondary Payer';
COMMENT ON COLUMN patients_data.payer_transitions.plan_ownership IS 'The owner of the insurance policy. Legal values: Guardian, Self, Spouse';
COMMENT ON COLUMN patients_data.payer_transitions.owner_name IS 'The name of the insurance policy owner';

-- Comments for Payers
COMMENT ON TABLE patients_data.payers IS 'Payer organization data';
COMMENT ON COLUMN patients_data.payers.id IS 'Primary key of the Payer (e.g. Insurance)';
COMMENT ON COLUMN patients_data.payers.name IS 'Name of the Payer';
COMMENT ON COLUMN patients_data.payers.address IS 'Payer''s street address without commas or newlines';
COMMENT ON COLUMN patients_data.payers.city IS 'Street address city';
COMMENT ON COLUMN patients_data.payers.state_headquartered IS 'Street address state abbreviation';
COMMENT ON COLUMN patients_data.payers.zip IS 'Street address zip or postal code';
COMMENT ON COLUMN patients_data.payers.phone IS 'Payer''s phone number';
COMMENT ON COLUMN patients_data.payers.amount_covered IS 'The monetary amount paid to Organizations during the entire simulation';
COMMENT ON COLUMN patients_data.payers.amount_uncovered IS 'The monetary amount not paid to Organizations during the entire simulation, and covered out of pocket by patients';
COMMENT ON COLUMN patients_data.payers.revenue IS 'The monetary revenue of the Payer during the entire simulation';
COMMENT ON COLUMN patients_data.payers.covered_encounters IS 'The number of Encounters paid for by this Payer';
COMMENT ON COLUMN patients_data.payers.uncovered_encounters IS 'The number of Encounters not paid for by this Payer, and paid out of pocket by patients';
COMMENT ON COLUMN patients_data.payers.covered_medications IS 'The number of Medications paid for by this Payer';
COMMENT ON COLUMN patients_data.payers.uncovered_medications IS 'The number of Medications not paid for by this Payer, and paid out of pocket by patients';
COMMENT ON COLUMN patients_data.payers.covered_procedures IS 'The number of Procedures paid for by this Payer';
COMMENT ON COLUMN patients_data.payers.uncovered_procedures IS 'The number of Procedures not paid for by this Payer, and paid out of pocket by patients';
COMMENT ON COLUMN patients_data.payers.covered_immunizations IS 'The number of Immunizations paid for by this Payer';
COMMENT ON COLUMN patients_data.payers.uncovered_immunizations IS 'The number of Immunizations not paid for by this Payer, and paid out of pocket by patients';
COMMENT ON COLUMN patients_data.payers.unique_customers IS 'The number of unique patients enrolled with this Payer during the entire simulation';
COMMENT ON COLUMN patients_data.payers.qols_avg IS 'The average Quality of Life Scores (QOLS) for all patients enrolled with this Payer during the entire simulation';
COMMENT ON COLUMN patients_data.payers.member_months IS 'The total number of months that patients were enrolled with this Payer during the simulation and paid monthly premiums (if any)';

-- Comments for Procedures
COMMENT ON TABLE patients_data.procedures IS 'Patient procedure data including surgeries';
COMMENT ON COLUMN patients_data.procedures.start IS 'The date and time the procedure was performed';
COMMENT ON COLUMN patients_data.procedures.stop IS 'The date and time the procedure was completed, if applicable';
COMMENT ON COLUMN patients_data.procedures.patient IS 'Foreign key to the Patient';
COMMENT ON COLUMN patients_data.procedures.encounter IS 'Foreign key to the Encounter where the procedure was performed';
COMMENT ON COLUMN patients_data.procedures.code IS 'Procedure code from SNOMED-CT';
COMMENT ON COLUMN patients_data.procedures.description IS 'Description of the procedure';
COMMENT ON COLUMN patients_data.procedures.base_cost IS 'The line item cost of the procedure';
COMMENT ON COLUMN patients_data.procedures.reasoncode IS 'Diagnosis code from SNOMED-CT specifying why this procedure was performed';
COMMENT ON COLUMN patients_data.procedures.reasondescription IS 'Description of the reason code';

-- Comments for Providers
COMMENT ON TABLE patients_data.providers IS 'Clinicians that provide patient care';
COMMENT ON COLUMN patients_data.providers.id IS 'Primary key of the Provider/Clinician';
COMMENT ON COLUMN patients_data.providers.organization IS 'Foreign key to the Organization that employs this provider';
COMMENT ON COLUMN patients_data.providers.name IS 'First and last name of the Provider';
COMMENT ON COLUMN patients_data.providers.gender IS 'Gender. M is male, F is female';
COMMENT ON COLUMN patients_data.providers.speciality IS 'Provider speciality';
COMMENT ON COLUMN patients_data.providers.address IS 'Provider''s street address without commas or newlines';
COMMENT ON COLUMN patients_data.providers.city IS 'Street address city';
COMMENT ON COLUMN patients_data.providers.state IS 'Street address state abbreviation';
COMMENT ON COLUMN patients_data.providers.zip IS 'Street address zip or postal code';
COMMENT ON COLUMN patients_data.providers.lat IS 'Latitude of Provider''s address';
COMMENT ON COLUMN patients_data.providers.lon IS 'Longitude of Provider''s address';
COMMENT ON COLUMN patients_data.providers.encounters IS 'The number of Encounter''s performed by this provider';
COMMENT ON COLUMN patients_data.providers.procedures IS 'The number of Procedures';

-- Comments for Supplies
COMMENT ON TABLE patients_data.supplies IS 'Supplies used in the provision of care';
COMMENT ON COLUMN patients_data.supplies.date IS 'The date the supplies were used';
COMMENT ON COLUMN patients_data.supplies.patient IS 'Foreign key to the Patient';
COMMENT ON COLUMN patients_data.supplies.encounter IS 'Foreign key to the Encounter when the supplies were used';
COMMENT ON COLUMN patients_data.supplies.code IS 'Code for the type of supply used, from SNOMED-CT';
COMMENT ON COLUMN patients_data.supplies.description IS 'Description of supply used';
COMMENT ON COLUMN patients_data.supplies.quantity IS 'Quantity of supply used';
