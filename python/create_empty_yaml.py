import os

def create_empty_yaml(csv_file):
  """Creates an empty YAML file if it doesn't exist."""
  yaml_file = os.path.splitext(csv_file)[0] + ".yml"
  if not os.path.exists(yaml_file):
    with open(yaml_file, "w") as f:
      pass  # Create an empty file

# Set the directory path
directory = os.path.join(os.path.dirname(__file__), "..", "seeds", "synthea")

# Iterate through the directory and find CSV files
for filename in os.listdir(directory):
  if filename.endswith(".csv"):
    csv_file = os.path.join(directory, filename)
    create_empty_yaml(csv_file)

print("Empty YAML files created for missing CSV files.")
