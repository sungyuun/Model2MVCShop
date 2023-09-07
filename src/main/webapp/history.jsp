<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
	<style>
		div {
			 border: 1px solid grey;
			 float: left; 
			 width: auto;
		}
	</style>
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
	$(document).ready(function(){
		
		$("div").on("click",function(){
			var prodNo = $(this).find("input[name='prodNo']").val();
			var prodName = $(this).find("h3").text();
			self.location = "/product/getProduct?prodName="+prodName+"&prodNo="+prodNo+"&menu=search"
		});
	});
	</script>
<title>열어본 상품 보기</title>

</head>
<body>
	<h1>최근 본 목록</h1>
	<c:forEach var="product" items="${list}">
		<c:set var="i" value="${i+1}" />
		<div>
			<table>
				<tr class="ct_list_pop">
					<img src="/getImages/${product.fileName}" width="200" height="200" align="absmiddle"/>
			
				</tr>
				<tr>
					<td><h3>${product.prodName}</h3></td>
					<td style="text-align: right;"><h4>${product.price}원</h4></td>
					<input type="hidden" name="prodNo" value="${product.prodNo}"/>
				</tr>	
			</table>
		</div>
		</c:forEach>
		
	
<br>
<br>	

	<!-- 
	<c:if test="${cookie['history'] ne null}">
		<c:set var="h" value="${fn:split(cookie['history'].value,'S')}"/>
		<c:forEach var="i" items="${h}">
			<c:if test="${i ne 'null'}">
				<a href="/getProduct.do?prodNo=${i}&menu=search" target="rightFrame">${i}</a>
				<br>
			</c:if>
		</c:forEach>
	</c:if>
	 -->
</body>
</html>