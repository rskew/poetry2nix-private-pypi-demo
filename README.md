To start and test the pypi server:
```sh
nix-shell
pypi-server -P passwordfile -a update,download,list -p 8080 --hash-algo sha256 ./simple &
curl localhost:8080/simple/test-package/ -u hello:HIHI
```

To test installing package via poetry2nix (demonstrating the new feature to download packages from private pypi repos):
```sh
cd user_project
# Move .netrc to /etc/nix because of permission errors trying to put . in extra-sandbox-paths
sudo mv .netrc /etc/nix/.netrc
sudo chmod 600 /etc/nix/.netrc
# Change permissions on .netrc to the nix builder
sudo chown 30001:30000 /etc/nix/.netrc
nix-shell -I NETRC=/etc/nix/.netrc --option extra-sandbox-paths /etc/nix
python -c "from test_package import hihi; hihi()"
```
To force re-download of the package after a successful build, run:
```sh
nix-store --delete /nix/store/*-test_package-0.1* /nix/store/*-test_package-0.1*
```

The test package is built and released via:
```sh
cd test_package; python setup.py sdist
mv dist/test_package-0.1.tar.gz ../simple/test_package/
```

passwordfile created via
```sh
htpasswd -c passwordfile hello
New password: HIHI
```
