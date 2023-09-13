package com.model2.mvc.service.comment;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Comment;
import com.model2.mvc.service.domain.Product;

public interface CommentDao {

	public void addComment(Comment comment);
	
	public void updateComment(Comment comment);
	
	public void recommend(boolean click);
	
	public void deleteComment(int commentId);
	
	public List<Comment> getCommentList(int prodNo) throws Exception;
	
	public Comment getComment(int commentId) throws Exception;

	//public int getTotalCount(Search search) throws Exception ;
}
