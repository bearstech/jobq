default:
	@echo Targets are: release, deb, debclean and debupload.

release:
	release=jobq-`./jobq -v |awk '{print $$2}'`; \
	mkdir -p $$release && ( \
	  cp jobq jobq-profile jobq-stat COPYING README TODO NEWS $$release; \
	  tar czf $$release.tar.gz $$release; \
	  rm -rf $$release )

deb:
	@echo "Don't forget to edit debian/changelog (dch -v <version>)..."
	@echo "Building the package..."
	dpkg-buildpackage -rfakeroot -i -I.svn -I'*.log'

debclean:
	fakeroot debian/rules clean
	rm build

debupload:
	rsync -z ../jobq_*.deb builder@deb:~/src/jobq/
	ssh builder@deb make -C www/squeeze jobq
