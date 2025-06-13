require 'json'
require 'fileutils'

def update_version_in_file(version, version_file)
  # Atualiza o arquivo .package-version com a nova versão
  File.write(version_file, version)
  puts "Atualizado #{version_file} para a versão #{version}"
end

def read_current_version(version_file)
  File.read(version_file).strip
end

def update_podspec_version(podspec_file, new_version)
  content = File.read(podspec_file)
  updated_content = content.gsub(/s.version\s*=\s*['"]\d+\.\d+\.\d+(-\w+)?['"]/, "s.version = '#{new_version}'")
  File.write(podspec_file, updated_content)
  puts "Atualizado #{podspec_file} para a versão #{new_version}"
end

def update_readme_version(readme_file, new_version)
    content = File.read(readme_file)
    updated_content = content.gsub(/Latest stable version:\s*`?\d+\.\d+\.\d+(-\w+)?`?/, "Latest stable version: `#{new_version}`")
    File.write(readme_file, updated_content)
    puts "Atualizado #{readme_file} para a versão #{new_version}"
end

# Caminhos para os arquivos
podspec_file = 'LibPub.podspec'
readme_file = 'README.md'
version_file = '.package-version'

# Verifica se uma nova versão foi passada como argumento
if ARGV.empty?
  puts "Por favor, forneça a nova versão no formato x.y.z."
  exit
end

new_version = ARGV[0]

# Atualiza o arquivo .package-version
update_version_in_file(new_version, version_file)

# Atualiza os outros arquivos
update_podspec_version(podspec_file, new_version)
update_readme_version(readme_file, new_version)