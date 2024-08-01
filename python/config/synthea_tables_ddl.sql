CREATE TABLE IF NOT EXISTS patients_data.allergies (
    start date,
    stop date,
    patient UUID,
    encounter UUID,
    code text,
    system text,
    description text,
    type text,
    category text,
    reaction1 text,
    description1 text,
    severity1 text,
    reaction2 text,
    description2 text,
    severity2 text
);

CREATE TABLE IF NOT EXISTS patients_data.careplans (
    id UUID,
    start date,
    stop date,
    patient UUID,
    encounter UUID,
    code text,
    description text,
    reasoncode text,
    reasondescription text
);

CREATE TABLE IF NOT EXISTS patients_data.claims (
    id UUID,
    patientid UUID,
    providerid UUID,
    primarypatientinsuranceid UUID,
    secondarypatientinsuranceid UUID,
    departmentid numeric,
    patientdepartmentid numeric,
    diagnosis1 text,
    diagnosis2 text,
    diagnosis3 text,
    diagnosis4 text,
    diagnosis5 text,
    diagnosis6 text,
    diagnosis7 text,
    diagnosis8 text,
    referringproviderid UUID,
    appointmentid UUID,
    currentillnessdate timestamp,
    servicedate timestamp,
    supervisingproviderid UUID,
    status1 text,
    status2 text,
    statusp text,
    outstanding1 numeric,
    outstanding2 numeric,
    outstandingp numeric,
    lastbilleddate1 timestamp,
    lastbilleddate2 timestamp,
    lastbilleddatep timestamp,
    healthcareclaimtypeid1 numeric,
    healthcareclaimtypeid2 numeric
);

CREATE TABLE IF NOT EXISTS patients_data.claims_transactions (
    id UUID,
    claimid UUID,
    chargeid numeric,
    patientid UUID,
    type text,
    amount numeric,
    method text,
    fromdate timestamp,
    todate timestamp,
    placeofservice UUID,
    procedurecode text,
    modifier1 text,
    modifier2 text,
    diagnosisref1 numeric,
    diagnosisref2 numeric,
    diagnosisref3 numeric,
    diagnosisref4 numeric,
    units numeric,
    departmentid numeric,
    notes text,
    unitamount numeric,
    transferoutid numeric,
    transfertype text,
    payments numeric,
    adjustments numeric,
    transfers numeric,
    outstanding numeric,
    appointmentid UUID,
    linenote text,
    patientinsuranceid UUID,
    feescheduleid numeric,
    providerid UUID,
    supervisingproviderid UUID
);

CREATE TABLE IF NOT EXISTS patients_data.conditions (
    start date,
    stop date,
    patient UUID,
    encounter UUID,
    code text,
    description text
);

CREATE TABLE IF NOT EXISTS patients_data.devices (
    start timestamp,
    stop timestamp,
    patient UUID,
    encounter UUID,
    code text,
    description text,
    udi text
);

CREATE TABLE IF NOT EXISTS patients_data.encounters (
    id UUID,
    start timestamp,
    stop timestamp,
    patient UUID,
    organization UUID,
    provider UUID,
    payer UUID,
    encounterclass text,
    code text,
    description text,
    base_encounter_cost numeric,
    total_claim_cost numeric,
    payer_coverage numeric,
    reasoncode text,
    reasondescription text
);

CREATE TABLE IF NOT EXISTS patients_data.imaging_studies (
    id UUID,
    date timestamp,
    patient UUID,
    encounter UUID,
    series_uid text,
    bodysite_code text,
    bodysite_description text,
    modality_code text,
    modality_description text,
    instance_uid text,
    sop_code text,
    sop_description text,
    procedure_code text
);

CREATE TABLE IF NOT EXISTS patients_data.immunizations (
    date timestamp,
    patient UUID,
    encounter UUID,
    code text,
    description text,
    base_cost numeric
);

CREATE TABLE IF NOT EXISTS patients_data.medications (
    start timestamp,
    stop timestamp,
    patient UUID,
    payer UUID,
    encounter UUID,
    code text,
    description text,
    base_cost numeric,
    payer_coverage numeric,
    dispenses numeric,
    totalcost numeric,
    reasoncode text,
    reasondescription text
);

CREATE TABLE IF NOT EXISTS patients_data.observations (
    date timestamp,
    patient UUID,
    encounter UUID,
    category text,
    code text,
    description text,
    value text,
    units text,
    type text
);

CREATE TABLE IF NOT EXISTS patients_data.organizations (
    id UUID,
    name text,
    address text,
    city text,
    state text,
    zip text,
    lat numeric,
    lon numeric,
    phone text,
    revenue numeric,
    utilization numeric
);

CREATE TABLE IF NOT EXISTS patients_data.patients (
    id UUID,
    birthdate date,
    deathdate date,
    ssn text,
    drivers text,
    passport text,
    prefix text,
    first text,
    middle text,
    last text,
    suffix text,
    maiden text,
    marital text,
    race text,
    ethnicity text,
    gender text,
    birthplace text,
    address text,
    city text,
    state text,
    county text,
    fips text,
    zip text,
    lat numeric,
    lon numeric,
    healthcare_expenses numeric,
    healthcare_coverage numeric,
    income numeric
);

CREATE TABLE IF NOT EXISTS patients_data.payer_transitions (
    patient UUID,
    memberid UUID,
    start_date date,
    end_date date,
    payer UUID,
    secondary_payer UUID,
    plan_ownership text,
    owner_name text
);

CREATE TABLE IF NOT EXISTS patients_data.payers (
    id UUID,
    name text,
    ownership text,
    address text,
    city text,
    state_headquartered text,
    zip text,
    phone text,
    amount_covered numeric,
    amount_uncovered numeric,
    revenue numeric,
    covered_encounters numeric,
    uncovered_encounters numeric,
    covered_medications numeric,
    uncovered_medications numeric,
    covered_procedures numeric,
    uncovered_procedures numeric,
    covered_immunizations numeric,
    uncovered_immunizations numeric,
    unique_customers numeric,
    qols_avg numeric,
    member_months numeric
);

CREATE TABLE IF NOT EXISTS patients_data.procedures (
    start timestamp,
    stop timestamp,
    patient UUID,
    encounter UUID,
    code text,
    description text,
    base_cost numeric,
    reasoncode text,
    reasondescription text
);

CREATE TABLE IF NOT EXISTS patients_data.providers (
    id UUID,
    organization UUID,
    name text,
    gender text,
    speciality text,
    address text,
    city text,
    state text,
    zip text,
    lat numeric,
    lon numeric,
    encounters numeric,
    procedures numeric
);

CREATE TABLE IF NOT EXISTS patients_data.supplies (
    date date,
    patient UUID,
    encounter UUID,
    code text,
    description text,
    quantity numeric
);
