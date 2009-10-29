default:
	@echo Targets are: release, deb, debclean and debupload.

release:
	release=jobq-`./jobq -v |awk '{print $$2}'`; \
	mkdir -p $$release && ( \
	  cp jobq COPYING README TODO NEWS $$release; \
	  tar czf $$release.tar.gz $$release; \
	  rm -rf $$release )

deb:
	dpkg-buildpackage -rfakeroot -uc -us

debclean:
	fakeroot debian/rules clean

debupload:
	rsync -z ../jobq_*.deb builder@deb:~/src/jobq/
	ssh builder@deb make -C www jobq
