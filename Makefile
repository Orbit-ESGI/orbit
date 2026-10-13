# Points d'entrée du projet ORBIT. À lancer depuis WSL2 / Linux.
.DEFAULT_GOAL := help
ANSIBLE_DIR := infra/ansible

help: ## Affiche cette aide
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | awk 'BEGIN{FS=":.*?## "}{printf "  \033[36m%-18s\033[0m %s\n", $$1, $$2}'

outils: ## Installe les outils du poste (mise) et les hooks pre-commit
	mise install
	pre-commit install

lint: ## Lance toutes les vérifications locales
	pre-commit run --all-files

ping: ## Vérifie qu'Ansible joint toutes les machines
	cd $(ANSIBLE_DIR) && ansible all -m ping

vps: ## Configure le VPS (site C)
	cd $(ANSIBLE_DIR) && ansible-playbook playbooks/vps.yml

.PHONY: help outils lint ping vps
