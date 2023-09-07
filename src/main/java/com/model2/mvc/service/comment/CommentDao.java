package com.model2.mvc.service.comment;

import java.util.List;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Comment;
import com.model2.mvc.service.domain.Product;

public interface CommentDao {

	public void addComment(Comment comment);
	
	public void updateComment(Comment comment);
	
	public void recommend(boolean click);
	
	public void deleteComment(Comment comment);
	
	public List<Comment> getCommentList(int prodNo) throws Exception;

	public int getTotalCount(Search search) throws Exception ;
}
