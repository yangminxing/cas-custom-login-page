<%--

    Licensed to Jasig under one or more contributor license
    agreements. See the NOTICE file distributed with this work
    for additional information regarding copyright ownership.
    Jasig licenses this file to you under the Apache License,
    Version 2.0 (the "License"); you may not use this file
    except in compliance with the License.  You may obtain a
    copy of the License at the following location:

      http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.

--%>
<%
    /**
     * Description：
     *    Based on the original login page source.
     */
%>

<%
  String auto=request.getParameter("auto");
  String customLogin=request.getParameter("customLogin");

  if(auto!=null&&auto.equals("true"))
  {
    /**
     * When you view the client custom login page and submit your parameter to the CAS server, the login request would be received here.
     */
    %>
    <html>
    <head>
      <script language="javascript">
        function doAutoLogin()
        {
          document.forms[0].submit();
        }
      </script>
    </head>
    <body onload="doAutoLogin()">
    <form id="credentials" method="POST" action="<%=request.getContextPath()%>/login?service=<%=request.getParameter("service")%>">
      <input type="hidden" name="lt" value="${loginTicket}" />
      <input type="hidden" name="execution" value="${flowExecutionKey}" />
      <input type="hidden" name="_eventId" value="submit" />
      <input type="hidden" name="username" value="<%=request.getParameter("username")%>" />
      <input type="hidden" name="password" value="<%=request.getParameter("password")%>" />
      <input type="hidden" name="login_form" value="<%=request.getParameter("login_form")%>" />
      <input type="hidden" name="rememberMe" value="true" />
      <input type="submit" value="Submit" style="visibility: hidden" />
    </form>
    </body>
    </html>

    <%
}
else if(customLogin!=null&&customLogin.equals("custom"))
{
  /**
   * When you view any CAS client page ( except caslogin.jsp ), if the request contains 'custom' parameter, request would be received here.
   * The function of this part is to redirected to the client custom login page. The reason that I don't put this function at client is
   * that when the client's 'doFilter()' is called, the client must verify you have logged in firstly instead of redirecting to custom login
   * page.
   * So assume you are first time to visit a CAS client. Then client would find there is no session or any other taken, and client would request
   * to CAS server login action with parameter 'custom'. The CAS server would receive the request, and redirect to client custom login page which
   * is defined in request parameter 'service'. After that, if you want to login an other CAS client which use the same CAS server. The client's
   * 'doFilter()' would be called again, while in this time the CAS server would find you have logged, and redirect to the client with token directly
   * rather than call the current casLoginView.jsp.
   */

  response.sendRedirect(request.getParameter("customLoginPage")+"?service="+request.getParameter("service"));
%>

<%
}
else
{
  /**
   * Generic login.
   */

%>
<jsp:directive.include file="includes/top.jsp" />

<c:if test="${not pageContext.request.secure}">
  <div id="msg" class="errors">
    <h2>Non-secure Connection</h2>
    <p>You are currently accessing CAS over a non-secure connection.  Single Sign On WILL NOT WORK.  In order to have single sign on work, you MUST log in over HTTPS.</p>
  </div>
</c:if>

<div class="box" id="login">
  <form:form method="post" id="fm1" commandName="${commandName}" htmlEscape="true">

    <form:errors path="*" id="msg" cssClass="errors" element="div" htmlEscape="false" />

    <h2><spring:message code="screen.welcome.instructions" /></h2>

    <section class="row">
      <label for="username"><spring:message code="screen.welcome.label.netid" /></label>
      <c:choose>
        <c:when test="${not empty sessionScope.openIdLocalId}">
          <strong>${sessionScope.openIdLocalId}</strong>
          <input type="hidden" id="username" name="username" value="${sessionScope.openIdLocalId}" />
        </c:when>
        <c:otherwise>
          <spring:message code="screen.welcome.label.netid.accesskey" var="userNameAccessKey" />
          <form:input cssClass="required" cssErrorClass="error" id="username" size="25" tabindex="1" accesskey="${userNameAccessKey}" path="username" autocomplete="off" htmlEscape="true" />
        </c:otherwise>
      </c:choose>
    </section>

    <section class="row">
      <label for="password"><spring:message code="screen.welcome.label.password" /></label>
        <%--
        NOTE: Certain browsers will offer the option of caching passwords for a user.  There is a non-standard attribute,
        "autocomplete" that when set to "off" will tell certain browsers not to prompt to cache credentials.  For more
        information, see the following web page:
        http://www.technofundo.com/tech/web/ie_autocomplete.html
        --%>
      <spring:message code="screen.welcome.label.password.accesskey" var="passwordAccessKey" />
      <form:password cssClass="required" cssErrorClass="error" id="password" size="25" tabindex="2" path="password"  accesskey="${passwordAccessKey}" htmlEscape="true" autocomplete="off" />
    </section>

    <section class="row check">
      <input id="warn" name="warn" value="true" tabindex="3" accesskey="<spring:message code="screen.welcome.label.warn.accesskey" />" type="checkbox" />
      <label for="warn"><spring:message code="screen.welcome.label.warn" /></label>
    </section>

    <section class="row btn-row">
      <input type="hidden" name="lt" value="${loginTicket}" />
      <input type="hidden" name="execution" value="${flowExecutionKey}" />
      <input type="hidden" name="_eventId" value="submit" />

      <input class="btn-submit" name="submit" accesskey="l" value="<spring:message code="screen.welcome.button.login" />" tabindex="4" type="submit" />
      <input class="btn-reset" name="reset" accesskey="c" value="<spring:message code="screen.welcome.button.clear" />" tabindex="5" type="reset" />
    </section>
  </form:form>
</div>

<div id="sidebar">
  <div class="sidebar-content">
    <p><spring:message code="screen.welcome.security" /></p>

    <div id="list-languages">
      <%final String queryString = request.getQueryString() == null ? "" : request.getQueryString().replaceAll("&locale=([A-Za-z][A-Za-z]_)?[A-Za-z][A-Za-z]|^locale=([A-Za-z][A-Za-z]_)?[A-Za-z][A-Za-z]", "");%>
      <c:set var='query' value='<%=queryString%>' />
      <c:set var="xquery" value="${fn:escapeXml(query)}" />

      <h3>Languages:</h3>

      <c:choose>
        <c:when test="${not empty requestScope['isMobile'] and not empty mobileCss}">
          <form method="get" action="login?${xquery}">
            <select name="locale">
              <option value="en">English</option>
              <option value="es">Spanish</option>
              <option value="fr">French</option>
              <option value="ru">Russian</option>
              <option value="nl">Nederlands</option>
              <option value="sv">Svenska</option>
              <option value="it">Italiano</option>
              <option value="ur">Urdu</option>
              <option value="zh_CN">Chinese (Simplified)</option>
              <option value="zh_TW">Chinese (Traditional)</option>
              <option value="de">Deutsch</option>
              <option value="ja">Japanese</option>
              <option value="hr">Croatian</option>
              <option value="cs">Czech</option>
              <option value="sl">Slovenian</option>
              <option value="pl">Polish</option>
              <option value="ca">Catalan</option>
              <option value="mk">Macedonian</option>
              <option value="fa">Farsi</option>
              <option value="ar">Arabic</option>
              <option value="pt_PT">Portuguese</option>
              <option value="pt_BR">Portuguese (Brazil)</option>
            </select>
            <input type="submit" value="Switch">
          </form>
        </c:when>
        <c:otherwise>
          <c:set var="loginUrl" value="login?${xquery}${not empty xquery ? '&' : ''}locale=" />
          <ul>
            <li class="first"><a href="${loginUrl}en">English</a></li>
            <li><a href="${loginUrl}es">Spanish</a></li>
            <li><a href="${loginUrl}fr">French</a></li>
            <li><a href="${loginUrl}ru">Russian</a></li>
            <li><a href="${loginUrl}nl">Nederlands</a></li>
            <li><a href="${loginUrl}sv">Svenska</a></li>
            <li><a href="${loginUrl}it">Italiano</a></li>
            <li><a href="${loginUrl}ur">Urdu</a></li>
            <li><a href="${loginUrl}zh_CN">Chinese (Simplified)</a></li>
            <li><a href="${loginUrl}zh_TW">Chinese (Traditional)</a></li>
            <li><a href="${loginUrl}de">Deutsch</a></li>
            <li><a href="${loginUrl}ja">Japanese</a></li>
            <li><a href="${loginUrl}hr">Croatian</a></li>
            <li><a href="${loginUrl}cs">Czech</a></li>
            <li><a href="${loginUrl}sl">Slovenian</a></li>
            <li><a href="${loginUrl}ca">Catalan</a></li>
            <li><a href="${loginUrl}mk">Macedonian</a></li>
            <li><a href="${loginUrl}fa">Farsi</a></li>
            <li><a href="${loginUrl}ar">Arabic</a></li>
            <li><a href="${loginUrl}pt_PT">Portuguese</a></li>
            <li><a href="${loginUrl}pt_BR">Portuguese (Brazil)</a></li>
            <li class="last"><a href="${loginUrl}pl">Polish</a></li>
          </ul>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</div>

<jsp:directive.include file="includes/bottom.jsp" />
<%}%>