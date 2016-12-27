#!/usr/bin/make -f

.PHONY: pdf-in-docker
pdf-in-docker:
	# We pass the original UID (UID) and GID (OGID) so that
	# the generated artefacts belong to the correct user
	sudo docker run -it -e OUID=$$(id -u) -e OGID=$$(id -g) -v $$PWD:/latex docker-texlive make pdf

.PHONY: pdf
pdf: clean
	lualatex -output-directory output report.tex
	biber output/report
	lualatex -output-directory output report.tex
	chown -R $$OUID:$$OGID output/

.PHONY: docker-image
docker-image:
	docker build -t docker-texlive .

.PHONY: clean
clean:
	rm output/* 2>/dev/null || true
