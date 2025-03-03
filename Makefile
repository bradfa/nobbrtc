dummy:
	@echo No need to compile this, please run `make install`

install:
	install -d $(DESTDIR)/usr/sbin
	install -d $(DESTDIR)/lib/systemd/system
	install -m 0755 nobbrtc.sh $(DESTDIR)/usr/sbin/
	install -m 0644 nobbrtc.service $(DESTDIR)/lib/systemd/system

clean:
	# Do nothing

.PHONY: dummy install clean
