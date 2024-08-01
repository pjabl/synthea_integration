CREATE TABLE IF NOT EXISTS patients_data.allergies (
    start date NOT NULL,
    stop date NULL,
    patient UUID NOT NULL,
    encounter UUID NOT NULL,
    code text NOT NULL,
    system text NOT NULL,
    description text NOT NULL,
    type text NULL,
    category text NULL,
    reaction1 text NULL,
    description1 text NULL,
    severity1 text NULL,
    reaction2 text NULL,
    description2 text NULL,
    severity2 text NULL
);

CREATE TABLE IF NOT EXISTS patients_data.careplans (
    id UUID NOT NULL,
    start date NOT NULL,
    stop date NULL,
    patient UUID NOT NULL,
    encounter UUID NOT NULL,
    code text NOT NULL,
    description text NOT NULL,
    reasoncode text,
    reasondescription text
);

CREATE TABLE IF NOT EXISTS patients_data.claims (
    id UUID NOT NULL,
    patientid UUID NOT NULL,
    providerid UUID NOT NULL,
    primarypatientinsuranceid UUID NULL,
    secondarypatientinsuranceid UUID NULL,
    departmentid numeric NOT NULL,
    patientdepartmentid numeric NOT NULL,
    diagnosis1 text NULL,
    diagnosis2 text NULL,
    diagnosis3 text NULL,
    diagnosis4 text NULL,
    diagnosis5 text NULL,
    diagnosis6 text NULL,
    diagnosis7 text NULL,
    diagnosis8 text NULL,
    referringproviderid UUID NULL,
    appointmentid UUID NULL,
    currentillnessdate timestamp NOT NULL,
    servicedate timestamp NOT NULL,
    supervisingproviderid UUID NULL,
    status1 text NULL,
    status2 text NULL,
    statusp text NULL,
    outstanding1 numeric NULL,
    outstanding2 numeric NULL,
    outstandingp numeric NULL,
    lastbilleddate1 timestamp NULL,
    lastbilleddate2 timestamp NULL,
    lastbilleddatep timestamp NULL,
    healthcareclaimtypeid1 numeric NULL,
    healthcareclaimtypeid2 numeric NULL
);

CREATE TABLE IF NOT EXISTS patients_data.claims_transactions (
    id UUID NOT NULL,
    claimid UUID NOT NULL,
    chargeid numeric NOT NULL,
    patientid UUID NOT NULL,
    type text NOT NULL,
    amount numeric NULL,
    method text NULL,
    fromdate timestamp NULL,
    todate timestamp NULL,
    placeofservice UUID NOT NULL,
    procedurecode text NOT NULL,
    modifier1 text NULL,
    modifier2 text NULL,
    diagnosisref1 numeric NULL,
    diagnosisref2 numeric NULL,
    diagnosisref3 numeric NULL,
    diagnosisref4 numeric NULL,
    units numeric NULL,
    departmentid numeric NULL,
    notes text NULL,
    unitamount numeric NULL,
    transferoutid numeric NULL,
    transfertype text NULL,
    payments numeric NULL,
    adjustments numeric NULL,
    transfers numeric NULL,
    outstanding numeric NULL,
    appointmentid UUID NULL,
    linenote text NULL,
    patientinsuranceid UUID NULL,
    feescheduleid numeric NULL,
    providerid UUID NOT NULL,
    supervisingproviderid UUID NULL
);

CREATE TABLE IF NOT EXISTS patients_data.conditions (
    start date NOT NULL,
    stop date NULL,
    patient UUID NOT NULL,
    encounter UUID NOT NULL,
    code text NOT NULL,
    description text NOT NULL
);

CREATE TABLE IF NOT EXISTS patients_data.devices (
    start timestamp NOT NULL,
    stop timestamp NULL,
    patient UUID NOT NULL,
    encounter UUID NOT NULL,
    code text NOT NULL,
    description text NOT NULL,
    udi text NOT NULL
);

CREATE TABLE IF NOT EXISTS patients_data.encounters (
    id UUID NOT NULL,
    start timestamp NOT NULL,
    stop timestamp NULL,
    patient UUID NOT NULL,
    organization UUID NOT NULL,
    provider UUID NOT NULL,
    payer UUID NOT NULL,
    encounterclass text NOT NULL,
    code text NOT NULL,
    description text NOT NULL,
    base_encounter_cost numeric NOT NULL,
    total_claim_cost numeric NOT NULL,
    payer_coverage numeric NOT NULL,
    reasoncode text NULL,
    reasondescription text NULL
);

CREATE TABLE IF NOT EXISTS patients_data.imaging_studies (
    id UUID NOT NULL,
    date timestamp NOT NULL,
    patient UUID NOT NULL,
    encounter UUID NOT NULL,
    series_uid text NOT NULL,
    bodysite_code text NOT NULL,
    bodysite_description text NOT NULL,
    modality_code text NOT NULL,
    modality_description text NOT NULL,
    instance_uid text NOT NULL,
    sop_code text NOT NULL,
    sop_description text NOT NULL,
    procedure_code text NOT NULL
);

CREATE TABLE IF NOT EXISTS patients_data.immunizations (
    date timestamp NOT NULL,
    patient UUID NOT NULL,
    encounter UUID NOT NULL,
    code text NOT NULL,
    description text NOT NULL,
    base_cost numeric NOT NULL
);

CREATE TABLE IF NOT EXISTS patients_data.medications (
    start timestamp NOT NULL,
    stop timestamp NULL,
    patient UUID NOT NULL,
    payer UUID NOT NULL,
    encounter UUID NOT NULL,
    code text NOT NULL,
    description text NOT NULL,
    base_cost numeric NOT NULL,
    payer_coverage numeric NOT NULL,
    dispenses numeric NULL,
    totalcost numeric NOT NULL,
    reasoncode text NULL,
    reasondescription text NULL
);

CREATE TABLE IF NOT EXISTS patients_data.observations (
    date timestamp NOT NULL,
    patient UUID NOT NULL,
    encounter UUID NOT NULL,
    category text NULL,
    code text NOT NULL,
    description text NOT NULL,
    value text NOT NULL,
    units text NULL,
    type text NOT NULL
);

CREATE TABLE IF NOT EXISTS patients_data.organizations (
    id UUID NOT NULL,
    name text NOT NULL,
    address text NOT NULL,
    city text NOT NULL,
    state text NULL,
    zip text NULL,
    lat numeric NULL,
    lon numeric NULL,
    phone text NULL,
    revenue numeric NOT NULL,
    utilization numeric NOT NULL
);

CREATE TABLE IF NOT EXISTS patients_data.patients (
    id UUID NOT NULL,
    birthdate date NOT NULL,
    deathdate date NULL,
    ssn text NOT NULL,
    drivers text NULL,
    passport text NULL,
    prefix text NULL,
    first text NOT NULL,
    middle text NULL,
    last text NOT NULL,
    suffix text NULL,
    maiden text NULL,
    marital text NULL,
    race text NOT NULL,
    ethnicity text NOT NULL,
    gender text NOT NULL,
    birthplace text NOT NULL,
    address text NOT NULL,
    city text NOT NULL,
    state text NOT NULL,
    county text NULL,
    fips text NULL,
    zip text NULL,
    lat numeric NULL,
    lon numeric NULL,
    healthcare_expenses numeric NOT NULL,
    healthcare_coverage numeric NOT NULL,
    income numeric NOT NULL
);

CREATE TABLE IF NOT EXISTS patients_data.payer_transitions (
    patient UUID NOT NULL,
    memberid UUID NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    payer UUID NOT NULL,
    secondary_payer UUID NULL,
    plan_ownership text NULL,
    owner_name text NULL
);

CREATE TABLE IF NOT EXISTS patients_data.payers (
    id UUID NOT NULL,
    name text NOT NULL,
    ownership text NULL,
    address text NULL,
    city text NULL,
    state_headquartered text NULL,
    zip text NULL,
    phone text NULL,
    amount_covered numeric NOT NULL,
    amount_uncovered numeric NOT NULL,
    revenue numeric NOT NULL,
    covered_encounters numeric NOT NULL,
    uncovered_encounters numeric NOT NULL,
    covered_medications numeric NOT NULL,
    uncovered_medications numeric NOT NULL,
    covered_procedures numeric NOT NULL,
    uncovered_procedures numeric NOT NULL,
    covered_immunizations numeric NOT NULL,
    uncovered_immunizations numeric NOT NULL,
    unique_customers numeric NOT NULL,
    qols_avg numeric NOT NULL,
    member_months numeric NOT NULL
);

CREATE TABLE IF NOT EXISTS patients_data.procedures (
    start timestamp NOT NULL,
    stop timestamp NULL,
    patient UUID NOT NULL,
    encounter UUID NOT NULL,
    code text NOT NULL,
    description text NOT NULL,
    base_cost numeric NOT NULL,
    reasoncode text NULL,
    reasondescription text NULL
);

CREATE TABLE IF NOT EXISTS patients_data.providers (
    id UUID NOT NULL,
    organization UUID NOT NULL,
    name text NOT NULL,
    gender text NOT NULL,
    speciality text NOT NULL,
    address text NOT NULL,
    city text NOT NULL,
    state text NULL,
    zip text NULL,
    lat numeric NULL,
    lon numeric NULL,
    encounters numeric NOT NULL,
    procedures numeric NOT NULL
);

CREATE TABLE IF NOT EXISTS patients_data.supplies (
    date date NOT NULL,
    patient UUID NOT NULL,
    encounter UUID NOT NULL,
    code text NOT NULL,
    description text NOT NULL,
    quantity numeric NOT NULL
);
