#!/bin/sh

exec ./bin/cmak -Dconfig.file=${KM_CONFIGFILE} "${@}"
