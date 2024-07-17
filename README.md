# sanofi data transformations

## Table of Contents
- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
  - [Step 1: Install Dependencies](#step-1-install-dependencies)
  - [Step 2: Install dbt](#step-2-install-dbt)
- [Configuration](#configuration)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Introduction
This README provides instructions for installing dbt (Data Build Tool) for our project. dbt is a command-line tool that enables data analysts and engineers to transform data in their warehouse more effectively. Follow the steps below to get dbt up and running.

## Prerequisites
Before you begin, make sure you have the following prerequisites in place:
- [Python](https://www.python.org/downloads/) (Python 3.10 or 3.11, at the time of writing dbt is not supported on 3.12)
- Access to a sanofi BigQuery datasets in project bdag-looker-demo: 
  - car_chargers_raw 
  - car_chargers_analytics
  - car_chargers_elementary 
  
  car_chargers_analytics and car_chargers_elementary can be empty with no tables. car_chargers_raw should have initial tables created prior to running any transformations from this repo.
- A working knowledge of your SQL and data transformations

## Installation
General dbt installations instructions for BigQuery: https://docs.getdbt.com/docs/core/connect-data-platform/bigquery-setup

### Step 1: Install Dependencies
1. Open your terminal or command prompt.
2. Create a virtual environment (recommended):
```
python -m venv venv 
```
3. Activate the virtual environment:
- On macOS and Linux:
  ```
  source venv/bin/activate
  ```
- On Windows:
  ```
  venv\Scripts\activate
  ```
4. Upgrade pip (optional but recommended):
```
pip install --upgrade pip
```

### Step 2: Install dbt
1. Install dbt and other anciliary packages using pip:
```
pip install -r requirements.txt
```
2. Verify that dbt has been installed successfully:
```
dbt --version
```
3. Install dbt package dependencies:
```
dbt deps
```

## Configuration
Configure .dbt/profiles.yml, using one of 4 [authentication method](https://docs.getdbt.com/docs/core/connect-data-platform/bigquery-setup#authentication-methods)  
Sample setup:
```yaml
sanofi:
  outputs:
    dev:
      dataset: car_chargers_analytics
      job_execution_timeout_seconds: 300
      job_retries: 1
      location: europe-west2
      method: oauth
      priority: interactive
      project: bdag-looker-demo
      threads: 4
      type: bigquery
  target: dev
```

## Usage
You're now ready to use dbt for managing and transforming your data. 
Here are some common dbt commands to get started:
- `dbt run`: Run dbt models to build your project.
- `dbt test`: Run tests on your data models.
- `dbt docs generate`: Generate documentation for your project.


## Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices

# Elementary Data Installation Guide

## Install Elementary CLI

1. Install the monitor module:
```bash
pip install 'elementary-data[bigquery]'
```

2. In dbt_project.yml comment out:
```bash
enabled: "{{ target.name in ['prod','analytics'] }}"
```
should be:
```bash
# enabled: "{{ target.name in ['prod','analytics'] }}"
```
3. Build Elementary Models:
```bash
dbt deps
dbt run --select elementary
```
4. Generate Tests Report UI
```bash
edr report
```

## Resources:
- Elementary installaction instructions [quickstart-cli](https://docs.elementary-data.com/oss/quickstart/quickstart-cli)
- Generate observability report [generate-report-ui](https://docs.elementary-data.com/oss/guides/generate-report-ui)

## License
This project is licensed under the [MIT License](LICENSE).