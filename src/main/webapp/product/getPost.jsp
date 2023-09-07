<%@ page contentType="text/html; charset=euc-kr" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
  <head>
    <title>getPostList</title>
    <script src="/javascript/jquery-2.1.4.js" type="text/javascript"></script>
    <script type="text/javascript">
      $.ajax({
        url: "/comment/getCommentList/${ post.postNo }",
        type: "GET",
        contentType: "application/json",
        success: function (data) {
          console.log(data);
          data.forEach((comment) => {
            $("#comments").append(
              "<h3>" +
                comment.commentContent +
                "</h3>" +
                "<p>" +
                new Date(comment.regDate) +
                "</p>"
            );
          });
        },
      });

      $(() => {
        $("button").on("click", () => {
          if ($("textarea").val() < 5) {
            alert("�ּ� 5���ڴ� ���ּ���.");
            return;
          }
          $.ajax({
            url: "/comment/addComment",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({
              commentContent: $('textarea[name="commentContent"]').val(),
              postNo: $('input[name="postNo"]').val(),
            }),
            success: function (comments) {},
          });
        });
      });
    </script>
  </head>
  <body>
    <h1>�Խñ� ����</h1>
    <h2>����: ${ post.postTitle }</h2>
    <h2>����: ${ post.postContent }</h2>
    <p>��ϳ�¥: ${ post.regDate }</p>
    <br />
    <br />
    <h1>���</h1>
    <div id="comments"></div>
    ��� �ۼ�&nbsp;
    <form>
      <textarea name="commentContent"></textarea>
      <input type="hidden" name="postNo" value="${ post.postNo }" />
      <button type="button">����</button>
    </form>
  </body>
</html>
