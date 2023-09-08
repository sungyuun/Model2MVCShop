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
	public String addComment(@ModelAttribute("product") Product product,@RequestBody Comment comment,HttpSession session,Model model) throws Exception {
		
		System.out.println("addComment()");
		User user = (User) session.getAttribute("user");
		System.out.println(comment.toString());
		Map<String,Object>commentMap = new HashMap<String,Object>();
		commentMap.put("userId", user.getUserId());
		commentMap.put("commentContent", comment.getCommentContent());
		commentMap.put("password", comment.getPassword());
		commentMap.put("prodNo", comment.getProdNo());
		
		int num = commentService.addComment(commentMap);
		System.out.println("db »ý¼º :"+num);
		product = productService.getProduct(comment.getProdNo());
		
		model.addAttribute("product",product);
		
		return "/product/getProduct.jsp";
	}
	@RequestMapping("/getCommentList/{postId}")
	public List<Comment> getCommentList(@PathVariable("postId") int postId) throws Exception {
		
		System.out.println("getCommentList()");
		List<Comment> comment= commentService.getCommentList(postId);
		
		return comment;
	}
}
