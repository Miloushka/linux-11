# Recipe created by recipetool
# This is the basis of a recipe and may need further editing in order to be fully functional.
# (Feel free to remove these comments when editing.)

# Unable to find any files that looked like license statements. Check the accompanying
# documentation and source headers and set LICENSE and LIC_FILES_CHKSUM accordingly.
#
# NOTE: LICENSE is being set to "CLOSED" to allow you to at least start building - if
# this is not accurate with respect to the licensing of the software being built (it
# will not be in most cases) you must specify the correct value before using this
# recipe for anything other than initial testing/development!
LICENSE = "CLOSED"
LIC_FILES_CHKSUM = ""

inherit pkgconfig update-rc.d

DEPENDS += "libgpiod (< 2.0)"

INITSCRIPT_PACKAGES = "${PN}"
INITSCRIPT_NAME:${PN} = "esme-gpio26-toggle"

# No information for SRC_URI yet (only an external source tree was specified)
SRC_URI = "git://github.com/Miloushka/linux-11.git;protocol=https;branch=scarthgap \
           file://0002-initial-version-of-gpio-program.patch \
           file://0004-install-esme-gpio26-toggle-startup-script.patch \
           file://0001-initial-commit.patch \
           file://0003-initial-version-of-esme-gpio26-toggle-startup-script.patch \
           "
SRCREV = "${AUTOREV}"

# NOTE: this is a Makefile-only piece of software, so we cannot generate much of the
# recipe automatically - you will need to examine the Makefile yourself and ensure
# that the appropriate arguments are passed in.

do_compile () {
	# You will almost certainly need to add additional arguments here
	oe_runmake
}

do_install () {
	# This is a guess; additional arguments may be required
	oe_runmake install INSTALL_DIR=${D}
}

