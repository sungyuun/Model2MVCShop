package com.model2.mvc.service.comment.impl;

import java.util.List;
import java.util.Map;

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
	

//	public void addComment(Map<String, Object> commentMap) {
//		sqlSession.insert("CommentMapper.addComment",commentMap);
//	}
	
	public void recommend(boolean click) {
		sqlSession.update("CommentMapper.recommend",click);
	}
	public void updateComment(Comment comment) {
		sqlSession.update("CommentMapper.updateComment",comment);
	}
	public void deleteComment(int commentId) {
		System.out.println("ÄÚ¸àÆ® ³Ñ¹ö :"+commentId);
		sqlSession.delete("CommentMapper.deleteComment",commentId);
	}
	
	public List<Comment> getCommentList(int prodNo) throws Exception {

		return sqlSession.selectList("CommentMapper.getCommentList",prodNo);
	}
	
	public Comment getComment(int commentNo) throws Exception {
		System.out.println(commentNo);	
		return sqlSession.selectOne("CommentMapper.getComment",commentNo);
	}


	public void addComment(Comment comment) {
		sqlSession.insert("CommentMapper.addComment",comment);
		
	}





//	public int getTotalCount(Search search) throws Exception {
//		return 0;
//	}



}
