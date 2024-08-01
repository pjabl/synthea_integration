CREATE TABLE IF NOT EXISTS patients_data.allergies (
    start date NULL,
    stop date NULL,
    patient text NULL,
    encounter text NULL,
    code int8 NULL,
    system text NULL,
    description text NULL,
    type text NULL,
    category text NULL,
    reaction1 int8 NULL,
    description1 text NULL,
    severity1 text NULL,
    reaction2 int8 NULL,
    description2 text NULL,
    severity2 text NULL
);

CREATE TABLE IF NOT EXISTS patients_data.careplans (
    id text NULL,
    start date NULL,
    stop date NULL,
    patient text NULL,
    encounter text NULL,
    code int8 NULL,
    description text NULL,
    reasoncode int8 NULL,
    reasondescription text NULL
);

CREATE TABLE IF NOT EXISTS patients_data.claims (
    id text NULL,
    patientid text NULL,
    providerid text NULL,
    primarypatientinsuranceid text NULL,
    secondarypatientinsuranceid text NULL,
    departmentid int8 NULL,
    patientdepartmentid int8 NULL,
    diagnosis1 int8 NULL,
    diagnosis2 int8 NULL,
    diagnosis3 int8 NULL,
    diagnosis4 int8 NULL,
    diagnosis5 int8 NULL,
    diagnosis6 int8 NULL,
    diagnosis7 int8 NULL,
    diagnosis8 int8 NULL,
    referringproviderid text NULL,
    appointmentid text NULL,
    currentillnessdate timestamp NULL,
    servicedate timestamp NULL,
    supervisingproviderid text NULL,
    status1 text NULL,
    status2 text NULL,
    statusp text NULL,
    outstanding1 float8 NULL,
    outstanding2 float8 NULL,
    outstandingp float8 NULL,
    lastbilleddate1 timestamp NULL,
    lastbilleddate2 timestamp NULL,
    lastbilleddatep timestamp NULL,
    healthcareclaimtypeid1 int8 NULL,
    healthcareclaimtypeid2 int8 NULL
);

CREATE TABLE IF NOT EXISTS patients_data.claims_transactions (
    id text NULL,
    claimid text NULL,
    chargeid int8 NULL,
    patientid text NULL,
    type text NULL,
    amount numeric NULL,
    method text NULL,
    fromdate timestamp NULL,
    todate timestamp NULL,
    placeofservice text NULL,
    procedurecode int8 NULL,
    modifier1 text NULL,
    modifier2 text NULL,
    diagnosisref1 text NULL,
    diagnosisref2 text NULL,
    diagnosisref3 text NULL,
    diagnosisref4 text NULL,
    units int8 NULL,
    departmentid int8 NULL,
    notes text NULL,
    unitamount numeric NULL,
    transferoutid text NULL,
    transfertype text NULL,
    payments numeric NULL,
    adjustments numeric NULL,
    transfers numeric NULL,
    outstanding numeric NULL,
    appointmentid text NULL,
    linenote text NULL,
    patientinsuranceid text NULL,
    feescheduleid int8 NULL,
    providerid text NULL,
    supervisingproviderid text NULL
);

CREATE TABLE IF NOT EXISTS patients_data.conditions (
    start date NULL,
    stop date NULL,
    patient text NULL,
    encounter text NULL,
    code int8 NULL,
    description text NULL
);

CREATE TABLE IF NOT EXISTS patients_data.devices (
    start timestamp NULL,
    stop timestamp NULL,
    patient text NULL,
    encounter text NULL,
    code int8 NULL,
    description text NULL,
    udi text NULL
);

CREATE TABLE IF NOT EXISTS patients_data.encounters (
    id text NULL,
    start timestamp NULL,
    stop timestamp NULL,
    patient text NULL,
    organization text NULL,
    provider text NULL,
    payer text NULL,
    encounterclass text NULL,
    code int8 NULL,
    description text NULL,
    base_encounter_cost numeric NULL,
    total_claim_cost numeric NULL,
    payer_coverage numeric NULL,
    reasoncode int8 NULL,
    reasondescription text NULL
);

CREATE TABLE IF NOT EXISTS patients_data.imaging_studies (
    id text NULL,
    date timestamp NULL,
    patient text NULL,
    encounter text NULL,
    series_uid text NULL,
    bodysite_code int8 NULL,
    bodysite_description text NULL,
    modality_code text NULL,
    modality_description text NULL,
    instance_uid text NULL,
    sop_code text NULL,
    sop_description text NULL,
    procedure_code int8 NULL
);

CREATE TABLE IF NOT EXISTS patients_data.immunizations (
    date timestamp NULL,
    patient text NULL,
    encounter text NULL,
    code text NULL,
    description text NULL,
    base_cost numeric NULL
);

CREATE TABLE IF NOT EXISTS patients_data.medications (
    start timestamp NULL,
    stop timestamp NULL,
    patient text NULL,
    payer text NULL,
    encounter text NULL,
    code text NULL,
    description text NULL,
    base_cost numeric NULL,
    payer_coverage numeric NULL,
    dispenses int4 NULL,
    totalcost numeric NULL,
    reasoncode text NULL,
    reasondescription text NULL
);

CREATE TABLE IF NOT EXISTS patients_data.observations (
    date timestamp NULL,
    patient text NULL,
    encounter text NULL,
    category text NULL,
    code text NULL,
    description text NULL,
    value text NULL,
    units text NULL,
    type text NULL
);

CREATE TABLE IF NOT EXISTS patients_data.organizations (
    id text NULL,
    name text NULL,
    address text NULL,
    city text NULL,
    state text NULL,
    zip text NULL,
    lat float8 NULL,
    lon float8 NULL,
    phone text NULL,
    revenue numeric NULL,
    utilization int4 NULL
);

CREATE TABLE IF NOT EXISTS patients_data.patients (
    id text NULL,
    birthdate date NULL,
    deathdate date NULL,
    ssn text NULL,
    drivers text NULL,
    passport text NULL,
    prefix text NULL,
    first text NULL,
    middle text NULL,
    last text NULL,
    suffix text NULL,
    maiden text NULL,
    marital text NULL,
    race text NULL,
    ethnicity text NULL,
    gender text NULL,
    birthplace text NULL,
    address text NULL,
    city text NULL,
    state text NULL,
    county text NULL,
    fips text NULL,
    zip text NULL,
    lat float8 NULL,
    lon float8 NULL,
    healthcare_expenses numeric NULL,
    healthcare_coverage numeric NULL,
    income numeric NULL
);

CREATE TABLE IF NOT EXISTS patients_data.payer_transitions (
    patient text NULL,
    memberid text NULL,
    start_date timestamp NULL,
    end_date timestamp NULL,
    payer text NULL,
    secondary_payer text NULL,
    plan_ownership text NULL,
    owner_name text NULL
);

CREATE TABLE IF NOT EXISTS patients_data.payers (
    id text NULL,
    name text NULL,
    ownership text NULL,
    address text NULL,
    city text NULL,
    state_headquartered text NULL,
    zip text NULL,
    phone text NULL,
    amount_covered numeric NULL,
    amount_uncovered numeric NULL,
    revenue numeric NULL,
    covered_encounters int4 NULL,
    uncovered_encounters int4 NULL,
    covered_medications int4 NULL,
    uncovered_medications int4 NULL,
    covered_procedures int4 NULL,
    uncovered_procedures int4 NULL,
    covered_immunizations int4 NULL,
    uncovered_immunizations int4 NULL,
    unique_customers int4 NULL,
    qols_avg float8 NULL,
    member_months int4 NULL
);

CREATE TABLE IF NOT EXISTS patients_data.procedures (
    start timestamp NULL,
    stop timestamp NULL,
    patient text NULL,
    encounter text NULL,
    code text NULL,
    description text NULL,
    base_cost numeric NULL,
    reasoncode text NULL,
    reasondescription text NULL
);

CREATE TABLE IF NOT EXISTS patients_data.providers (
    id text NULL,
    organization text NULL,
    name text NULL,
    gender text NULL,
    speciality text NULL,
    address text NULL,
    city text NULL,
    state text NULL,
    zip text NULL,
    lat float8 NULL,
    lon float8 NULL,
    encounters int4 NULL,
    procedures int4 NULL
);

CREATE TABLE IF NOT EXISTS patients_data.supplies (
    date date NULL,
    patient text NULL,
    encounter text NULL,
    code text NULL,
    description text NULL,
    quantity int4 NULL
);
