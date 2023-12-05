FROM gitpod/workspace-full

USER gitpod

RUN bash -c ". /home/gitpod/.sdkman/bin/sdkman-init.sh && \
    sdk install java 17.0.3-ms && \
    sdk default java 17.0.3-ms"
# RUN curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
# RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
# RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
# RUN echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
# RUN sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
# RUN kubectl version --client
