# Ansible Role for DNS Server Management
=========

Ansible playbook to install and configure a DNS server using dnsmasq on an Ubuntu server.

# Requirements
------------

The role can be executed on any machine having a Debian-based OS with the below packages.
  - Ansible 
  - Python

# Role Variables
--------------

Available variables are listed below (`ansible/dns-server/defaults/main.yml`): 

*   `dns_domain`: The local domain that dnsmasq will serve. (Default: `an.example.com`)
*   `dns_upstream_servers`: A list of upstream DNS servers to forward queries to. (Default: `['8.8.8.8', '8.8.4.4']`)
*   `dns_static_records`: A list of dictionaries for static A records. Each dictionary should have `name` and `ip`.
*   `dns_cname_records`: A list of dictionaries for CNAME records. Each dictionary should have `cname` and `target`.

# Role tasks
-------------

The `main.yml` in the tasks directory will run the following operations:
  - Install dnsmasq.
  - Configure dnsmasq using a template.
  - Create a directory for custom dnsmasq configurations.
  - Create configuration files for static and CNAME records from templates.
  - Ensure the dnsmasq service is started and enabled.

The role also includes a handler to restart the `dnsmasq` service upon configuration changes.

# Dependencies
------------

There are no external dependencies for this role. Ensure that the target server is an Ubuntu server and is accessible via SSH.

# Example Playbook
----------------

To use this role, you can create a playbook like the one provided in `ansible/dns-server.yml`:

    ---
    - name: Configure DNS Server using dnsmasq
      hosts: dns_servers
      become: yes
      roles:
        - role: dns-server

You can then run the playbook using the following command:

    ansible-playbook ansible/dns-server.yml --extra-vars "hosts=your_host_group"

You would typically define your inventory of `dns_servers` in a separate inventory file.

Here is an example of how you can pass the records:

    ansible-playbook ansible/dns-server.yml -i inventory --extra-vars '{
      "dns_static_records": [
        { "name": "host1.an.example.com", "ip": "192.168.1.10" },
        { "name": "host2.an.example.com", "ip": "192.168.1.11" }
      ],
      "dns_cname_records": [
        { "cname": "alias.an.example.com", "target": "host1.an.example.com" }
      ]
    }'

# Author Information
------------------

QBurst DevOps Team
