# This script will create the Windows Bootstrapper (Setup.exe) for the CAVE msi installer.

if ( Test-Path "${A2_WIX_PROJECT_DIR}\bin\Debug\AWIPS_II_CAVE.msi" ) {
    Remove-Item -force "${A2_WIX_PROJECT_DIR}\bin\Debug\AWIPS_II_CAVE.msi"
    if ($? -ne $true) { EXIT 1; }
}

# Rename the WiX-generated msi installer.
Rename-Item -path "${A2_WIX_PROJECT_DIR}\bin\Debug\AWIPS II CAVE.msi" -newname AWIPS_II_CAVE.msi -force
if ($? -ne $true) { EXIT 1; }

pushd .

# Use iexpress to create the bootstrapper.
cd ${IEXPRESS_EXE_DIR}
.\iexpress.exe ${A2_STAGING_DIR}\AWIPS_II_CAVE.SED /N | Out-Host
if ($? -ne $true) { EXIT 1; }

popd