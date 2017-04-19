# docker-sonatype-nexus-repository-oss

Dockerized [Sonatype Nexus Repository Manager OSS](https://www.sonatype.com/nexus-repository-oss) ready to use as Proxy for most common Repositories.

:bangbang: WORK IN PROGRESS :bangbang:

**:red_circle: Note:** This docker image is pre configured to run in a trusted network of a startup. 
**Security is configured loosely** so that the Nexus OSS just acts as a 'Proxy' for all repositories out in the world.
The primary focus is to safe bandwidth when downloading maven jars or docker images from the internet. 
If you care for security and want to upload artifacts - that should not be downloadable without authentication - 
to Nexus OSS, please do not use this image! You can also use the [official Docker Image](https://hub.docker.com/r/sonatype/nexus3/)

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
-----

&nbsp;

### Usage

It will use volumes for persistent storage.

**(1) Create Volumes**

```bash
docker volume create nexus-oss-home
```

&nbsp;

**(2) Create Nexus OSSInstance**

```bash
docker create \
    --rm \
    --name nexus-oss \
    -p 18085:8085 \
    -v nexus-home:/nexus-home \
    codeclou/docker-sonatype-nexus-repository-oss:3.3.0-01

docker start nexus-oss
```

 
 
&nbsp;

**(3) Start Post Configuration**


todo


-----

&nbsp;

### Maven Repository Mirror

Preconfigured remote Repositories

```
https://maven.atlassian.com/3rdparty/
https://maven.atlassian.com/public/
https://maven.atlassian.com/public-snapshot/
https://repo.spring.io/release
https://repo.spring.io/milestone
https://repo.spring.io/snapshot
https://maven.java.net/content/groups/public/
https://repo.maven.apache.org/maven2/
https://repository.apache.org/content/repositories/releases/
http://maven.jahia.org/maven2/
http://repo.jenkins-ci.org/public/
```

Put this in your `~/.m2/settings.xml`. We want our public Repository group to be accessible without authentication. 

```xml
<?xml version="1.0" encoding="UTF-8"?>
<settings xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.1.0 http://maven.apache.org/xsd/settings-1.1.0.xsd" 
    xmlns="http://maven.apache.org/SETTINGS/1.1.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <mirrors>
    <mirror>
      <mirrorOf>*</mirrorOf>
      <name>remote-repos</name>
      <id>remote-repos</id>
      <url>http://localhost:8080/repository/all/</url>      
    </mirror>
  </mirrors>
</settings>
```

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

[MIT](https://github.com/codeclou/docker-apache-archiva/blob/master/LICENSE) © [Bernhard Grünewaldt](https://github.com/clouless)
