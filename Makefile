build: repos.toml
	zola build

serve: repos.toml
	zola serve


repos.toml:
	bash ./build-gh-repos.sh
