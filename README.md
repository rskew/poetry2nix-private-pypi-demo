To start and test the pypi server:
```sh
nix-shell
pypi-server -P passwordfile -a update,download,list -p 8080 --hash-algo sha256 ./packages &
curl localhost:8080/simple/test-package/ -u hello:HIHI
```

To test installing package via poetry2nix (demonstrating the new feature to download packages from private pypi repos):
```sh
cd user_project
nix-shell
python -c "from test_package import hihi; hihi()"
```

The test package is built and released via:
```sh
cd test_package; python setup.py sdist
mv dist/test_package-0.1.tar.gz ../simple/test_package/
```
