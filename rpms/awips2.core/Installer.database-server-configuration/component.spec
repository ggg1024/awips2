#
# AWIPS II Database Server Configuration Spec File
#
Name: awips2-database-server-configuration
Summary: AWIPS II Database Server Configuration
Version: 1.0.0
Release: 1
Group: AWIPSII
BuildRoot: /tmp
URL: N/A
License: N/A
Distribution: N/A
Vendor: Raytheon
Packager: Bryan Kowal

AutoReq: no
requires: awips2-postgresql
provides: awips2-database-server-configuration
provides: awips2-database-configuration

%description
AWIPS II Database Server Configuration - contains the AWIPS II server
configuration files optimized for a clustered, server environment.

%prep
# Verify That The User Has Specified A BuildRoot.
if [ "${RPM_BUILD_ROOT}" = "/tmp" ]
then
   echo "An Actual BuildRoot Must Be Specified. Use The --buildroot Parameter."
   echo "Unable To Continue ... Terminating"
   exit 1
fi

mkdir -p ${RPM_BUILD_ROOT}/awips2/data

%build

%install
PROJECT_DIR="Installer.database-server-configuration"
CONFIGURATION_DIR="Installer.rpm/awips2.core/${PROJECT_DIR}/configuration"
CONF_FILE="postgresql.conf"

cp ${WORKSPACE_DIR}/${CONFIGURATION_DIR}/${CONF_FILE} \
   ${RPM_BUILD_ROOT}/awips2/data

%pre
# Remove any existing postgresql.conf files
if [ -f /awips2/data/postgresql.conf ]; then
   rm -f /awips2/data/postgresql.conf
fi

%files
%attr(644,awips,fxalpha) /awips2/data/postgresql.conf