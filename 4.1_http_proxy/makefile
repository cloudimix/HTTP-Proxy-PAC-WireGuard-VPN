#!/bin/bash
Infrastructure-setup:
	terraform init
	terraform apply -auto-approve
	terraform output > dynamic_inventory.txt
	ansible-playbook -i dynamic_inventory.py play_squid.yml
