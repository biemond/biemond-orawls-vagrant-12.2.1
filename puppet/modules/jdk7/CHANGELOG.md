# History

## 0.5.0
- Refactored this module so it works with puppet4

## 0.4.12
- Added urandom fixes and use notify when there is rngd configuration refresh

## 0.4.10
- urandom fix for JDK 8

## 0.4.9
- also check if the java alternatives priority is correct

## 0.4.8
- refactored the alternatives code

## 0.4.7
- urandom fix for (rngd.service ) RedHat Family >= 7

## 0.4.6
- sets keytool as defaultsss

## 0.4.5
- sets javac as default

## 0.4.4
- another typo in urandomfix

## 0.4.3
- typo in urandomfix

## 0.4.2
- cleanup code
- fixes for future parser puppet 3.7

## 0.4.0
- cryptography Extension (US export policy)

## 0.3.9
- JDK8 support and option to change the default java homes folder ( default = /usr/java )

## 0.3.8
- rsakeySizeFix parameter set true for weblogic 12.1.1 and jdk 1.7 >= version 40

## 0.3.6
- Performance fix

## 0.3.5
- Ruby escaped char warnings resolved

## 0.3.4
- Bugfix on install folder, conflicts with others modules

## 0.3.3
- updated license to Apache 2.0

## 0.3.2
- sourceParam, alternativesPriority in install7 plus formatting

## 0.3.1
- Entropy fix for low on entropy, you can configure the rngd or rng-tools service or add it to java.security

## 0.2.1
- Added SLES as O.S. plus SED and alternatives fixes

## 0.2.0
- Puppet 3.0 compatible, creates download folder
