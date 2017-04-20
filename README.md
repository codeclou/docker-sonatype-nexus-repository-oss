# docker-sonatype-nexus-repository-oss

[![](https://codeclou.github.io/doc/badges/generated/docker-image-size-500.svg?v2)](https://hub.docker.com/r/codeclou/docker-sonatype-nexus-repository-oss/tags/) [![](https://codeclou.github.io/doc/badges/generated/docker-from-alpine-3.5.svg)](https://alpinelinux.org/) [![](https://codeclou.github.io/doc/badges/generated/docker-run-as-non-root.svg)](https://docs.docker.com/engine/reference/builder/#/user)

Dockerized [Sonatype Nexus Repository Manager OSS](https://www.sonatype.com/nexus-repository-oss) ready to use as Proxy for most common Repositories.

-----

&nbsp;

### Prerequisites

 * Runs as non-root with fixed UID 10777 and GID 10777. See [howto prepare volume permissions](https://github.com/codeclou/doc/blob/master/docker/README.md).
 * See [howto use SystemD for named Docker-Containers and system startup](https://github.com/codeclou/doc/blob/master/docker/README.md).
 * You need Linux at best.
 * Latest Docker version must be installed.

-----

&nbsp;

### Initial Configuration

**(1) Add hostname alias**

Add the alias on your Docker-Host machine. Or configure a valid hostname in your DNS.

```bash
sudo su
echo "127.0.0.1  nexus-oss" >> /etc/hosts
```

**(2) Prepare the shared volume directory**

```bash
sudo su
mkdir /opt/nexus-oss-home
chown 10777:10777 /opt/nexus-oss-home
```

-----

&nbsp;

### Usage

**(1) Create Nexus OSS Instance**

```bash
docker create \
    --name nexus \
    -p 8333:8333 \
    -v /opt/nexus-oss-home:/nexus-home \
    codeclou/docker-sonatype-nexus-repository-oss:3.3.0-01

docker start nexus
```

 
 
&nbsp;

**(2) Start Post Configuration**

Now go to **[http://localhost:8333/](http://localhost:8333/)** and log in as `admin` with password `admin123`.

Configure the Instance to your liking.


-----

&nbsp;

### Trademarks and Third Party Licenses

 * **Sonatype Nexus OSS**
   * Sonatype and Sonatype Nexus are trademarks of [Sonatype, Inc](https://www.sonatype.org/).
   * Sonatype Nexus OSS is licensed under the [Eclipse Public License 1.0](https://github.com/sonatype/nexus-public/blob/master/LICENSE.txt).
 * **Apache Maven**
   * Apache Maven and Maven are trademarks of the [Apache Software Foundation](http://www.apache.org/).
 * **Oracle Java JDK 8**
   * Oracle and Java are registered [trademarks of Oracle](https://www.oracle.com/legal/trademarks.html) and/or its affiliates. Other names may be trademarks of their respective owners.
   * Please check yourself for corresponding Licenses and Terms of Use at [www.oracle.com](https://www.oracle.com/).
 * **Docker**
   * Docker and the Docker logo are trademarks or registered [trademarks of Docker](https://www.docker.com/trademark-guidelines), Inc. in the United States and/or other countries. Docker, Inc. and other parties may also have trademark rights in other terms used herein.
   * Please check yourself for corresponding Licenses and Terms of Use at [www.docker.com](https://www.docker.com/).
 * **Ubuntu**
   * Ubuntu and Canonical are registered [trademarks of Canonical Ltd.](https://www.ubuntu.com/legal/short-terms)
 * **Apple**
   * macOS®, Mac and OS X are [trademarks of Apple Inc.](http://www.apple.com/legal/intellectual-property/trademark/appletmlist.html), registered in the U.S. and other countries.
   
-----

&nbsp;

### License

[MIT](https://github.com/codeclou/docker-sonatype-nexus-repository-oss/blob/master/LICENSE) © [Bernhard Grünewaldt](https://github.com/clouless)
