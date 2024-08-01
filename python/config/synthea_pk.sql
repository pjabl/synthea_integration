DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_constraint
        WHERE conname = 'pk_careplans'
    ) THEN
        ALTER TABLE patients_data.careplans
            ADD CONSTRAINT pk_careplans PRIMARY KEY (id);
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM pg_constraint
        WHERE conname = 'pk_claims'
    ) THEN
        ALTER TABLE patients_data.claims
            ADD CONSTRAINT pk_claims PRIMARY KEY (id);
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM pg_constraint
        WHERE conname = 'pk_claims_transactions'
    ) THEN
        ALTER TABLE patients_data.claims_transactions
            ADD CONSTRAINT pk_claims_transactions PRIMARY KEY (id);
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM pg_constraint
        WHERE conname = 'pk_encounters'
    ) THEN
        ALTER TABLE patients_data.encounters
            ADD CONSTRAINT pk_encounters PRIMARY KEY (id);
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM pg_constraint
        WHERE conname = 'pk_organizations'
    ) THEN
        ALTER TABLE patients_data.organizations
            ADD CONSTRAINT pk_organizations PRIMARY KEY (id);
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM pg_constraint
        WHERE conname = 'pk_patients'
    ) THEN
        ALTER TABLE patients_data.patients
            ADD CONSTRAINT pk_patients PRIMARY KEY (id);
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM pg_constraint
        WHERE conname = 'pk_payers'
    ) THEN
        ALTER TABLE patients_data.payers
            ADD CONSTRAINT pk_payers PRIMARY KEY (id);
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM pg_constraint
        WHERE conname = 'pk_providers'
    ) THEN
        ALTER TABLE patients_data.providers
            ADD CONSTRAINT pk_providers PRIMARY KEY (id);
    END IF;
END $$;
