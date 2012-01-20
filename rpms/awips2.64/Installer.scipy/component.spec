%global __os_install_post %(echo '%{__os_install_post}' | sed -e 's!/usr/lib[^[:space:]]*/brp-python-bytecompile[[:space:]].*$!!g')

%define _python_pkgs_dir "%{_baseline_workspace}/pythonPackages"

#
# AWIPS II Python scipy Spec File
#
Name: awips2-python-scipy
Summary: AWIPS II Python scipy Distribution - 64 Bit
Version: 0.8.0
Release: 1
Group: AWIPSII
BuildRoot: %{_build_root}
URL: N/A
License: N/A
Distribution: N/A
Vendor: Raytheon
Packager: Bryan Kowal

AutoReq: no
requires: awips2-python
requires: awips2-python-numpy
provides: awips2-python-scipy

%description
AWIPS II Python scipy Site-Package - 64-bit.

%prep
# Verify That The User Has Specified A BuildRoot.
if [ "%{_build_root}" = "/tmp" ]
then
   echo "An Actual BuildRoot Must Be Specified. Use The --buildroot Parameter."
   echo "Unable To Continue ... Terminating"
   exit 1
fi

rm -rf %{_build_root}
mkdir -p %{_build_root}
mkdir -p %{_build_root}/build-python

%build
SCIPY_SRC_DIR="%{_python_pkgs_dir}/scipy"

cp -rv ${SCIPY_SRC_DIR}/* \
   %{_build_root}/build-python
RC=$?
if [ ${RC} -ne 0 ]; then
   exit 1
fi

export BLAS=/awips2/python/lib
export LAPACK=/awips2/python/lib
source /etc/profile.d/awips2Python64.sh
RC=$?
if [ ${RC} -ne 0 ]; then
   exit 1
fi

pushd . > /dev/null
cd %{_build_root}/build-python
export LD_LIBRARY_PATH=/awips2/python/lib
/awips2/python/bin/python setup.py build
RC=$?
if [ ${RC} -ne 0 ]; then
   # Try to build a second time. It seems to work
   # for some reason.
   /awips2/python/bin/python setup.py build
   RC=$?
   if [ ${RC} -ne 0 ]; then
      exit 1
   fi
fi
popd > /dev/null

%install

export BLAS=/awips2/python/lib
export LAPACK=/awips2/python/lib

pushd . > /dev/null
cd %{_build_root}/build-python
export LD_LIBRARY_PATH=/awips2/python/lib
/awips2/python/bin/python setup.py install \
   --root=%{_build_root} \
   --prefix=/awips2/python
RC=$?
if [ ${RC} -ne 0 ]; then
   exit 1
fi
popd > /dev/null

rm -rf %{_build_root}/build-python

%clean
rm -rf %{_build_root}

%files
%defattr(644,awips,fxalpha,755)
%dir /awips2/python/lib/python2.7/site-packages
/awips2/python/lib/python2.7/site-packages/*