build: repos.toml gallery-images.toml ./static/Prashant-Rahul-CV.pdf
	zola build

serve: repos.toml gallery-images.toml ./static/Prashant-Rahul-CV.pdf
	zola serve

ci: repos.toml gallery-images.toml ./static/Prashant-Rahul-CV.pdf

./static/Prashant-Rahul-CV.pdf: ./static/resume/pre-proj.tex ./static/resume/post-proj.tex ./build-resume.sh repos.toml
	bash ./build-resume.sh

repos.toml:
	bash ./build-gh-repos.sh

gallery-images.toml:
	bash ./build-gallery-index.sh

clean:
	rm -f repos.toml gallery-images.toml ./static/Prashant-Rahul-CV.*
