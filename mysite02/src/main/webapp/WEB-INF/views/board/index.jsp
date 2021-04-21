<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>mysite</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link href="${pageContext.request.contextPath }/assets/css/board.css"
	rel="stylesheet" type="text/css">
</head>
<body>
	<div id="container">
		<c:import url='/WEB-INF/views/includes/header.jsp' />
		<div id="content">
			<div id="board">
				<form id="search_form" action="${pageContext.request.contextPath }/board" method="post">
					<input type="text" id="search" name="search" value="${search }"> 
					<input type="submit" value="찾기">
				</form>

				<table class="tbl-ex">
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>글쓴이</th>
						<th>조회수</th>
						<th>작성일</th>
						<th>&nbsp;</th>
					</tr>
					<c:set var="count" value="${fn:length(list) }" />
					<c:forEach items="${list }" var="vo" varStatus="status">
						<tr>
							<td>${count-status.index }</td>
							<td><a href="${pageContext.request.contextPath }/board?a=view&no=${vo.no}" style="text-align:left; padding-left:${vo.depth * 40 }px">
									<c:if test="${vo.depth >= 1 }">
										<img src="${pageContext.request.contextPath }/assets/images/reply.png" />
									</c:if>
								${vo.title }</a></td>
							<td>${vo.name }</td>
							<td>${vo.hit_cnt }</td>
							<td>${vo.reg_date }</td>
							<c:choose>
								<c:when test="${!empty authUser && authUser.no == vo.userNo }">
									<td><a
										href="${pageContext.request.contextPath }/board?a=delete&no=${vo.no}"
										class="del">삭제</a></td>
								</c:when>
								<c:otherwise>
									<td>&nbsp;</td>
								</c:otherwise>
							</c:choose>
						</tr>
					</c:forEach>
				</table>

				<!-- pager 추가 -->
				<!-- 이전페이지/다음페이지를 추가하기 위해서 페이징체크처리 -->
				<!-- 미리 계산한 데이터를 map에 저장해서 내려주기 -->
				<div class="pager">
					<ul>
						<c:if test="${pageVo.nowPage > pageVo.cntPage/2 + 1 }">
							<li><a href="${pageContext.request.contextPath }/board">◀</a></li>
						</c:if>
						<c:forEach begin="${pageVo.firstPageInCurrentPageGroup }" end="${pageVo.lastPageInCurrentPageGroup }" var="i" step="1">
							<c:choose>
								<c:when test="${i == pageVo.nowPage }">
									<li class="selected"><a id="link" href="${pageContext.request.contextPath }/board?p=${i }&search=${search }">${i }</a></li>	
								</c:when>
								<c:otherwise>
									<li><a id="link" href="${pageContext.request.contextPath }/board?p=${i }&search=${search }">${i }</a></li>	
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if test="${pageVo.lastPage > 5 && pageVo.nowPage != pageVo.lastPage }">
							<li><a href="${pageContext.request.contextPath }/board?p=${pageVo.lastPage}">▶</a></li>
						</c:if>
					</ul>
				</div>
				<!-- pager 추가 -->
				<c:if test="${!empty authUser }">
					<div class="bottom">
						<a href="${pageContext.request.contextPath }/board?a=writeform"
							id="new-book">글쓰기</a>
					</div>
				</c:if>
			</div>
		</div>
		<c:import url='/WEB-INF/views/includes/navigation.jsp' />
		<c:import url='/WEB-INF/views/includes/footer.jsp' />
	</div>
	href="http://localhost:8080/mysite02/index1.jsp"
	src="http://naver.com.jpg"
</body>
</html>