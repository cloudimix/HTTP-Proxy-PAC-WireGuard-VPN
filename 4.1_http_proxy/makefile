#!/bin/bash

Infrastructure-setup:
	ansible-playbook id_rsa_generating.yml
	terraform init
	terraform apply -auto-approve
	terraform output > dynamic_inventory.txt
	ansible-playbook -i dynamic_inventory.py play_squid.yml
