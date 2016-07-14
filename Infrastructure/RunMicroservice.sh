source /home/ec2-user/.bashrc

JAR_PATH=$1

if ! [[ $JAR_PATH ]]; then
	echo "Error: no argument given. Please provide a path to a .jar file ex: ./RunMicroservice.sh ~/customer.jar"
	exit 1;
fi

# find PID of the Microservice by its -Dname=$JAR_PATH
MSVC_PID="$(pgrep -f $JAR_PATH)"

if ! [[ $MSVC_PID ]]; then
	echo "Process is not running. Starting $JAR_PATH"
	java -Dname=$JAR_PATH -jar $JAR_PATH server ~/config.yml
fi
