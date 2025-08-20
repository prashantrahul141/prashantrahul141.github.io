build: ./static/Prashant-Rahul-CV.pdf repos.toml gallery-images.toml
	zola build

serve: ./static/Prashant-Rahul-CV.pdf repos.toml gallery-images.toml
	zola serve

ci: ./static/Prashant-Rahul-CV.pdf repos.toml gallery-images.toml

./static/Prashant-Rahul-CV.pdf: ./static/resume/pre-proj.tex ./static/resume/post-proj.tex ./build-resume.sh
	bash ./build-resume.sh

repos.toml:
	bash ./build-gh-repos.sh

gallery-images.toml:
	bash ./build-gallery-index.sh

clean:
	rm -f repos.toml gallery-images.toml ./static/Prashant-Rahul-CV.*
