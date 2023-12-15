<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ Register</title>
</head>
<body>
<sec:authentication property="principal.mvo.memEmail" var="authEmail" />
<jsp:include page="../common/header.jsp" />
<div class="bodyContainer">

<form action="/faq/register" method="post">
	<input type="hidden" name="faqEmail" value="${authEmail }">
	
	<input type="text" name="faqTitle" placeholder="제목을 입력해 주세요" required="required">
	
	<select name="faqCategory">
		<option value="이용문의">이용문의</option>
		<option value="거래문의">거래문의</option>
		<option value="회원/계정">회원/계정</option>
		<option value="운영정책">운영정책</option>
		<option value="기타">기타</option>
	</select>
	
	<textarea name="faqContent" id="dynamicTextarea" placeholder="내용 입력" required="required"></textarea>
	
	<button type="submit">작성하기</button>
</form>

</div>
<!-- 여기까지 bodyContainer -->
<jsp:include page="../common/footer.jsp" />

<script type="text/javascript" src="/resources/js/abjustTextareaRows.js"></script>
</body>
</html>