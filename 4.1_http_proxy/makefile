#!/bin/bash
Infrastructure-setup:
	terraform init
	terraform apply -auto-approve
	terraform output > dynamic_inventory.txt
	python3 dynamic_inventory.py
	sleep 50
	ansible-playbook play_squid.yml
