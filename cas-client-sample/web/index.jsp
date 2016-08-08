<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title></title>
  </head>
  <body>
     Login Successfully !
     <br />
     The login username is : <%=request.getRemoteUser()%>
     <br />
     <a href="caslogout.jsp">Click me to logout</a>
  </body>
</html>
