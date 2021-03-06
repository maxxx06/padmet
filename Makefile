
all: clean compile sdist

clean:
	@echo Clean Python build dir...
	python setup.py clean --all
	@echo Clean Python distribution dir...
	@-rm -rf dist

compile:
	@echo Building the library...
	python setup.py build

sdist:
	@echo Building the distribution package...
	python setup.py sdist

install:
	@echo Install the package...
	python setup.py install --record files.txt

uninstall: files.txt
	@echo Uninstalling the package...
	cat files.txt | xargs rm -rf
	rm files.txt

test_register:
	python setup.py register -r pypitest

test_install:
	python setup.py sdist upload -r pypitest
	pip install -U -i https://testpypi.python.org/pypi padmet

real_register:
	python setup.py register

real_install:
	python setup.py sdist upload
	pip install padmet
push:
	python3 setup.py sdist upload

