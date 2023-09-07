package com.model2.mvc.service.comment.impl;

import com.model2.mvc.service.comment.CommentService;

@Service("commentServiceImpl")
public class CommentServiceImpl implements CommentService {

    @Autowired
    @Qualifier("CommentDaoImpl")
    private CommentDao commentDao;

    public void setCommentDao(CommentDao commentDao){
        this.commentDao = commentDao;
    }

    public void setSqlSession(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }


    public void addComment(Comment comment) {
        commentDao.addComment(comment);
    }
    public void updateComment(Comment comment) {
       commentDao. updateComment(comment);
    }
    public void recommend(boolean click) {

        commentDao.recommend(click);
    }

    public void deleteComment(Comment comment) {

        commentDao.deleteComment(comment);
    }

    public List<Comment> getCommentList(int postNo) throws Exception {

        List<Comment> list = commentDao.getCommentList(postNo);

        return list;
    }
}
