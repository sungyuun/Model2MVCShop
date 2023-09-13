package com.model2.mvc.service.comment.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.comment.CommentDao;
import com.model2.mvc.service.comment.CommentService;
import com.model2.mvc.service.domain.Comment;

@Service("commentServiceImpl")
public class CommentServiceImpl implements CommentService {

    @Autowired
    @Qualifier("commentDaoImpl")
    private CommentDao commentDao;

    public void setCommentDao(CommentDao commentDao){
        this.commentDao = commentDao;
    }

//	public void addComment(Map<String, Object> commentMap) {
//		
//		commentDao.addComment(commentMap);
//	}

    public void updateComment(Comment comment) {
       commentDao.updateComment(comment);
    }
    public void recommend(boolean click) {

        commentDao.recommend(click);
    }

    public void deleteComment(int commentId) {

        commentDao.deleteComment(commentId);
    }

    public List<Comment> getCommentList(int postNo) throws Exception {

        List<Comment> list = commentDao.getCommentList(postNo);

        return list;
    }

	
	public Comment getComment(int commentNo) throws Exception {
		
		return commentDao.getComment(commentNo);
	}


	public void addComment(Comment comment) {
		commentDao.addComment(comment);
		
	}
	



}
