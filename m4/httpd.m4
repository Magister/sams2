
AC_DEFUN([AC_CHECK_HTTPD],
[
ac_httpd="/usr/sbin/httpd /usr/local/sbin/httpd /usr/sbin/httpd2 /usr/local/sbin/httpd2 /usr/sbin/apache /usr/local/sbin/apache /usr/sbin/apache2 /usr/local/sbin/apache2"
for i in $ac_httpd; do
    if test -e $i
    then
        $1="$i"
        HTTPD_SERVER="$i"
    fi
done

HTTPD_ROOT=`apachectl -V |grep HTTPD_ROOT|sed -e 's/"//g'|sed -e 's/=/ /g'|sed -e 's/-D HTTPD_ROOT//g'|sed -e 's/\n//g'|sed -e 's/ //g'`
SERVER_CONFIG_FILE=$HTTPD_ROOT/`apachectl -V |grep SERVER_CONFIG_FILE|sed -e 's/"//g'|sed -e 's/=/ /g'|sed -e 's/-D SERVER_CONFIG_FILE//g'|sed -e 's/\n//g'|sed -e 's/ //g'`
altlinux5=`grep -qi  "ALT Linux 5" /etc/altlinux-release &>/dev/null && echo 1 || echo 0`
altlinux4=`grep -qi  "ALT Linux 4" /etc/altlinux-release &>/dev/null && echo 1 || echo 0`
rhel7=`rpm -q filesystem | grep "el7" &>/dev/null && echo 1 || echo 0`
debian=`test -e /etc/debian_version && echo 1 || echo 0`
redhat=`test -e /etc/redhat-release && echo 1 || echo 0`

echo "HTTPD_ROOT=$HTTPD_ROOT"
echo "SERVER_CONFIG_FILE=$SERVER_CONFIG_FILE"

if [[ $altlinux5 -eq 1 ]]
then
    HTTPD_INCLUDE=$HTTPD_ROOT/`grep ^"Include " $SERVER_CONFIG_FILE | grep "sites-enabled" |sed -e 's|/.*$ |/|g'|sed -e 's/Include//g'|sed -e 's, ,,g'| sed -e 's/[[^\/]]*$//g'`
elif [[ $altlinux4 -eq 1 ]]
then
    HTTPD_INCLUDE=$HTTPD_ROOT/`grep ^"Include " $SERVER_CONFIG_FILE | grep "sites-enabled" |sed -e 's|/.*$ |/|g'|sed -e 's/Include//g'|sed -e 's, ,,g'| sed -e 's/[[^\/]]*$//g'`
elif [[ $debian -eq 1 ]]
then
	HTTPD_INCLUDE=$HTTPD_ROOT/conf.d/
elif [[ $redhat -eq 1 ]]
then
	HTTPD_INCLUDE=$HTTPD_ROOT/conf.d/
else
    HTTPD_INCLUDE=$HTTPD_ROOT/`grep ^"Include " $SERVER_CONFIG_FILE |sed -e 's|/.*$ |/|g'|sed -e 's/Include//g'|sed -e 's, ,,g'| sed -e 's/[[^\/]]*$//g'`
fi

if [[ "$HTTPD_INCLUDE" = "$HTTPD_ROOT/" ]]
then
    HTTPD_INCLUDE=`echo $SERVER_CONFIG_FILE |sed -e 's/\/httpd.conf//g'`
fi

AC_DEFINE(debian, $debian, [debian distribution])
AC_SUBST(debian)dnl

])
