CAS Custom Client Login Page
=======================================

Overview
--------

CAS( Central Authentication Service ) is a open source project that could help you to make a simple single sign on web
application. However CAS use an uniform login page on the CAS server rather than a login page on the CAS client.
How to custom a client login page is this project's purpose.

Please find some other tutorials if you want to custom a login page on the CAS server. It's not should be too hard.

CAS 4.0.0
JDK 1.6
TOMCAT 6

How to use
---------

This project mainly includes five parts:

**cas-server-core** : The core of CAS server based on official version.
**cas-server-webapp** : The web application of CAS server this reference the server core. It is also based on official version.
**cas-client-core** : The core of CAS client based on official version.
**cas-client-sample** : A simple web application as CAS client reference the client core.
**sample** : The demo that I packaged the cas-server-webapp  and cas-client-sample.

 1.You need three web containers with three different ip address. Assume these addresses are:
        192.168.243.147:8080 as CAS server. 147 for short.
        192.168.221.128:8080 as CAS client. 128 for short.
        192.168.221.129:8080 as an other CAS client. 129 for short.
 <br />
 2.Deploy CAS server
 Deploy /sample/casserver.war (In this project) to the tomcat at 147. Then view the page (http://192.168.243.147:8080/casserver/login).
 If you see the CAS style login page, it mains you deploy CAS server successfully. No need more configures in CAS server web application.
<br />
 3.Deploy CAS client at 128
 Deploy /sample/casclient.war to the tomcat at 128. Then some changes are to be needed.

 Open the web.xml in the casclient.war.

 Config the default client index page after logged in successfully.
 The key is 'defaultServerIndexUrl', the value is 'http://192.168.221.128:8080/casclient/index.jsp'

 Config the default client login page if you are not logged in the server.
 The key is 'customServerLoginUrl', the value is 'http://192.168.221.128:8080/casclient/caslogin.jsp'

 Config the CAS server login address for CAS client.
 The key is 'casServerLoginUrl', the value is 'http://192.168.243.147:8080/casserver/login'

 Config the CAS server address for CAS client.
 This key is 'casServerUrlPrefix', the value is 'http://192.168.243.147:8080/casserver'

 Config the server name for the CAS client.
 The key is 'serverName', the value is 'http://192.168.221.128:8080'

 View the page 'http://192.168.221.128/casclient/index.jsp'. If you see the custom login page( caslogin.jsp ), It
  mains you set the CAS client successfully.
<br />
 4.Deploy CAS client at 129
 Deploy /sample/casclient.war to the tomcat at 128. The changes in web.xml are same to the STEP 3, you just need to
 replace '128' to '129'.
 <br />
 5. Verify
 View 'http://192.168.221.128/casclient/index.jsp' , your see the custom login page in 128.
 View 'http://192.168.221.129/casclient/index.jsp' , your see the custom login page in 129.
 Return to the 128 custom login page, login in with 'casuser' as username and 'casuser' as password.
 Then the browser will redirect to the 'http://192.168.221.128/casclient/index.jsp'.
 View 'http://192.168.221.129/casclient/index.jsp', then you will find you could see the index page rather than
 the 129 custom login page.

Reference
--------
https://wiki.jasig.org/display/CAS/Using+CAS+without+the+CAS+login+screen

Contract Me
-----------------
Email: ymxbtbu@163.com