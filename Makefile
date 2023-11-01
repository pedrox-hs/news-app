find_packages_depth=5

help: ## Mostra todos os comandos disponíveis com uma breve descrição
	@echo -e "Uso: make [target]\n\ntarget:"
	@grep -Fh "##" $(MAKEFILE_LIST) | grep -v grep | sed -e 's/\\$$//' | sed -e 's/: ##\s*/\t/' | expand -t 15 | pr -to2

setup: ## Cria o arquivo .env e instala as dependências
	[ -f .env ] || cp .env.example .env
	find . -maxdepth $(find_packages_depth) -type f -name pubspec.yaml -execdir flutter pub get \;
	npm --prefix packages/commons/ui/design_system install


ds: ## Cria/atualiza os dicionários de estilo a partir dos arquivos de Design Tokens
	dart run design_system:main build
	dart fix --apply packages/commons/ui/design_system/lib
	dart format packages/commons/ui/design_system/lib


run: ## Executa o app Flutter com o arquivo .env; você pode adicionar argumentos adicionais como `make run args='-d chrome'`
	flutter run --dart-define-from-file=.env $(args)


run-web: ## Executa o app Flutter Web com o arquivo .env
	make run args='-d web-server'


test-all: ## Executa todos os testes
	find . -maxdepth $(find_packages_depth) -type f -name pubspec.yaml -execdir test -e './test' \; -execdir flutter test --coverage \;
