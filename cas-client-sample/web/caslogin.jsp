<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login Page</title>
</head>
<body>
  Login Page

  <form method="GET" action="<%=request.getAttribute("casServerLoginUrl")%>">
    <p>Username : <input type="text" name="username" /></p>
    <p>Password : <input type="password" name="password" /></p>
    <p><input type="submit" value="Login" /></p>
    <input type="hidden" name="auto" value="true" />
    <input type="hidden" name="service" value="<%=request.getParameter("service")==null?
                                                  request.getAttribute("defaultServerIndexUrl"):
                                                  request.getParameter("service")%>" />
  </form>
</body>
</html>
