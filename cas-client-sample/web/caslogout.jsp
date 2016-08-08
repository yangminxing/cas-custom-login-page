<%
    /**
     * When you need logout, just redirect to this page. (a href or some others)
     * The attributes added to the request via filter.
     */
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  Object casServerLoginUrl=request.getAttribute("casServerLogoutUrl");
  Object customServerLoginUrl=request.getAttribute("customServerLoginUrl");
  if(casServerLoginUrl!=null && customServerLoginUrl!=null)
  {
    response.sendRedirect(casServerLoginUrl.toString()+"?service="+customServerLoginUrl);
  }
%>
