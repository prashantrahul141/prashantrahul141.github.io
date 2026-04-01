.PHONY: clean ci

build: index resume
	zola build

serve: index resume
	zola serve

serve-fast: index resume
	zola serve --fast

ci: index resume

RESUME_OUTFILE = ./static/Prashant-Rahul-CV.pdf
RESUME_INFILE = ./static/resume-typst/01-pre-proj.typ ./static/resume-typst/02-post-proj.typ
REPO_INDEX_FILE = repos.toml

# resume
resume: $(RESUME_OUTFILE)

$(RESUME_OUTFILE): $(RESUME_INFILE) $(REPO_INDEX_FILE)
	./scripts/build_resume.py

# both index
index: repos

# repos index
repos: $(REPO_INDEX_FILE)

$(REPO_INDEX_FILE):
	./scripts/build_gh_repos.py

# prebuild
generate_doodles:
	cd ./scripts/thumbnail/ && bash svg-to-png.sh

# run using `make generate_thumbnail TITLE="Title of the Blog"`
generate_thumbnail:
	./scripts/gen_meta_images.py "$(TITLE)"

# cleanup
clean: clean-repos clean-gallery-images clean-resume

clean-repos:
	rm -f $(REPO_INDEX_FILE)

clean-gallery-images:
	rm -f $(GALLERY_INDEX_FILE)

clean-resume:
	rm -f ./static/Prashant-Rahul-CV.*
