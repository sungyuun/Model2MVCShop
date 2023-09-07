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
	//==> �߰��Ⱥκ� : "�˻�" ,  userId link  Event ���� �� ó��
	 $(function() {
	 
		 $( "td.ct_btn01:contains('�˻�')" ).on("click" , function() {
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
				var prodNo = anchorElement.attr("href").match(/prodNo=(\d+)/)[1]; // prodNo ����
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
	
	
	//==> �Ʒ��� ���� ������ ������ ??
	//==> �Ʒ��� �ּ��� �ϳ��� Ǯ�� ���� �����ϼ���.					
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
						${!empty menu && menu == 'manage' ? '��ǰ����' : '��ǰ��� ��ȸ'}
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
				<option value="0" ${!empty search.searchCondition && search.searchCondition==0 ? "select" : ""}>��ǰ��ȣ</option>
				<option value="1" ${!empty search.searchCondition && search.searchCondition==1 ? "select" : ""}>��ǰ��</option>
				<option value="0" ${!empty search.searchCondition && search.searchCondition==2 ? "select" : ""}>��ǰ����</option>
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
						<!-- <a href="javascript:fncGetProductList();" value = "${search.searchKeyword}">�˻�</a> -->
						�˻�
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
		<td colspan="11" >��ü  ${resultPage.totalCount} �Ǽ�, ���� ${resultPage.currentPage} ������</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��ǰ��</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">�������</td>	
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
				    <c:when test="${product.proTranCode == '0'}">�Ǹ���</c:when>
				    <c:when test="${menu eq 'manage'}">
				        <c:choose>
				            <c:when test="${product.proTranCode == '2'}">���ſϷ�</c:when>
				            <c:when test="${product.proTranCode == '3'}">�����</c:when>
				            <c:when test="${product.proTranCode == '4'}">��ۿϷ�</c:when>
				            <c:when test="${product.proTranCode == '5'}">�ǸſϷ�</c:when>
				            <c:otherwise>���� ������</c:otherwise>
				        </c:choose>
				    </c:when>
				    <c:otherwise>������</c:otherwise>
				</c:choose>
				
				<c:if test="${menu eq 'manage' && product.proTranCode eq '2'}">
					<a href="/product/updateTranCode?tranCode=3&prodNo=${product.prodNo}">����ϱ�</a>
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

<!--  ������ Navigator �� -->

</form>

</div>
</body>
</html>
