#!/bin/sh

# Save/restore the clock to/from /etc/rtctimestamp timestamp file.

echo_usage() {
	echo
	echo "Usage: ${0} <save|restore>"
	echo "Save/restore the system clock to/from a file"
	echo
}

# Save the current time to /etc/rtctimestamp
do_save() {
	date -u +%4Y%2m%2d%2H%2M%2S > /etc/rtctimestamp
}

# Restore the time from /etc/rtctimestamp if it's later than the current time
do_restore() {
	if [ -s /etc/rtctimestamp ]; then
		read TIMESTAMP < /etc/rtctimestamp
	else
		exit 0
	fi
	SYSTEMDATE=`date -u +%4Y%2m%2d%2H%2M%2S`
	# If timestamp is newer than now, update the time to it's value
	if [ ${TIMESTAMP} -gt ${SYSTEMDATE} ]; then
		# Format the timestamp as date expects it (2m2d2H2M4Y.2S)
		TS_YR=${TIMESTAMP%??????????}
		TS_SEC=${TIMESTAMP#????????????}
		TS_FIRST12=${TIMESTAMP%??}
		TS_MIDDLE8=${TS_FIRST12#????}
		date -u ${TS_MIDDLE8}${TS_YR}.${TS_SEC}
	else
		exit 2
	fi
}

##########################
# Execution Starts Here! #
##########################
if [ ! ${1} ]; then
	echo_usage
	exit 1
fi
case ${1} in
	save)
		do_save
		;;
	restore)
		do_restore
		;;
	\?)
		echo_usage
		exit 1
		;;
esac
