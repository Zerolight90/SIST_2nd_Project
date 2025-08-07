<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  로그아웃은 로그인 할 때 세션에 저장한 "mvo"를 삭제!
--%>
<c:remove var="mvo" scope="session"/>
<c:remove var="kvo" scope="session"/>
<c:redirect url="/Controller?type=index"/>
