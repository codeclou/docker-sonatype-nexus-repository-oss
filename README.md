# docker-apache-archiva

Dockerized Apache Archiva™ ready to use as Proxy for most common Repositories.

:bangbang: WORK IN PROGRESS :bangbang:

The Docker Image comes with the following predefined remote repositories, and a repository group called `all`
which acts as a mirror for everything. 

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

Put this in your `~/.m2/settings.xml`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<settings xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.1.0 http://maven.apache.org/xsd/settings-1.1.0.xsd" xmlns="http://maven.apache.org/SETTINGS/1.1.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <mirrors>
    <mirror>
      <mirrorOf>*</mirrorOf>
      <name>remote-repos</name>
      <id>remote-repos</id>
      <url>http://localhost:8080/repository/all/</url>      
    </mirror>
  </mirrors>
  <servers>
    <server>
      <id>remote-repos</id>
      <username>admin</username>
      <password>admin1</password>
    </server>
  </servers>
</settings>
```

Start up Container

```bash
docker volume create archiva-home
docker run \
    --name archiva \
    --tty \
    -p 8080:8080 \
    -v archiva-home:/archiva-home \
    codeclou/docker-apache-archiva:2.2.1
```

Now go to http://localhost:8080 and configure user `admin` with password `admin1`

-----

&nbsp;

### Trademarks and Third Party Licenses

 * **Apache Archiva™**
   * Apache Archiva, Archiva, Apache, the Apache feather logo, and the Apache Archiva project logos are [trademarks of The Apache Software Foundation](https://www.apache.org/).
   * It is licensed under the [Apache License](http://www.apache.org/licenses/).
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
