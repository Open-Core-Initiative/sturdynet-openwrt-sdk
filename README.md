<p  align="center">

<img  src="https://github.com/Open-Core-Initiative/sturdynet-openwrt-sdk/assets/41849970/fb7cb650-82fa-47ae-842f-fadec816c229">

</p>

---

## Repository Contents

| File                       | Description                                         |
| :------------------------ | :-------------------------------------------------------- |
| `scripts/add-custom-local-feed.sh` | This file adds the custom feed directory into package feeds available in SDK.        |
| `scripts/generate-repository.sh` | Copy the public key, packages, etc. into the directory to publish them.        |
| `scripts/install-custom-feed-packages.sh` | Install sources of all packages from the custom feed into SDK.        |
| `scripts/make-custom-feed-packages.sh` | Compile and build all packages from the custom feed in SDK into the SDK bin output directory.        |
| `scripts/make-index.sh` | The private and public key pair will be generated if the private key file does not exist.        |
| `scripts/make.sh` | Execute make in the SDK home directory with given arguments.        |
| `scripts/reconfigure.sh` | Reconfigure SDK to disable the build of all target-specific packages, all kernel module packages, and all userspace packages, and enable the remaining (custom) packages built as modules by default.        |
| `Dockerfile` | This file will be used to create a docker image of our imagebuilder.        |
| `.github/workflows/main.yml` | Yaml file used by GitHub action to build images.        |

---

## Prerequisites

1. Github Runner assigned to the project. A runner needs to be running Ubuntu and has Docker installed. You can learn about self-hosted runners [here](#how-to-setup-a-self-hosted-github-runner).
2. Link to Openwrt SDK `.tar.xz` file.
3. Dockerhub Account

---

## Link the Dockerhub account with the repository

1. Open [Dockerhub](https://hub.docker.com/), go to `Account Settings` -> `Security` -> `New Access Token`.
2. Go to Github Repository setting -> `Actions secrets and variables`. Add the following two secrets:

    | File                       | Description                                         |
    | :------------------------ | :-------------------------------------------------------- |
    | `DOCKERHUB_USERNAME` | Username of your Dockerhub account.        |
    | `DOCKERHUB_TOKEN` | Access token generated from your Dockerhub account.        |

3. Done.

---

## How to dockerize your SDK?

1. Open `Dockerfile` and change `SDK_URL` to your SDK file link.
2. Change `SDK_NAME` to your file name.
3. Change the following env variables to match your Imagebuilder details:

            ENV \
            OPENWRT_ARCH="${OPENWRT_ARCH:-YOUR_ARCHITECTURE}" \
            OPENWRT_GCC="${OPENWRT_GCC:-YOUR_GCC}" \
            OPENWRT_HOST="${OPENWRT_HOST:-YOUR_HOST}" \
            OPENWRT_TARGET="${OPENWRT_TARGET:-YOUR_TARGET}" \
            OPENWRT_SUBTARGET="${OPENWRT_SUBTARGET:-YOUR_SUBTARGET}" \
            OPENWRT_VERSION="${OPENWRT_VERSION:-YOUR_VERSION}"

4. Go to `.github/workflows/main.yml` file and change the following name to your intended docker image name:


       - run: sudo docker image build --file=Dockerfile --pull --tag=${{ secrets.DOCKERHUB_USERNAME }}/YOUR_DOCKER_IMAGE_NAME:YOUR_DOCKER_TAG .
       - run: sudo docker push "${{ secrets.DOCKERHUB_USERNAME }}/YOUR_DOCKER_IMAGE_NAME:YOUR_DOCKER_TAG"

---

## How to setup a self-hosted Github runner?

To create a self-hosted runner for this project we need to have a Ubuntu running instance with [Docker installed](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository). AWS EC2 instance recommended.

1. Go to the Github repository setting -> `Actions` -> `Runners` -> `New self-hosted runner`.
2. Follow the steps for `Linux`
3. In your Ubuntu instance terminal, run `sudo ./svc.sh install`
4. Give access to docker, run `sudo usermod -a -G docker <GITHUB_RUNNER_USER>`
5. Run `sudo ./svc.sh start`
