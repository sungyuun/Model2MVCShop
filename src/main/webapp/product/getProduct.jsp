<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<head>

	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script type="text/javascript" src="../javascript/dateFormat.js"></script>
    <script type="text/javascript">
    
    function initializeClick() {
		  console.log("hi");
		  
		  $('span[name="update"]').on("click",function(){
			  	const commentNo = $(this).attr('commentno');
			  	const formElement = $('span[name="update"][commentno=' + commentNo + ']').prev('form');

			    if (formElement.length === 0) {
			      // 같은 commentNo를 가진 input 엘리먼트가 없는 경우에만 추가
			    	 $('span[name="update"][commentno=' + commentNo + ']').before('<form style="display: inline;"><input type="text" name="checkPassword" placeholder="비밀번호를 입력해주세요"></input><button name="checkPasswordbt">확인</button></form>');
			    } else {
			      // 이미 input 엘리먼트가 있는 경우 제거
			      formElement.remove();
			    } 
  	  	  });
  	  	  $('span[name="delete"]').on("click", function() {
	  	  		const commentNo = $(this).attr('commentno');
	  	  		const formElement = $('span[name="update"][commentno=' + commentNo + ']').prev('form');
	
			    if (formElement.length === 0) {
			      // 같은 commentNo를 가진 input 엘리먼트가 없는 경우에만 추가
			      $('span[name="update"][commentno=' + commentNo + ']').before('<form style="display: inline;"><input type="text" name="checkPassword" placeholder="비밀번호를 입력해주세요"></input><input name="checkPasswordbt" type="button">확인</input></form>');
			    		  
			    } else {
			      // 이미 input 엘리먼트가 있는 경우 제거
			    	formElement.remove();
			    } 
	  	  });
	  }
    
	    $.ajax({
	        url: "/comment/getCommentList/${ product.prodNo }",
	        type: "GET",
	        contentType: "application/json",
	        success: function (data) {
	          console.log(data);
	          console.log("댓글가져옴");
	          data.forEach((comment) => {
	        	const formattedDate = formatDate(new Date(comment.regDate));
	            $("#comments").prepend(
	            	"<div prodNo="+comment.prodNo+" commentNo="+comment.commentNo+">"+
	             		"<span userId="+comment.userId+">"+comment.userId+"</span> <span>"+ comment.commentContent +"</span> <span commentno = "+comment.commentNo+" name='update'>수 정 </span><span commentno = "+comment.commentNo+" name='delete'>삭 제</span> <span>" +formattedDate +"</span>"+
	              		""+
	              	"</div>"
	            );
	          });
	          initializeClick();
	        },
	      });

      $(() => {
    	  
      });
      
        
      $(document).ready(function() {
    	  
    	  $('button[name="updateCommentbt"]').on("click",()=>{
    		  $.ajax({
                  url: "/comment/updateComment",
                  type: "POST",
                  contentType: "application/json",
                  data: JSON.stringify({
                    commentContent: $('textarea[name="commentContent"]').val(),
                    password: $('input[name="password"]').val(),
                    prodNo : ${product.prodNo}
                  }),
                  success: function (comments) {},
                });
    	  })

    	  
    	  $("button").on("click", () => {
              if ($("textarea").val() < 5) {
                alert("최소 5글자는 쳐주세요.");
                return;
              }
              $.ajax({
                url: "/comment/addComment",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify({
                  commentContent: $('textarea[name="commentContent"]').val(),
                  password: $('input[name="password"]').val(),
                  prodNo : ${product.prodNo}
                }),
                success: function (comments) {
                	console.log(comments);
                },
              });
            });
    	  
    	  	$('input[name="checkPasswordbt"]').on("click",function(){
    	  		console.log("일단눌림");
    	  	})
    	  
          });
    	
 
    </script>

<title>상품 상세조회</title>
</head>

<body bgcolor="#ffffff" text="#000000">

<form name="detailForm" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"	width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">상품상세조회</td>
					<td width="20%" align="right">&nbsp;</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif"  width="12" height="37"/>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 13px;">
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<c:if test="${menu == 'manage'}">
	<tr>
		<td width="104" class="ct_write">
			상품번호 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
			
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="105">${product.prodNo}</td>
					
				</tr>
			</table>
		</td>
	</tr>
	</c:if>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			상품명 
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${product.prodName}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			상품이미지 
			
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<img src="/getImages/${product.fileName}" width="360" height="360" align="absmiddle"/>
			
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			상품상세정보 <!-- <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/> -->
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${product.prodDetail}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">제조일자</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${product.manuDate}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">가격</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${product.price}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<c:if test="${menu == 'manage'}">
	<tr>
		<td width="104" class="ct_write">등록일자</td>
		<td bgcolor="D6D6D6" width="1"></td>
		
		<!-- <td class="ct_write01">${product.regDate}</td> -->
		<td class="ct_write01">${date}</td>
	</tr>
	</c:if>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td width="53%"></td>
		<td align="right">

		<table border="0" cellspacing="0" cellpadding="0">
			<tr>
				<c:choose>
					<c:when test="${!empty user.role && user.role == 'admin' }">
						<td width="17" height="23">
							<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
						</td>
						<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
							<a href="/product/listProduct?menu=manage">확인</a>
						</td>
						<td width="14" height="23">
							<img src="/images/ct_btnbg03.gif" width="14" height="23">
						</td>
					</c:when>	
					<c:when test="${product.proTranCode == '0'}">
						<td width="17" height="23">
							<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
						</td>
						<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
							<a href="/product/addPurchase?prodNo=${product.prodNo}">구매하기</a>
						</td>
						<td width="14" height="23">
							<img src="/images/ct_btnbg03.gif" width="14" height="23">
						</td>
					</c:when>	
				</c:choose>
				
			</tr>
		</table>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr>
		
				<td width="17" height="23">
					<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
				
				<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
				${!empty user.role && user.role == 'admin' ? '<a href=\"./addProductView.jsp\">추가등록</a>' : '<a href=\"/product/listProduct?menu=search\">이전</a>'}
				
				</td>
				<td width="14" height="23">
					<img src="/images/ct_btnbg03.gif" width="14" height="23">
				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>
</form>
	<hr/>
	<div id="comments"></div>
	<form>
	      <textarea name="commentContent"></textarea>
	      <input type="text" name="password"/>
	      <input type="hidden" name="postNo" value="${ post.postNo }" />
	      <button type="button">제출</button>
    </form>
</body>
</html>