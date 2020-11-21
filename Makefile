SHELL=bash

SCRIPTS_DIR:=$(PWD)/scripts

PYTHONS:=2.7.18 3.5.9 3.6.11 3.7.8 3.8.5
PYTHON_MAJORS:=$(shell        \
	echo "$(PYTHONS)" |         \
	tr ' ' '\n' | cut -d. -f1 | \
	uniq                        \
)
PYTHON_MINORS:=$(shell          \
	echo "$(PYTHONS)" |           \
	tr ' ' '\n' | cut -d. -f1,2 | \
	uniq                          \
)

# PyPI server name, as specified in ~/.pypirc
# See http://peterdowns.com/posts/first-time-with-pypi.html
PYPI=pypitest
TWINE=twine

# default target
all: test

test: pytest
	
quicktest:
	PYPI=$(PYPI) python setup.py test

coverage:

pytest: deps-dev
	PYTHONS="$(PYTHONS)" PYTHON_MINORS="$(PYTHON_MINORS)" "$(SCRIPTS_DIR)/run.sh"

clean: clean-build clean-eggs clean-temps

distclean: clean

clean-build:
	rm -rf dist build

clean-eggs:
	rm -rf *.egg* .eggs/

clean-temps:
	rm -rf $(TEMPS)


# Register at PyPI
register:
	PYPI=$(PYPI) python setup.py register -r $(PYPI)

# Setup for live upload
release:
	$(eval PYPI=pypi)

# Build source distribution
sdist-upload: distclean deps-dev
	PYPI=$(PYPI) python setup.py sdist
	if [[ "$(PYPI)" == pypitest ]]; then \
		$(TWINE) upload --repository-url https://test.pypi.org/legacy/ dist/*; \
	else \
		$(TWINE) upload dist/*; \
	fi

deps-dev: pyenv-install-versions

# Uploads to test server, unless the release target was run too
upload: test clean sdist-upload

pyenv-is-installed:
	pyenv --version &>/dev/null || (echo "ERROR: pyenv not installed" && false)

pyenv-install-versions: pyenv-is-installed
	for pyver in $(PYTHONS); do (echo N | pyenv install $$pyver) || true; done
	for pyver in $(PYTHONS); do \
		export PYENV_VERSION=$$pyver; \
		pip install -U pip; \
		pip install -U pytest; \
	done | grep -v 'Requirement already satisfied, skipping upgrade'
	# twine and wheel needed only under latest PYTHONS version for uploading to PYPI
	export PYENV_VERSION=$(shell \
		echo $(PYTHONS) | \
		tr ' ' '\n' | \
		tail -n1 \
	)
	pip install -U twine
	pip install -U wheel
	pyenv rehash

# for debugging the Makefile
env:
	@echo
	@echo TEMPS="\"$(TEMPS)\""
	@echo PYTHONS="\"$(PYTHONS)\""
	@echo PYTHON_MAJORS="\"$(PYTHON_MAJORS)\""
	@echo PYTHON_MINORS="\"$(PYTHON_MINORS)\""
	@echo PYPI="\"$(PYPI)\""


.PHONY: all \
	test \
	quicktest \
	pytest \
	clean \
	distclean \
	clean-build \
	clean-eggs \
	clean-temps \
	install-testpypi \
	install-pypi \
	install-develop \
	pyenv-install-versions \
	pyenv-is-installed \
	uninstall \
	register \
	release \
	sdist-upload \
	deps-ci \
	deps-dev \
	pm-update \
	upload \
	env

