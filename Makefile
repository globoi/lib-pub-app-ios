# Configuration Variables
SCRIPT = Scripts/update_version.rb
PODSPEC_FILEPATH = LibPub.podspec
POD_NAME = LibPub
PODSPEC_REPOSITORY_NAME = "pods-repository-native"
SOURCE_URL = "https://gitlab.globoi.com/native/pods-repository"

CURRENT_VERSION = $(shell cat .package-version)

# Atualiza a versão do pacote e adiciona nas mudanças do git
bump_version:
	@echo "Por favor, insira a nova versão no formato x.y.z:"
	@read version; \
	echo "Atualizando a versão para $$version..."; \
	ruby $(SCRIPT) $$version; \
	git add .package-version README.md $(PODSPEC_FILEPATH); \

# Faz um commit de BUMP da nova versão e sobe para o repositório remoto
add_version_remote:
	@echo "Por favor, insira o nome da branch"
	@read branch; \
	git commit -m "[BUMP] version: $(CURRENT_VERSION)"; \
	git push origin $$branch;

# Adiciona o repositório de pods aos repos locais do cocoapods, necessário para deploy
setup_cocoapods_deploy:
	@bundle exec pod repo add $(PODSPEC_REPOSITORY_NAME) $(SOURCE_URL)

# Cria a tag a partir da versão do `.package-version` e faz deploy para o repositório de pods
cocoapods_deploy:
	@git tag '$(CURRENT_VERSION)'
	@git push --tags
	@bundle exec pod repo push $(PODSPEC_REPOSITORY_NAME) $(PODSPEC_FILEPATH) --allow-warnings

# Remove tag baseada na versão atual do `.package-version`, usar caso o deploy tenha falhado e gerar uma nova tag corretamente
remove_tag:
	@git tag -d $(CURRENT_VERSION);
	@git push origin :refs/tags/$(CURRENT_VERSION)
	@bundle exec pod cache clean $(POD_NAME) --all

# Deleta uma versão do repositório de pods baseada na versão atual do `.package-version`
delete_version_from_repository:
	remove_tag
	@bundle exec pod trunk delete $(POD_NAME) $(CURRENT_VERSION)

# Exclui todos os arquivos não rastreáveis pelo Git
clean:
	@git clean -xdf
	
# Valida o podspec para garantir que esteja com as configurações corretas (remoto)
validate_podspec:
	@bundle exec pod spec lint

# Valida o podspec para garantir que esteja com as configurações corretas (local)
lint:
	@bundle exec pod lib lint

# Roda os testes unitários e integração
test:
	@xcodebuild test -workspace LibPub/LibPub.xcworkspace -scheme LibPub -destination 'platform=iOS Simulator,name=iPhone 16'

.PHONY: bump-version setup_cocoapods_deploy cocoapods_deploy remove_tag delete_version_from_repository clean
