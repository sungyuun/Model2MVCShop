package com.model2.mvc.service.comment.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.comment.CommentDao;
import com.model2.mvc.service.domain.Comment;


@Repository("commentDaoImpl")
public class CommentDaoImpl implements CommentDao{

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	
	public void addComment(Comment comment) {
		sqlSession.insert("CommentMapper.addComment",comment);
	}
	public void updateComment(Comment comment) {
		sqlSession.update("CommentMapper.updateComment",comment);
	}
	public void recommend(boolean click) {
		sqlSession.update("CommentMapper.recommend",click);
	}

	public void deleteComment(Comment comment) {
		sqlSession.delete("CommentMapper.deleteComment")
	}

	public List<Comment> getCommentList() throws Exception {

		List<Comment> list = commentDao.getCommentList(postNo);

		return list;
	}


}
