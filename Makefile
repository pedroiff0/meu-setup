.PHONY: help install verify lint

help: ## Exibe a lista de comandos disponíveis
	@echo "Comandos disponíveis em Meu Setup:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-18s\033[0m %s\n", $$1, $$2}'

install: ## Executa o bootstrap do instalador principal
	bash install.sh

verify: ## Valida sintaxe dos scripts de shell e do arquivo packages.yaml
	bash -n install.sh
	python3 -c "import yaml; yaml.safe_load(open('packages.yaml'))"
	@echo "Configurações e scripts válidos!"

lint: verify ## Executa validação de sintaxe
