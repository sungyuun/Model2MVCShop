package com.model2.mvc.web.comment;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

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

import com.model2.mvc.common.Search;
import com.model2.mvc.service.comment.CommentService;
import com.model2.mvc.service.domain.Comment;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;



@RestController
@RequestMapping("/comment/*")
public class CommentController {

	@Autowired
	@Qualifier("commentServiceImpl")
	private CommentService commentService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	public CommentController() {
		
	}
	@RequestMapping("/addComment")
	public Comment addComment(@RequestBody Comment comment,HttpSession session,Model model) throws Exception {
		
		System.out.println("addComment()");
		User user = (User) session.getAttribute("user");
	
		commentService.addComment(comment);
		comment = commentService.getComment(comment.getCommentNo());
		
		return comment;
	}
	@RequestMapping("/getComment/{commentNo}")
	public Comment getComment(@PathVariable("commentNo") int commentNo,@RequestBody Comment comment) throws Exception{
		return commentService.getComment(commentNo);
	}
	@RequestMapping("/updateComment")
	public Comment updateComment(@RequestBody Comment comment, Model model) throws Exception{
		
		
		
		commentService.updateComment(comment);
		System.out.println(comment.getCommentNo());
		comment = commentService.getComment(comment.getCommentNo());
		
		System.out.println("성공");
		// 업데이트한 게시물 아이디
		return comment;
	}
	@RequestMapping("/deleteComment/{commentNo}")
	public String deleteComment(@PathVariable("commentNo") int commentNo, Model model) throws Exception{
		System.out.println("deleteComment");
		System.out.println("커멘트 " +commentNo);
		commentService.deleteComment(commentNo);
		return "/product/getProduct.jsp";
	}
	@RequestMapping("/getCommentList/{prodNo}")
	public List<Comment> getCommentList(@PathVariable("prodNo") int prodNo) throws Exception {
		
		System.out.println("getCommentList()");
		List<Comment> comment= commentService.getCommentList(prodNo);
		
		return comment;
	}
	
//	@RequestMapping("/checkPassword")
//	public boolean checkPassword(@RequestParam("checkPassword") String reqPassword, @RequestParam("checkPasswordbt") int commentNo, Model model) throws Exception {
//	    
//		
//		System.out.println("checkPass");
//		System.out.println(reqPassword+commentNo);
//		Comment comment = commentService.getComment(commentNo);  
//		System.out.println(reqPassword+comment.getPassword());
//	    model.addAttribute("comment", comment);
//	    
//	    return reqPassword.equals(comment.getPassword());
//	}
	@RequestMapping("/checkPassword")
	public Comment checkPassword(@RequestBody Map<String, String> requestMap, Model model) throws Exception {
	    String reqPassword = requestMap.get("password");
	    int commentNo = Integer.parseInt(requestMap.get("commentNo"));
	    
	    System.out.println("checkPass");
	    System.out.println(reqPassword + commentNo);
	    
	    Comment comment = commentService.getComment(commentNo);  
	    System.out.println(reqPassword + comment.getPassword());
	   
	    if (reqPassword.equals(comment.getPassword())==true)
	    	return comment;
	    else {
	    	System.out.println("null 반환");
	    	return null;
	    }
	}

	
	
	
}
