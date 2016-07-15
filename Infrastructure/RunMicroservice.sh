if [ -f /home/$USER/.bashrc ]; then
	source /home/$USER/.bashrc
fi

# Optional path to config.yml
MSVC_CONFIG_PATH=$2

if ! [[ $MSVC_CONFIG_PATH ]]; then
	# Default path to config.yml
	MSVC_CONFIG_PATH=~/config.yml
fi

JAR_PATH=$1

if ! [[ $JAR_PATH ]]; then
	echo "Error: no argument given. Please provide a path to a .jar file ex: ./RunMicroservice.sh ~/customer.jar"
	exit 1;
fi

# Find PID of the Microservice by its $JAR_PATH
MSVC_PID="$(pgrep -f $JAR_PATH)"

if ! [[ $MSVC_PID ]]; then
	echo "Process is not running. Starting $JAR_PATH"
	java -jar $JAR_PATH server $MSVC_CONFIG_PATH
fi
