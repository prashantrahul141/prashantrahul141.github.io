build: repos.toml gallery-images.toml ./static/Prashant-Rahul-CV.pdf
	zola build

serve: repos.toml gallery-images.toml ./static/Prashant-Rahul-CV.pdf
	zola serve

serve-fast: repos.toml gallery-images.toml ./static/Prashant-Rahul-CV.pdf
	zola serve --fast

ci: repos.toml gallery-images.toml ./static/Prashant-Rahul-CV.pdf

./static/Prashant-Rahul-CV.pdf: ./static/resume/pre-proj.tex ./static/resume/post-proj.tex ./build-resume.sh repos.toml
	./build_resume.py

repos.toml:
	./build_gh_repos.py

gallery-images.toml:
	./build_gallery_index.py

clean:
	rm -f repos.toml gallery-images.toml ./static/Prashant-Rahul-CV.*
