<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<html>
<head>
<meta charset="EUC-KR">
<title>
	
</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">

	function fncGetProductList(currentPage) {
		//document.getElementById("currentPage").value = currentPage;
		$("#currentPage").val(currentPage)
		
	   	//document.detailForm.submit();
		$("form").attr("method" , "POST").attr("action" , "/product/listProduct").submit();
	}
	//===========================================//
	//==> 추가된부분 : "검색" ,  userId link  Event 연결 및 처리
	 $(function() {
	 
		 $( "td.ct_btn01:contains('검색')" ).on("click" , function() {
			fncGetProductList(1);
		});
		
		$(".ct_list_pop:nth-child(n)").hover(function(){
			$(this).css("background-color","#CCE1FF");
		}, function() {
	
			$(this).css("background-color","#ffffff");
	
		});
		
		$( ".ct_list_pop:nth-child(n)" ).on("click" , function() {
				//self.location ="/product/getProduct?prodNo="+$(this).find("td:eq(1)").text().trim();
				var anchorElement = $(this).find("td:eq(2) a");
				var prodNo = anchorElement.attr("href").match(/prodNo=(\d+)/)[1]; // prodNo 추출
				self.location ="/product/getProduct?prodNo="+prodNo;
		});
		
		$("#searchInput").autocomplete({
			source: ${totalProductName},
			focus : function(event, ui) { 
				return false;
			},
			minLength: 2,
			delay: 100
		});
		
		//console.log("${totalProductName}");
	
	
	//==> 아래와 같이 정의한 이유는 ??
	//==> 아래의 주석을 하나씩 풀어 가며 이해하세요.					
	$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
	//console.log ( $(".ct_list_pop:nth-child(1)" ).html() );
	//console.log ( $(".ct_list_pop:nth-child(2)" ).html() );
	//console.log ( $(".ct_list_pop:nth-child(3)" ).html() );
	//console.log ( $(".ct_list_pop:nth-child(4)" ).html() ); //==> ok
	//console.log ( $(".ct_list_pop:nth-child(5)" ).html() ); 
	//console.log ( $(".ct_list_pop:nth-child(6)" ).html() ); //==> ok
	//console.log ( $(".ct_list_pop:nth-child(7)" ).html() ); 
	});	
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm" action="/product/listProduct?menu=${menu}" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
						${!empty menu && menu == 'manage' ? '상품관리' : '상품목록 조회'}
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
	
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
				<option value="0" ${!empty search.searchCondition && search.searchCondition==0 ? "select" : ""}>상품번호</option>
				<option value="1" ${!empty search.searchCondition && search.searchCondition==1 ? "select" : ""}>상품명</option>
				<option value="0" ${!empty search.searchCondition && search.searchCondition==2 ? "select" : ""}>상품가격</option>
			</select>
			<input id="searchInput" type="text" name="searchKeyword" value="${search.searchKeyword}"
						class="ct_input_g" style="width:200px; height:19px" />
		</td>
		
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<!-- <a href="javascript:fncGetProductList();" value = "${search.searchKeyword}">검색</a> -->
						검색
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >전체  ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage} 페이지</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">가격</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">등록일</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">현재상태</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	<c:set var="i" value="0" />
	<c:forEach var="product" items="${list}">
		<c:set var="i" value="${i+1}" />
		<tr class="ct_list_pop">
			<td align="center">${product.rownum}</td> 
			<td></td>
				<td align="left">
				<c:choose>
					<c:when test="${!empty user.role && !empty menu && user.role == 'admin' && menu == 'manage'}">
						<c:choose>
							<c:when test="${product.proTranCode != '0'}">
								${product.prodName}
							</c:when>
							<c:otherwise>
								<a href="/product/updateProduct?prodName=${product.prodName}&prodNo=${product.prodNo}&menu=manage">${product.prodName}</a>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
							<a href="/product/getProduct?prodName=${product.prodName}&prodNo=${product.prodNo}&menu=search">${product.prodName}</a>
					</c:otherwise>
				</c:choose>
				</td>
				
			<td></td>
			<td align="left">${product.price}</td>
			<td></td>
			<td align="left">${product.manuDate}</td>
			<td></td>
			<td align="left">
				<c:choose>
				    <c:when test="${product.proTranCode == '0'}">판매중</c:when>
				    <c:when test="${menu eq 'manage'}">
				        <c:choose>
				            <c:when test="${product.proTranCode == '2'}">구매완료</c:when>
				            <c:when test="${product.proTranCode == '3'}">배송중</c:when>
				            <c:when test="${product.proTranCode == '4'}">배송완료</c:when>
				            <c:when test="${product.proTranCode == '5'}">판매완료</c:when>
				            <c:otherwise>상태 미정의</c:otherwise>
				        </c:choose>
				    </c:when>
				    <c:otherwise>재고없음</c:otherwise>
				</c:choose>
				
				<c:if test="${menu eq 'manage' && product.proTranCode eq '2'}">
					<a href="/product/updateTranCode?tranCode=3&prodNo=${product.prodNo}">배송하기</a>
				</c:if>
			</td>	
		</tr>
		<tr>
			<td colspan="11" bgcolor="D6D7D6" height="1"></td>
		</tr>	
		</c:forEach>

</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
		<input type="hidden" id="menu" name="menu" value="${menu}"/>	
    	<input type="hidden" id="currentPage" name="currentPage" value=""/>
		<jsp:include page="../common/pageNavigator.jsp">
			<jsp:param name="fileName" value="Product"/>
		</jsp:include>	
    	</td>
    	
	</tr>
</table>

<!--  페이지 Navigator 끝 -->

</form>

</div>
</body>
</html>
