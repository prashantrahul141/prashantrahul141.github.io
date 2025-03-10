build: repos.toml gallery-images.toml
	zola build

serve: repos.toml gallery-images.toml
	zola serve

ci: repos.toml gallery-images.toml

repos.toml:
	bash ./build-gh-repos.sh

gallery-images.toml:
	bash ./build-gallery-index.sh

clean:
	rm -f repos.toml gallery-images.toml
