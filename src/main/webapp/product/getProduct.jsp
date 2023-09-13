<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<head>

	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	
	<script type="text/javascript" src="../javascript/dateFormat.js"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript">
    
    function initializeClick() {
    	  console.log("hi");

    	  // 부모 엘리먼트에서 이벤트 위임
    	  $(document).on("click", 'span[name="update"]', function() {
    	    const commentNo = $(this).attr('commentno');
    	    const passwordSpan = $('span[name="checkPassword"]');

    	    if (passwordSpan.length === 0) {
    	      // 같은 commentNo를 가진 span 엘리먼트가 없는 경우에만 추가
    	      const passwordElement = $('<span name="checkPassword" value="update"><input type="password" name="password" placeholder="비밀번호를 입력해주세요"></input><input id =' + commentNo + ' type="button" value="확인"></input></span>');
    	      $('span[name="update"][commentno=' + commentNo + ']').before(passwordElement);
    	    } else {
    	      // 이미 span 엘리먼트가 있는 경우 제거
    	      passwordSpan.remove();
    	    }
    	  });

    	  // 부모 엘리먼트에서 이벤트 위임
    	  $(document).on("click", 'span[name="delete"]', function() {
    	    const commentNo = $(this).attr('commentno');
    	    const passwordSpan = $('span[name="checkPassword"]');

    	    if (passwordSpan.length === 0) {
    	      // 같은 commentNo를 가진 span 엘리먼트가 없는 경우에만 추가
    	      const passwordElement = $('<span name="checkPassword" value="delete"><input type="password" name="password" placeholder="비밀번호를 입력해주세요"></input><input id =' + commentNo + ' type="button" value="확인"></input></span>');
    	      $('span[name="update"][commentno=' + commentNo + ']').before(passwordElement);
    	    } else {
    	      // 이미 span 엘리먼트가 있는 경우 제거
    	      passwordSpan.remove();
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
	        		    '<div class="media mb-4"  prodNo="' + comment.prodNo + '" commentNo="' + comment.commentNo + '">' +
	        		    '<img class="d-flex mr-3 rounded-circle" src="http://placehold.it/50x50" alt="">' +
	        		    '<div class="media-body" prodNo="' + comment.prodNo + '" commentNo="' + comment.commentNo + '">' +
	        		    //'<span class="float-right"><span commentno = "'+comment.commentNo+'" name="update">수 정 </span><span commentno = "'+comment.commentNo+'" name="delete">삭 제</span></span>'+
	        		    '<span class="float-right"><span role="button" class="btn btn-sm btn-info" commentno = "'+comment.commentNo+'" name="update">수 정 </span><span role="button" class="btn btn-sm btn-danger ml-1" commentno = "'+comment.commentNo+'" name="delete">삭 제</span></span>'+
	        		    '<h5 class="mt-0"><span userId="' + comment.userId + '">' + comment.userId + '</span> &nbsp;&nbsp;<small class="text-muted"><span>' + formattedDate + '</span></small></h5>' +
	        		    '<p><span name="commentContent" commentno="' + comment.commentNo + '">' + comment.commentContent + '</span></p>' +
	        		    '</div>' +
	        		    '</div>'
						
		                /*
			                "<div prodNo="+comment.prodNo+" commentNo="+comment.commentNo+">"+
			             		"<span userId="+comment.userId+">"+comment.userId+"</span> <span name='commentContent' commentno = "+comment.commentNo+">"+ comment.commentContent +"</span> <span commentno = "+comment.commentNo+" name='update'>수 정 </span><span commentno = "+comment.commentNo+" name='delete'>삭 제</span> <span>" +formattedDate +"</span>"+
			              		""+
			              	"</div>"
		                */
	            	
	            );
	          });
	          initializeClick();
	          
	        },
	      });

      $(() => {
    	  
      });
      
        
      $(document).ready(function() {
    	  //이거 무임?
    	  $('button[name="updateCommentbt"]').on("click",()=>{
    		  $.ajax({
                  url: "/comment/updateComment",
                  type: "POST",
                  contentType: "application/json",
                  data: JSON.stringify({
                	userId: '${user.userId}',
                    commentContent: $('textarea[name="commentContent"]').val(),
                    password: $('input[name="password"]').val(),
                    prodNo : ${product.prodNo}
                  }),
                  success: function (comments) {},
                });
    	  })
    	  
    	  
    	  
    	  $('button[name="addComment"]').on("click", () => {
    		  
			    var textarea = $('textarea[name="commentContent"]');
			    var password = $('input[name="password"]');
			    
			    if ($('textarea[name="commentContent"]').val().length < 5) {
			        alert("최소 5글자는 입력하세요.");
			        return;
			    }
			    $.ajax({
			        url: "/comment/addComment",
			        type: "POST",
			        contentType: "application/json",
			        data: JSON.stringify({
			        	
			        	userId: '${user.userId}',
			            commentContent : $('textarea[name="commentContent"]').val(),
			            password: $('input[name="password"]').val(),
			            prodNo: ${product.prodNo}
			        }),
			        success: function (comment) {
			        	textarea.val('');
			        	password.val('');
			        	const formattedDate = formatDate(new Date(comment.regDate));
			            $("#comments").prepend(
			            		'<div class="media mb-4"  prodNo="' + comment.prodNo + '" commentNo="' + comment.commentNo + '">' +
			        		    '<img class="d-flex mr-3 rounded-circle" src="http://placehold.it/50x50" alt="">' +
			        		    '<div class="media-body" prodNo="' + comment.prodNo + '" commentNo="' + comment.commentNo + '">' +
			        		    //'<span class="float-right"><span commentno = "'+comment.commentNo+'" name="update">수 정 </span><span commentno = "'+comment.commentNo+'" name="delete">삭 제</span></span>'+
			        		    '<span class="float-right"><span role="button" class="btn btn-sm btn-info" commentno = "'+comment.commentNo+'" name="update">수 정 </span><span role="button" class="btn btn-sm btn-danger ml-1" commentno = "'+comment.commentNo+'" name="delete">삭 제</span></span>'+
			        		    '<h5 class="mt-0"><span userId="' + comment.userId + '">' + comment.userId + '</span> &nbsp;&nbsp;<small class="text-muted"><span>' + formattedDate + '</span></small></h5>' +
			        		    '<p><span name="commentContent" commentno="' + comment.commentNo + '">' + comment.commentContent + '</span></p>' +
			        		    '</div>' +
			        		    '</div>'
			              		);
			            console.log(comment);
			        },
			    });
			});
    	  
    	  	$('input[name="checkPasswordbt"]').on("click",function(){
    	  		console.log("일단눌림");
    	  	})
    	  	$('.form-control')
    	  	
          });
      //수정 삭제버튼이 생성되어 비밀번호를 입력하여 비밀번호가 맞는지 체크하는 항목
      $(document).ready(function() {
    	  $(document).on("click", 'input[type="button"]', function() {
    		    // password 입력란의 값을 가져오기
    		    var passwordValue = $(this).siblings('span[name="checkPassword"] input[name="password"]').val();
    		    var commentNo = $(this).closest('div').attr('commentno');
    		    //var commentDiv = $(this).closest('div');
    		    var commentDiv = $('.media[commentNo="'+commentNo+'"]');
    		    // input 엘리먼트의 id 값을 가져오기
    		    var inputId = $(this).attr('id');
    		    console.log("passwordValue : "+passwordValue);
    		    
    		    
    		    
    		    
    		    $.ajax({
                    url: "/comment/checkPassword",
                    type: "POST",
                    contentType: "application/json",
                    data: JSON.stringify({
                      password: passwordValue,
                      commentNo: inputId
                    }),
                    success: function (comments) {
                    	if (comments.commentNo === undefined) {
                    	      alert("비밀번호가 맞지 않습니다");
                   	    } else {
                   	    	
                   	    	var value = $('span[name="checkPassword"]').attr('value');
                   	    	$('span[name="checkPassword"]').remove();
                   	    	if (value==='update'){
                   	    		//var commentContentSpan = $('span[name="commentContent"][commentno="'+commentNo+'"]');
                   	    		var commentContentSpan = $('.media-body[commentNo='+commentNo+'] span[name="commentContent"]');
                   	    		//var commentContentSpan = $(this).siblings('span[name="commentContent"] input[name="password"]');
    		                   	var commentContentInput = $('<input name="updateComment" type="text">');
    		                   	
    						console.log("ㅁ"+commentContentSpan);
    		                   	// input 요소의 값을 span 요소의 텍스트로 설정합니다.
    		                   	commentContentInput.val(commentContentSpan.text());
    		
    		                   	// span 요소를 input 요소로 교체합니다.
    		                   	commentContentSpan.replaceWith(commentContentInput);
    		                   	commentContentInput.after('<button name="update">수정</button>')                 	    
                   	    	}
                   	    	else{
                   	    		console.log("코멘트 : "+commentNo);
                   	    		$.ajax({
                                    url: "/comment/deleteComment/"+commentNo+"",
                                    type: "POST",
                                    contentType: "application/json",
                                    data: JSON.stringify({
                                    	commentNo: commentNo
                                    }),
                                    success: function (comments) {
                                    	commentDiv.remove();
                                 	  },
                                 	  error: function (request, error) {
                                 	    alert("오류가 발생했습니다: " + error);
                                 	  }
                                 	});
                   	    	}
                   	    }
                   	  },
                   	  error: function (request, error) {
                   	    alert("오류가 발생했습니다: " + error);
                   	  }
                  	});
    		  });
    	  
    	  $(document).on("click", 'button[name="update"]', function() {
    		  var commentContentInput = $('input[name="updateComment"]').val();
    		  var commentNo = $(this).closest('div').attr('commentno');
    		  console.log(commentNo);
    		  $.ajax({
                  url: "/comment/updateComment",
                  type: "POST",
                  contentType: "application/json",
                  data: JSON.stringify({
                    commentContent: commentContentInput,
                    commentNo: commentNo
                  }),
                  success: function (comment) {
                	  
                	 

                	  var commentContentSpan = $('<span name="commentContent" commentno="' + comment.commentNo + '">' + comment.commentContent + '</span>');
                	  var commentContentInput = $('input[name="updateComment"]');
                	  commentContentInput.after(commentContentSpan);
                	  // input 엘리먼트를 제거합니다.
                	  commentContentInput.remove();
                	  $('button[name="update"]').remove();

                	  // 제거된 input 엘리먼트 자리에 span 엘리먼트를 동적으로 생성합니다.
                	  

                	  
                	  
               	  },
               	  error: function (request, error) {
               	    alert("오류가 발생했습니다: " + error);
               	  }
               	});
    	  
    	  });
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
							<a href="/purchase/addPurchase?prodNo=${product.prodNo}">구매하기</a>
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
	<!--기존 폼
		<div id="comments"></div>
		<form>
		      <textarea name="commentContent"></textarea>
		      <input type="text" name="password"/>
		      <input type="hidden" name="postNo" value="${ post.postNo }" />
		      <button name="addComment" type="button">제출</button>
	    </form>
	  -->
	
    <div id="comments" class="col-6"></div>
    <!-- 댓글 폼 -->
    <div class="card my-4 col-6">
        <h5 class="card-header">Comment:</h5>
        <div class="card-body">
            <form>
            <c:choose>
            	<c:when test="${!empty user.role}">
            		<div class="form-group">
            			<textarea class="form-control col-9 float-left" rows=2" name="commentContent"></textarea>
	            	</div>
	            	<input class = "col-2 float-left ml-3" type="password" name="password" placeholder="Password"/>
	      			<input type="hidden" name="postNo" value="${ post.postNo }" />
	            	<button class="btn btn-primary col-2 ml-3 mt-1" name="addComment" type="button">Submit</button>
            	</c:when>
            	<c:otherwise>
            		<div class="form-group">
            			<textarea disabled class="form-control col-9 float-left" rows=2" name="commentContent" placeholder="로그인후 이용 가능합니다."></textarea>
	            	</div>
	            	<input class = "col-2 float-left ml-3" type="password" name="password"/>
	      			<input type="hidden" name="postNo" value="${ post.postNo }" />
	            	<button class="btn btn-primary col-2 ml-3 mt-1" name="addComment" type="button">Submit</button>
            	</c:otherwise>
            </c:choose>
            	
            </form>
        </div>
	    
	    <!-- 댓글 추가부분 -->	    
    </div>
</body>
</html>