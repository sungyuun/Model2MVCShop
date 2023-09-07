package kr.co.devcs.board.web.comment;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import kr.co.devcs.board.service.comment.CommentService;
import kr.co.devcs.board.service.domain.Comment;
import kr.co.devcs.board.service.domain.Post;

@RestController
@RequestMapping("/comment/*")
public class CommentController {

	@Autowired
	@Qualifier("commentServiceImpl")
	private CommentService commentService;
	public CommentController() {
		
	}
	@RequestMapping("/addComment")
	public String addComment(@ModelAttribute("product") Product product,@ModelAttribute("comment") Comment comment,HttpSession session) {
		
		System.out.println("addComment()");
		User user = (User)session.getSession();
		Map<String,Object>commentMap = new HashMap<String,Object>();
		commentMap.put("commentContent", comment.getCommentContent());
		commentMap.put("prodNo", comment.getProdNo());
		
		int num = commentService.addComment(commentMap);

		return "/product/getProduct/"+product.getProdNo();
	}
	@RequestMapping("/getCommentList/{postId}")
	public List<Comment> getCommentList(@PathVariable("postId") int postId) {
		
		System.out.println("getCommentList()");
		List<Comment> comment= commentService.getCommentList(postId);
		
		return comment;
	}
}
