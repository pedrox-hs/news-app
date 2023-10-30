find_packages_depth=4

help: ## Mostra todos os comandos disponíveis com uma breve descrição
	@echo -e "Uso: make [target]\n\ntarget:"
	@grep -Fh "##" $(MAKEFILE_LIST) | grep -v grep | sed -e 's/\\$$//' | sed -e 's/: ##\s*/\t/' | expand -t 15 | pr -to2

setup: ## Cria o arquivo .env e instala as dependências
	[ -f .env ] || cp .env.example .env
	find . -maxdepth $(find_packages_depth) -type f -name pubspec.yaml -execdir flutter pub get \;
	npm --prefix packages/ds install


ds: ## Cria/atualiza os dicionários de estilo a partir dos arquivos de Design Tokens
	dart run ds:main build
	dart fix --apply packages/ds/lib
	dart format packages/ds/lib


run: ## Executa o app Flutter com o arquivo .env; você pode adicionar argumentos adicionais como `make run args='-d chrome'`
	flutter run --dart-define-from-file=.env $(args)


run-web: ## Executa o app Flutter Web com o arquivo .env
	make run args='-d web-server'


test-all: ## Executa todos os testes
	find . -maxdepth $(find_packages_depth) -type f -name pubspec.yaml -execdir test -e './test' \; -execdir flutter test --coverage \;
