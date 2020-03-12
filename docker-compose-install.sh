# Install docker-compose
LIST=$( git ls-remote https://github.com/docker/compose | grep "refs/tags" | grep -oP "[0-9]+(\.[0-9]+)+$" )
VERSION=""
while [ $( echo "${LIST}" | wc -l ) -gt 1 ]
do
    DIGIT=$( echo "${LIST}" | grep -oP "^[0-9]+" | sort -g | tail -n 1 )
    VERSION="${VERSION}"."${DIGIT}"
    LIST=$( echo "${LIST}" | sed -e "/^${DIGIT}/!d" -e "s/^${DIGIT}.//" )
done
VERSION=$( echo "${VERSION}" | sed "s/^\.//" )

sudo sh -c "curl -L https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose"
sudo chmod +x /usr/local/bin/docker-compose
sudo sh -c "curl -L https://raw.githubusercontent.com/docker/compose/${VERSION}/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose"
