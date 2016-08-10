CAS客户端自定义登录页面
=======================================

概览
--------

CAS单点登录框架可以方便的搭建单点登录系统，但是CAS使用了统一的登录页面，本项目目的在于表现如何在客户端自定义登录页面。

如果想在服务端自定义登录页面，请在网上搜索一些其他教程。这里不再赘述。

CAS 4.0.0
JDK 1.6
TOMCAT 6

示例如何使用
---------

本项目一共由4个项目组成：

**cas-server-webapp** :  CAS服务端应用程序，基于官方版本改造。引用cas-server-core。<br />
**cas-client-core** : CAS客户端核心，基于官方版本改造。<br />
**cas-client-sample** : 一个简单的应用WEB程序。引用cas-client-core。<br />
**Sample** : 将以上项目直接打包的样例<br />

 1. 准备三个服务容器，并部署于3个不同的IP（域名）地址下，为方便使用，这里假定三个容器的IP地址以及端口分别为：
        192.168.243.147:8080 作为CAS服务端容器地址，简称147
        192.168.221.128:8080 作为应用web程序1的地址，简称128
        192.168.221.129:8080 作为应用web程序2的地址，简称129
 <br />`此处输入代码`
 2. 配置CAS服务端
将/Sample/casserver.war 部署到147中的TOMCAT中（/webapp/casserver.war）。casserver.war中无需进行多余的配置（已经去掉了HTTP保护限制）。
访问 http://192.168.243.147:8080/casserver/login 弹出CAS统一的登录页面，表示CAS服务端配置成功。
<br />
 3. 配置CAS客户端应用WEB程序1
将/Sample/casclient.war 部署到128中的TOMCAT中（/webapp/casclient.war）。
对casclient.war中的web.xml需要做如下配置：

 指定CAS登陆成功后客户端默认访问首页 defaultServerIndexUrl ，这里设定为 http://192.168.221.128:8080/casclient/index.jsp。

 指定CAS客户端默认登录页面 customServerLoginUrl ,这里设定为 http://192.168.221.128:8080/casclient/caslogin.jsp

 指定CAS客户端访问CAS服务端login服务地址 casServerLoginUrl，这里设定为 http://192.168.243.147:8080/casserver/login

 指定CAS客户端访问CAS服务端地址 casServerUrlPrefix ，这里设定为 http://192.168.243.147:8080/casserver

 指定CAS客户端名称（不含Context） serverName ，这里设定为 http://192.168.221.128:8080

 访问 http://192.168.221.128/casclient/index.jsp 能弹出登陆页面，说明客户端应用WEB程序1配置成功。
<br />
 4. 配置CAS客户端应用WEB程序2
 配置方法同3，将所有128地址替换为129即可。
 <br />
 5. 验证程序
 访问 http://192.168.221.128/casclient/index.jsp 显示了128的登陆页面 caslogin.jsp ,同时访问 http://192.168.221.129/casclient/index.jsp 显示了129的登录页面 caslogin.jsp 说明128 129两个客户端没有登陆。

 访问 http://192.168.221.128/casclient/index.jsp 显示128的登陆页面 caslogin.jsp。输入用户名为casuser，密码为casuser，点击登陆。如果跳转到 http://192.168.221.128/casclient/index.jsp 说明登陆成功。此时访问 http://192.168.221.129/casclient/index.jsp 并没有再跳到129的caslogin.jsp 说明单点登录成功。

如何编译
------
因为我修改了源代码，所以这里边的项目就不能用maven打包了，不过cas-client-core除外。
我把相关的每个项目需要引用的jar都放在每个项目下边的lib目录下了，然后请打开IDE然后把他们引用进去吧。


参考文章
--------
https://wiki.jasig.org/display/CAS/Using+CAS+without+the+CAS+login+screen

联系我
-----------------
Email: ymxbtbu@163.com
