from postgres_manager import PostgresManager

def fetch_patient_ids(source_manager: PostgresManager, process_id: str):
    query = f"SELECT patient_id FROM log.patients_log where process_id = '{process_id}'" 
    try:
        ids = source_manager.execute_query(query)
        patient_ids = [id_tuple[0] for id_tuple in ids]  # Extract the IDs from the tuples
        return patient_ids
    finally:
        source_manager.close()

if __name__ == "__main__":
    source_manager = PostgresManager(env_prefix="REMOTE_")
    patient_ids = fetch_patient_ids(source_manager=source_manager, process_id='c1de4c90-f0f6-484c-a833-9ee97ee45b8d')
    print(patient_ids)  # D
