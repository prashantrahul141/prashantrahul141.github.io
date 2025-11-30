.PHONY: clean ci

build: index resume
	zola build

serve: index resume
	zola serve

serve-fast: index resume
	zola serve --fast

ci: index resume

RESUME_OUTFILE = ./static/Prashant-Rahul-CV.pdf
RESUME_INFILE = ./static/resume/pre-proj.tex ./static/resume/post-proj.tex
REPO_INDEX_FILE = repos.toml
GALLERY_INDEX_FILE = gallery-images.toml

# resume
resume: $(RESUME_OUTFILE)

$(RESUME_OUTFILE): $(RESUME_INFILE) ./build-resume.sh repos.toml
	./build_resume.py


# both index
index: repos gallery


# repos index
repos: $(REPO_INDEX_FILE)

$(REPO_INDEX_FILE):
	./build_gh_repos.py


# gallery index
gallery: $(GALLERY_INDEX_FILE)

$(GALLERY_INDEX_FILE):
	./build_gallery_index.py


# cleanup
clean: clean-repos clean-gallery-images clean-resume

clean-repos:
	rm -f $(REPO_INDEX_FILE)

clean-gallery-images:
	rm -f $(GALLERY_INDEX_FILE)

clean-resume:
	rm -f ./static/Prashant-Rahul-CV.*
