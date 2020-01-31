FROM ubuntu:latest

ENV PACKAGES="apt-transport-https build-essential ca-certificates curl gnupg iptables lxc pigz python python-setuptools"
ENV DUMBINIT_VER="1.2.2"
ENV DOCKERMACHINE_VER="0.16.1"

# установка docker и GitLab Runner
RUN apt-get update && apt-get install -y --no-install-recommends ${PACKAGES} \
    && echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" > \
                /etc/apt/sources.list.d/docker.list \
    && echo "deb https://packages.gitlab.com/runner/gitlab-ci-multi-runner/ubuntu/ bionic main" > \
                /etc/apt/sources.list.d/runner_gitlab-ci-multi-runner.list \
    && curl -L --progress-bar --compressed "https://download.docker.com/linux/ubuntu/gpg" | apt-key add - \
    && curl -L --progress-bar --compressed "https://packages.gitlab.com/runner/gitlab-ci-multi-runner/gpgkey" | apt-key add - \
    && apt-get update && apt-get install -y --no-install-recommends cdebootstrap docker-ce gitlab-ci-multi-runner \
        && mkdir -p /etc/gitlab-runner/certs \
        && chmod -R 700 /etc/gitlab-runner \
# установка dumb-init
    && curl -L --progress-bar --compressed "https://github.com/Yelp/dumb-init/releases/download/v${DUMBINIT_VER}/dumb-init_${DUMBINIT_VER}_amd64" -o "/usr/bin/dumb-init" \
        && chmod +x /usr/bin/dumb-init \
# установка docker-machine
    && curl -L --progress-bar --compressed "https://github.com/docker/machine/releases/download/v${DOCKERMACHINE_VER}/docker-machine-Linux-x86_64" -o "/usr/bin/docker-machine" \
        && chmod +x /usr/bin/docker-machine \
# очистка
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* CHANGELOG.md LICENSE README.md 

# установка rancher-gitlab-deploy
COPY . /rancher-gitlab-deploy
WORKDIR /rancher-gitlab-deploy
RUN python /rancher-gitlab-deploy/setup.py install \
        && ln -s /usr/local/bin/rancher-gitlab-deploy /usr/local/bin/upgrade \
        && rm -rf setup.py rancher_gitlab_deploy/ rancher_gitlab_deploy.egg-info build/ dist/ 

COPY wrapdocker.sh /
RUN chmod +x /wrapdocker.sh \
    && usermod -aG docker gitlab-runner

VOLUME ["/etc/gitlab-runner", "/home/gitlab-runner", "/var/lib/docker"]
ENTRYPOINT ["/usr/bin/dumb-init", "/wrapdocker.sh"]
CMD ["/usr/bin/dumb-init", "gitlab-runner", "run", "--user=gitlab-runner", "--working-directory=/home/gitlab-runner"]