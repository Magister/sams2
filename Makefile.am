# not a GNU package. You can remove this line, if
# have all needed files, that a GNU package needs
AUTOMAKE_OPTIONS = foreign 1.4

SUBDIRS = src php doc plugins/loadavg plugins/fsusage
bin_SCRIPTS = scripts/sams_send_email

EXTRA_DIST = Makefile.cvs doc php etc spec debian redhat scripts
DISTCLEANFILES = Makefile.in configure aclocal.m4 config.guess config.sub depcomp install-sh ltmain.sh missing

dist-hook:
	find $(distdir) -type d -name .svn | xargs rm -rf

docdir = $(datadir)/doc/$(PACKAGE)-$(VERSION)

install-data-local:
#	$(mkinstalldirs) $(DESTDIR)/$(datadir)/$(distdir)
	$(mkinstalldirs) $(DESTDIR)/$(sysconfdir)
	if [ ! -f $(DESTDIR)/$(sysconfdir)/sams2.conf ] ; then \
	    $(install_sh) -c -m 644 $(top_srcdir)/etc/sams2.conf $(DESTDIR)/$(sysconfdir) ;\
	fi
	echo "httpd_server=$(httpd_server)"
	$(httpd_server) -v
	echo "debian=$(debian)"
	echo "==> find datadir=$(datadir) destdir=$(DESTDIR) httpd_include=$(HTTPD_INCLUDE) conf=/sams2.conf HTTPD_ROOT=$(HTTPD_ROOT) httpd_root=$(httpd_root)"
	if [ "$(DESTDIR)" = "" ] ; then \
	    if [ ! -f $(HTTPD_INCLUDE)/sams2.conf ] ; then \
		if $(httpd_server) -v | grep "/2.4" &>/dev/null ; then \
		    $(install_sh) -c -m 644 $(top_srcdir)/etc/httpd2.4_conf $(HTTPD_INCLUDE)/sams2.conf ;\
		    sed -i -e 's,__WEBPREFIX,$(datadir)/sams2,g' $(HTTPD_INCLUDE)/sams2.conf ;\
		    echo "copy httpd2.4_conf ==> $(HTTPD_INCLUDE)/sams2.conf" ; \
		else \
		    $(install_sh) -c -m 644 $(top_srcdir)/etc/httpd_conf $(HTTPD_INCLUDE)/sams2.conf ;\
		    sed -i -e 's,__WEBPREFIX,$(datadir)/sams2,g' $(HTTPD_INCLUDE)/sams2.conf ;\
		    echo "copy httpd_conf ==> $(HTTPD_INCLUDE)/sams2.conf" ; \
		fi ; \
		if test -d $(HTTPD_ROOT)/sites-enabled ; then ln -s $(HTTPD_INCLUDE)/sams2.conf $(HTTPD_ROOT)/sites-enabled/sams2.conf ; fi ; \
	    fi ; \
	else \
	    if [ ! -f $(DESTDIR)/$(HTTPD_INCLUDE)/sams2.conf ] ; then \
		if $(httpd_server) -v | grep "/2.4" &>/dev/null ; then \
		    $(install_sh) -c -m 644 $(top_srcdir)/etc/httpd2.4_conf $(DESTDIR)/$(HTTPD_INCLUDE)/sams2.conf ;\
		    sed -i -e 's,__WEBPREFIX,$(datadir)/sams2,g' $(DESTDIR)/$(HTTPD_INCLUDE)/sams2.conf ;\
		    echo "copy httpd2.4_conf ==> $(DESTDIR)/$(HTTPD_INCLUDE)/sams2.conf" ; \
		else \
		    $(install_sh) -c -m 644 $(top_srcdir)/etc/httpd_conf $(DESTDIR)/$(HTTPD_INCLUDE)/sams2.conf ;\
		    sed -i -e 's,__WEBPREFIX,$(datadir)/sams2,g' $(DESTDIR)/$(HTTPD_INCLUDE)/sams2.conf ;\
		    echo "copy httpd_conf ==> $(DESTDIR)/$(HTTPD_INCLUDE)/sams2.conf" ; \
		fi ; \
		if test -d $(DESTDIR)/$(HTTPD_ROOT)/sites-enabled ; then ln -s $(DESTDIR)/$(HTTPD_INCLUDE)/sams2.conf $(DESTDIR)/$(HTTPD_ROOT)/sites-enabled/sams2.conf ; fi ; \
	    fi ; \
	fi
#	if [ ! -f $(DESTDIR)/$(HTTPD_INCLUDE)/sams2.conf ] ; then \
#	    $(install_sh) -c -m 644 $(top_srcdir)/etc/httpd_conf $(DESTDIR)/$(HTTPD_INCLUDE)/sams2.conf ;\
#	    sed -i -e 's,__WEBPREFIX,$(datadir)/sams2,g' $(DESTDIR)/$(HTTPD_INCLUDE)/sams2.conf ;\
#	fi
	if [ ! -f $(DESTDIR)/$(HTTPD_INCLUDE)/doc4sams2.conf ] ; then \
	    $(install_sh) -c -m 644 $(top_srcdir)/etc/doc_sams2_conf $(DESTDIR)/$(HTTPD_INCLUDE)/doc4sams2.conf ;\
	    sed -i -e 's,__DOCPREFIX,$(docdir),g' $(DESTDIR)/$(HTTPD_INCLUDE)/doc4sams2.conf ;\
	fi
	if [ ! -d /etc/squid3 ] ; then \
	    sed -i -e 's/SQUIDROOTDIR=\/etc\/squid3/SQUIDROOTDIR=\/etc\/squid/g' $(DESTDIR)/$(sysconfdir)/sams2.conf ;\
	fi
	if [ ! -d /var/log/squid3 ] ; then \
	    sed -i -e 's/SQUIDLOGDIR=\/var\/log\/squid3/SQUIDLOGDIR=\/var\/log\/squid/g' $(DESTDIR)/$(sysconfdir)/sams2.conf ;\
	fi
	if [ ! -d /var/spool/squid3 ] ; then \
	    sed -i -e 's/SQUIDCACHEDIR=\/var\/spool\/squid3/SQUIDCACHEDIR=\/var\/spool\/squid/g' $(DESTDIR)/$(sysconfdir)/sams2.conf ;\
	fi

uninstall-local:
	if [ -f $(DESTDIR)/$(sysconfdir)/sams2.conf ] ; then \
		mv -f $(DESTDIR)/$(sysconfdir)/sams2.conf $(DESTDIR)/$(sysconfdir)/sams2.conf.save ;\
	fi
	if [ -f $(DESTDIR)/$(HTTPD_INCLUDE)/sams2.conf ] ; then \
		mv -f $(DESTDIR)/$(HTTPD_INCLUDE)/sams2.conf $(DESTDIR)/$(HTTPD_INCLUDE)/sams2.conf.save ;\
	fi
	if [ -f  $(DESTDIR)/$(HTTPD_INCLUDE)/doc4sams2.conf ] ; then \
		mv -f $(DESTDIR)/$(HTTPD_INCLUDE)/doc4sams2.conf $(DESTDIR)/$(HTTPD_INCLUDE)/doc4sams2.conf.save ;\
	fi
