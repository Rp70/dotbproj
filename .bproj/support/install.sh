#!/usr/bin/env bash
#set -ex

VERSION=20221031
CSFPOSTD=/usr/local/include/csf/post.d

export PROJECT_DIR="$(pwd)"
if [ ! -f $PROJECT_DIR/project.env ]; then
    echo "$PROJECT_DIR/project.env not found."
    echo "Please create and customize it from the sample file $PROJECT_DIR/.bproj/sample.project.env"
    echo "This command may help: \`cp $PROJECT_DIR/.bproj/sample.project.env $PROJECT_DIR/project.env\`"
    exit
fi
set -o allexport
. $PROJECT_DIR/project.env
set +o allexport


export PROJECT_SERVICE_NAME=$PROJECT_ID


if [ `id -u` != 0 ]; then
    echo "Root or Sudo required! Please run this script under root account or SUDO."
    exit 1
fi

CMDPREFIX=""
if [ "$SUDO_USER" != '' ]; then
	CMDPREFIX="sudo "
fi
if [ "$ENVIRONMENT" = '' ] || [ "$HOST" = '' ]; then
    echo "ERROR: Please specify more environment vars! For example:
* For production: \`${CMDPREFIX}ENVIRONMENT=prod HOST=`hostname` $0\`
* For development (for SUDO account): \`${CMDPREFIX}ENVIRONMENT=dev HOST=`id -un` sudo $0\`
* For development (for name of your choice): \`${CMDPREFIX}ENVIRONMENT=dev HOST=AnyName $0\`"
    exit 1
fi
export ENVIRONMENT

ENVFILE="${ENVIRONMENT}.${HOST}.env"
if [ ! -f $PROJECT_DIR/${ENVFILE} ]; then
    echo "Please create $ENVFILE and define variables."
    echo "This command may help: \`touch $ENVFILE\`"
    exit 1
fi

if [ "$ENVIRONMENT" != 'prod' ]; then
	PROJECT_SERVICE_NAME="$PROJECT_SERVICE_NAME-$HOST"
fi

cd $(dirname $0)
SUPPORT_DIR="`pwd`"
echo "Project Name: $PROJECT_NAME"
echo "Project Path: $PROJECT_DIR"
echo "Project Service Name: $PROJECT_SERVICE_NAME"
echo "Project Support Files: $SUPPORT_DIR"
echo

if [ -f $PROJECT_DIR/project ]; then
    echo "Setting file permissions:"
    chmod -cv 0755 $PROJECT_DIR/project
    echo
fi


echo "Updating .env files:"
rm -f $PROJECT_DIR/.env
echo "${ENVIRONMENT}=1" >> $PROJECT_DIR/.env
echo "ENVIRONMENT=${ENVIRONMENT}" >> $PROJECT_DIR/.env
echo "HOST=${HOST}" >> $PROJECT_DIR/.env
chmod 0644 $PROJECT_DIR/.env
chown $SUDO_USER.$SUDO_USER $PROJECT_DIR/.env


echo "Installing systemd service:"
if [ "`systemctl is-enabled ${PROJECT_SERVICE_NAME}.service 2>/dev/null`" = 'enabled' ]; then
    systemctl disable ${PROJECT_SERVICE_NAME}.service
fi
envsubst '$PROJECT_NAME $PROJECT_DIR $PROJECT_SERVICE_NAME $PROJECT_USER $SERVICE_TYPE $ENVIRONMENT' < ./systemd.service > /etc/systemd/system/${PROJECT_SERVICE_NAME}.service
echo

echo "Activating systemd service:"
systemctl enable ${PROJECT_SERVICE_NAME}.service
echo


if [ -f $SUPPORT_DIR/firewall.sh ]; then
    echo "Linking files:"
    mkdir -p $CSFPOSTD # Make the folder in case it doesn't exist.
    ln -sfv $SUPPORT_DIR/firewall.sh $CSFPOSTD/vv_${PROJECT_SERVICE_NAME}.sh
    echo
    echo "Listing installed firewall hooks in $CSFPOSTD:"
    ls -lah $CSFPOSTD
    echo
fi

echo "Creating temp folder:"
mkdir -p $PROJECT_DIR/tmp
chmod -c 1755 $PROJECT_DIR/tmp
chown -cv $SUDO_USER.$SUDO_USER $PROJECT_DIR/tmp
echo "done"
