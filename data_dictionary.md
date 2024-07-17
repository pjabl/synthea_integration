# Synthea Data Dictionary


| Table|Description|
|----------------------|-------------------------------------------------------|
| allergies            | Patient allergy data.                                 |
| careplans            | Patient care plan data, including goals.              |
| claims               | Patient claim data.                                   |
| claims_transactions  | Transactions per line item per claim.                 |
| conditions           | Patient conditions or diagnoses.                      |
| devices              | Patient-affixed permanent and semi-permanent devices. |
| encounters           | Patient encounter data.                               |
| imaging_studies      | Patient imaging metadata.                             |
| immunizations        | Patient immunization data.                            |
| medications          | Patient medication data.                              |
| observations         | Patient observations including vital signs and lab reports. |
| organizations        | Provider organizations including hospitals.           |
| patients             | Patient demographic data.                             |
| payer_transitions    | Payer Transition data (i.e. changes in health insurance). |
| payers               | Payer organization data.                              |
| procedures           | Patient procedure data including surgeries.           |
| providers            | Clinicians that provide patient care.                 |


## allergies

| Column Name  | Data Type | Required? | Description                                |
|--------------|-----------|-----------|--------------------------------------------|
| Id           | UUID      | Yes       | Unique identifier for the allergy record   |
| Patient_Id   | UUID      | Yes       | Reference to the patient                   |
| Start        | date      | No        | Start date of the allergy                  |
| Stop         | date      | No        | End date of the allergy                    |
| Code         | string    | Yes       | Allergy code                               |
| Description  | string    | Yes       | Description of the allergy                 |
| Encounter    | UUID      | Yes       | Reference to the encounter                 |
| ReasonCode   | string    | No        | Reason code for the allergy                |
| ReasonDesc   | string    | No        | Reason description for the allergy         |

## careplans

| Column Name  | Data Type | Required? | Description                                |
|--------------|-----------|-----------|--------------------------------------------|
| Id           | UUID      | Yes       | Unique identifier for the care plan        |
| Patient_Id   | UUID      | Yes       | Reference to the patient                   |
| Start        | date      | No        | Start date of the care plan                |
| Stop         | date      | No        | End date of the care plan                  |
| Code         | string    | Yes       | Care plan code                             |
| Description  | string    | Yes       | Description of the care plan               |
| Encounter    | UUID      | Yes       | Reference to the encounter                 |
| ReasonCode   | string    | No        | Reason code for the care plan              |
| ReasonDesc   | string    | No        | Reason description for the care plan       |
| Goal         | string    | No        | Goals of the care plan                     |

## claims

| Column Name  | Data Type | Required? | Description                                |
|--------------|-----------|-----------|--------------------------------------------|
| Id           | UUID      | Yes       | Unique identifier for the claim            |
| Patient_Id   | UUID      | Yes       | Reference to the patient                   |
| Date         | date      | Yes       | Date of the claim                          |
| TotalCost    | float     | Yes       | Total cost of the claim                    |
| CoveredCost  | float     | Yes       | Covered cost of the claim                  |
| UncoveredCost| float     | Yes       | Uncovered cost of the claim                |
| Procedure    | string    | No        | Procedures associated with the claim       |
| Medication   | string    | No        | Medications associated with the claim      |
| Provider     | UUID      | Yes       | Provider associated with the claim         |
