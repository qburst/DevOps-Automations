# Ansible Role for User Management
=========

Ansible playbook to create user accounts in AWS, Jenkins, Linux, MySQL and PostgreSQL.

# Requirements
------------

The role can be executed on any machine having Linux OS with the below packages.
  - Ansible 
  - Python
  - pymysql
  - mysql-client
  - postgresql-client
  - awscli

# Role Variables
--------------

Available variables are listed below (user-management/vars/main.yml): 

users
 - aws
 - linux
 - jenkins
 - mysql
 - postgres

# Role tasks
-------------

Available tasks are listed below (user-management/tasks/)

tasks
  - aws-add-user.yml
  - jenkins-add-user.yml
  - linux-add-user.yml
  - mysql-add-user.yml
  - postgres-add-user.yml

# Dependencies
------------

1. Configure AWS access key and secret key for running aws user creation.
2. Modify Jenkins authorization security by enabling necessary permission for the admin user.
3. Grant access to the IP from where you are running this playbook in the MySQL server. 
4. Allow necessary access in all the servers.


# Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    ---
    - name: Ansible roles to create/manage users
      hosts: servers
      gather_facts: true
      become: yes
      roles:
        - role: user-management

The same is provided in the main.yml residing outside the role. You can use the following command to run all the tasks.

### ansible-playbook main.yml

You can use --skip-tags to exclude any particular role

### Ex: ansible-playbook main.yml --skip-tags linux

# Author Information
------------------

QBurst DevOps Team