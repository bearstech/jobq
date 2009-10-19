default:
	@echo Targets are: deb, debclean and debupload.

deb:
	dpkg-buildpackage -rfakeroot -uc -us

debclean:
	fakeroot debian/rules clean

debupload:
	rsync -z ../jobq_*.deb builder@deb:~/src/jobq/
	ssh builder@deb make -C www jobq
