dbt_ Teach-in
============

![Made with Python](https://img.shields.io/badge/made%20with-python-blue)
![Python version](https://img.shields.io/badge/python-3.5%20%7C%203.6%20%7C%203.7-blue)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/1bk/dbt-teach-in)
![GitHub repo size](https://img.shields.io/github/repo-size/1bk/dbt-teach-in)
[![Website](https://img.shields.io/website?label=dbt%20documentation%20website&url=https%3A%2F%2F1bk.github.io%2Fdbt-teach-in%2F)][1]
![GitHub](https://img.shields.io/github/license/1bk/dbt-teach-in)

## Contents
-----------

## Quick Links
--------------
Check out the [dbt_ documentation][1] website for this repo!


[1]:dbt_teach_in/docs/


## Introduction
---------------
A repo with examples for a more advance dbt_ teach-in session


## Requirements
---------------
1. A Database 
    - You may either use the Analytics Redshift; or
    - Spin up a local Postgres database instance (using docker)

2. Python 
    - Version 3.6 or above

3. Git
    - To clone this repository on Github
    
4. dbt_  


## Initial Setup
--------
1. Prepare the Database
    - If you are using the Analytics Redshift, make sure to set the [`profile.yml`
      in the dbt project](dbt_teach_in/profiles.yml) accordingly.
    - To run a local Postgres database instance, you will need to:
        - [Install Docker](https://docs.docker.com/docker-for-mac/install/)
        - tbc

2. Installing Python
    - Follow the [guides to install Python][install-py-guide] if you don't 
      have it installed already.

3. Cloning this repository
    - If you haven't already, install Git (we recommend [installing via Homebrew][install-hb-guide])
    - Create a directory
      ```bash
      mkdir ~/github
      cd ~/github
      ``` 
    - Clone the repository
      ```bash
      git clone git@github.com:1bk/dbt-teach-in.git
      ``` 
      > _If you are having trouble with this, please reach out to me._
          

4. Installing dbt_
    - While there are many ways to install dbt_, we suggest to install it in a
      python virtual environment.
    - Follow [the official dbt_ guide][install-dbt-guide] that details each step:
        1. Create a local environment
           ```bash
           cd dbt-teach-in                     # set the working directory to the cloned repo
            
           python3 -m venv dbt-env             # create the environment
           source dbt-env/bin/activate         # activate the environment
           ```
        2. Install `dbt`
           ```bash
           pip install dbt
           ```

## Topics
---------
The topics here is shared in the order in which it was presented.

Note: 
 - Here we are applying dbt on a local Postgres instance.
 - Make sure to be in the dbt project directory
    ```bash
    cd ~/github/dbt-teach-in/dbt_teach_in
    ```
   
  
### Seed
> _Teach-in file reference:_
>   - [Raw data in `/data`](dbt_teach_in/data)
>   - [Documentation in `/data/seeds.yml`](dbt_teach_in/data/seeds.yml)
> 
> _Teach-in dbt\_ documentation reference:_
>   - [Table Documentation](dbt_teach_in/docs/#!/seed/seed.dbt_teach_in.raw_countries)
> 
> _Official dbt\_ docs:_
>   - [Seed -- Getting Started](https://docs.getdbt.com/docs/building-a-dbt-project/seeds/)
>   - [Seed configurations](https://docs.getdbt.com/reference/seed-configs)
>   - [Seed properties](https://docs.getdbt.com/reference/seed-properties)
>   - [`seed` command](https://docs.getdbt.com/reference/commands/seed)

1. Specify a schema to populate the seed files
    - In `dbt_project.yml`
        ```yaml
        seeds:
          dbt_teach_in:
            +schema: seeds
            quote_columns: true
        ```

2. Seed the data
    - Making sure the files you want to seed are in `/data`, run:
        ```bash
        dbt seed --profiles-dir ./
        ```

3. Setting custom columns
    - In `dbt_project.yml`
        ```yaml
        seeds:
          dbt_teach_in:
            ...
      
            raw_orders:
              # Override column types
              +column_types:
                order_priority: varchar(1)
        ```

4. Enable/Disable seed files:
     - In `dbt_project.yml`
        ```yaml
        seeds:
          dbt_teach_in:
            +schema: seeds

            ...

            snapshots:
              +schema: snapshots
        
              raw_orders_snapshot_backup:
                +enabled: true
        ```

5. Seeding specific files:
    - Using `--select`:
        ```bash 
        dbt seed --profiles-dir ./ --select raw_orders_snapshot_backup 
        ``` 

### Testing
> _Teach-in file reference:_
>   - [Raw data in `/data`](dbt_teach_in/data)
>   - [Documentation in `/data/seeds.yml`](dbt_teach_in/data/seeds.yml)
> 
> _Teach-in dbt\_ documentation reference:_
>   - [Table Documentation](dbt_teach_in/docs/#!/seed/seed.dbt_teach_in.raw_countries)
> 
> _Official dbt\_ docs:_
>   - [Seed -- Getting Started](https://docs.getdbt.com/docs/building-a-dbt-project/seeds/)
>   - [Seed configurations](https://docs.getdbt.com/reference/seed-configs)
>   - [Seed properties](https://docs.getdbt.com/reference/seed-properties)
>   - [`seed` command](https://docs.getdbt.com/reference/commands/seed)

1. Setting schema tests 
    - create  

### Snapshots

### Analysis

### Hooks

### Documentation

### Jinja

### Macros


### Redshift Connections

### Best Practices



[install-py-guide]: https://realpython.com/installing-python/#how-to-install-python-on-macos
[install-hb-guide]: https://github.com/git-guides/install-git#install-git-from-homebrew
[install-dbt-guide]: https://docs.getdbt.com/dbt-cli/installation/#installation